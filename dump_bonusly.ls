require! {
  getsecret
  bonusly
  fs
}

API_KEY = getsecret('bonusly_api_key')

b = new bonusly(API_KEY)

b.bonuses.getAll({}).then (results) ->
  console.log results
  fs.writeFileSync 'bonusly_data.json', JSON.stringify(results, null, 2)
  console.log 'done writing'
