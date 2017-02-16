module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc "Import repo image"
    macro :repo_img, :parse_args => false do |obj, args, text|

      project_id = obj.page.project.id
      repo = args.split(',')[0]
      img = args.split(',')[1]
      width = args.split(',')[2]
      height = args.split(',')[3]

      content = "<img style=\"width:#{width};height:#{height};\" src=\"/projects/#{project_id}/repository/#{repo}/revisions/master/raw/#{img}\" />"

      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

end
