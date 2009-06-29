require 'xmpp4r'
require 'xmpp4r/muc'
require 'yaml'

require 'rubygems'
require 'sqlite3'

def main
  config   = YAML.load_file('config.yml')
  jid      = Jabber::JID.new(config.jid)
  room_jid = Jabber::JID.new("#{config.room_jid}/#{config.nick}")
  logger   = JabberLogger.new(jid, config.password, room_jid)
  at_exit{ logger.db.close }
  logger.run
  sleep
end

JabberConfig = Struct.new(:jid, :password, :room_jid, :nick)

class JabberLogger

  attr_reader :db

  def initialize(jid, password, room)
    @db = SQLite3::Database.new('chat.sqlite3')
    @logging = true
    @db.execute(<<-SQL)
      CREATE TABLE IF NOT EXISTS logs (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        nick       VARCHAR(255),
        body       TEXT,
        subject    TEXT,
        created_at VARCHAR(255)
      );
    SQL
    @client = Jabber::Client.new(jid)
    @client.connect
    @client.auth(password)

    @room = room

    @muc = Jabber::MUC::SimpleMUCClient.new(@client)
  end

  def run
    @muc.on_message{|time, nick, text|
      begin
        command(nick, text) if time.to_i + 10 < Time.now.to_i
        log(time || Time.now, nick, text)
        # @muc.say text unless ('logger' == nick || /\A#logger/ =~ text)
      rescue => ex
        p ex
      end
    }
    @muc.join(@room)
  end

  private

  def log(time, nick, text)
    return unless @logging
    return if 'logger' == nick
    return if /\A@logger/ =~ text
    sql =<<-SQL
      INSERT INTO logs (nick, body, subject, created_at)
      values(?, ?, ?, ?);
    SQL
    @db.execute(sql,
                nick,
                text,
                @muc.subject || time.strftime('%Y%m%d'),
                time.strftime('%Y%m%d%H%M%S'))
  end

  def command(nick, text)
    return true unless 'okkez' == nick
    case text
    when /\A#logger start\z/
      @logging = true
      @muc.say 'start logging'
    when /\A#logger stop\z/
      @logging = false
      @muc.say 'stop logging'
    when /\A#logger stat/
      message = @logging ? 'logging now' : 'not logging'
      @muc.say message
    else
      # do nothing
    end
    true
  end

end

main
