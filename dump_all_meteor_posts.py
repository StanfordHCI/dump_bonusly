from pymongo import MongoClient
from subprocess import check_output

output = []
for weeknum in range(2, 3):
  meteor_url = 'crowdresearch' + str(weeknum) + 's.meteor.com'
  mongo_url = check_output('meteor mongo --url ' + meteor_url, shell=True)
  client = MongoClient(mongo_url)
  dbname = 'crowdresearch' + str(weeknum) + 's_meteor_com'
  db = client[dbname]
  posts = db.posts.find({})
  for post in posts:
    output.append(post)

print output