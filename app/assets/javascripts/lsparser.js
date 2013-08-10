/*
  * LSParser-JS ~ 
  * :: A simple parser that makes API calls to replace text surrounded
  * :: in @  @. The tag, recall, is at-space!
*/

var LSParser = function(){
  var parse = function(string){
    console.log(string)
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
    $.get("http://" + window.location.hostname + "/passthrough/get", 
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