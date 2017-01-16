# coding: utf-8
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

  Redmine::WikiFormatting::Macros.register do
    desc "Enable p5 js draw library"
    macro :enable_p5, :parse_args => false do |obj, args, text|
      result = '<script> var head = document.getElementsByTagName("head")[0], t = document.createElement("script"); t.src ="/plugin_assets/bryt_wiki_extension/p5.min.js"; t.type="text/javascript"; head.appendChild(t); </script>'
      result = "#{ CGI::unescapeHTML(result) }".html_safe
      return result
    end
  end

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

  Redmine::WikiFormatting::Macros.register do
    desc "Import lean canvas"
    macro :import_lean_canvas, :parse_args => false do |obj, args, text|

      html = <<-eos
<div id="dialog_help" title="LeanCanvas帮助" style="display:none;">
  <img src="/plugin_assets/bryt_wiki_extension/lean-canvas/help.png"/>
</div>

<div ng-app="BusinessModelCanvas" ng-controller="RootController" id="lean_canvas" class="container">
    <div class="row">
        <div class="col-md-4 title">
            <div class='row'>
                <p>
                    <button ng-click="archiveDoc()">保存</button>
                    <button ng-click="loadHistory()">加载</button>
                    <button ng-click="clearAll()">重置</button>
                    <button id="btn_help">帮助</button>
                </p>
            </div>
        </div>
    </div>
    <div class="row">
        <table class="table table-bordered canvas-table" style="border:3px #000 solid;">
            <tbody>
            <tr ng-repeat="row in tableLayout">
                <td ng-repeat="cell in row"
                    ng-controller="SectionController"
                    class="canvas-cell"
                    ng-class="{'tall-cell':  cell.rowspan == 2,
                               'short-cell': cell.rowspan == 1}"
                    rowspan="{{cell.rowspan}}"
                    colspan="{{cell.colspan}}"
                    style="border:2px #000 solid;"
                    >
                    <div class="table-cell">
                        <span class="canvas-cell-image glyphicon"
                              ng-class="'glyphicon-' + cell.icon"></span>
                        <span class="cell-title" style="color:{{cell.color}}">{{cell.title}}</span>

                        <ul>
                            <li ng-repeat="item in doc.sections[cell.key]">
                                <bmc-editable-label model="item.label"
                                                    just-added="item === lastAddedItem">
                                </bmc-editable-label>
                            </li>
                        </ul>

                        <button ng-click="addItem()">+</button>
                    </div>
                </td>
            </tr>
            </tbody>
        </table>
    </div>
    <div class="row lean-note">
      <span style="color:red;">A-产品风险</span>
      <span style="color:purple;">B-客户风险</span>
      <span style="color:green;">C-市场风险</span>
    </div>
</div>
      eos

      content = '<script>
                  var head = document.getElementsByTagName("head")[0];
                  var t = document.createElement("link"); t.href ="/plugin_assets/bryt_wiki_extension/lean-canvas/bootstrap.css"; t.media="all"; t.rel="stylesheet"; head.appendChild(t);
                  t = document.createElement("link"); t.href ="/plugin_assets/bryt_wiki_extension/lean-canvas/style.css"; t.media="all"; t.rel="stylesheet"; head.appendChild(t);
                </script>'
      content = content + html
      content = content + '
      <script src="/plugin_assets/bryt_wiki_extension/lean-canvas/angular.js"></script>
      <script src="/plugin_assets/bryt_wiki_extension/lean-canvas/angular-touch.js"></script>
      <script src="/plugin_assets/bryt_wiki_extension/lean-canvas/angular-local-storage.js"></script>
      <script src="/plugin_assets/bryt_wiki_extension/lean-canvas/ui-utils.js"></script>
      <script src="/plugin_assets/bryt_wiki_extension/lean-canvas/leancanvas.js"></script>'
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end


  Redmine::WikiFormatting::Macros.register do
    desc "Import gantt"
    macro :import_gantt, :parse_args => false do |obj, args, text|

      data = args.split(',')[0]
      theme = args.split(',')[1]
      step = args.split(',')[2]

      content = '<script> var head = document.getElementsByTagName("head")[0], '
      if theme && !theme.empty? 
        content = content + "t = document.createElement(\"link\"); t.href =\"/plugin_assets/bryt_wiki_extension/gantt/skins/dhtmlxgantt_#{theme}.css\"; t.media=\"all\"; t.rel=\"stylesheet\"; head.appendChild(t); "
      else
        content = content + 't = document.createElement("link"); t.href ="/plugin_assets/bryt_wiki_extension/gantt/dhtmlxgantt.css"; t.media="all"; t.rel="stylesheet"; head.appendChild(t); '
      end
      content = content + '</script>'
      content = content + '<script src="/plugin_assets/bryt_wiki_extension/gantt/dhtmlxgantt.js"></script>'
      content = content + '<script src="/plugin_assets/bryt_wiki_extension/gantt/ext/dhtmlxgantt_marker.js"></script>'
      content = content + '<script src="/plugin_assets/bryt_wiki_extension/gantt/dhtmlxgantt_locale_cn.js"></script>'

      style = <<-eos
.high{
  border:2px solid #d96c49;
  color: #d96c49;
  background: #d96c49;
}
.high .gantt_task_progress{
  background: #db2536;
}

.medium{
  border:2px solid #34c461;
  color:#34c461;
  background: #34c461;
}
.medium .gantt_task_progress{
  background: #23964d;
}

.low{
  border:2px solid #6ba8e3;
  color:#6ba8e3;
  background: #6ba8e3;
}
.low .gantt_task_progress{
  background: #547dab;
}
.none{
  display:none;
}
      eos

      content = content + "<style type=\"text/css\">#{style}</style>"

      html = '<div id="gantt"></div>'
      content = content+html

      script = <<-eos
      
gantt.config.columns=[
  {name:"text",       label:"任务",  tree:true, width:"*", resize:true },
  {name:"priority",   label:"优先级",   align: "center", template:function(obj){
      if (obj.priority == 0){ return ""}
      if (obj.priority == 2){ return "中等"}
      if (obj.priority == 3){ return "紧急"}
      return "普通"
  } },
  {name:"assignee",   label:"负责人", width:"110" },
];

gantt.templates.task_class  = function(start, end, task){
  switch (task.priority){
    case 0:
      return "none";
      break;
    case 1:
      return "low";
      break;
    case 2:
      return "medium";
      break;
    case 3:
      return "high";
      break;
  }
};

var date_to_str = gantt.date.date_to_str(gantt.config.task_date);
var markerId = gantt.addMarker({
    start_date: new Date(), //a Date object that sets the marker's date
    css: "today", //a CSS class applied to the marker
    text: "Now", //the marker title
    title:date_to_str( new Date()) // the marker's tooltip
});

gantt.config.grid_width = 450;
gantt.config.scale_unit = "month";
gantt.config.date_scale = "%F, %Y";

gantt.config.scale_height = 50;


gantt.init("gantt");

var tasks = {
  "data":[
  ],
  "links":[
  ]
};

var id = 0;
function fillTaskData(data,parent){
  for(var i=0;i<data.length;i++){
    id++;
    var task = {
      "id":id,
      "parent": parent,
      "text":data[i]["text"], 
      "assignee": data[i]["assignee"]?data[i]["assignee"]:"", 
      "progress": data[i]["subtasks"]?0:data[i]["progress"],
      "priority": data[i]["subtasks"]?0:(data[i]["priority"]?data[i]["priority"]:1),
      "start_date":data[i]["start_date"], 
      "duration":data[i]["duration"],
      "open": true
    };
    tasks["data"].push(task);
    //console.log(task);
    if(data[i]["subtasks"])
      fillTaskData(data[i]["subtasks"],id);
  }
}
      eos

      script = script + "gantt.config.subscales = [{unit:\"day\", step:#{step}, date:\"%j, %D\" }];"

      script = script + "fillTaskData(#{data}, id);gantt.parse(tasks);"

      content = content + "<script>#{script}</script>";
      result = "#{ CGI::unescapeHTML(content) }".html_safe
      return result
    end
  end

  
end
