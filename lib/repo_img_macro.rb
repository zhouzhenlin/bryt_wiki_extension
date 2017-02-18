module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc "Import repo image"
    macro :repo_img, :parse_args => true do |obj, args|

      repo = args[0]
      img = args[1]

      width = "400px"
      width = args[2] if args[2]
      height = "400px"
      height = args[3] if args[3]
      project_id = obj.page.project.id
      project_id = args[4].strip if args[4]

      content = "<img style=\"width:#{width};height:#{height};\" src=\"/projects/#{project_id}/repository/#{repo}/revisions/master/raw/#{img}\" />"

      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

end
