require! {
  getsecret
  bonusly
  fs
}

API_KEY = getsecret('bonusly_api_key')

b = new bonusly(API_KEY)

badge_results <- b.bonuses.getAll({limit: 9999999999999}).then
console.log badge_results
fs.writeFileSync 'bonusly_badges.json', JSON.stringify(badge_results, null, 2)
console.log 'done writing badges'

user_results <- b.users.getAll({limit: 9999999999999}).then
console.log user_results
fs.writeFileSync 'bonusly_users.json', JSON.stringify(user_results, null, 2)
console.log 'done writing users'

