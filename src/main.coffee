define (require, exports, module) ->
  
  require './styles/app.css' 
  require './index.html' 

  require 'famous/core/famous.css' 
  require 'famous-polyfills' 

  Engine = require 'famous/core/Engine' 
  RenderNode = require 'famous/core/RenderNode' 
  Surface = require 'famous/core/Surface' 
  Modifier = require 'famous/core/Modifier' 
  Transform = require 'famous/core/Transform' 
  ImageSurface = require 'famous/surfaces/ImageSurface' 

  {type} = require 'lightsaber/lib/type'

  if ENV is "dev" then {log, p} = require 'lightsaber/lib/log'

  class Nexus
    @SIZE = 555

    constructor: (params) ->
      sources = params.sources
      if type(sources) isnt 'array' then throw "required parameter sources must be an array"
      if sources.length < 1 then throw "expected 1 or more sources"

      @context = Engine.createContext()
      @root = new RenderNode()

      if sources.length <= 4
        for source, index in sources
          face = new Face
            content: "<iframe width='100%' height='100%' src='#{source}'></iframe>"
            transform: Transform.multiply(
              Transform.rotateY(Math.PI * index * 0.5)
              Transform.translate(0, 0, Nexus.SIZE / 2)
            )
          @root.add(face.modifier).add(face.surface)
      else 
        throw "Unsupported sources length #{sources.length}"

      initialTime = Date.now()
      center = new Modifier
        origin: [0.5, 0.5]
        align: [0.5, 0.5]
        transform: ->
          Transform.rotateY(0.0006 * (Date.now() - initialTime))

      @context.add(center).add(@root)

  class Face
    @SIZE = 555

    constructor: (params) ->
      @modifier = new Modifier
        align: [0.5, 0.5]
        transform: params.transform
      @surface = new Surface
        align: [0.5, 1]
        content: params.content
        size: [Face.SIZE, Face.SIZE]
        classes: []
        properties:
          lineHeight: "25px"
          textSize: "20px"
          textAlign: "center"
          overflow: "auto"
      
  new Nexus sources: [
    'http://bl.ocks.org/harlantwood/raw/8f486a7d5af1b72074b6'
    'http://processing.nav.nodesphere.org/'
    'http://three.nav.nodesphere.org/'
    'http://bl.ocks.org/harlantwood/raw/4743857/'
  ]
