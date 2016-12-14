#
# vendor/plugins/redmine_wiki_html_util/init.rb
#
require 'redmine'
require 'open-uri'

Redmine::Plugin.register :bryt_wiki_extension do
  name 'Bryt Redmine Wiki Extension'
  author 'Arlo Carreon, Bryt Li'
  author_url 'https://github.com/bryt-li/bryt_wiki_extension.git'
  description 'Allows you to embedd RAW HTML into your wiki, load stylesheets and javascript.  Made for html/css/js demo wikis'
  version '0.0.1'

  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw html\nUsage:\n<pre>{{html\nHTML CODE\n}}</pre>"
    macro :html, :parse_args => false do |obj, args, text|
      page = obj.page
      raise 'Page not found' if page.nil?

      content = text || args 
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw css"
    macro :css, :parse_args => false do |obj, args, text|
      page = obj.page
      raise 'Page not found' if page.nil?

      content = text || args 
      content = "<style type=\"text/css\">"+content+"</style>"        
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Insert a CSS file into the DOM\nUsage:\n<pre>{{css_url(http://css.url)}}</pre>"
    macro :css_url do |obj, args|
      page = obj.page
      raise 'Page not found' if page.nil?

      result = "<script> var head = document.getElementsByTagName('head')[0], t = document.createElement('link'); t.href = "+args[0]+"; t.media='all'; t.rel='stylesheet'; head.appendChild(t); </script>"
      result = "#{ CGI::unescapeHTML(result) }".html_safe
      return result
    end 
  end
        
        Redmine::WikiFormatting::Macros.register do
          desc "Embed raw js"
          macro :js, :parse_args => false do |obj, args, text|
            page = obj.page
            raise 'Page not found' if page.nil?

            content = text || args
            content = "<script>"+content+"</script>"
            result = "#{ CGI::unescapeHTML(content) }".html_safe
     	      return result
          end 
        end

        Redmine::WikiFormatting::Macros.register do
          desc "Embed raw babel"
          macro :babel, :parse_args => false do |obj, args, text|
            page = obj.page
            raise 'Page not found' if page.nil?

            content = text || args 
            content = '<script type="text/babel">'+content+"</script>"
            result = "#{ CGI::unescapeHTML(content) }".html_safe
            return result
          end
        end

        Redmine::WikiFormatting::Macros.register do
          desc "Import react js"
          macro :import_react, :parse_args => false do |obj, args, text|
            page = obj.page
            raise 'Page not found' if page.nil?

            content = '<script src="/plugin_assets/wiki_html/react.min.js"></script><script src="/plugin_assets/wiki_html/react-dom.min.js"></script><script src="/plugin_assets/wiki_html/browser.min.js"></script>'
            result = "#{ CGI::unescapeHTML(content) }".html_safe
            return result
          end
        end

        Redmine::WikiFormatting::Macros.register do
          desc "Import p5 js"
          macro :import_p5, :parse_args => false do |obj, args, text|
            page = obj.page
            raise 'Page not found' if page.nil?

            content = '<script src="/plugin_assets/wiki_html/p5.min.js"></script><script src="/plugin_assets/wiki_html/react-dom.min.js"></script><script src="/plugin_assets/wiki_html/browser.min.js"></script>'
            result = "#{ CGI::unescapeHTML(content) }".html_safe
            return result
          end
        end

        Redmine::WikiFormatting::Macros.register do
          desc "Import antd"
          macro :import_antd, :parse_args => false do |obj, args, text|
            page = obj.page
            raise 'Page not found' if page.nil?

            content = '<script src="/plugin_assets/wiki_html/antd.min.js"></script><script> var head = document.getElementsByTagName("head")[0], t = document.createElement("link"); t.href = "/plugin_assets/wiki_html/antd.min.css"; t.media="all"; t.rel="stylesheet"; head.appendChild(t); </script>'
            result = "#{ CGI::unescapeHTML(content) }".html_safe
            return result
          end
        end

  Redmine::WikiFormatting::Macros.register do
    desc "Insert a JS file into the DOM\nUsage:\n<pre>{{js_url(http://js.url)}}</pre>"
    macro :js_url do |obj, args|
      page = obj.page
      raise 'Page not found' if page.nil?

      result = "<script> var head = document.getElementsByTagName('head')[0], t = document.createElement('script'); t.src = "+args[0]+"; t.type='text/javascript'; head.appendChild(t); </script>"
    	result = "#{ CGI::unescapeHTML(result) }".html_safe        
	    return result
    end 
  end
        
end
