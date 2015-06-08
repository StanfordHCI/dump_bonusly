#!/usr/bin/env python

import networkx as nx
import json

G = nx.Graph()

badges = json.load(open('bonusly_badges.json'))['data']['result']

edges = [(x['giver']['username'], x['receiver']['username']) for x in badges]

G.add_edges_from(edges)

pagerank_results = nx.algorithms.link_analysis.pagerank_alg.pagerank(G)

score_and_username = [(score,username) for username,score in pagerank_results.items()]

for score,username in sorted(score_and_username, reverse=True):
  print username, score
