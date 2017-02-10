module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc "Import antd"
    macro :import_antd, :parse_args => false do |obj, args, text|
      content = '<script> var head = document.getElementsByTagName("head")[0], '
      content = content + 't = document.createElement("link"); t.href ="/plugin_assets/bryt_wiki_extension/antd.min.css"; t.media="all"; t.rel="stylesheet"; head.appendChild(t); '
      content = content + '</script>'
      content = content + '<script src="/plugin_assets/bryt_wiki_extension/antd.min.js"></script>'
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

end
