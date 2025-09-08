global record World<T>
   enum CollisionType
      "touch"
      "cross"
      "slide"
      "bounce"
   end

   type Vector = record
      x : number
      y : number
   end
   type Rect = record
      x : number
      y : number
      w : number
      h : number
   end
   type Collision = record<U>
      item: U
      other: U
      type : CollisionType
      overlaps: boolean
      ti: number
      move: Vector
      normal: Vector
      itemRect: Rect
      otherRect: Rect
   end

   type ItemInfo = record<U>
      item: U
      x1: number
      y1: number
      x2: number
      y2: number
      ti1: number
      ti2: number
   end

   type Filter = function(item : T, other : T) : CollisionType | boolean | nil

   add: function (self: World<T>, item: T, x : number, y: number, w: number, h: number): T
   move: function (self: World<T>, item: T, goalX: number, goalY: number, filter: Filter) : number, number, {number: Collision<T>}, number
   getRect: function(self: World<T>, item: T): number, number, number, number
   remove: function(self: World<T>, item : T)
   update: function (self: World<T>, item: T, x: number, y : number, w: number, h: number)
   check: function (self: World<T>, item: T, goalX: number, goalY: number, filter: Filter) : number, number, {number: Collision<T>}, number
   queryPoint: function (self: World<T>, x: number, y: number, filter: Filter): {number: T}, number
   queryRect: function (self: World<T>, l: number, t: number, w: number, h: number, filter: Filter): {number: T}, number
   querySegment: function (self: World<T>, x1: number, y1: number, x2: number, y2: number, filter: Filter): {number: T}, number
   querySegmentWithCoords: function (self: World<T>, x1: number, y1: number, x2: number, y2: number, filter: Filter) : {number: ItemInfo<T>}, number
   hasItem: function (self: World<T>, item: T) : boolean
   countItems: function (self: World<T>) : number
   getItems: function (self: World<T>) : {number: T}, number
   getRect: function (self: World<T>, item: T): number, number, number, number
   countCells: function (self: World<T>) : number
   toCell: function(self: World<T>, x: number, y: number): number, number
   toWorld: function (self: World<T>, x: number, y: number): number, number
   project: function (self: World<T>, item: T, x: number, y: number, w: number, h: number, goalX: number, goalY: number, filter: Filter): {number: Collision<T>}, number

end

local record bump
   newWorld: function<T>(cellSize: number) : World<T>
end

return bump
