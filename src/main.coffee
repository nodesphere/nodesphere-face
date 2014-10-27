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

