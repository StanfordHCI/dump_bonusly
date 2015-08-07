{execSync} = require 'child_process'
{MongoClient} = require 'mongodb'

require! {
  asyncblock
  fs
  yamlfile
}

getPosts = (mongo_url, callback) ->
  MongoClient.connect mongo_url, (err, db) ->
    db.collection('posts').find().toArray (err2, results) ->
      callback(null, results)

asyncblock (flow) ->
  output = []
  for let weeknum in [2 to 10]
    meteor_url = "crowdresearch#{weeknum}s.meteor.com"
    mongo_url = execSync("meteor mongo --url #{meteor_url}").toString('utf-8').trim()
    console.log mongo_url
    posts = flow.sync(getPosts(mongo_url, flow.callback()))
    for post in posts
      output.push post
  yamlfile.writeFileSync 'meteor_posts.yaml', output
  console.log 'done'