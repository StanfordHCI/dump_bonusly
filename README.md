# dump_bonusly

Dumps bonus.ly badges into a JSON file. Also computes pagerank on the network of badge-giving.

## Dumping badges

First, get your [bonus.ly API key](https://bonus.ly/api) and create a file `.getsecret.yaml` with the following format:

```
bonusly_api_key: YOUR_API_KEY_GOES_HERE
```

Then install dependencies:

```
npm install
```

Now run the script:

```
node dump_bonusly.js
```

The set of badges will now be in `bonusly_badges.json`.

## Computing pagerank

Once you have dumped the badges to `bonusly_badges.json`, install networkx:

```
pip install networkx
```

And then run the script to compute pagerank:

```
python compute_pagerank.py
```
