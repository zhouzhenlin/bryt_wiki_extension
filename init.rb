# coding: utf-8
#
# vendor/plugins/redmine_wiki_html_util/init.rb
#
require 'redmine'
require 'open-uri'

Dir::foreach(File.join(File.dirname(__FILE__), 'lib')) do |file|
  next unless /\.rb$/ =~ file
  require file
end


Redmine::Plugin.register :bryt_wiki_extension do
  name 'Bryt Redmine Wiki Extension'
  author 'Arlo Carreon, Bryt Li'
  author_url 'https://github.com/bryt-li/bryt_wiki_extension.git'
  description 'Allows you to embedd RAW HTML into your wiki, load stylesheets and javascript.  Made for html/css/js demo wikis'
  version '0.0.1'
end
