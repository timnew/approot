isBrowser = typeof(window) isnt 'undefined'

if isBrowser
  fs = require('./fakeFS')
else
  fs = require('fs')

pathUtil = require('path')

approot = (rootPath...) ->
  path = pathUtil.resolve.apply pathUtil, rootPath

  rootpath = (args...) ->
    pathUtil.resolve path, pathUtil.join.apply(null, args)

  rootpath.consolidate = consolidate
  rootpath.listChildren = listChildren

  rootpath

categorizeArg = (arg) ->
  return 'null' unless arg?

  type = typeof(arg)
  switch type
    when 'number', 'string', 'boolean' then type
    when 'object'
      if Array.isArray(arg)
        'array'
      else
        'hash'

consolidateDepth = (depth) ->
  return this unless depth > 0

  path = this()

  if fs.existsSync(path)
    try
      subfiles = fs.readdirSync(path)
      for file in subfiles
        this[file] = approot(path, file)
        consolidateDepth.call(this[file], depth - 1)
    catch ex
      throw ex unless ex.code == 'ENOTDIR'

  this

consolidateObject = (hierarchy) ->
  path = this()

  for key, options of hierarchy
    this[key] = approot(path, key)

    switch categorizeArg(options)
      when 'number' then consolidateDepth.call(this[key], options)
      when 'string' then consolidateArray.call(this[key], [options])
      when 'array' then consolidateArray.call(this[key], options)
      when 'hash' then consolidateObject.call(this[key], options)

  this

consolidateArray = (items) ->
  path = this()

  this[item] = approot(path, item) for item in items

  this

consolidate = (options = 1) ->
  switch categorizeArg(options)
    when 'number' then consolidateDepth.call(this, options)
    when 'string' then consolidateArray.call(this, [options])
    when 'array' then consolidateArray.call(this, options)
    when 'hash' then consolidateObject.call(this, options)
    else
      consolidateDepth.call(this, 1)

  this

listChildren = (args...) ->
  args.unshift(this())
  path = pathUtil.join.apply(pathUtil, args)

  return [] unless fs.existsSync(path)

  fs.readdirSync(path)

exports = module.exports = approot
