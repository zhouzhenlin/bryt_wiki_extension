# coding: utf-8

module WikiMacro

	
	Redmine::WikiFormatting::Macros.register do
		desc "Import react js"
		macro :import_react, :parse_args => false do |obj, args, text|
			if false
				content = '<script> var head = document.getElementsByTagName("head")[0], '
				content = content + 't = document.createElement("script"); t.src ="/plugin_assets/bryt_wiki_extension/react.min.js"; t.type="text/javascript"; head.appendChild(t); '
				content = content + 't = document.createElement("script"); t.src ="/plugin_assets/bryt_wiki_extension/react-dom.min.js"; t.type="text/javascript"; head.appendChild(t); '
				content = content + 't = document.createElement("script"); t.src ="/plugin_assets/bryt_wiki_extension/browser.min.js"; t.type="text/javascript"; head.appendChild(t); '
				content = content + '</script>'
			end

			content = '<script src="/plugin_assets/bryt_wiki_extension/react.min.js"></script>'
			content = content + '<script src="/plugin_assets/bryt_wiki_extension/react-dom.min.js"></script>'
			content = content + '<script src="/plugin_assets/bryt_wiki_extension/browser.min.js"></script>'

			result = "#{ CGI::unescapeHTML(content) }".html_safe
			return result
		end
	end


end