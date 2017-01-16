var tableLayout = [
[
{ 
  title: "A.1 问题",
  color: "red",
  icon: "link",
  key: "problem",
  rowspan: 2,
  colspan: 2 
},
{
  title: "A.4 解决方案",
  color: "red",
  icon: "check",
  key: "solution",
  rowspan: 1,
  colspan: 2 
},
{
  title: "A.3 独特卖点",
  color: "red",
  icon: "gift",
  key: "valuePropositions",
  rowspan: 2,
  colspan: 2 
},
{
  title: "9 门槛优势",
  color: "black",
  icon: "heart",
  key: "unfariAdvantage",
  rowspan: 1,
  colspan: 2
},
{
  title: "B.2 客户群体分类",
  color: "purple",
  icon: "user",
  key: "customerSegments",
  rowspan: 2,
  colspan: 2 
}],
[
{
  title: "A.8 关键指标",
  color: "red",
  icon: "tree-deciduous",
  key: "keyResources",
  rowspan: 1,
  colspan: 2 
},
{
  title: "B.5 渠道",
  color: "purple",
  icon: "send",
  key: "channels",
  rowspan: 1,
  colspan: 2 
}],
[{
  title: "C.7 成本结构",
  color: "green",
  icon: "tags",
  key: "costStructure",
  rowspan: 1,
  colspan: 5 
},
{
  title: "C.6 收入来源",
  color: "green",
  icon: "usd",
  key: "revenueStreams",
  rowspan: 1,
  colspan: 5 
}]
];

$('#btn_help').click(function(e){
  $('#dialog_help').dialog({
     width: 750,
     height: 580,
     modal: true});
  e.preventDefault();  
});


var app = angular.module('BusinessModelCanvas', ['ui.keypress', 'LocalStorageModule', 'ngTouch'])
.config(function(localStorageServiceProvider){
  localStorageServiceProvider.setPrefix('bmc');
});

app.controller('RootController', function($scope, localStorageService) {
  var storedBusinessModel = localStorageService.get('localLeanBusinessModel');
  $scope.doc = storedBusinessModel || doc;
  $scope.tableLayout = tableLayout;

  $scope.$watch('doc', function(){
    localStorageService.set('localLeanBusinessModel', $scope.doc);
  }, true);

  $scope.clearAll = function(){
    (localStorageService.clearAll)();
    $scope.doc = doc;
  };

  $scope.loadHistory = function(){
    var docStr = prompt("Please enter saved data", "{}");
    if(docStr != null)
      $scope.doc = angular.fromJson(docStr);
  };

  $scope.archiveDoc = function(){
    var docStr = angular.toJson($scope.doc);
    alert(docStr);
  };
});

app.controller('SectionController', function($scope) {
  $scope.addItem = function() {
    var newItem = { label: "New Item" };
    $scope.doc.sections[$scope.cell.key].push(newItem);
    $scope.lastAddedItem = newItem;
  };
});

app.directive('bmcFocusWhen', function($timeout) {
  return {
    scope: { bmcFocusWhen: "=" },
    link: function(scope, element, attrs) {
      scope.$watch('bmcFocusWhen', function(value) {
        if(value) {
          $timeout(function() { element[0].focus(); });
        }
      });
    }
  };
});

app.directive('bmcEditableLabel', function () {
  return {
    restrict: 'E',
    replace: true,
    scope: { model: '=', justAdded: '='},
    templateUrl: '/plugin_assets/bryt_wiki_extension/lean-canvas/editableLabel.html',
    link: function(scope, element, attrs) {
      scope.editing = scope.justAdded;
      scope.edit = function() {
        scope.editing = true;
      };

      scope.stopEditing = function() {
        scope.editing = false;
      };
    }
  };
});

app.directive('bmcSelectAll', function($parse, $timeout) {
 return {
   restrict: 'A',
   link: function(scope, element, attrs) {
     if($parse(attrs.bmcSelectAll)(scope)) {
       $timeout(function() { element[0].select(); });
     }
   }
 };
});

