cupcake = require('../lib/cupcake').cupcake

describe 'cupcake', ->
  it 'should have version', ->
    (expect cupcake.VERSION).toEqual('0.2.1')
  it 'should root file count of 5', ->
    (expect cupcake.ROOT.length).toEqual(5)

  it 'should have artifacts', ->
    (expect cupcake.ARTIFACTS?).toEqual(true)

  it 'should create package.json from template', ->
    spyOn(cupcake.fs, 'readFileSync').andReturn('Hello World')
    spyOn(cupcake.eco, 'render').andReturn('Bar Foo')
    spyOn(cupcake.fs, 'writeFileSync').andReturn('Foo Bar')

    cupcake.render_template 'package.json', 
      project: { name: 'bar' }

    expect(cupcake.fs.readFileSync).toHaveBeenCalled()
    expect(cupcake.eco.render).toHaveBeenCalled()
    expect(cupcake.fs.writeFileSync).toHaveBeenCalled()

  it 'should build folders', ->
    spyOn(cupcake.fs, 'mkdirSync').andReturn('foo ya')
    cupcake.build_folders({ project: { name: 'bar me'}})
    expect(cupcake.fs.mkdirSync).toHaveBeenCalled()

  it 'should build files', ->
    spyOn(cupcake, 'render_template').andReturn('happy day')
    cupcake.build_files({ project: { template: 'jade' }})
    expect(cupcake.render_template).toHaveBeenCalled()

  it 'should display choices', ->
    spyOn(console, 'log').andReturn 'log me'
    cupcake.display_choices { options: ['1','2','3'] }
    expect(console.log).toHaveBeenCalled()

  it 'should say thank you', ->
    spyOn(console, 'log').andReturn 'thank you'
    cupcake.thank_you { name: 'awesome' }
    expect(console.log).toHaveBeenCalled()



