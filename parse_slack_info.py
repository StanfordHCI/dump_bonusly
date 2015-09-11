import csv

slack_info = csv.DictReader(open('slack_info.csv'))
for x in slack_info:
  if x['billing-active'] != '1':
    continue
  print x['username']