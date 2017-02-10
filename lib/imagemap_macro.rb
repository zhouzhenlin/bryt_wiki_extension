# coding: utf-8

module WikiMacro


  Redmine::WikiFormatting::Macros.register do
    desc "Enable graphviz image map navigation"
    macro :enable_graph_nav, :parse_args => false do |obj, args, text|
      html = <<-eos
      <div id="dialog" title="预览">
        <a id="linked_img" target="_blank" href="#"><img src=""/></a>
      </div>
      eos

      prj = args.split(',')[0]
      repo = args.split(',')[1]
      js = "var project='#{prj}'; var repository='#{repo}';"
      js = js + <<-eos
      $( "area" ).each(function( index ) {
        var href = $(this).attr("href").split('|');

        var img = href[0].split(',')[0];
        img = '/projects/'+project+'/repository/'+repository+'/revisions/master/raw/'+img;
        var width = href[0].split(',')[1];
        if(!width) width=800;
        var height = href[0].split(',')[2];
        if(!height) height=600;

        var wiki = href[1];

        $(this).click(function(e){
            $('#linked_img img').attr('src',img).css('width',width-30).css('height',height-60);
            if(wiki)
               $('#linked_img').attr('href','/projects/'+project+'/wiki/'+wiki);
            else
               $('#linked_img').attr('href','#');

            $('#dialog').dialog({
               height: height,
               width: width,
               modal: true});
            e.preventDefault();
        });
      });

      eos

      content = html + "<script>#{js}</script>"
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

end