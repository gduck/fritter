app.factory('Message', ["$http", function($http){
  var msg = {};

  msg.sendNoty = function (notyType, notyMessage) {
    noty({
      layout: 'topLeft',
      text: notyMessage,
      type: notyType,
      timeout: 3000,
      closeWith: ['click']
    })
  }

   return msg;
}]);

