# coding: utf-8

module WikiMacro

	
  Redmine::WikiFormatting::Macros.register do
    desc "Enable p5 js draw library"
    macro :enable_p5, :parse_args => false do |obj, args, text|
      result = '<script> var head = document.getElementsByTagName("head")[0], t = document.createElement("script"); t.src ="/plugin_assets/bryt_wiki_extension/p5.min.js"; t.type="text/javascript"; head.appendChild(t); </script>'
      result = "#{ CGI::unescapeHTML(result) }".html_safe
      return result
    end
  end
  
end