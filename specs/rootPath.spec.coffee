require('./spec_helper')

path = require('path')

describe 'approot', ->
  AppRoot = require('../index')

  createAppRoot = ->
    AppRoot(__dirname)

  appRoot = createAppRoot()
  
  describe 'factory', ->
    it 'should set root path', ->
      appRoot = AppRoot(__dirname)

      appRoot().should.equal __dirname

    it 'should resolve path', ->
      appRoot = AppRoot(__dirname, 'fixtures/folder/..')
      
      appRoot().should.equal path.join(__dirname, 'fixtures')
    
  it 'should expand file paths', ->
    appRoot('file').should.equal path.join(__dirname, 'file')
    appRoot('file.ext').should.equal path.join(__dirname, 'file.ext')

  it 'should expand multiple path', ->
    appRoot('folder', 'file').should.equal path.join(__dirname, 'folder', 'file')

  describe 'consolidate', ->
    it 'should consolidate', ->
      appRoot = createAppRoot()
      consolidated = appRoot.consolidate()
      consolidated.should.equal appRoot

      appRoot.fixtures().should.equal appRoot('fixtures')
      appRoot.fixtures('file').should.equal appRoot('fixtures', 'file')

    it 'should contain all members', ->
      appRoot = createAppRoot()
      fixtures = appRoot.consolidate().fixtures.consolidate()

      expect(fixtures.folder).to.be.a 'function'
      expect(fixtures.file).to.be.a 'function'

    describe 'consolidate through path', ->
      it 'consolidate through path', ->
        appRoot = createAppRoot()
        folder = appRoot.consolidate('fixtures', 'folder')
        expect(folder).to.be.exist
        folder().should.equal appRoot('fixtures', 'folder')

      it 'should yield null when path not exists', ->
        appRoot = createAppRoot()

        folder = appRoot.consolidate('fixtures', 'not exist')

        expect(folder).to.be.null

  describe 'force consolidate', ->
    describe 'appRoot.consolidate(true)', ->
    describe "appRoot.consolidate(true, 'fixtures', 'folder')", ->

  describe 'folder consolidate', ->
    describe 'appRoot.consolidate(2)', ->
    describe 'appRoot.consolidate(true, 2)', ->

  describe 'listChildren', ->
    it 'should list children', ->
      expect(appRoot.listChildren()).to.have.members ['fixtures', 'rootPath.spec.coffee', 'spec_helper.js']

    it 'should list children for subfolder', ->
      expect(appRoot.listChildren('fixtures')).to.have.members ['folder', 'file']

    it 'should return null if path not exists', ->
      appRoot = AppRoot('/path/not/exists')
      expect(appRoot.listChildren()).to.be.null
      expect(appRoot.listChildren('a')).to.be.null