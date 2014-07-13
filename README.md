approot [![NPM version][npm-image]][npm-url] [![Build Status][ci-image]][ci-url] [![Dependency Status][depstat-image]][depstat-url]
================

> An utility to build path based on a base path. Useful in node.js application, such as web app server. 
> Recommend to instantiate an `approot` in global namespace, to provide an specific reference path across all files in the project

## Install

Install using [npm][npm-url].

    $ npm install approot

## Usage

```javascript 

// suppose __dirname is /var/application

// build approot based on __dirname
global.approot = require('approot')(__dirname).consolidate();

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

[homepage]: https://github.com/timnew/approot

[npm-url]: https://npmjs.org/package/approot
[npm-image]: http://img.shields.io/npm/v/approot.svg?style=flat
[npm-downloads]: http://img.shields.io/npm/dm/approot.svg?style=flat

[ci-url]: https://drone.io/github.com/timnew/approot/latest
[ci-image]: https://drone.io/github.com/timnew/approot/status.png

[depstat-url]: https://gemnasium.com/timnew/approot
[depstat-image]: http://img.shields.io/gemnasium/timnew/approot.svg?style=flat
