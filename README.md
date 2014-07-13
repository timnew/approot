app-root [![NPM version][npm-image]][npm-url] [![Build Status][ci-image]][ci-url] [![Dependency Status][depstat-image]][depstat-url]
================

> An utility to build path based on a base path. Useful in node.js application, such as web app server. 
> Recommend to instantiate an `app-root` in global namespace, to provide an specific reference path across all files in the project

## Install

Install using [npm][npm-url].

    $ npm install app-root

## Usage

```javascript 

// suppose __dirname is /var/application

// build approot based on __dirname
global.approot = require('app-root')(__dirname).consolidate();

approot()                         // return /var/application
approot('data', 'sample.json')    // return /var/application/data/sample.json
approot.models()                  // return /var/application/models, exists after consolidate is called
approot.models('user.js')         // return /var/application/models/user.js

// equivalent to call approot.consolidate().data.consolidate().important.consolidate()
approot.consolidate('data', 'important') 

```

## License
MIT

[![NPM downloads][npm-downloads]][npm-url]

[homepage]: https://github.com/timnew/app-root

[npm-url]: https://npmjs.org/package/app-root
[npm-image]: http://img.shields.io/npm/v/app-root.svg?style=flat
[npm-downloads]: http://img.shields.io/npm/dm/app-root.svg?style=flat

[ci-url]: https://drone.io/github.com/timnew/app-root/latest
[ci-image]: https://drone.io/github.com/timnew/app-root/status.png

[depstat-url]: https://gemnasium.com/timnew/app-root
[depstat-image]: http://img.shields.io/gemnasium/timnew/app-root.svg?style=flat
