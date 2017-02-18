module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc "Insert iframe tag for wiki page."
    macro :iframe_wiki, :parse_args => true do |obj, args|

      wiki = args[0]

      width = '100%'
      width = args[1].strip if args[1]
      height = '400pt'
      height = args[2].strip if args[2]
      project_id = obj.page.project.id
      project_id = args[3].strip if args[3]

      scrolling = 'auto'

      url = "/projects/#{project_id}/wiki/#{wiki}"
      o = ''
      o << '<iframe src="' + url + '" style="border: 0" width="' + width +
        '" height="' + height + '" frameborder="0" scrolling="' + scrolling + '"></iframe>'

      result = "#{ CGI::unescapeHTML(o) }".html_safe
      return result
    end
  end

end
