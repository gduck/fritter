app.factory('Message', ["$http", function($http){
  var msg = {};

  msg.sendNoty = function (notyType, notyMessage) {
    noty({
      // layout: 'topLeft',
      layout: 'center',
      text: notyMessage,
      type: notyType,
      // timeout: 3000,
      timeout: false,
      // closeWith: ['click']
      closeWith: ['hover']
    })
  }

   return msg;
}]);
