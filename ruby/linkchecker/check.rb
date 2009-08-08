#! /usr/bin/ruby
# -*- coding: utf-8 -*-

require 'optparse'
require 'uri'

require 'rubygems'
require 'mechanize'
require 'activerecord'

def main
  base_uri    = nil
  link_depth  = 3
  recheck     = false
  report_only = nil
  parser = OptionParser.new
  parser.on('-b URI', '--base-uri=URI', 'Base URI') do |uri|
    base_uri = uri
  end
  parser.on('-d num', '--depth=num', 'Link depth (default 3)') do |depth|
    link_depth = depth.to_i
  end
  parser.on('--recheck', 'Recheck error URI') do
    recheck = true
  end
  parser.on('--report', 'Show report only') do
    report_only = true
  end
  begin
    parser.parse!
  rescue OptionParser::ParseError => ex
    $stderr.puts ex.message
    $stderr.puts parser.help
    exit 1
  end
  begin
    unless recheck || report_only
      raise 'must specify --base-uri' if base_uri.nil?
    end
  rescue => ex
    $stderr.puts ex.message
    $stderr.puts parser.help
    exit 1
  end
  setup_db

  link_checker = LinkChecker.new(base_uri, link_depth, recheck)
  link_checker.run unless report_only
  link_checker.report

end

def setup_db
  ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
                                          :dbfile  => "cache.sqlite3")
  ActiveRecord::Base.logger = nil # Logger.new(STDOUT)
  return if Check.table_exists?
  ActiveRecord::Schema.define(:version => 1) do
    create_table :checks do |t|
      t.string  :source_uri
      t.string  :target_uri
      t.integer :http_status
      t.integer :depth

      t.timestamps
    end
    add_index :checks, :source_uri
    add_index :checks, :target_uri
  end
end

class Check < ActiveRecord::Base

  CONDITION = 'http_status between ? and ?'
  ORDER = 'source_uri ASC, target_uri ASC'
  named_scope :informatinals, :conditions => [CONDITION, 100, 199], :order => ORDER
  named_scope :successes,     :conditions => [CONDITION, 200, 299], :order => ORDER
  named_scope :redirections,  :conditions => [CONDITION, 300, 399], :order => ORDER
  named_scope :client_errors, :conditions => [CONDITION, 400, 499], :order => ORDER
  named_scope :server_errors, :conditions => [CONDITION, 500, 599], :order => ORDER

  def show
    puts "#{http_status} #{source_uri} #{target_uri} (#{depth})"
  end
end

class LinkChecker
  def initialize(base_uri = nil, link_depth = 3, recheck = false)
    @base_uri   = URI.parse(base_uri) if base_uri
    @link_depth = link_depth
    @recheck = recheck
    @agent = WWW::Mechanize.new
    @agent.user_agent_alias = 'Mac Safari'
  end

  def run
    if @recheck
      recheck
      return
    end
    page = @agent.get(@base_uri)
    page.links.each do |link|
      check(@base_uri, link, 1)
    end
  end

  def check(source_uri, link, depth = 1)
    # FIXME HTTP Status の分類を細かくする
    return if Check.exists?(:source_uri => source_uri.to_s,
                            :target_uri => link.node['href'])
    page = nil
    begin
      page = link.click
      Check.create!(:source_uri  => source_uri.to_s,
                    :target_uri  => link.node['href'],
                    :http_status => 200,
                    :depth       => depth)
      return if external?(link)
      return if @link_depth < depth + 1
      return if Check.exists?(:source_uri => page.uri.to_s)
      page.links.each do |link|
        check(page.uri, link, depth + 1)
      end
    rescue WWW::Mechanize::ResponseCodeError => ex
      Check.create!(:source_uri  => source_uri.to_s,
                    :target_uri  => link.node['href'],
                    :http_status => ex.response_code.to_i,
                    :depth       => depth)
    rescue ActiveRecord::RecordInvalid => ex
      # do nothing
    rescue ActiveRecord::RecordNotSaved => ex
      # do nothing
    rescue RuntimeError => ex
      $stderr.puts link.node['href']
    end
  end

  def recheck
    Check.client_errors.each do |record|
      check_uri(record)
    end
    Check.server_errors.each do |record|
      check_uri(record)
    end
  end

  def check_uri(record)
    begin
      page = @agent.get(record.target_uri)
      record.http_status = 200
      record.save!
    rescue WWW::Mechanize::ResponseCodeError => ex
      record.http_status = ex.response_code
      record.save!
    end
  end

  def report
    Check.client_errors.each do |record|
      record.show
    end
    Check.server_errors.each do |record|
      record.show
    end
    error_count = Check.client_errors.count + Check.server_errors.count
    puts "all: #{Check.all.count}, errors: #{error_count}"
  end

  private

  def internal?(link)
     link.uri.host.nil? || link.uri.host == @base_uri.host
  end

  def external?(link)
    !internal?(link)
  end

end

if __FILE__ == $0
  main
end
