fakeFS =
  existsSync: ->
    false
  readdirSync: ->
    []

module.exports = fakeFS
