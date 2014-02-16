# Arco web

A simple Angular.js client for the arco backend

## installation
```bash
npm install
```

## start
```bash
npm start
```

## development
Source files are in CoffeScript which are compiled into a sinlg `public/script/app.js` by a rule in the makefile. Please note that all global variables MUST be put in `app.coffee`, because the compile rule in the make file takes `app.coffee` as the first file.

## LICENSE
MIT
