// Generated by LiveScript 1.3.1
(function(){
  var getsecret, bonusly, fs, asyncblock, API_KEY, b, noerr;
  getsecret = require('getsecret');
  bonusly = require('bonusly');
  fs = require('fs');
  asyncblock = require('asyncblock');
  API_KEY = getsecret('bonusly_api_key');
  b = new bonusly(API_KEY);
  noerr = function(f){
    return function(a){
      return f(null, a);
    };
  };
  asyncblock(function(flow){
    var fcback, all_badges, badge_results, i$, ref$, len$, badge, all_badge_results;
    fcback = function(){
      return noerr(flow.callback());
    };
    all_badges = [];
    for (;;) {
      console.log('fetching badges');
      badge_results = flow.sync(b.bonuses.getAll({
        limit: 100,
        skip: all_badges.length
      }).then(fcback()));
      console.log('got badges');
      console.log(badge_results.data.result.length);
      for (i$ = 0, len$ = (ref$ = badge_results.data.result).length; i$ < len$; ++i$) {
        badge = ref$[i$];
        all_badges.push(badge);
      }
      if (badge_results.data.result.length < 100) {
        break;
      }
    }
    all_badge_results = {
      data: {
        result: all_badges
      }
    };
    fs.writeFileSync('bonusly_badges.json', JSON.stringify(all_badge_results, null, 2));
    return console.log('done writing badges');
  });
}).call(this);
