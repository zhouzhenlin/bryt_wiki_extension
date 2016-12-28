var tableLayout = [
[
{ title: "问题",
icon: "link",
key: "problem",
rowspan: 2,
colspan: 2 },

{ title: "解决方案",
icon: "check",
key: "solution",
rowspan: 1,
colspan: 2 },

{ title: "独特卖点",
icon: "gift",
key: "valuePropositions",
rowspan: 2,
colspan: 2 },

{ title: "门槛优势",
icon: "heart",
key: "unfariAdvantage",
rowspan: 1,
colspan: 2 },

{ title: "客户群体分类",
icon: "user",
key: "customerSegments",
rowspan: 2,
colspan: 2 }
], [
{ title: "关键指标",
icon: "tree-deciduous",
key: "keyResources",
rowspan: 1,
colspan: 2 },

{ title: "渠道",
icon: "send",
key: "channels",
rowspan: 1,
colspan: 2 }
], [
{ title: "成本结构",
icon: "tags",
key: "costStructure",
rowspan: 1,
colspan: 5 },

{ title: "收入来源",
icon: "usd",
key: "revenueStreams",
rowspan: 1,
colspan: 5 }
]
];

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

