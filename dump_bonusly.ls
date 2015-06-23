require! {
  getsecret
  bonusly
  fs
  asyncblock
}

API_KEY = getsecret('bonusly_api_key')

b = new bonusly(API_KEY)

noerr = (f) ->
  return (a) -> f(null, a)

asyncblock (flow) ->
  fcback = ->
    noerr(flow.callback())
  
  all_badges = []
  while true
    console.log 'fetching badges'
    badge_results = flow.sync b.bonuses.getAll({limit: 100, skip: all_badges.length}).then fcback()
    console.log 'got badges'
    console.log badge_results.data.result.length
    for badge in badge_results.data.result
      all_badges.push badge
    if badge_results.data.result.length < 100
      break
  all_badge_results = {data: {result: all_badges}}
  fs.writeFileSync 'bonusly_badges.json', JSON.stringify(all_badge_results, null, 2)
  console.log 'done writing badges'

  #user_results = b.users.getAll({limit: 9999999999999}).then fcback()
  #fs.writeFileSync 'bonusly_users.json', JSON.stringify(user_results, null, 2)
  #console.log 'done writing users'

