--  love: love2d type definitions
--  this file was auto-generated!

local record Audio
  --  enums
  enum DistanceModel
    'none'
    'inverse'
    'inverseclamped'
    'linear'
    'linearclamped'
    'exponent'
    'exponentclamped'
  end
  enum EffectType
    'chorus'
    'compressor'
    'distortion'
    'echo'
    'equalizer'
    'flanger'
    'reverb'
    'ringmodulator'
  end
  enum EffectWaveform
    'sawtooth'
    'sine'
    'square'
    'triangle'
  end
  enum FilterType
    'lowpass'
    'highpass'
    'bandpass'
  end
  enum SourceType
    'static'
    'stream'
    'queue'
  end
  enum TimeUnit
    'seconds'
    'samples'
  end

  --  types
  record RecordingDevice
    getBitDepth: function(): number
    getBitDepth: function(): number
    getChannelCount: function(): number
    getData: function(): Sound.SoundData
    getName: function(): string
    getSampleCount: function(): number
    getSampleRate: function(): number
    isRecording: function(): boolean
    start: function(number, number, number, number): boolean
    stop: function(): Sound.SoundData
  end
  record Source
    clone: function(): Audio.Source
    getActiveEffects: function(): table
    getAirAbsorption: function(): number
    getAttenuationDistances: function(): (number, number)
    getChannelCount: function(): number
    getCone: function(): (number, number, number)
    getDirection: function(): (number, number, number)
    getDuration: function(Audio.TimeUnit): number
    getEffect: function(string, table): table
    getFilter: function(): table
    getFreeBufferCount: function(): number
    getPitch: function(): number
    getPosition: function(): (number, number, number)
    getRolloff: function(): number
    getType: function(): Audio.SourceType
    getVelocity: function(): (number, number, number)
    getVolume: function(): number
    getVolumeLimits: function(): (number, number)
    isLooping: function(): boolean
    isPlaying: function(): boolean
    isRelative: function(): boolean
    pause: function()
    play: function(): boolean
    queue: function(Sound.SoundData): boolean
    seek: function(number, Audio.TimeUnit)
    setAirAbsorption: function(number)
    setAttenuationDistances: function(number, number)
    setCone: function(number, number, number)
    setDirection: function(number, number, number)
    setEffect: function(string, boolean): boolean
    setEffect: function(string, table): boolean
    setFilter: function(table): boolean
    setFilter: function()
    setLooping: function(boolean)
    setPitch: function(number)
    setPosition: function(number, number, number)
    setRelative: function(boolean)
    setRolloff: function(number)
    setVelocity: function(number, number, number)
    setVolume: function(number)
    setVolumeLimits: function(number, number)
    stop: function()
    tell: function(Audio.TimeUnit): number
  end

  --  functions
  getActiveEffects: function(): table
  getActiveSourceCount: function(): number
  getDistanceModel: function(): Audio.DistanceModel
  getDopplerScale: function(): number
  getEffect: function(string): table
  getMaxSceneEffects: function(): number
  getMaxSourceEffects: function(): number
  getOrientation: function(): (number, number)
  getPosition: function(): (number, number, number)
  getRecordingDevices: function(): table
  getSourceCount: function(): number
  getVelocity: function(): (number, number, number)
  getVolume: function(): number
  isEffectsSupported: function(): boolean
  newQueueableSource: function(number, number, number, number): Audio.Source
  newSource: function(string, Audio.SourceType): Audio.Source
  newSource: function(Filesystem.File, Audio.SourceType): Audio.Source
  newSource: function(Sound.Decoder, Audio.SourceType): Audio.Source
  newSource: function(Filesystem.FileData, Audio.SourceType): Audio.Source
  newSource: function(Sound.SoundData): Audio.Source
  pause: function(): table
  pause: function(Audio.Source, Audio.Source)
  pause: function(table)
  play: function(Audio.Source)
  play: function(table)
  play: function(Audio.Source, Audio.Source, Audio.Source)
  setDistanceModel: function(Audio.DistanceModel)
  setDopplerScale: function(number)
  setEffect: function(string, table): boolean
  setEffect: function(string, boolean): boolean
  setMixWithSystem: function(boolean): boolean
  setOrientation: function(number, number)
  setPosition: function(number, number, number)
  setVelocity: function(number, number, number)
  setVolume: function(number)
  stop: function()
  stop: function(Audio.Source)
  stop: function(Audio.Source, Audio.Source, Audio.Source)
  stop: function(table)
end

local record Data
  --  enums
  enum CompressedDataFormat
    'lz4'
    'zlib'
    'gzip'
    'deflate'
  end
  enum ContainerType
    'data'
    'string'
  end
  enum EncodeFormat
    'base64'
    'hex'
  end
  enum HashFunction
    'md5'
    'sha1'
    'sha224'
    'sha256'
    'sha384'
    'sha512'
  end

  --  types
  record ByteData
  end
  record CompressedData
    getFormat: function(): Data.CompressedDataFormat
  end

  --  functions
  compress: function(Data.ContainerType, Data.CompressedDataFormat, string, number): Data.CompressedData | string
  compress: function(Data.ContainerType, Data.CompressedDataFormat, Data, number): Data.CompressedData | string
  decode: function(Data.ContainerType, Data.EncodeFormat, string): Data.ByteData | string
  decode: function(Data.ContainerType, Data.EncodeFormat, Data): Data.ByteData | string
  decompress: function(Data.ContainerType, Data.CompressedData): Data | string
  decompress: function(Data.ContainerType, Data.CompressedDataFormat, string): Data | string
  decompress: function(Data.ContainerType, Data.CompressedDataFormat, Data): Data | string
  encode: function(Data.ContainerType, Data.EncodeFormat, string, number): Data.ByteData | string
  encode: function(Data.ContainerType, Data.EncodeFormat, Data, number): Data.ByteData | string
  getPackedSize: function(string): number
  hash: function(Data.HashFunction, string): string
  hash: function(Data.HashFunction, Data): string
  newByteData: function(string): Data.ByteData
  newByteData: function(Data, number, number): Data.ByteData
  newByteData: function(number): Data.ByteData
  newDataView: function(Data, number, number): Data
  pack: function(Data.ContainerType, string, number | boolean | string, number | boolean | string): Data | string
  unpack: function(string, string, number): (number | boolean | string, number | boolean | string, number)
  unpack: function(string, Data, number): (number | boolean | string, number | boolean | string, number)
end

local record Event
  --  enums
  enum Event
    'focus'
    'joystickpressed'
    'joystickreleased'
    'keypressed'
    'keyreleased'
    'mousepressed'
    'mousereleased'
    'quit'
    'resize'
    'visible'
    'mousefocus'
    'threaderror'
    'joystickadded'
    'joystickremoved'
    'joystickaxis'
    'joystickhat'
    'gamepadpressed'
    'gamepadreleased'
    'gamepadaxis'
    'textinput'
    'mousemoved'
    'lowmemory'
    'textedited'
    'wheelmoved'
    'touchpressed'
    'touchreleased'
    'touchmoved'
    'directorydropped'
    'filedropped'
    'jp'
    'jr'
    'kp'
    'kr'
    'mp'
    'mr'
    'q'
    'f'
  end

  --  functions
  clear: function()
  poll: function(): function
  pump: function()
  push: function(Event.Event, any, any, any, any, any, any, any)
  quit: function(number)
  quit: function(string)
  wait: function(): (Event.Event, any, any, any, any, any, any, any)
end

local record Filesystem
  --  enums
  enum BufferMode
    'none'
    'line'
    'full'
  end
  enum FileDecoder
    'file'
    'base64'
  end
  enum FileMode
    'r'
    'w'
    'a'
    'c'
  end
  enum FileType
    'file'
    'directory'
    'symlink'
    'other'
  end

  --  types
  record DroppedFile
  end
  record File
    close: function(): boolean
    flush: function(): (boolean, string)
    getBuffer: function(): (Filesystem.BufferMode, number)
    getFilename: function(): string
    getMode: function(): Filesystem.FileMode
    getSize: function(): number
    isEOF: function(): boolean
    isOpen: function(): boolean
    lines: function(): function
    open: function(Filesystem.FileMode): (boolean, string)
    read: function(number): (string, number)
    read: function(Data.ContainerType, number): (Filesystem.FileData | string, number)
    seek: function(number): boolean
    setBuffer: function(Filesystem.BufferMode, number): (boolean, string)
    tell: function(): number
    write: function(string, number): (boolean, string)
    write: function(Data, number): (boolean, string)
  end
  record FileData
    getExtension: function(): string
    getFilename: function(): string
  end

  --  functions
  append: function(string, string, number): (boolean, string)
  append: function(string, Data, number): (boolean, string)
  areSymlinksEnabled: function(): boolean
  createDirectory: function(string): boolean
  getAppdataDirectory: function(): string
  getCRequirePath: function(): string
  getDirectoryItems: function(string): table
  getDirectoryItems: function(string, function): table
  getIdentity: function(): string
  getInfo: function(string, Filesystem.FileType): table
  getInfo: function(string, table): table
  getInfo: function(string, Filesystem.FileType, table): table
  getRealDirectory: function(string): string
  getRequirePath: function(): string
  getSaveDirectory: function(): string
  getSource: function(): string
  getSourceBaseDirectory: function(): string
  getUserDirectory: function(): string
  getWorkingDirectory: function(): string
  init: function(string)
  isFused: function(): boolean
  lines: function(string): function
  load: function(string): (function, string)
  mount: function(string, string, boolean): boolean
  mount: function(Filesystem.FileData, string, boolean): boolean
  mount: function(Data, string, string, boolean): boolean
  newFile: function(string): Filesystem.File
  newFile: function(string, Filesystem.FileMode): (Filesystem.File, string)
  newFileData: function(string, string): Filesystem.FileData
  newFileData: function(string): (Filesystem.FileData, string)
  read: function(string, number): (string, number, nil, string)
  read: function(Data.ContainerType, string, number): (Filesystem.FileData | string, number, nil, string)
  remove: function(string): boolean
  setCRequirePath: function(string)
  setIdentity: function(string)
  setIdentity: function(string)
  setRequirePath: function(string)
  setSource: function(string)
  setSymlinksEnabled: function(boolean)
  unmount: function(string): boolean
  write: function(string, string, number): (boolean, string)
  write: function(string, Data, number): (boolean, string)
end

local record Font
  --  enums
  enum HintingMode
    'normal'
    'light'
    'mono'
    'none'
  end

  --  types
  record GlyphData
    getAdvance: function(): number
    getBearing: function(): (number, number)
    getBoundingBox: function(): (number, number, number, number)
    getDimensions: function(): (number, number)
    getFormat: function(): Image.PixelFormat
    getGlyph: function(): number
    getGlyphString: function(): string
    getHeight: function(): number
    getWidth: function(): number
  end
  record Rasterizer
    getAdvance: function(): number
    getAscent: function(): number
    getDescent: function(): number
    getGlyphCount: function(): number
    getGlyphData: function(string): Font.GlyphData
    getGlyphData: function(number): Font.GlyphData
    getHeight: function(): number
    getLineHeight: function(): number
    hasGlyphs: function(string | number, string | number, string | number): boolean
  end

  --  functions
  newBMFontRasterizer: function(Image.ImageData, string, number): Font.Rasterizer
  newBMFontRasterizer: function(string, string, number): Font.Rasterizer
  newGlyphData: function(Font.Rasterizer, number)
  newImageRasterizer: function(Image.ImageData, string, number, number): Font.Rasterizer
  newRasterizer: function(string): Font.Rasterizer
  newRasterizer: function(Filesystem.FileData): Font.Rasterizer
  newRasterizer: function(number, Font.HintingMode, number): Font.Rasterizer
  newRasterizer: function(string, number, Font.HintingMode, number): Font.Rasterizer
  newRasterizer: function(Filesystem.FileData, number, Font.HintingMode, number): Font.Rasterizer
  newRasterizer: function(Image.ImageData, string, number): Font.Rasterizer
  newRasterizer: function(string, string, number): Font.Rasterizer
  newTrueTypeRasterizer: function(number, Font.HintingMode, number): Font.Rasterizer
  newTrueTypeRasterizer: function(string, number, Font.HintingMode, number): Font.Rasterizer
  newTrueTypeRasterizer: function(Filesystem.FileData, number, Font.HintingMode, number): Font.Rasterizer
end

local record Graphics
  --  enums
  enum AlignMode
    'center'
    'left'
    'right'
    'justify'
  end
  enum ArcType
    'pie'
    'open'
    'closed'
  end
  enum AreaSpreadDistribution
    'uniform'
    'normal'
    'ellipse'
    'borderellipse'
    'borderrectangle'
    'none'
  end
  enum BlendAlphaMode
    'alphamultiply'
    'premultiplied'
  end
  enum BlendMode
    'alpha'
    'replace'
    'screen'
    'add'
    'subtract'
    'multiply'
    'lighten'
    'darken'
    'additive'
    'subtractive'
    'multiplicative'
    'premultiplied'
  end
  enum CompareMode
    'equal'
    'notequal'
    'less'
    'lequal'
    'gequal'
    'greater'
    'never'
    'always'
  end
  enum CullMode
    'back'
    'front'
    'none'
  end
  enum DrawMode
    'fill'
    'line'
  end
  enum FilterMode
    'linear'
    'nearest'
  end
  enum GraphicsFeature
    'clampzero'
    'lighten'
    'multicanvasformats'
    'glsl3'
    'instancing'
    'fullnpot'
    'pixelshaderhighp'
    'shaderderivatives'
  end
  enum GraphicsLimit
    'pointsize'
    'texturesize'
    'multicanvas'
    'canvasmsaa'
    'texturelayers'
    'volumetexturesize'
    'cubetexturesize'
    'anisotropy'
  end
  enum IndexDataType
    'uint16'
    'uint32'
  end
  enum LineJoin
    'miter'
    'none'
    'bevel'
  end
  enum LineStyle
    'rough'
    'smooth'
  end
  enum MeshDrawMode
    'fan'
    'strip'
    'triangles'
    'points'
  end
  enum MipmapMode
    'none'
    'auto'
    'manual'
  end
  enum ParticleInsertMode
    'top'
    'bottom'
    'random'
  end
  enum SpriteBatchUsage
    'dynamic'
    'static'
    'stream'
  end
  enum StackType
    'transform'
    'all'
  end
  enum StencilAction
    'replace'
    'increment'
    'decrement'
    'incrementwrap'
    'decrementwrap'
    'invert'
  end
  enum TextureType
    '2d'
    'array'
    'cube'
    'volume'
  end
  enum VertexAttributeStep
    'pervertex'
    'perinstance'
  end
  enum VertexWinding
    'cw'
    'ccw'
  end
  enum WrapMode
    'clamp'
    'repeat'
    'mirroredrepeat'
    'clampzero'
  end

  --  types
  record Canvas
    generateMipmaps: function()
    getMSAA: function(): number
    getMipmapMode: function(): Graphics.MipmapMode
    newImageData: function(): Image.ImageData
    newImageData: function(number, number, number, number, number, number): Image.ImageData
    renderTo: function(function)
  end
  record Drawable
  end
  record Font
    getAscent: function(): number
    getBaseline: function(): number
    getDPIScale: function(): number
    getDescent: function(): number
    getFilter: function(): (Graphics.FilterMode, Graphics.FilterMode, number)
    getHeight: function(): number
    getLineHeight: function(): number
    getWidth: function(string): number
    getWrap: function(string, number): (number, table)
    hasGlyphs: function(string): boolean
    hasGlyphs: function(string, string): boolean
    hasGlyphs: function(number, number): boolean
    setFallbacks: function(Graphics.Font, Graphics.Font)
    setFilter: function(Graphics.FilterMode, Graphics.FilterMode, number)
    setLineHeight: function(number)
  end
  record Image
    getFlags: function(): table
    isCompressed: function(): boolean
    replacePixels: function(Image.ImageData, number, number, number, number, boolean)
  end
  record Mesh
    attachAttribute: function(string, Graphics.Mesh)
    attachAttribute: function(string, Graphics.Mesh, Graphics.VertexAttributeStep, string)
    attachAttribute: function(string, Graphics.Mesh)
    attachAttribute: function(string, Graphics.Mesh, Graphics.VertexAttributeStep, string)
    detachAttribute: function(string): boolean
    getDrawMode: function(): Graphics.MeshDrawMode
    getDrawRange: function(): (number, number)
    getTexture: function(): Graphics.Texture
    getVertex: function(number): (number, number)
    getVertex: function(number): (number, number, number, number, number, number, number, number)
    getVertexAttribute: function(number, number): (number, number, number)
    getVertexCount: function(): number
    getVertexFormat: function(): table
    getVertexMap: function(): table
    isAttributeEnabled: function(string): boolean
    setAttributeEnabled: function(string, boolean)
    setDrawMode: function(Graphics.MeshDrawMode)
    setDrawRange: function(number, number)
    setDrawRange: function()
    setTexture: function(Graphics.Texture)
    setTexture: function()
    setVertex: function(number, number, number)
    setVertex: function(number, table)
    setVertex: function(number, number, number, number, number, number, number, number, number)
    setVertex: function(number, table)
    setVertexAttribute: function(number, number, number, number, number)
    setVertexMap: function(table)
    setVertexMap: function(number, number, number)
    setVertexMap: function(Data, Graphics.IndexDataType)
    setVertices: function(table, number)
    setVertices: function(Data, number)
    setVertices: function(table)
  end
  record ParticleSystem
    clone: function(): Graphics.ParticleSystem
    emit: function(number)
    getBufferSize: function(): number
    getColors: function(): (number, number, number, number, number, number, number, number, number, number, number, number)
    getCount: function(): number
    getDirection: function(): number
    getEmissionArea: function(): (Graphics.AreaSpreadDistribution, number, number, number, boolean)
    getEmissionRate: function(): number
    getEmitterLifetime: function(): number
    getInsertMode: function(): Graphics.ParticleInsertMode
    getLinearAcceleration: function(): (number, number, number, number)
    getLinearDamping: function(): (number, number)
    getOffset: function(): (number, number)
    getParticleLifetime: function(): (number, number)
    getPosition: function(): (number, number)
    getQuads: function(): table
    getRadialAcceleration: function(): (number, number)
    getRotation: function(): (number, number)
    getSizeVariation: function(): number
    getSizes: function(): (number, number, number)
    getSpeed: function(): (number, number)
    getSpin: function(): (number, number, number)
    getSpinVariation: function(): number
    getSpread: function(): number
    getTangentialAcceleration: function(): (number, number)
    getTexture: function(): Graphics.Texture
    hasRelativeRotation: function(): boolean
    isActive: function(): boolean
    isPaused: function(): boolean
    isStopped: function(): boolean
    moveTo: function(number, number)
    pause: function()
    reset: function()
    setBufferSize: function(number)
    setColors: function(number, number, number, number, number, number, number, number, number, number, number, number)
    setDirection: function(number)
    setEmissionArea: function(Graphics.AreaSpreadDistribution, number, number, number, boolean)
    setEmissionRate: function(number)
    setEmitterLifetime: function(number)
    setInsertMode: function(Graphics.ParticleInsertMode)
    setLinearAcceleration: function(number, number, number, number)
    setLinearDamping: function(number, number)
    setOffset: function(number, number)
    setParticleLifetime: function(number, number)
    setPosition: function(number, number)
    setQuads: function(Graphics.Quad, Graphics.Quad)
    setQuads: function(table)
    setRadialAcceleration: function(number, number)
    setRelativeRotation: function(boolean)
    setRotation: function(number, number)
    setSizeVariation: function(number)
    setSizes: function(number, number, number)
    setSpeed: function(number, number)
    setSpin: function(number, number)
    setSpinVariation: function(number)
    setSpread: function(number)
    setTangentialAcceleration: function(number, number)
    setTexture: function(Graphics.Texture)
    start: function()
    stop: function()
    update: function(number)
  end
  record Quad
    getTextureDimensions: function(): (number, number)
    getViewport: function(): (number, number, number, number)
    setViewport: function(number, number, number, number, number, number)
  end
  record Shader
    getWarnings: function(): string
    hasUniform: function(string): boolean
    send: function(string, number, number)
    send: function(string, table, table)
    send: function(string, table, table)
    send: function(string, Graphics.Texture)
    send: function(string, boolean, boolean)
    send: function(string, Math.MatrixLayout, table, table)
    send: function(string, Data, number, number)
    send: function(string, Data, Math.MatrixLayout, number, number)
    sendColor: function(string, table, table)
  end
  record SpriteBatch
    add: function(number, number, number, number, number, number, number, number, number): number
    add: function(Graphics.Quad, number, number, number, number, number, number, number, number, number): number
    addLayer: function(number, number, number, number, number, number, number, number, number, number): number
    addLayer: function(number, Graphics.Quad, number, number, number, number, number, number, number, number, number): number
    addLayer: function(number, Math.Transform): number
    addLayer: function(number, Graphics.Quad, Math.Transform): number
    attachAttribute: function(string, Graphics.Mesh)
    clear: function()
    flush: function()
    getBufferSize: function(): number
    getColor: function(): (number, number, number, number)
    getCount: function(): number
    getTexture: function(): Graphics.Texture
    set: function(number, number, number, number, number, number, number, number, number, number)
    set: function(number, Graphics.Quad, number, number, number, number, number, number, number, number, number)
    setColor: function(number, number, number, number)
    setColor: function()
    setDrawRange: function(number, number)
    setDrawRange: function()
    setLayer: function(number, number, number, number, number, number, number, number, number, number, number)
    setLayer: function(number, number, Graphics.Quad, number, number, number, number, number, number, number, number, number)
    setLayer: function(number, number, Math.Transform)
    setLayer: function(number, number, Graphics.Quad, Math.Transform)
    setTexture: function(Graphics.Texture)
  end
  record Text
    add: function(string, number, number, number, number, number, number, number, number, number): number
    add: function(table, number, number, number, number, number, number, number, number, number): number
    addf: function(string, number, Graphics.AlignMode, number, number, number, number, number, number, number, number, number): number
    addf: function(table, number, Graphics.AlignMode, number, number, number, number, number, number, number, number, number): number
    clear: function()
    getDimensions: function(): (number, number)
    getDimensions: function(number): (number, number)
    getFont: function(): Graphics.Font
    getHeight: function(): number
    getHeight: function(number): number
    getWidth: function(): number
    getWidth: function(number): number
    set: function(string)
    set: function(table)
    setFont: function(Graphics.Font)
    setf: function(string, number, Graphics.AlignMode)
    setf: function(table, number, Graphics.AlignMode)
  end
  record Texture
    getDPIScale: function(): number
    getDepth: function(): number
    getDepthSampleMode: function(): Graphics.CompareMode
    getDimensions: function(): (number, number)
    getFilter: function(): (Graphics.FilterMode, Graphics.FilterMode, number)
    getFormat: function(): Image.PixelFormat
    getHeight: function(): number
    getLayerCount: function(): number
    getMipmapCount: function(): number
    getMipmapFilter: function(): (Graphics.FilterMode, number)
    getPixelDimensions: function(): (number, number)
    getPixelHeight: function(): number
    getPixelWidth: function(): number
    getTextureType: function(): Graphics.TextureType
    getWidth: function(): number
    getWrap: function(): (Graphics.WrapMode, Graphics.WrapMode, Graphics.WrapMode)
    isReadable: function(): boolean
    setDepthSampleMode: function(Graphics.CompareMode)
    setFilter: function(Graphics.FilterMode, Graphics.FilterMode, number)
    setMipmapFilter: function(Graphics.FilterMode, number)
    setMipmapFilter: function()
    setWrap: function(Graphics.WrapMode, Graphics.WrapMode, Graphics.WrapMode)
  end
  record Video
    getDimensions: function(): (number, number)
    getFilter: function(): (Graphics.FilterMode, Graphics.FilterMode, number)
    getHeight: function(): number
    getSource: function(): Audio.Source
    getStream: function(): Video.VideoStream
    getWidth: function(): number
    isPlaying: function(): boolean
    pause: function()
    play: function()
    rewind: function()
    seek: function(number)
    setFilter: function(Graphics.FilterMode, Graphics.FilterMode, number)
    setSource: function(Audio.Source)
    tell: function(): number
  end

  --  functions
  applyTransform: function(Math.Transform)
  arc: function(Graphics.DrawMode, number, number, number, number, number, number)
  arc: function(Graphics.DrawMode, Graphics.ArcType, number, number, number, number, number, number)
  captureScreenshot: function(string)
  captureScreenshot: function(function)
  captureScreenshot: function(Thread.Channel)
  circle: function(Graphics.DrawMode, number, number, number)
  circle: function(Graphics.DrawMode, number, number, number, number)
  clear: function()
  clear: function(number, number, number, number, boolean, boolean)
  clear: function(table, table, boolean, boolean)
  clear: function(boolean, boolean, boolean)
  discard: function(boolean, boolean)
  discard: function(table, boolean)
  draw: function(Graphics.Drawable, number, number, number, number, number, number, number, number, number)
  draw: function(Graphics.Texture, Graphics.Quad, number, number, number, number, number, number, number, number, number)
  draw: function(Graphics.Drawable, Math.Transform)
  draw: function(Graphics.Texture, Graphics.Quad, Math.Transform)
  drawInstanced: function(Graphics.Mesh, number, number, number, number, number, number, number, number, number, number)
  drawInstanced: function(Graphics.Mesh, number, Math.Transform)
  drawLayer: function(Graphics.Texture, number, number, number, number, number, number, number, number, number, number)
  drawLayer: function(Graphics.Texture, number, Graphics.Quad, number, number, number, number, number, number, number, number, number)
  drawLayer: function(Graphics.Texture, number, Math.Transform)
  drawLayer: function(Graphics.Texture, number, Graphics.Quad, Math.Transform)
  ellipse: function(Graphics.DrawMode, number, number, number, number)
  ellipse: function(Graphics.DrawMode, number, number, number, number, number)
  flushBatch: function()
  getBackgroundColor: function(): (number, number, number, number)
  getBlendMode: function(): (Graphics.BlendMode, Graphics.BlendAlphaMode)
  getCanvas: function(): Graphics.Canvas
  getCanvasFormats: function(): table
  getCanvasFormats: function(boolean): table
  getColor: function(): (number, number, number, number)
  getColorMask: function(): (boolean, boolean, boolean, boolean)
  getDPIScale: function(): number
  getDefaultFilter: function(): (Graphics.FilterMode, Graphics.FilterMode, number)
  getDepthMode: function(): (Graphics.CompareMode, boolean)
  getDimensions: function(): (number, number)
  getFont: function(): Graphics.Font
  getFrontFaceWinding: function(): Graphics.VertexWinding
  getHeight: function(): number
  getImageFormats: function(): table
  getLineJoin: function(): Graphics.LineJoin
  getLineStyle: function(): Graphics.LineStyle
  getLineWidth: function(): number
  getMeshCullMode: function(): Graphics.CullMode
  getPixelHeight: function(): number
  getPixelWidth: function(): number
  getPointSize: function(): number
  getRendererInfo: function(): (string, string, string, string)
  getScissor: function(): (number, number, number, number)
  getShader: function(): Graphics.Shader
  getStackDepth: function(): number
  getStats: function(): table
  getStats: function(table): table
  getStencilTest: function(): (Graphics.CompareMode, number)
  getSupported: function(): table
  getSystemLimits: function(): table
  getTextureTypes: function(): table
  getWidth: function(): number
  intersectScissor: function(number, number, number, number)
  inverseTransformPoint: function(number, number): (number, number)
  isActive: function(): boolean
  isGammaCorrect: function(): boolean
  isWireframe: function(): boolean
  line: function(number, number, number, number, number)
  line: function(table)
  newArrayImage: function(table, table): Graphics.Image
  newCanvas: function(): Graphics.Canvas
  newCanvas: function(number, number): Graphics.Canvas
  newCanvas: function(number, number, table): Graphics.Canvas
  newCanvas: function(number, number, number, table): Graphics.Canvas
  newCubeImage: function(string, table): Graphics.Image
  newCubeImage: function(table, table): Graphics.Image
  newFont: function(string): Graphics.Font
  newFont: function(string, number, Font.HintingMode, number): Graphics.Font
  newFont: function(string, string): Graphics.Font
  newFont: function(number, Font.HintingMode, number): Graphics.Font
  newImage: function(string): Graphics.Image
  newImage: function(Image.ImageData): Graphics.Image
  newImage: function(Image.CompressedImageData): Graphics.Image
  newImage: function(string, table): Graphics.Image
  newImageFont: function(string, string): Graphics.Font
  newImageFont: function(Image.ImageData, string): Graphics.Font
  newImageFont: function(string, string, number): Graphics.Font
  newMesh: function(table, Graphics.MeshDrawMode, Graphics.SpriteBatchUsage): Graphics.Mesh
  newMesh: function(number, Graphics.MeshDrawMode, Graphics.SpriteBatchUsage): Graphics.Mesh
  newMesh: function(table, table, Graphics.MeshDrawMode, Graphics.SpriteBatchUsage): Graphics.Mesh
  newMesh: function(table, number, Graphics.MeshDrawMode, Graphics.SpriteBatchUsage): Graphics.Mesh
  newMesh: function(number, Graphics.Texture, Graphics.MeshDrawMode): Graphics.Mesh
  newParticleSystem: function(Graphics.Image, number): Graphics.ParticleSystem
  newParticleSystem: function(Graphics.Texture, number): Graphics.ParticleSystem
  newQuad: function(number, number, number, number, number, number): Graphics.Quad
  newShader: function(string): Graphics.Shader
  newShader: function(string, string): Graphics.Shader
  newSpriteBatch: function(Graphics.Image, number): Graphics.SpriteBatch
  newSpriteBatch: function(Graphics.Image, number, Graphics.SpriteBatchUsage): Graphics.SpriteBatch
  newSpriteBatch: function(Graphics.Texture, number, Graphics.SpriteBatchUsage): Graphics.SpriteBatch
  newText: function(Graphics.Font, string): Graphics.Text
  newVideo: function(string): Graphics.Video
  newVideo: function(Video.VideoStream): Graphics.Video
  newVideo: function(string, table): Graphics.Video
  newVideo: function(string, boolean): Graphics.Video
  newVideo: function(Video.VideoStream, boolean): Graphics.Video
  newVolumeImage: function(table, table): Graphics.Image
  origin: function()
  points: function(number, number, number)
  points: function(table)
  points: function(table)
  polygon: function(Graphics.DrawMode, number)
  polygon: function(Graphics.DrawMode, table)
  pop: function()
  present: function()
  print: function(string, number, number, number, number, number, number, number, number, number)
  print: function(table, number, number, number, number, number, number, number, number, number)
  print: function(string, Math.Transform)
  print: function(table, Math.Transform)
  print: function(string, Graphics.Font, Math.Transform)
  print: function(table, Graphics.Font, Math.Transform)
  printf: function(string, number, number, number, Graphics.AlignMode, number, number, number, number, number, number, number)
  printf: function(string, Graphics.Font, number, number, number, Graphics.AlignMode, number, number, number, number, number, number, number)
  printf: function(string, Math.Transform, number, Graphics.AlignMode)
  printf: function(string, Graphics.Font, Math.Transform, number, Graphics.AlignMode)
  printf: function(table, number, number, number, Graphics.AlignMode, number, number, number, number, number, number, number)
  printf: function(table, Graphics.Font, number, number, number, Graphics.AlignMode, number, number, number, number, number, number, number)
  printf: function(table, Math.Transform, number, Graphics.AlignMode)
  printf: function(table, Graphics.Font, Math.Transform, number, Graphics.AlignMode)
  push: function()
  push: function(Graphics.StackType)
  rectangle: function(Graphics.DrawMode, number, number, number, number)
  rectangle: function(Graphics.DrawMode, number, number, number, number, number, number, number)
  replaceTransform: function(Math.Transform)
  reset: function()
  rotate: function(number)
  scale: function(number, number)
  setBackgroundColor: function(number, number, number, number)
  setBackgroundColor: function()
  setBackgroundColor: function()
  setBlendMode: function(Graphics.BlendMode)
  setBlendMode: function(Graphics.BlendMode, Graphics.BlendAlphaMode)
  setCanvas: function(Graphics.Canvas, number)
  setCanvas: function()
  setCanvas: function(Graphics.Canvas, Graphics.Canvas, Graphics.Canvas)
  setCanvas: function(Graphics.Canvas, number, number)
  setCanvas: function(table)
  setColor: function(number, number, number, number)
  setColor: function(table)
  setColorMask: function(boolean, boolean, boolean, boolean)
  setColorMask: function()
  setDefaultFilter: function(Graphics.FilterMode, Graphics.FilterMode, number)
  setDepthMode: function(Graphics.CompareMode, boolean)
  setDepthMode: function()
  setFont: function(Graphics.Font)
  setFrontFaceWinding: function(Graphics.VertexWinding)
  setLineJoin: function(Graphics.LineJoin)
  setLineStyle: function(Graphics.LineStyle)
  setLineWidth: function(number)
  setMeshCullMode: function(Graphics.CullMode)
  setNewFont: function(number): Graphics.Font
  setNewFont: function(string, number): Graphics.Font
  setNewFont: function(Filesystem.File, number): Graphics.Font
  setNewFont: function(Data, number): Graphics.Font
  setNewFont: function(Font.Rasterizer): Graphics.Font
  setPointSize: function(number)
  setScissor: function(number, number, number, number)
  setScissor: function()
  setShader: function(Graphics.Shader)
  setShader: function()
  setStencilTest: function(Graphics.CompareMode, number)
  setStencilTest: function()
  setWireframe: function(boolean)
  shear: function(number, number)
  stencil: function(function, Graphics.StencilAction, number, boolean)
  transformPoint: function(number, number): (number, number)
  translate: function(number, number)
  validateShader: function(boolean, string): (boolean, string)
  validateShader: function(boolean, string, string): (boolean, string)
end

local record Image
  --  enums
  enum CompressedImageFormat
    'DXT1'
    'DXT3'
    'DXT5'
    'BC4'
    'BC4s'
    'BC5'
    'BC5s'
    'BC6h'
    'BC6hs'
    'BC7'
    'ETC1'
    'ETC2rgb'
    'ETC2rgba'
    'ETC2rgba1'
    'EACr'
    'EACrs'
    'EACrg'
    'EACrgs'
    'PVR1rgb2'
    'PVR1rgb4'
    'PVR1rgba2'
    'PVR1rgba4'
    'ASTC4x4'
    'ASTC5x4'
    'ASTC5x5'
    'ASTC6x5'
    'ASTC6x6'
    'ASTC8x5'
    'ASTC8x6'
    'ASTC8x8'
    'ASTC10x5'
    'ASTC10x6'
    'ASTC10x8'
    'ASTC10x10'
    'ASTC12x10'
    'ASTC12x12'
  end
  enum ImageFormat
    'tga'
    'png'
    'jpg'
    'bmp'
  end
  enum PixelFormat
    'unknown'
    'normal'
    'hdr'
    'r8'
    'rg8'
    'rgba8'
    'srgba8'
    'r16'
    'rg16'
    'rgba16'
    'r16f'
    'rg16f'
    'rgba16f'
    'r32f'
    'rg32f'
    'rgba32f'
    'la8'
    'rgba4'
    'rgb5a1'
    'rgb565'
    'rgb10a2'
    'rg11b10f'
    'stencil8'
    'depth16'
    'depth24'
    'depth32f'
    'depth24stencil8'
    'depth32fstencil8'
    'DXT1'
    'DXT3'
    'DXT5'
    'BC4'
    'BC4s'
    'BC5'
    'BC5s'
    'BC6h'
    'BC6hs'
    'BC7'
    'ETC1'
    'ETC2rgb'
    'ETC2rgba'
    'ETC2rgba1'
    'EACr'
    'EACrs'
    'EACrg'
    'EACrgs'
    'PVR1rgb2'
    'PVR1rgb4'
    'PVR1rgba2'
    'PVR1rgba4'
    'ASTC4x4'
    'ASTC5x4'
    'ASTC5x5'
    'ASTC6x5'
    'ASTC6x6'
    'ASTC8x5'
    'ASTC8x6'
    'ASTC8x8'
    'ASTC10x5'
    'ASTC10x6'
    'ASTC10x8'
    'ASTC10x10'
    'ASTC12x10'
    'ASTC12x12'
  end

  --  types
  record CompressedImageData
    getDimensions: function(): (number, number)
    getDimensions: function(number): (number, number)
    getFormat: function(): Image.CompressedImageFormat
    getHeight: function(): number
    getHeight: function(number): number
    getMipmapCount: function(): number
    getWidth: function(): number
    getWidth: function(number): number
  end
  record ImageData
    encode: function(Image.ImageFormat, string): Filesystem.FileData
    encode: function(string)
    encode: function(string, Image.ImageFormat)
    getDimensions: function(): (number, number)
    getHeight: function(): number
    getPixel: function(number, number): (number, number, number, number)
    getWidth: function(): number
    mapPixel: function(function, number, number, number, number)
    paste: function(Image.ImageData, number, number, number, number, number, number)
    setPixel: function(number, number, number, number, number, number)
  end

  --  functions
  isCompressed: function(string): boolean
  isCompressed: function(Filesystem.FileData): boolean
  newCompressedData: function(string): Image.CompressedImageData
  newCompressedData: function(Filesystem.FileData): Image.CompressedImageData
  newImageData: function(number, number): Image.ImageData
  newImageData: function(number, number, Image.PixelFormat, string): Image.ImageData
  newImageData: function(number, number, string): Image.ImageData
  newImageData: function(string): Image.ImageData
  newImageData: function(Filesystem.FileData): Image.ImageData
end

local record Joystick
  --  enums
  enum GamepadAxis
    'leftx'
    'lefty'
    'rightx'
    'righty'
    'triggerleft'
    'triggerright'
  end
  enum GamepadButton
    'a'
    'b'
    'x'
    'y'
    'back'
    'guide'
    'start'
    'leftstick'
    'rightstick'
    'leftshoulder'
    'rightshoulder'
    'dpup'
    'dpdown'
    'dpleft'
    'dpright'
  end
  enum JoystickHat
    'c'
    'd'
    'l'
    'ld'
    'lu'
    'r'
    'rd'
    'ru'
    'u'
  end
  enum JoystickInputType
    'axis'
    'button'
    'hat'
  end

  --  types
  record Joystick
    getAxes: function(): (number, number, number)
    getAxis: function(number): number
    getAxisCount: function(): number
    getButtonCount: function(): number
    getDeviceInfo: function(): (number, number, number)
    getGUID: function(): string
    getGamepadAxis: function(Joystick.GamepadAxis): number
    getGamepadMapping: function(Joystick.GamepadAxis): (Joystick.JoystickInputType, number, Joystick.JoystickHat)
    getGamepadMapping: function(Joystick.GamepadButton): (Joystick.JoystickInputType, number, Joystick.JoystickHat)
    getGamepadMappingString: function(): string
    getHat: function(number): Joystick.JoystickHat
    getHatCount: function(): number
    getID: function(): (number, number)
    getName: function(): string
    getVibration: function(): (number, number)
    isConnected: function(): boolean
    isDown: function(number): boolean
    isGamepad: function(): boolean
    isGamepadDown: function(Joystick.GamepadButton): boolean
    isVibrationSupported: function(): boolean
    setVibration: function(number, number): boolean
    setVibration: function(): boolean
    setVibration: function(number, number, number): boolean
  end

  --  functions
  getGamepadMappingString: function(string): string
  getJoystickCount: function(): number
  getJoysticks: function(): table
  loadGamepadMappings: function(string)
  loadGamepadMappings: function(string)
  saveGamepadMappings: function(string): string
  saveGamepadMappings: function(): string
  setGamepadMapping: function(string, Joystick.GamepadButton, Joystick.JoystickInputType, number, Joystick.JoystickHat): boolean
  setGamepadMapping: function(string, Joystick.GamepadAxis, Joystick.JoystickInputType, number, Joystick.JoystickHat): boolean
end

local record Keyboard
  --  enums
  enum KeyConstant
    'a'
    'b'
    'c'
    'd'
    'e'
    'f'
    'g'
    'h'
    'i'
    'j'
    'k'
    'l'
    'm'
    'n'
    'o'
    'p'
    'q'
    'r'
    's'
    't'
    'u'
    'v'
    'w'
    'x'
    'y'
    'z'
    '0'
    '1'
    '2'
    '3'
    '4'
    '5'
    '6'
    '7'
    '8'
    '9'
    'space'
    '!'
    '"'
    '#'
    '$'
    '&'
    '\''
    '('
    ')'
    '*'
    '+'
    ','
    '-'
    '.'
    '/'
    ':'
    ';'
    '<'
    '='
    '>'
    '?'
    '@'
    '['
    '\\'
    ']'
    '^'
    '_'
    '`'
    'kp0'
    'kp1'
    'kp2'
    'kp3'
    'kp4'
    'kp5'
    'kp6'
    'kp7'
    'kp8'
    'kp9'
    'kp.'
    'kp/'
    'kp*'
    'kp-'
    'kp+'
    'kpenter'
    'kp='
    'up'
    'down'
    'right'
    'left'
    'home'
    'end'
    'pageup'
    'pagedown'
    'insert'
    'backspace'
    'tab'
    'clear'
    'return'
    'delete'
    'f1'
    'f2'
    'f3'
    'f4'
    'f5'
    'f6'
    'f7'
    'f8'
    'f9'
    'f10'
    'f11'
    'f12'
    'f13'
    'f14'
    'f15'
    'numlock'
    'capslock'
    'scrollock'
    'rshift'
    'lshift'
    'rctrl'
    'lctrl'
    'ralt'
    'lalt'
    'rmeta'
    'lmeta'
    'lsuper'
    'rsuper'
    'mode'
    'compose'
    'pause'
    'escape'
    'help'
    'print'
    'sysreq'
    'break'
    'menu'
    'power'
    'euro'
    'undo'
    'www'
    'mail'
    'calculator'
    'appsearch'
    'apphome'
    'appback'
    'appforward'
    'apprefresh'
    'appbookmarks'
  end
  enum Scancode
    'a'
    'b'
    'c'
    'd'
    'e'
    'f'
    'g'
    'h'
    'i'
    'j'
    'k'
    'l'
    'm'
    'n'
    'o'
    'p'
    'q'
    'r'
    's'
    't'
    'u'
    'v'
    'w'
    'x'
    'y'
    'z'
    '1'
    '2'
    '3'
    '4'
    '5'
    '6'
    '7'
    '8'
    '9'
    '0'
    'return'
    'escape'
    'backspace'
    'tab'
    'space'
    '-'
    '='
    '['
    ']'
    '\\'
    'nonus#'
    ';'
    '\''
    '`'
    ','
    '.'
    '/'
    'capslock'
    'f1'
    'f2'
    'f3'
    'f4'
    'f5'
    'f6'
    'f7'
    'f8'
    'f9'
    'f10'
    'f11'
    'f12'
    'f13'
    'f14'
    'f15'
    'f16'
    'f17'
    'f18'
    'f19'
    'f20'
    'f21'
    'f22'
    'f23'
    'f24'
    'lctrl'
    'lshift'
    'lalt'
    'lgui'
    'rctrl'
    'rshift'
    'ralt'
    'rgui'
    'printscreen'
    'scrolllock'
    'pause'
    'insert'
    'home'
    'numlock'
    'pageup'
    'delete'
    'end'
    'pagedown'
    'right'
    'left'
    'down'
    'up'
    'nonusbackslash'
    'application'
    'execute'
    'help'
    'menu'
    'select'
    'stop'
    'again'
    'undo'
    'cut'
    'copy'
    'paste'
    'find'
    'kp/'
    'kp*'
    'kp-'
    'kp+'
    'kp='
    'kpenter'
    'kp1'
    'kp2'
    'kp3'
    'kp4'
    'kp5'
    'kp6'
    'kp7'
    'kp8'
    'kp9'
    'kp0'
    'kp.'
    'international1'
    'international2'
    'international3'
    'international4'
    'international5'
    'international6'
    'international7'
    'international8'
    'international9'
    'lang1'
    'lang2'
    'lang3'
    'lang4'
    'lang5'
    'mute'
    'volumeup'
    'volumedown'
    'audionext'
    'audioprev'
    'audiostop'
    'audioplay'
    'audiomute'
    'mediaselect'
    'www'
    'mail'
    'calculator'
    'computer'
    'acsearch'
    'achome'
    'acback'
    'acforward'
    'acstop'
    'acrefresh'
    'acbookmarks'
    'power'
    'brightnessdown'
    'brightnessup'
    'displayswitch'
    'kbdillumtoggle'
    'kbdillumdown'
    'kbdillumup'
    'eject'
    'sleep'
    'alterase'
    'sysreq'
    'cancel'
    'clear'
    'prior'
    'return2'
    'separator'
    'out'
    'oper'
    'clearagain'
    'crsel'
    'exsel'
    'kp00'
    'kp000'
    'thsousandsseparator'
    'decimalseparator'
    'currencyunit'
    'currencysubunit'
    'app1'
    'app2'
    'unknown'
  end

  --  functions
  getKeyFromScancode: function(Keyboard.Scancode): Keyboard.KeyConstant
  getScancodeFromKey: function(Keyboard.KeyConstant): Keyboard.Scancode
  hasKeyRepeat: function(): boolean
  hasTextInput: function(): boolean
  isDown: function(Keyboard.KeyConstant): boolean
  isDown: function(Keyboard.KeyConstant, Keyboard.KeyConstant): boolean
  isScancodeDown: function(Keyboard.Scancode, Keyboard.Scancode): boolean
  setKeyRepeat: function(boolean)
  setTextInput: function(boolean)
  setTextInput: function(boolean, number, number, number, number)
end

local record Math
  --  enums
  enum MatrixLayout
    'row'
    'column'
  end

  --  types
  record BezierCurve
    evaluate: function(number): (number, number)
    getControlPoint: function(number): (number, number)
    getControlPointCount: function(): number
    getDegree: function(): number
    getDerivative: function(): Math.BezierCurve
    getSegment: function(number, number): Math.BezierCurve
    insertControlPoint: function(number, number, number)
    removeControlPoint: function(number)
    render: function(number): table
    renderSegment: function(number, number, number): table
    rotate: function(number, number, number)
    scale: function(number, number, number)
    setControlPoint: function(number, number, number)
    translate: function(number, number)
  end
  record RandomGenerator
    getSeed: function(): (number, number)
    getState: function(): string
    random: function(): number
    random: function(number): number
    random: function(number, number): number
    randomNormal: function(number, number): number
    setSeed: function(number)
    setSeed: function(number, number)
    setState: function(string)
  end
  record Transform
    apply: function(Math.Transform): Math.Transform
    clone: function(): Math.Transform
    getMatrix: function(): (number, number, number, number)
    inverse: function(): Math.Transform
    inverseTransformPoint: function(number, number): (number, number)
    isAffine2DTransform: function(): boolean
    reset: function(): Math.Transform
    rotate: function(number): Math.Transform
    scale: function(number, number): Math.Transform
    setMatrix: function(number, number, number, number): Math.Transform
    setMatrix: function(Math.MatrixLayout, number, number, number, number): Math.Transform
    setMatrix: function(Math.MatrixLayout, table): Math.Transform
    setMatrix: function(Math.MatrixLayout, table): Math.Transform
    setTransformation: function(number, number, number, number, number, number, number, number, number): Math.Transform
    shear: function(number, number): Math.Transform
    transformPoint: function(number, number): (number, number)
    translate: function(number, number): Math.Transform
  end

  --  functions
  colorFromBytes: function(number, number, number, number): (number, number, number, number)
  colorToBytes: function(number, number, number, number): (number, number, number, number)
  compress: function(string, Data.CompressedDataFormat, number): Data.CompressedData
  compress: function(Data, Data.CompressedDataFormat, number): Data.CompressedData
  decompress: function(Data.CompressedData): string
  decompress: function(string, Data.CompressedDataFormat): string
  decompress: function(Data, Data.CompressedDataFormat): string
  gammaToLinear: function(number, number, number): (number, number, number)
  gammaToLinear: function(table): (number, number, number)
  gammaToLinear: function(number): number
  getRandomSeed: function(): (number, number)
  getRandomState: function(): string
  isConvex: function(table): boolean
  isConvex: function(number, number, number, number, number, number): boolean
  linearToGamma: function(number, number, number): (number, number, number)
  linearToGamma: function(table): (number, number, number)
  linearToGamma: function(number): number
  newBezierCurve: function(table): Math.BezierCurve
  newBezierCurve: function(number, number, number, number, number, number): Math.BezierCurve
  newRandomGenerator: function(): Math.RandomGenerator
  newRandomGenerator: function(number): Math.RandomGenerator
  newRandomGenerator: function(number, number): Math.RandomGenerator
  newTransform: function(): Math.Transform
  newTransform: function(number, number, number, number, number, number, number, number, number): Math.Transform
  noise: function(number): number
  noise: function(number, number): number
  noise: function(number, number, number): number
  noise: function(number, number, number, number): number
  random: function(): number
  random: function(number): number
  random: function(number, number): number
  randomNormal: function(number, number): number
  setRandomSeed: function(number)
  setRandomSeed: function(number, number)
  setRandomState: function(string)
  triangulate: function(table): table
  triangulate: function(number, number, number, number, number, number): table
end

local record Mouse
  --  enums
  enum CursorType
    'image'
    'arrow'
    'ibeam'
    'wait'
    'waitarrow'
    'crosshair'
    'sizenwse'
    'sizenesw'
    'sizewe'
    'sizens'
    'sizeall'
    'no'
    'hand'
  end

  --  types
  record Cursor
    getType: function(): Mouse.CursorType
  end

  --  functions
  getCursor: function(): Mouse.Cursor
  getPosition: function(): (number, number)
  getRelativeMode: function(): boolean
  getSystemCursor: function(Mouse.CursorType): Mouse.Cursor
  getX: function(): number
  getY: function(): number
  hasCursor: function(): boolean
  isCursorSupported: function(): boolean
  isDown: function(number, number): boolean
  isGrabbed: function(): boolean
  isVisible: function(): boolean
  newCursor: function(Image.ImageData, number, number): Mouse.Cursor
  newCursor: function(string, number, number): Mouse.Cursor
  newCursor: function(Filesystem.FileData, number, number): Mouse.Cursor
  setCursor: function(Mouse.Cursor)
  setCursor: function()
  setGrabbed: function(boolean)
  setPosition: function(number, number)
  setRelativeMode: function(boolean)
  setVisible: function(boolean)
  setX: function(number)
  setY: function(number)
end

local record Physics
  --  enums
  enum BodyType
    'static'
    'dynamic'
    'kinematic'
  end
  enum JointType
    'distance'
    'friction'
    'gear'
    'mouse'
    'prismatic'
    'pulley'
    'revolute'
    'rope'
    'weld'
  end
  enum ShapeType
    'circle'
    'polygon'
    'edge'
    'chain'
  end

  --  types
  record Body
    applyAngularImpulse: function(number)
    applyForce: function(number, number)
    applyForce: function(number, number, number, number)
    applyLinearImpulse: function(number, number)
    applyLinearImpulse: function(number, number, number, number)
    applyTorque: function(number)
    destroy: function()
    getAngle: function(): number
    getAngularDamping: function(): number
    getAngularVelocity: function(): number
    getContacts: function(): table
    getFixtures: function(): table
    getGravityScale: function(): number
    getInertia: function(): number
    getJoints: function(): table
    getLinearDamping: function(): number
    getLinearVelocity: function(): (number, number)
    getLinearVelocityFromLocalPoint: function(number, number): (number, number)
    getLinearVelocityFromWorldPoint: function(number, number): (number, number)
    getLocalCenter: function(): (number, number)
    getLocalPoint: function(number, number): (number, number)
    getLocalVector: function(number, number): (number, number)
    getMass: function(): number
    getMassData: function(): (number, number, number, number)
    getPosition: function(): (number, number)
    getTransform: function(): (number, number, number)
    getType: function(): Physics.BodyType
    getUserData: function(): any
    getWorld: function(): Physics.World
    getWorldCenter: function(): (number, number)
    getWorldPoint: function(number, number): (number, number)
    getWorldPoints: function(number, number, number, number): (number, number, number, number)
    getWorldVector: function(number, number): (number, number)
    getX: function(): number
    getY: function(): number
    isActive: function(): boolean
    isAwake: function(): boolean
    isBullet: function(): boolean
    isDestroyed: function(): boolean
    isFixedRotation: function(): boolean
    isSleepingAllowed: function(): boolean
    isTouching: function(Physics.Body): boolean
    resetMassData: function()
    setActive: function(boolean)
    setAngle: function(number)
    setAngularDamping: function(number)
    setAngularVelocity: function(number)
    setAwake: function(boolean)
    setBullet: function(boolean)
    setFixedRotation: function(boolean)
    setGravityScale: function(number)
    setInertia: function(number)
    setLinearDamping: function(number)
    setLinearVelocity: function(number, number)
    setMass: function(number)
    setMassData: function(number, number, number, number)
    setPosition: function(number, number)
    setSleepingAllowed: function(boolean)
    setTransform: function(number, number, number)
    setType: function(Physics.BodyType)
    setUserData: function(any)
    setX: function(number)
    setY: function(number)
  end
  record ChainShape
    getChildEdge: function(number): Physics.EdgeShape
    getNextVertex: function(): (number, number)
    getPoint: function(number): (number, number)
    getPoints: function(): (number, number, number, number)
    getPreviousVertex: function(): (number, number)
    getVertexCount: function(): number
    setNextVertex: function(number, number)
    setPreviousVertex: function(number, number)
  end
  record CircleShape
    getPoint: function(): (number, number)
    getRadius: function(): number
    setPoint: function(number, number)
    setRadius: function(number)
  end
  record Contact
    getFixtures: function(): (Physics.Fixture, Physics.Fixture)
    getFriction: function(): number
    getNormal: function(): (number, number)
    getPositions: function(): (number, number, number, number)
    getRestitution: function(): number
    isEnabled: function(): boolean
    isTouching: function(): boolean
    resetFriction: function()
    resetRestitution: function()
    setEnabled: function(boolean)
    setFriction: function(number)
    setRestitution: function(number)
  end
  record DistanceJoint
    getDampingRatio: function(): number
    getFrequency: function(): number
    getLength: function(): number
    setDampingRatio: function(number)
    setFrequency: function(number)
    setLength: function(number)
  end
  record EdgeShape
    getNextVertex: function(): (number, number)
    getPoints: function(): (number, number, number, number)
    getPreviousVertex: function(): (number, number)
    setNextVertex: function(number, number)
    setPreviousVertex: function(number, number)
  end
  record Fixture
    destroy: function()
    getBody: function(): Physics.Body
    getBoundingBox: function(number): (number, number, number, number)
    getCategory: function(): (number, number)
    getDensity: function(): number
    getFilterData: function(): (number, number, number)
    getFriction: function(): number
    getGroupIndex: function(): number
    getMask: function(): (number, number)
    getMassData: function(): (number, number, number, number)
    getRestitution: function(): number
    getShape: function(): Physics.Shape
    getUserData: function(): any
    isDestroyed: function(): boolean
    isSensor: function(): boolean
    rayCast: function(number, number, number, number, number, number): (number, number, number)
    setCategory: function(number, number)
    setDensity: function(number)
    setFilterData: function(number, number, number)
    setFriction: function(number)
    setGroupIndex: function(number)
    setMask: function(number, number)
    setRestitution: function(number)
    setSensor: function(boolean)
    setUserData: function(any)
    testPoint: function(number, number): boolean
  end
  record FrictionJoint
    getMaxForce: function(): number
    getMaxTorque: function(): number
    setMaxForce: function(number)
    setMaxTorque: function(number)
  end
  record GearJoint
    getJoints: function(): (Physics.Joint, Physics.Joint)
    getRatio: function(): number
    setRatio: function(number)
  end
  record Joint
    destroy: function()
    getAnchors: function(): (number, number, number, number)
    getBodies: function(): (Physics.Body, Physics.Body)
    getCollideConnected: function(): boolean
    getReactionForce: function(number): (number, number)
    getReactionTorque: function(number): number
    getType: function(): Physics.JointType
    getUserData: function(): any
    isDestroyed: function(): boolean
    setUserData: function(any)
  end
  record MotorJoint
    getAngularOffset: function(): number
    getLinearOffset: function(): (number, number)
    setAngularOffset: function(number)
    setLinearOffset: function(number, number)
  end
  record MouseJoint
    getDampingRatio: function(): number
    getFrequency: function(): number
    getMaxForce: function(): number
    getTarget: function(): (number, number)
    setDampingRatio: function(number)
    setFrequency: function(number)
    setMaxForce: function(number)
    setTarget: function(number, number)
  end
  record PolygonShape
    getPoints: function(): (number, number, number, number)
  end
  record PrismaticJoint
    areLimitsEnabled: function(): boolean
    getAxis: function(): (number, number)
    getJointSpeed: function(): number
    getJointTranslation: function(): number
    getLimits: function(): (number, number)
    getLowerLimit: function(): number
    getMaxMotorForce: function(): number
    getMotorForce: function(number): number
    getMotorSpeed: function(): number
    getUpperLimit: function(): number
    isMotorEnabled: function(): boolean
    setLimits: function(number, number)
    setLimitsEnabled: function(): boolean
    setLowerLimit: function(number)
    setMaxMotorForce: function(number)
    setMotorEnabled: function(boolean)
    setMotorSpeed: function(number)
    setUpperLimit: function(number)
  end
  record PulleyJoint
    getConstant: function(): number
    getGroundAnchors: function(): (number, number, number, number)
    getLengthA: function(): number
    getLengthB: function(): number
    getMaxLengths: function(): (number, number)
    getRatio: function(): number
    setConstant: function(number)
    setMaxLengths: function(number, number)
    setRatio: function(number)
  end
  record RevoluteJoint
    areLimitsEnabled: function(): boolean
    getJointAngle: function(): number
    getJointSpeed: function(): number
    getLimits: function(): (number, number)
    getLowerLimit: function(): number
    getMaxMotorTorque: function(): number
    getMotorSpeed: function(): number
    getMotorTorque: function(): number
    getUpperLimit: function(): number
    hasLimitsEnabled: function(): boolean
    isMotorEnabled: function(): boolean
    setLimits: function(number, number)
    setLimitsEnabled: function(boolean)
    setLowerLimit: function(number)
    setMaxMotorTorque: function(number)
    setMotorEnabled: function(boolean)
    setMotorSpeed: function(number)
    setUpperLimit: function(number)
  end
  record RopeJoint
    getMaxLength: function(): number
    setMaxLength: function(number)
  end
  record Shape
    computeAABB: function(number, number, number, number): (number, number, number, number)
    computeMass: function(number): (number, number, number, number)
    getChildCount: function(): number
    getRadius: function(): number
    getType: function(): Physics.ShapeType
    rayCast: function(number, number, number, number, number, number, number, number, number): (number, number, number)
    testPoint: function(number, number, number, number, number): boolean
  end
  record WeldJoint
    getDampingRatio: function(): number
    getFrequency: function(): number
    setDampingRatio: function(number)
    setFrequency: function(number)
  end
  record WheelJoint
    getAxis: function(): (number, number)
    getJointSpeed: function(): number
    getJointTranslation: function(): number
    getMaxMotorTorque: function(): number
    getMotorSpeed: function(): number
    getMotorTorque: function(number): number
    getSpringDampingRatio: function(): number
    getSpringFrequency: function(): number
    setMaxMotorTorque: function(number)
    setMotorEnabled: function(boolean)
    setMotorSpeed: function(number)
    setSpringDampingRatio: function(number)
    setSpringFrequency: function(number)
  end
  record World
    destroy: function()
    getBodies: function(): table
    getBodyCount: function(): number
    getCallbacks: function(): (function, function, function, function)
    getContactCount: function(): number
    getContactFilter: function(): function
    getContacts: function(): table
    getGravity: function(): (number, number)
    getJointCount: function(): number
    getJoints: function(): table
    isDestroyed: function(): boolean
    isLocked: function(): boolean
    isSleepingAllowed: function(): boolean
    queryBoundingBox: function(number, number, number, number, function)
    rayCast: function(Physics.Fixture, number, number, number, number, number): number
    setCallbacks: function(function, function, function, function)
    setContactFilter: function(function)
    setGravity: function(number, number)
    setSleepingAllowed: function(boolean)
    translateOrigin: function(number, number)
    update: function(number, number, number)
  end

  --  functions
  getDistance: function(Physics.Fixture, Physics.Fixture): (number, number, number, number, number)
  getMeter: function(): number
  newBody: function(Physics.World, number, number, Physics.BodyType): Physics.Body
  newChainShape: function(boolean, number, number, number, number, number): Physics.ChainShape
  newChainShape: function(boolean, table): Physics.ChainShape
  newCircleShape: function(number): Physics.CircleShape
  newCircleShape: function(number, number, number): Physics.CircleShape
  newDistanceJoint: function(Physics.Body, Physics.Body, number, number, number, number, boolean): Physics.DistanceJoint
  newEdgeShape: function(number, number, number, number): Physics.EdgeShape
  newFixture: function(Physics.Body, Physics.Shape, number): Physics.Fixture
  newFrictionJoint: function(Physics.Body, Physics.Body, number, number, boolean): Physics.FrictionJoint
  newFrictionJoint: function(Physics.Body, Physics.Body, number, number, number, number, boolean): Physics.FrictionJoint
  newGearJoint: function(Physics.Joint, Physics.Joint, number, boolean): Physics.GearJoint
  newMotorJoint: function(Physics.Body, Physics.Body, number): Physics.MotorJoint
  newMotorJoint: function(Physics.Body, Physics.Body, number, boolean): Physics.MotorJoint
  newMouseJoint: function(Physics.Body, number, number): Physics.MouseJoint
  newPolygonShape: function(number, number, number, number, number, number, number): Physics.PolygonShape
  newPolygonShape: function(table): Physics.PolygonShape
  newPrismaticJoint: function(Physics.Body, Physics.Body, number, number, number, number, boolean): Physics.PrismaticJoint
  newPrismaticJoint: function(Physics.Body, Physics.Body, number, number, number, number, number, number, boolean): Physics.PrismaticJoint
  newPrismaticJoint: function(Physics.Body, Physics.Body, number, number, number, number, number, number, boolean, number): Physics.PrismaticJoint
  newPulleyJoint: function(Physics.Body, Physics.Body, number, number, number, number, number, number, number, number, number, boolean): Physics.PulleyJoint
  newRectangleShape: function(number, number): Physics.PolygonShape
  newRectangleShape: function(number, number, number, number, number): Physics.PolygonShape
  newRevoluteJoint: function(Physics.Body, Physics.Body, number, number, boolean): Physics.RevoluteJoint
  newRevoluteJoint: function(Physics.Body, Physics.Body, number, number, number, number, boolean, number): Physics.RevoluteJoint
  newRopeJoint: function(Physics.Body, Physics.Body, number, number, number, number, number, boolean): Physics.RopeJoint
  newWeldJoint: function(Physics.Body, Physics.Body, number, number, boolean): Physics.WeldJoint
  newWeldJoint: function(Physics.Body, Physics.Body, number, number, number, number, boolean): Physics.WeldJoint
  newWeldJoint: function(Physics.Body, Physics.Body, number, number, number, number, boolean, number): Physics.WeldJoint
  newWheelJoint: function(Physics.Body, Physics.Body, number, number, number, number, boolean): Physics.WheelJoint
  newWheelJoint: function(Physics.Body, Physics.Body, number, number, number, number, number, number, boolean): Physics.WheelJoint
  newWorld: function(number, number, boolean): Physics.World
  setMeter: function(number)
end

local record Sound
  --  types
  record Decoder
    clone: function(): Sound.Decoder
    getBitDepth: function(): number
    getChannelCount: function(): number
    getDuration: function(): number
    getSampleRate: function(): number
  end
  record SoundData
    getBitDepth: function(): number
    getChannelCount: function(): number
    getDuration: function(): number
    getSample: function(number): number
    getSample: function(number, number): number
    getSampleCount: function(): number
    getSampleRate: function(): number
    setSample: function(number, number)
    setSample: function(number, number, number)
  end

  --  functions
  newDecoder: function(Filesystem.File, number): Sound.Decoder
  newDecoder: function(string, number): Sound.Decoder
  newSoundData: function(string): Sound.SoundData
  newSoundData: function(Filesystem.File): Sound.SoundData
  newSoundData: function(Sound.Decoder): Sound.SoundData
  newSoundData: function(number, number, number, number): Sound.SoundData
end

local record System
  --  enums
  enum PowerState
    'unknown'
    'battery'
    'nobattery'
    'charging'
    'charged'
  end

  --  functions
  getClipboardText: function(): string
  getOS: function(): string
  getPowerInfo: function(): (System.PowerState, number, number)
  getProcessorCount: function(): number
  hasBackgroundMusic: function(): boolean
  openURL: function(string): boolean
  setClipboardText: function(string)
  vibrate: function(number)
end

local record Thread
  --  types
  record Channel
    clear: function()
    demand: function(): any
    demand: function(number): any
    getCount: function(): number
    hasRead: function(number): boolean
    peek: function(): any
    performAtomic: function(function, any, any): (any, any)
    pop: function(): any
    push: function(any): number
    supply: function(any): boolean
    supply: function(any, number): boolean
  end
  record Thread
    getError: function(): string
    isRunning: function(): boolean
    start: function()
    start: function(any, any, any)
    wait: function()
  end

  --  functions
  getChannel: function(string): Thread.Channel
  newChannel: function(): Thread.Channel
  newThread: function(string): Thread.Thread
  newThread: function(Filesystem.FileData): Thread.Thread
  newThread: function(string): Thread.Thread
end

local record Timer
  --  functions
  getAverageDelta: function(): number
  getDelta: function(): number
  getFPS: function(): number
  getTime: function(): number
  sleep: function(number)
  step: function(): number
end

local record Touch
  --  functions
  getPosition: function(any): (number, number)
  getPressure: function(any): number
  getTouches: function(): table
end

local record Video
  --  types
  record VideoStream
  end

  --  functions
  newVideoStream: function(string): Video.VideoStream
  newVideoStream: function(Filesystem.File): Video.VideoStream
end

local record Window
  --  enums
  enum DisplayOrientation
    'unknown'
    'landscape'
    'landscapeflipped'
    'portrait'
    'portraitflipped'
  end
  enum FullscreenType
    'desktop'
    'exclusive'
    'normal'
  end
  enum MessageBoxType
    'info'
    'warning'
    'error'
  end

  --  functions
  close: function()
  fromPixels: function(number): number
  fromPixels: function(number, number): (number, number)
  getDPIScale: function(): number
  getDisplayName: function(number): string
  getDisplayOrientation: function(number): Window.DisplayOrientation
  getFullscreen: function(): (boolean, Window.FullscreenType)
  getFullscreenModes: function(number): table
  getIcon: function(): Image.ImageData
  getMode: function(): (number, number, table)
  getPosition: function(): (number, number, number)
  getSafeArea: function(): (number, number, number, number)
  getTitle: function(): string
  getVSync: function(): number
  hasFocus: function(): boolean
  hasMouseFocus: function(): boolean
  isDisplaySleepEnabled: function(): boolean
  isMaximized: function(): boolean
  isMinimized: function(): boolean
  isOpen: function(): boolean
  isVisible: function(): boolean
  maximize: function()
  minimize: function()
  requestAttention: function(boolean)
  restore: function()
  setDisplaySleepEnabled: function(boolean)
  setFullscreen: function(boolean): boolean
  setFullscreen: function(boolean, Window.FullscreenType): boolean
  setIcon: function(Image.ImageData): boolean
  setMode: function(number, number, table): boolean
  setPosition: function(number, number, number)
  setTitle: function(string)
  setVSync: function(number)
  showMessageBox: function(string, string, Window.MessageBoxType, boolean): boolean
  showMessageBox: function(string, string, table, Window.MessageBoxType, boolean): number
  toPixels: function(number): number
  toPixels: function(number, number): (number, number)
  updateMode: function(number, number, table): boolean
end

local record Love
  --  types
  record Data
    clone: function(): Data
    getFFIPointer: function(): any
    getPointer: function(): any
    getSize: function(): number
    getString: function(): string
  end
  record Object
    release: function(): boolean
    type: function(): string
    typeOf: function(string): boolean
  end

  --  functions
  getVersion: function(): (number, number, number, string)
  hasDeprecationOutput: function(): boolean
  setDeprecationOutput: function(boolean)

  --  callbacks
  conf: function(table)
  directorydropped: function(string)
  displayrotated: function(number, Window.DisplayOrientation)
  draw: function()
  errorhandler: function(string)
  filedropped: function(Filesystem.DroppedFile)
  focus: function(boolean)
  gamepadaxis: function(Joystick.Joystick, Joystick.GamepadAxis, number)
  gamepadpressed: function(Joystick.Joystick, Joystick.GamepadButton)
  gamepadreleased: function(Joystick.Joystick, Joystick.GamepadButton)
  joystickadded: function(Joystick.Joystick)
  joystickaxis: function(Joystick.Joystick, number, number)
  joystickhat: function(Joystick.Joystick, number, Joystick.JoystickHat)
  joystickpressed: function(Joystick.Joystick, number)
  joystickreleased: function(Joystick.Joystick, number)
  joystickremoved: function(Joystick.Joystick)
  keypressed: function(Keyboard.KeyConstant, Keyboard.Scancode, boolean)
  keypressed: function(Keyboard.KeyConstant, boolean)
  keyreleased: function(Keyboard.KeyConstant, Keyboard.Scancode)
  load: function(table, table)
  lowmemory: function()
  mousefocus: function(boolean)
  mousemoved: function(number, number, number, number, boolean)
  mousepressed: function(number, number, number, boolean, number)
  mousereleased: function(number, number, number, boolean, number)
  quit: function(): boolean
  resize: function(number, number)
  run: function(): function
  textedited: function(string, number, number)
  textinput: function(string)
  threaderror: function(Thread.Thread, string)
  touchmoved: function(any, number, number, number, number, number)
  touchpressed: function(any, number, number, number, number, number)
  touchreleased: function(any, number, number, number, number, number)
  update: function(number)
  visible: function(boolean)
  wheelmoved: function(number, number)

  --  modules
  audio: Audio
  data: Data
  event: Event
  filesystem: Filesystem
  font: Font
  graphics: Graphics
  image: Image
  joystick: Joystick
  keyboard: Keyboard
  math: Math
  mouse: Mouse
  physics: Physics
  sound: Sound
  system: System
  thread: Thread
  timer: Timer
  touch: Touch
  video: Video
  window: Window
end

return Love
