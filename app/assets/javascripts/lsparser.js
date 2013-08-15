/*
  * LSParser-JS ~ 
  * :: A simple parser that makes API calls to replace text surrounded
  * :: in @  @. The tag is an @ followed by a space.
*/

var LSParser = function(){
  var parse = function(string){
    var lsStrings = string.match(/@ (.+) @/g);
    var results = _.each(lsStrings, function(lsString){
      parseSequence(lsString);
    });
  };

  var parseSequence = function(lsString){
    var split = lsString.match(/@ ([A-Z]+)(.*) @/);
    var command = split[1]
    var arguments = split[2].replace(/^\s+|\s+$/, '').split(" ");

    if(command == "STOCK"){
      parseStock(arguments);
    }
    else if(command == "WEATHER"){
      parseWeather(arguments);
    }
    else{
      parseIdentity(command, arguments);
    }
  };

  var parseStock = function(arguments){
    var ticker = arguments[0];
    stockApiCall(ticker);
  }

  var stockApiCall = function(ticker){
    var apiurl = "http://dev.markitondemand.com/Api/Quote";
    var currentHost = window.location.hostname;
    if (window.location.port.length)
      currentHost += ":" + window.location.port;

    $.get("http://" + currentHost + "/passthrough/get",
          {apiurl: apiurl, type: "xml", params: {symbol: ticker}})
    .done(function(data){
      console.log(data)
      var price = data["QuoteApiModel"]["Data"]["LastPrice"];
      if (price){
        $("#markdown-edit").val($("#markdown-edit").val().replace(/@ STOCK.* @/, price));
    }
    });
  };

  return {parse: parse};
}();