#!/usr/bin/env python

import networkx as nx
import json
from collections import Counter

G = nx.DiGraph()

badges = json.load(open('bonusly_badges.json'))['data']['result']

edges = [(x['giver']['short_name'], x['receiver']['short_name']) for x in badges]

edges = [(giver,receiver) for giver,receiver in edges if giver != receiver]

users = set()
for giver,receiver in edges:
  users.add(giver)
  users.add(receiver)

edge_weights = Counter()
for giver,receiver in edges:
  edge_weights[giver + '_' + receiver] += 1

weighted_edges = []
added_edges = set()
for giver,receiver in edges:
  edgename = giver + '_' + receiver
  if edgename in added_edges:
    continue
  added_edges.add(edgename)
  weighted_edges.append((giver, receiver, edge_weights[edgename]))

user_to_num_badges = Counter()
user_to_num_given = Counter()
for giver,receiver in edges:
  user_to_num_badges[receiver] += 1
  user_to_num_given[giver] += 1

personalization_vector = {}
for user in users:
  if user not in personalization_vector:
    personalization_vector[user] = 1.0 

G.add_weighted_edges_from(weighted_edges)

pagerank_results = nx.algorithms.link_analysis.pagerank_alg.pagerank(G, alpha=0.85, max_iter=10000, personalization=personalization_vector)

score_and_username = [(score,username) for username,score in pagerank_results.items()]

for score,username in sorted(score_and_username, reverse=True):
  print username, 'score=' + str(score), 'received=' + str(user_to_num_badges[username]), 'given=' + str(user_to_num_given[username])
  print
