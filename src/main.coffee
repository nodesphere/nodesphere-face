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

  if ENV is "dev" then {log, p} = require 'lightsaber/lib/log'

  class Nexus
    @SIZE = 555

    constructor: ->
      @context = Engine.createContext()
      @root = new RenderNode()

      face = new Face
        content: "<iframe width='100%' height='100%' src='http://bl.ocks.org/harlantwood/raw/8f486a7d5af1b72074b6'></iframe>"
        transform: Transform.multiply(
          Transform.rotateY(Math.PI * 0)
          Transform.translate(0, 0, Nexus.SIZE / 2), 
        )
      @root.add(face.modifier).add(face.surface)

      face = new Face
        content: "<iframe width='100%' height='100%' src='http://processing.nav.nodesphere.org/'></iframe>"
        transform: Transform.translate(0, 0, Nexus.SIZE / 2)
        transform: Transform.multiply(
          Transform.rotateY(Math.PI * .5)
          Transform.translate(0, 0, Nexus.SIZE / 2), 
        )
      @root.add(face.modifier).add(face.surface)

      face = new Face
        content: "<iframe width='100%' height='100%' src='http://three.nav.nodesphere.org/'></iframe>"
        transform: Transform.translate(0, 0, Nexus.SIZE / 2)
        transform: Transform.multiply(
          Transform.rotateY(Math.PI * 1)
          Transform.translate(0, 0, Nexus.SIZE / 2), 
        )
      @root.add(face.modifier).add(face.surface)

      face = new Face
        content: "<iframe width='100%' height='100%' src='http://bl.ocks.org/harlantwood/raw/4743857/'></iframe>"
        transform: Transform.translate(0, 0, Nexus.SIZE / 2)
        transform: Transform.multiply(
          Transform.rotateY(Math.PI * 1.5)
          Transform.translate(0, 0, Nexus.SIZE / 2), 
        )
      @root.add(face.modifier).add(face.surface)

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
      
  new Nexus()
