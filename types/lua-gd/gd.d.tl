--
-- https://www.ittner.com.br/lua-gd/
--

local record gd
   VERSION: string
   COPYRIGHT: string

   -- constants
   MAX_COLORS: integer
   GD2_FMT_RAW: integer
   GD2_FMT_COMPRESSED: integer
   ARC: integer
   CHORD: integer
   PIE: integer
   NO_FILL: integer
   EDGED: integer
   ANTI_ALIASED: integer
   BRUSHED: integer
   STYLED: integer
   STYLED_BRUSHED: integer
   TILED: integer
   TRANSPARENT: integer
   FTEX_Unicode: integer
   FTEX_Shift_JIS: integer
   FTEX_Big5: integer
   DISPOSAL_NONE: integer
   DISPOSAL_UNKNOWN: integer
   DISPOSAL_RESTORE_BACKGROUND: integer
   DISPOSAL_RESTORE_PREVIOUS: integer
   FONT_TINY: integer
   FONT_SMALL: integer
   FONT_MEDIUM: integer
   FONT_LARGE: integer
   FONT_GIANT: integer

   record FTExtra
      linespacing: number
      charmap: integer
      hdpi: integer
      vdpi: integer
      disable_kerning: boolean
      xshow: boolean
      return_font_path_name: boolean
      fontconfig: boolean
   end

   record gdImage
      userdata
      createPaletteFromTrueColor: function(self: gdImage, dither: boolean, colorsWanted: integer): gdImage
      trueColorToPalette: function(self: gdImage, dither: boolean, colorsWanted: integer)
      jpeg: function(self: gdImage, filename: string, quality: integer): boolean
      jpegStr: function(self: gdImage, quality: integer): string
      png: function(self: gdImage, filename: string): boolean
      pngStr: function(self: gdImage): string
      pngEx: function(self: gdImage, filename: string, compression_level: integer): boolean
      pngStrEx: function(self: gdImage, compression_level: integer): string
      gif: function(self: gdImage, filename: string): boolean
      gifStr: function(self: gdImage): string
      gd: function(self: gdImage, filename: string): boolean
      gdStr: function(self: gdImage): string
      gd2: function(self: gdImage, filename: string, chunkSize: integer, format: integer): boolean
      gd2Str: function(self: gdImage, chunkSize: integer, format: integer): string
      wbmp: function(self: gdImage, foreground: integer, filename: string): boolean
      wbmpStr: function(self: gdImage, foreground: integer): string
      colorAllocate: function(self: gdImage, red: integer, green: integer, blue: integer): integer
      colorAllocateAlpha: function(self: gdImage, red: integer, green: integer, blue: integer, alpha: integer): integer
      colorClosest: function(self: gdImage, red: integer, green: integer, blue: integer): integer
      colorClosestAlpha: function(self: gdImage, red: integer, green: integer, blue: integer, alpha: integer): integer
      colorClosestHWB: function(self: gdImage, red: integer, green: integer, blue: integer): integer
      colorExact: function(self: gdImage, red: integer, green: integer, blue: integer): integer
      colorExactAlpha: function(self: gdImage, red: integer, green: integer, blue: integer, alpha: integer): integer
      colorResolve: function(self: gdImage, red: integer, green: integer, blue: integer): integer
      colorResolveAlpha: function(self: gdImage, red: integer, green: integer, blue: integer, alpha: integer): integer
      colorsTotal: function(self: gdImage): integer
      red: function(self: gdImage, color: integer): integer
      blue: function(self: gdImage, color: integer): integer
      green: function(self: gdImage, color: integer): integer
      alpha: function(self: gdImage, color: integer): integer
      getTransparent: function(self: gdImage): integer
      colorTransparent: function(self: gdImage, color: integer)
      colorDeallocate: function(self: gdImage, color: integer)
      boundsSafe: function(self: gdImage, x: integer, y: integer): boolean
      getPixel: function(self: gdImage, x: integer, y: integer): integer
      sizeX: function(self: gdImage): integer
      sizeY: function(self: gdImage): integer
      sizeXY: function(self: gdImage): integer, integer
      getClip: function(self: gdImage): integer, integer, integer, integer
      setClip: function(self: gdImage, x1: integer, y1: integer, x2: integer, y2: integer)
      setPixel: function(self: gdImage, x: integer, y: integer, color: integer)
      line: function(self: gdImage, x1: integer, y1: integer, x2: integer, y2: integer, color: integer)
      rectangle: function(self: gdImage, x1: integer, y1: integer, x2: integer, y2: integer, color: integer)
      filledRectangle: function(self: gdImage, x1: integer, y1: integer, x2: integer, y2: integer, color: integer)
      polygon: function(self: gdImage, points: {{integer, integer}}, color: integer)
      filledPolygon: function(self: gdImage, points: {{integer, integer}}, color: integer)
      openPolygon: function(self: gdImage, points: {{integer, integer}}, color: integer)
      arc: function(self: gdImage, cx: integer, cy: integer, w: integer, h: integer, s: integer, e: integer, color: integer)
      filledArc: function(self: gdImage, cx: integer, cy: integer, w: integer, h: integer, s: integer, e: integer, color: integer, style: integer)
      filledEllipse: function(self: gdImage, cx: integer, cy: integer, w: integer, h: integer, color: integer)
      fill: function(self: gdImage, x: integer, y: integer, color: integer)
      fillToBorder: function(self: gdImage, x: integer, y: integer, border_color: integer, color: integer)
      setAntiAliased: function(self: gdImage, color: integer)
      setAntiAliasedDontBlend: function(self: gdImage, color: integer)
      setBrush: function(self: gdImage, brush: gdImage)
      setTile: function(self: gdImage, tile: gdImage)
      setStyle: function(self: gdImage, style: {integer})
      setThickness: function(self: gdImage, thickness: integer)
      alphaBlending: function(self: gdImage, blending: boolean)
      saveAlpha: function(self: gdImage, save: boolean)
      getInterlaced: function(self: gdImage): integer
      interlace: function(self: gdImage, interlace: boolean)
      string: function(self: gdImage, font: integer, x: integer, y: integer, text: string, color: integer)
      stringUp: function(self: gdImage, font: integer, x: integer, y: integer, text: string, color: integer)
      char: function(self: gdImage, font: integer, x: integer, y: integer, char: string, color: integer)
      charUp: function(self: gdImage, font: integer, x: integer, y: integer, char: string, color: integer)
      copy: function(self: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, w: integer, h: integer)
      copyResized: function(self: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, dstW: integer, dstH: integer, srcW: integer, srcH: integer)
      copyResampled: function(self: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, dstW: integer, dstH: integer, srcW: integer, srcH: integer)
      copyRotated: function(self: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, srcW: integer, srcH: integer, angle: integer)
      copyMerge: function(self: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, w: integer, h: integer, pct: integer)
      copyMergeGray: function(self: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, w: integer, h: integer, pct: integer)
      paletteCopy: function(self: gdImage, src: gdImage)
      squareToCircle: function(self: gdImage, radius: integer)
      sharpen: function(self: gdImage, pct: integer)
      stringFT: function(self: gdImage, color: integer, fontname: string, ptsize: number, angle: number, x: integer, y: integer, text: string)
      stringFTEx: function(self: gdImage, color: integer, fontname: string, ptsize: number, angle: number, x: integer, y: integer, text: string, extra: FTExtra)
      stringFTCircle: function(self: gdImage, cx: integer, cy: integer, radius: number, textRadius: number, fillPortion: number, fontname: string, points: number, top: string, bottom: string, color: integer)
      gifAnimBegin: function(self: gdImage, filename: string, globalCM: boolean, loops: integer)
      gifAnimAdd: function(self: gdImage, filename: string, localCM: boolean, leftOfs: integer, topOfs: integer, delay: integer, disposal: integer, previm: gdImage)
      gifAnimEnd: function(self: gdImage, filename: string)
      gifAnimBeginStr: function(self: gdImage, globalCM: boolean, loops: integer): string
      gifAnimAddStr: function(self: gdImage, localCM: boolean, leftOfs: integer, topOfs: integer, delay: integer, disposal: integer, previm: gdImage): string
      gifAnimEndStr: function(self: gdImage): string
   end

   create: function(x: integer, y: integer): gdImage
   createPalette: function(x: integer, y: integer): gdImage
   createTrueColor: function(x: integer, y: integer): gdImage
   createFromJpeg: function(filename: string): gdImage
   createFromJpegStr: function(data: string): gdImage
   createFromGif: function(filename: string): gdImage
   createFromGifStr: function(data: string): gdImage
   createFromPng: function(filename: string): gdImage
   createFromPngStr: function(data: string): gdImage
   createFromGd: function(filename: string): gdImage
   createFromGdStr: function(data: string): gdImage
   createFromGd2: function(filename: string): gdImage
   createFromGd2Str: function(data: string): gdImage
   createFromGd2Part: function(filename: string, x: integer, y: integer, w: integer, h: integer): gdImage
   createFromGd2PartStr: function(data: string, x: integer, y: integer, w: integer, h: integer): gdImage
   createFromXbm: function(filename: string): gdImage
   createFromXpm: function(filename: string): gdImage
   copy: function(dst: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, w: integer, h: integer)
   copyResized: function(dst: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, dstW: integer, dstH: integer, srcW: integer, srcH: integer)
   copyResampled: function(dst: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, dstW: integer, dstH: integer, srcW: integer, srcH: integer)
   copyRotated: function(dst: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, srcW: integer, srcH: integer, angle: integer)
   copyMerge: function(dst: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, w: integer, h: integer, pct: integer)
   copyMergeGray: function(dst: gdImage, src: gdImage, dstX: integer, dstY: integer, srcX: integer, srcY: integer, w: integer, h: integer, pct: integer)
   paletteCopy: function(dst: gdImage, src: gdImage)
   fontCacheSetup: function(): boolean
   fontCacheShutdown: function()
   useFontConfig: function(flag: boolean): boolean
end

return gd
