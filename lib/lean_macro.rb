# coding: utf-8

module WikiMacro
  

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

end