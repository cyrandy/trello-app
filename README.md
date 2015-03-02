# trello-app

### Environment Require
- Node v0.12.0

### Config Your Developer Key
Set your trello developer key in `src/scripts/app/utils/key.coffee`
```
module.exports = ->
  'YOUR KEY HERE'
```
and
`src/index.jade` line 31
```
script(src='https://api.trello.com/1/client.js?key=YOUR_KEY_HERE')
```

### Setup step
1. `npm install -g gulp`
2. `git clone git@github.com:cyrandy/trello-app.git; cd trello-app`
3. `npm install`
4. `gulp`
5. open `localhost:3000` in your browser
