require('./spec_helper')

path = require('path')

describe 'appRoot', ->
  AppRoot = require('../lib_src')

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
      expect(appRoot.fixtures.folder).to.be.undefined

    it 'should contain all members', ->
      appRoot = createAppRoot()
      fixtures = appRoot.consolidate().fixtures.consolidate()

      expect(fixtures.folder).to.be.a 'function'
      expect(fixtures.file).to.be.a 'function'

    it 'should consolidate with depth', ->
      appRoot = createAppRoot().consolidate(2)

      expect(appRoot.fixtures).to.be.a 'function'
      expect(appRoot.fixtures.folder).to.be.a 'function'
      expect(appRoot.fixtures.folder.another).to.be.undefined

    it 'should consolidate with string', ->
      appRoot = createAppRoot().consolidate('folder')

      expect(appRoot.folder).to.be.a 'function'
      expect(appRoot.folder()).to.equal appRoot('folder')

    it 'should consolidate with array', ->
      appRoot = createAppRoot().consolidate(['folder', 'not_exist'])

      expect(appRoot.folder).to.be.a 'function'
      expect(appRoot.folder()).to.equal appRoot('folder')

      expect(appRoot.not_exist).to.be.a 'function'
      expect(appRoot.not_exist()).to.equal appRoot('not_exist')

    it 'should consolidate with hash', ->
      appRoot = createAppRoot().consolidate
        a:
          b: ['c']
          d: true
          e: 'f'

      expect(appRoot).to.have.deep.property('a').that.is.a('function')
      expect(appRoot.a()).to.equal appRoot('a')
      expect(appRoot).to.have.deep.property('a.b').that.is.a('function')
      expect(appRoot.a.b()).to.equal appRoot('a', 'b')
      expect(appRoot).to.have.deep.property('a.b.c').that.is.a('function')
      expect(appRoot.a.b.c()).to.equal appRoot('a', 'b', 'c')
      expect(appRoot).to.have.deep.property('a.d').that.is.a('function')
      expect(appRoot.a.d()).to.equal appRoot('a', 'd')
      expect(appRoot).to.have.deep.property('a.e').that.is.a('function')
      expect(appRoot.a.e()).to.equal appRoot('a', 'e')
      expect(appRoot).to.have.deep.property('a.e.f').that.is.a('function')
      expect(appRoot.a.e.f()).to.equal appRoot('a', 'e', 'f')

  describe 'listChildren', ->
    it 'should list children', ->
      expect(appRoot.listChildren()).to.have.members ['fixtures', 'rootPath.spec.coffee', 'spec_helper.js']

    it 'should list children for subfolder', ->
      expect(appRoot.listChildren('fixtures')).to.have.members ['folder', 'file']

    it 'should return [] if path not exists', ->
      appRoot = AppRoot('/path/not/exists')
      expect(appRoot.listChildren()).to.deep.equal []
      expect(appRoot.listChildren('a')).to.deep.equal []
