require('./spec_helper')

path = require('path')

describe "app-root", ->
  createAppRoot = ->
    require('../index')(__dirname)
  
  appRoot = createAppRoot()

  it "should expand Path root path", ->
    appRoot().should.equal __dirname

  it "should expand file paths", ->
    appRoot('file').should.equal path.join(__dirname, 'file')
    appRoot('file.ext').should.equal path.join(__dirname, 'file.ext')

  it "should expand multiple path", ->
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
