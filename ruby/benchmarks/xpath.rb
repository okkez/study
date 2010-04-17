require 'rubygems'
require 'nokogiri'
require 'nkf'

# url = "http://www11.ocn.ne.jp/~kui168/link37.html"

doc = Nokogiri::HTML(File.read('link37.html'))
xpath = '//table/tr/td' 
# xpath = "//div[@id='Layer2']/table/tbody/tr[1]/td[1]" 
p doc.xpath(xpath)

