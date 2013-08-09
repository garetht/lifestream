// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// the compiled file.
//
// WARNING: THE FIRST BLANK LINE MARKS THE END OF WHAT'S TO BE PROCESSED, ANY BLANK LINE SHOULD
// GO AFTER THE REQUIRES BELOW.
//
//= require jquery
//= require select2
//= require jquery_ujs

/*
  * LSParser-JS ~ 
  * :: A simple parser that makes API calls to replace text surrounded
  * :: in @  @. The tag, recall, is at-space!
*/

var LSParser = function(){
  var parseCommand = function(){
    string.match(/([A-Z]+)(.*)/);
  };

  var parseStock = function(){

  };

  var stockApiCall = function(ticker){
    $.get("http://finance.yahoo.com/d/quotes.csv?s=" + ticker + "&f=k1")
     .done(function(data){console.log(error)})
     .fail(function(one, two, three){console.log(one); console.log(two); console.log(three)});
  };

  return {stockApiCall: stockApiCall};
}();


/*
  * Konami-JS ~ 
  * :: Now with support for touch events and multiple instances for 
  * :: those situations that call for multiple easter eggs!
  * Code: http://konami-js.googlecode.com/
  * Examples: http://www.snaptortoise.com/konami-js
  * Copyright (c) 2009 George Mandis (georgemandis.com, snaptortoise.com)
  * Version: 1.4.1 (3/1//2013)
  * Licensed under the GNU General Public License v3
  * http://www.gnu.org/copyleft/gpl.html
  * Tested in: Safari 4+, Google Chrome 4+, Firefox 3+, IE7+, Mobile Safari 2.2.1 and Dolphin Browser
*/

var Konami = function(callback) {
  var konami= {
      addEvent:function ( obj, type, fn, ref_obj )
      {
        if (obj.addEventListener)
          obj.addEventListener( type, fn, false );
        else if (obj.attachEvent)
        {
          // IE
          obj["e"+type+fn] = fn;
          obj[type+fn] = function() { obj["e"+type+fn]( window.event,ref_obj ); }
          obj.attachEvent( "on"+type, obj[type+fn] );
        }
      },
          input:"",
          pattern:"38384040373937396665",   
          load: function(link) {          
        this.addEvent(document,"keydown", function(e,ref_obj) {                     
          if (ref_obj) konami = ref_obj; // IE
          konami.input+= e ? e.keyCode : event.keyCode;
          if (konami.input.length > konami.pattern.length) konami.input = konami.input.substr((konami.input.length - konami.pattern.length));
          if (konami.input == konami.pattern) {
                    konami.code(link);
          konami.input="";
                    return;
                    }
              },this);
           this.iphone.load(link);

        },
          code: function(link) { window.location=link},
          iphone:{
                  start_x:0,
                  start_y:0,
                  stop_x:0,
                  stop_y:0,
                  tap:false,
                  capture:false,
          orig_keys:"",
                  keys:["UP","UP","DOWN","DOWN","LEFT","RIGHT","LEFT","RIGHT","TAP","TAP"],
                  code: function(link) { konami.code(link);},
                  load: function(link){
                  this.orig_keys = this.keys;
                    konami.addEvent(document,"touchmove",function(e){
                            if(e.touches.length == 1 && konami.iphone.capture==true){ 
                              var touch = e.touches[0]; 
                                  konami.iphone.stop_x = touch.pageX;
                                  konami.iphone.stop_y = touch.pageY;
                                  konami.iphone.tap = false; 
                                  konami.iphone.capture=false;
                                  konami.iphone.check_direction();
                                  }
                                  });               
                          konami.addEvent(document,"touchend",function(evt){
                                  if (konami.iphone.tap==true) konami.iphone.check_direction(link);           
                                  },false);
                          konami.addEvent(document,"touchstart", function(evt){
                                  konami.iphone.start_x = evt.changedTouches[0].pageX;
                                  konami.iphone.start_y = evt.changedTouches[0].pageY;
                                  konami.iphone.tap = true;
                                  konami.iphone.capture = true;
                                  });               
                                  },
                  check_direction: function(link){
                          x_magnitude = Math.abs(this.start_x-this.stop_x);
                          y_magnitude = Math.abs(this.start_y-this.stop_y);
                          x = ((this.start_x-this.stop_x) < 0) ? "RIGHT" : "LEFT";
                          y = ((this.start_y-this.stop_y) < 0) ? "DOWN" : "UP";
                          result = (x_magnitude > y_magnitude) ? x : y;
                          result = (this.tap==true) ? "TAP" : result;                     

                          if (result==this.keys[0]) this.keys = this.keys.slice(1,this.keys.length);
                          if (this.keys.length==0) { 
                this.keys=this.orig_keys;
                this.code(link);
                }
                          }
                  }
  }

  typeof callback === "string" && konami.load(callback);
  if(typeof callback === "function")  {
    konami.code = callback;
    konami.load();
  }

  return konami;
};

var konami = new Konami();
  
    konami.code = function(){
      var c=1; var imgs=['rhoTL','7FJ5A','jI8xC','pABcB','vzEmk','1Jd48']; 
      setInterval(function() {c = (c + 1) % 6;
        document.body.style.cursor = 'url(http://i.imgur.com/'+imgs[c]+'.gif), pointer';
        $('*').css('cursor', 'url(http://i.imgur.com/'+imgs[c]+'.gif), pointer'); 
        
        
        
      }, 120);
    }

konami.load();
