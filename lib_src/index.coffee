fs = require('fs')
pathUtil = require('path')

consolidate = (args...)->
  path = this()

  if fs.existsSync(path)

    subfiles = fs.readdirSync(path)

    for file in subfiles
      this[file] = approot(pathUtil.join(path, file))

    if args.length > 0
      firstName = args.shift()
      first = this[firstName]
      if first?
        return first.consolidate.apply(first, args)
      else
        return null
  this  


approot = (rootPath) ->
  path = pathUtil.resolve rootPath

  rootpath = (args...) ->
    pathUtil.resolve path, pathUtil.join.apply(null, args)
    
  rootpath.consolidate = consolidate

  rootpath

exports = module.exports = approot