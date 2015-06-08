# dump_bonusly

Dumps bonus.ly badges into a JSON file.

## Usage

First, get your bonus.ly API key and create a file `.getsecret.yaml` with the following format:

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

Your badges will be in `bonusly_data.json`
