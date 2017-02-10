# coding: utf-8
module WikiMacro

  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw html\nUsage:\n<pre>{{html\nHTML CODE\n}}</pre>"
    macro :html, :parse_args => false do |obj, args, text|
      content = text || args 
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw css"
    macro :css, :parse_args => false do |obj, args, text|
      content = text || args 
      content = '<style type="text/css">'+content+'</style>'
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Insert a CSS file into the DOM\nUsage:\n<pre>{{css_url(http://css.url)}}</pre>"
    macro :css_url do |obj, args|
      result = "<script> var head = document.getElementsByTagName('head')[0], t = document.createElement('link'); t.href = "+args[0]+"; t.media='all'; t.rel='stylesheet'; head.appendChild(t); </script>"
      result = "#{ CGI::unescapeHTML(result) }".html_safe
      return result
    end 
  end
        
  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw js"
    macro :js, :parse_args => false do |obj, args, text|
      content = text || args
      content = "<script>"+content+"</script>"
      result = "#{ CGI::unescapeHTML(content) }".html_safe
        return result
    end 
  end

  Redmine::WikiFormatting::Macros.register do
    desc "Insert a JS file into the DOM\nUsage:\n<pre>{{js_url(http://js.url)}}</pre>"
    macro :js_url do |obj, args|
      result = "<script> var head = document.getElementsByTagName('head')[0]; var t = document.createElement('script'); t.src = "+args[0]+"; t.type='text/javascript'; head.appendChild(t); </script>"
      result = "#{ CGI::unescapeHTML(result) }".html_safe        
      return result
    end 
  end

  Redmine::WikiFormatting::Macros.register do
    desc "Embed raw babel"
    macro :babel, :parse_args => false do |obj, args, text|
      content = text || args 
      content = '<script type="text/babel">'+content+"</script>"
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

end