# coding: utf-8
module WikiMacro

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