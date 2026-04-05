-- Teal definitions for ComputerCraft / CraftOS
-- Source basis: ported from @jackmacwindows TypeScript declarations in craftos-types and cc-types.


local enum SeekWhence
    "cur" "set" "end"
end

local enum OpenReadMode
    "r" "rb"
end

local enum OpenWriteMode
    "w" "wb" "a" "ab"
end

local enum OpenReadWriteMode
    "r+" "rb+" "w+" "wb+" "a+" "ab+"
end

global type Color = number
global type Colour = Color
global type Key = number

local type FileAttributes = record
    size: number
    isDir: boolean
    isReadOnly: boolean
    created: number
    modified: number
end

local type RequestOptions = record
    url: string
    body: string | nil
    headers: {string:string} | nil
    binary: boolean | nil
    method: string | nil
    redirect: boolean | nil
    timeout: number | nil
end

local type WebSocketOptions = record
    url: string
    headers: {string:string} | nil
    timeout: number | nil
end

local type SettingOptions = record
    description: string | nil
    default: any
    type: string | nil
end

local type UnserializeJSONOptions = record
    nbt_style: boolean | nil
    parse_null: boolean | nil
    parse_empty_array: boolean | nil
end

local type SerializeOptions = record
    compact: boolean | nil
    allow_repetitions: boolean | nil
end

local type SerializeJSONOptions = record
    nbtStyle: boolean | nil
    allow_repetitions: boolean | nil
    unicode_strings: boolean | nil
end

local type LuaDate = record
    year: number
    month: number
    day: number
    hour: number
    min: number
    sec: number
    wday: number
    yday: number
    isdst: boolean
end

local type ItemDetail = record
    name: string
    count: string
    nbt: string | nil
    displayName: string
    maxCount: number
    damage: number | nil
    maxDamage: number | nil
    durability: number | nil
    tags: {string}
    lore: {string} | nil
    enchantments: {{string:any}} | nil
    unbreakable: boolean | nil
end

local record ReadFileHandle
    close: function()
    seek: function(? SeekWhence, ? number): number
    read: function(? number): string | number
    readLine: function(? boolean): string
    readAll: function(): string
end

local record WriteFileHandle
    close: function()
    seek: function(? SeekWhence, ? number): number
    write: function(any)
    writeLine: function(string)
    flush: function()
end

local record HTTPResponse
    getResponseCode: function(): number
    getResponseHeaders: function(): {string:string}
    read: function(? number): string | number | nil
    readLine: function(? boolean): string | nil
    readAll: function(): string | nil
    close: function()
end

local record WebSocket
    receive: function(? number): string | nil
    send: function(string, ? boolean)
    close: function()
end

local interface IPeripheral
end

local interface ITerminal
    write: function(string)
    blit: function(string, string, string)
    clear: function()
    clearLine: function()
    getCursorPos: function(): number, number
    setCursorPos: function(number, number)
    getCursorBlink: function(): boolean
    setCursorBlink: function(boolean)
    isColor: function(): boolean
    isColour: function(): boolean
    getSize: function(? boolean | number): number, number
    scroll: function(number)
    getTextColor: function(): Color
    getTextColour: function(): Colour
    setTextColor: function(Color)
    setTextColour: function(Colour)
    getBackgroundColor: function(): Color
    getBackgroundColour: function(): Colour
    setBackgroundColor: function(Color)
    setBackgroundColour: function(Colour)
    getPaletteColor: function(Color): number, number, number
    getPaletteColour: function(Colour): number, number, number
    setPaletteColor: function(Color, number)
    setPaletteColor: function(Color, number, number, number)
    setPaletteColour: function(Colour, number)
    setPaletteColour: function(Colour, number, number, number)
end

global record CommandPeripheral
    is IPeripheral
    getCommand: function(): string
    setCommand: function(string)
    runCommand: function(): boolean, string | nil
end

global record ComputerPeripheral
    is IPeripheral
    turnOn: function()
    shutdown: function()
    reboot: function()
    getID: function(): number
    isOn: function(): boolean
    getLabel: function(): string
end

global record DrivePeripheral
    is IPeripheral
    isDiskPresent: function(): boolean
    getDiskLabel: function(): string
    setDiskLabel: function(? string)
    hasData: function(): boolean
    getMountPath: function(): string
    hasAudio: function(): boolean
    getAudioTitle: function(): string
    playAudio: function()
    stopAudio: function()
    ejectDisk: function()
    getDiskID: function(): number
end

global record ModemPeripheral
    is IPeripheral
    open: function(number)
    isOpen: function(number): boolean
    close: function(number)
    closeAll: function()
    transmit: function(number, number, any)
    isWireless: function(): boolean
end

global record WiredModemPeripheral
    is IPeripheral
    open: function(number)
    isOpen: function(number): boolean
    close: function(number)
    closeAll: function()
    transmit: function(number, number, any)
    isWireless: function(): boolean
    getNamesRemote: function(): {string}
    isPresentRemote: function(string): boolean
    getTypeRemote: function(string): string
    getMethodsRemote: function(string): {string}
    callRemote: function(string, string, string...): any...
    getNameLocal: function(): string
end

global record MonitorPeripheral
    is ITerminal
    setTextScale: function(number)
end

global record PrinterPeripheral
    is IPeripheral
    write: function((string | number)...)
    getCursorPos: function(): number, number
    setCursorPos: function(number, number)
    getPageSize: function(): number, number
    newPage: function()
    endPage: function()
    setPageTitle: function(? string)
    getInkLevel: function(): number
    getPaperLevel: function(): number
end

global record SpeakerPeripheral
    is IPeripheral
    playSound: function(string, ? number, ? number)
    playNote: function(string, ? number, ? number)
    playAudio: function({number}, ? number): boolean
    stop: function()
end

global record EnergyStoragePeripheral
    is IPeripheral
    getEnergy: function(): number
    getEnergyCapacity: function(): number
end

global record FluidStoragePeripheral
    is IPeripheral
    tanks: function(): {integer:{string:any}}
    pushFluid: function(string, ? number, ? string): number
    pullFluid: function(string, ? number, ? string): number
end

global record InventoryPeripheral
    is IPeripheral
    size: function(): number
    list: function(): {integer:{string:any}}
    getItemDetail: function(number): ItemDetail | nil
    getItemLimit: function(number): number
    pushItems: function(string, number, ? number, ? number): number
    pullItems: function(string, number, ? number, ? number): number
end

local record Vector
    x: number
    y: number
    z: number
    add: function(): Vector
    sub: function(): Vector
    mul: function(number): Vector
    div: function(number): Vector
    unm: function(): Vector
    dot: function(): Vector
    cross: function(): Vector
    length: function(): number
    normalize: function(): Vector
    round: function(? number): Vector
    tostring: function(): string
    equals: function(): boolean
end

local record Window
    is ITerminal
    getVisible: function(): boolean
    setVisible: function(boolean)
    redraw: function()
    restoreCursor: function()
    getPosition: function(): number, number
    reposition: function(number, number, ? number, ? number)
end

global record colors
    white: Color
    orange: Color
    magenta: Color
    lightBlue: Color
    yellow: Color
    lime: Color
    pink: Color
    gray: Color
    lightGray: Color
    cyan: Color
    purple: Color
    blue: Color
    brown: Color
    green: Color
    red: Color
    black: Color
    combine: function(Color, Color...): Color
    subtract: function(Color, Color...): Color
    test: function(Color, Color): boolean
    packRGB: function(number, number, number): number
    unpackRGB: function(number): number, number, number
    toBlit: function(Color): string
    fromBlit: function(string): Color | nil
end

global record colours
    white: Colour
    orange: Colour
    magenta: Colour
    lightBlue: Colour
    yellow: Colour
    lime: Colour
    pink: Colour
    grey: Colour
    lightGrey: Colour
    cyan: Colour
    purple: Colour
    blue: Colour
    brown: Colour
    green: Colour
    red: Colour
    black: Colour
    combine: function(Colour, Colour...): Colour
    subtract: function(Colour, Colour...): Colour
    test: function(Colour, Colour): boolean
    packRGB: function(number, number, number): number
    unpackRGB: function(number): number, number, number
    toBlit: function(Colour): string
end

global record commands
    exec: function(string): boolean, any
    execAsync: function(string): number
    list: function(string): any
    getBlockPosition: function(): number, number, number
    getBlockInfo: function(number, number, number): any
    getBlockInfos: function(number, number, number, number, number, number): any
end

global record disk
    isPresent: function(string): boolean
    getLabel: function(string): string | nil
    setLabel: function(string, ? string)
    hasData: function(string): boolean
    getMountPath: function(string): string | nil
    hasAudio: function(string): boolean
    getAudioTitle: function(string): string | nil
    playAudio: function(string)
    stopAudio: function(string)
    eject: function(string)
    getID: function(string): number
end

global record fs
    list: function(string): {string}
    exists: function(string): boolean
    isDir: function(string): boolean
    isReadOnly: function(string): boolean
    getName: function(string): string
    getDrive: function(string): string
    getSize: function(string): number
    getFreeSpace: function(string): number
    makeDir: function(string)
    move: function(string, string)
    copy: function(string, string)
    ["delete"]: function(string)
    combine: function(string, string...): string
    open: function(string, OpenReadMode): ReadFileHandle | nil, string | nil
    open: function(string, OpenWriteMode): WriteFileHandle | nil, string | nil
    open: function(string, OpenReadWriteMode): any, string | nil
    find: function(string): {string}
    getDir: function(string): string
    complete: function(string, string, ? boolean, ? boolean): {string}
    complete: function(string, string, {string:boolean | nil}): {string}
    getCapacity: function(string): number
    attributes: function(string): FileAttributes
    isDriveRoot: function(string): boolean
end

global sleep: function(number)
global write: function(string): number
global printError: function(any...)
global read: function(? string, ? {string}, ? (function(string): {string}), ? string): string

global _CC_DEFAULT_SETTINGS: string
global _CC_DISABLE_LUA51_FEATURES: boolean
global _HOST: string

global record gps
    CHANNEL_GPS: number
    locate: function(? number, ? boolean): number, number, number
end

global record help
    path: function(): string
    setPath: function(string)
    lookup: function(string): string
    topics: function(): {string}
    completeTopic: function(string): {string}
end

global record http
    request: function(string, ? string, ? {string:string}, ? boolean)
    request: function(RequestOptions)
    get: function(string, ? {string:string}, ? boolean): HTTPResponse | nil, string | nil, HTTPResponse | nil
    get: function(RequestOptions): HTTPResponse | nil, string | nil, HTTPResponse | nil
    post: function(string, ? string, ? {string:string}, ? boolean): HTTPResponse | nil, string | nil, HTTPResponse | nil
    post: function(RequestOptions): HTTPResponse | nil, string | nil, HTTPResponse | nil
    checkURLAsync: function(string)
    checkURL: function(string): boolean
    websocket: function(string, ? {string:string}): WebSocket | boolean, string | nil
    websocket: function(WebSocketOptions): WebSocket | boolean, string | nil
    websocketAsync: function(string, ? {string:string})
    websocketAsync: function(WebSocketOptions)
end

global record keys
    a: Key
    apostrophe: Key
    at: Key
    ax: Key
    b: Key
    backslash: Key
    backspace: Key
    c: Key
    capsLock: Key
    cimcumflex: Key
    colon: Key
    comma: Key
    convert: Key
    d: Key
    ["delete"]: Key
    down: Key
    e: Key
    eight: Key
    ["end"]: Key
    enter: Key
    equals: Key
    f: Key
    f1: Key
    f10: Key
    f11: Key
    f12: Key
    f13: Key
    f14: Key
    f15: Key
    f2: Key
    f3: Key
    f4: Key
    f5: Key
    f6: Key
    f7: Key
    f8: Key
    f9: Key
    five: Key
    four: Key
    g: Key
    grave: Key
    h: Key
    home: Key
    i: Key
    insert: Key
    j: Key
    k: Key
    kana: Key
    kanji: Key
    l: Key
    left: Key
    leftAlt: Key
    leftBracket: Key
    leftCtrl: Key
    leftShift: Key
    m: Key
    minus: Key
    multiply: Key
    n: Key
    nine: Key
    noconvert: Key
    numLock: Key
    numPad0: Key
    numPad1: Key
    numPad2: Key
    numPad3: Key
    numPad4: Key
    numPad5: Key
    numPad6: Key
    numPad7: Key
    numPad8: Key
    numPad9: Key
    numPadAdd: Key
    numPadComma: Key
    numPadDecimal: Key
    numPadDivide: Key
    numPadEnter: Key
    numPadEquals: Key
    numPadSubtract: Key
    o: Key
    one: Key
    p: Key
    pageDown: Key
    pageUp: Key
    pause: Key
    period: Key
    q: Key
    r: Key
    returnKey: Key
    right: Key
    rightAlt: Key
    rightBracket: Key
    rightCtrl: Key
    rightShift: Key
    s: Key
    scollLock: Key
    semiColon: Key
    seven: Key
    six: Key
    slash: Key
    space: Key
    stop: Key
    t: Key
    tab: Key
    three: Key
    two: Key
    u: Key
    underscore: Key
    up: Key
    v: Key
    w: Key
    x: Key
    y: Key
    yen: Key
    z: Key
    zero: Key
    getName: function(Key): string
end

global record multishell
    getFocus: function(): number
    setFocus: function(number)
    getTitle: function(number): string | nil
    setTitle: function(number, string)
    getCurrent: function(): number
    launch: function({any:any}, string, string...): number
    getCount: function(): number
end

global record os
    version: function(): string
    getComputerID: function(): number
    computerID: function(): number
    getComputerLabel: function(): string | nil
    computerLabel: function(): string | nil
    setComputerLabel: function(? string)
    run: function({any:any}, string, string...): boolean
    queueEvent: function(string, any...)
    clock: function(): number
    startTimer: function(number): number
    cancelTimer: function(number)
    time: function(? string): number
    sleep: function(number)
    day: function(? string): number
    setAlarm: function(number): number
    cancelAlarm: function(number)
    shutdown: function()
    reboot: function()
    epoch: function(? string): number
    date: function(? string, ? number): string | LuaDate
    pullEvent: function(? string): string, any...
    pullEventRaw: function(? string): string, any...
end

global record paintutils
    parseImage: function(string): {{number}} | nil
    loadImage: function(string): {{number}} | nil
    drawPixel: function(number, number, ? Color)
    drawLine: function(number, number, number, number, ? Color)
    drawBox: function(number, number, number, number, ? Color)
    drawFilledBox: function(number, number, number, number, ? Color)
    drawImage: function({{number}}, number, number)
end

global record parallel
    waitForAny: function((function())...)
    waitForAll: function((function())...)
end

global record peripheral
    getNames: function(): {string}
    isPresent: function(string): boolean
    getType: function(IPeripheral | string): any...
    hasType: function(IPeripheral | string, string): boolean | nil
    getMethods: function(string): {string} | nil
    getName: function(IPeripheral): string
    call: function(string, string, any...): any...
    wrap: function(string): IPeripheral
    find: function(string, ? function(IPeripheral): boolean): IPeripheral...
end

global record pocket
    equipBack: function(): boolean, string | nil
    unequipBack: function(): boolean, string | nil
end

global record rednet
    CHANNEL_BROADCAST: number
    CHANNEL_REPEAT: number
    open: function(string)
    close: function(? string)
    isOpen: function(? string)
    send: function(number, any, ? string)
    broadcast: function(any, ? string)
    receive: function(? string, ? number): number | nil, any, string | nil
    host: function(string, string)
    unhost: function(string)
    lookup: function(string, ? string)
    run: function()
end

global record redstone
    getSides: function(): {string}
    setOutput: function(string, boolean)
    getOutput: function(string): boolean
    getInput: function(string): boolean
    setAnalogOutput: function(string, number)
    getAnalogOutput: function(string): number
    getAnalogInput: function(string): number
    setAnalogueOutput: function(string, number)
    getAnalogueOutput: function(string): number
    getAnalogueInput: function(string): number
    setBundledOutput: function(string, Color)
    getBundledOutput: function(string): Color
    getBundledInput: function(string): Color
    testBundledInput: function(string, number): boolean
end

global record settings
    define: function(string, ? SettingOptions)
    undefine: function(string)
    set: function(string, any)
    get: function(string, ? any): any
    getDetails: function(string): SettingOptions
    unset: function(string)
    clear: function()
    getNames: function(): {string}
    load: function(? string)
    save: function(? string)
end

global record shell
    exit: function()
    dir: function(): string
    setDir: function(string)
    path: function(): string
    setPath: function(string)
    resolve: function(string): string
    resolveProgram: function(string): string
    aliases: function(): {string:string}
    setAlias: function(string, string)
    clearAlias: function(string)
    programs: function(? boolean): {string}
    getRunningProgram: function(): string
    run: function(string, string...): boolean
    execute: function(string, string...): boolean
    openTab: function(string, string...): number
    switchTab: function(number)
    complete: function(string): {string}
    completeProgram: function(string): {string}
    setCompletionFunction: function(string, function({any:any}, number, string, {string}): {string})
    getCompletionInfo: function(): {{string:any}}
end

global record term
    redirect: function(): ITerminal
    current: function(): ITerminal
    native: function(): ITerminal
    screenshot: function()
    showMouse: function(boolean)
    write: function(string)
    blit: function(string, string, string)
    clear: function()
    clearLine: function()
    getCursorPos: function(): number, number
    setCursorPos: function(number, number)
    getCursorBlink: function(): boolean
    setCursorBlink: function(boolean)
    isColor: function(): boolean
    isColour: function(): boolean
    getSize: function(? boolean | number): number, number
    scroll: function(number)
    getTextColor: function(): Color
    getTextColour: function(): Colour
    setTextColor: function(Color)
    setTextColour: function(Colour)
    getBackgroundColor: function(): Color
    getBackgroundColour: function(): Colour
    setBackgroundColor: function(Color)
    setBackgroundColour: function(Colour)
    nativePaletteColor: function(number): number, number, number
    nativePaletteColour: function(number): number, number, number
    getPaletteColor: function(Color): number, number, number
    getPaletteColour: function(Colour): number, number, number
    setPaletteColor: function(Color, number)
    setPaletteColor: function(Color, number, number, number)
    setPaletteColour: function(Colour, number)
    setPaletteColour: function(Colour, number, number, number)
end

global record textutils
    empty_json_array: {any:any}
    json_null: {any:any}
    slowWrite: function(string, ? number)
    slowPrint: function(string, ? number)
    formatTime: function(number, ? boolean): string
    pagedPrint: function(string, ? number): number
    tabulate: function((({any:any} | Color))...)
    pagedTabulate: function((({any:any} | Color))...)
    serialize: function(any, ? SerializeOptions): string
    serialise: function(any, ? SerializeOptions): string
    serializeJSON: function(any, ? boolean): string
    serialiseJSON: function(any, ? boolean): string
    serializeJSON: function(any, SerializeJSONOptions): string
    serialiseJSON: function(any, SerializeJSONOptions): string
    unserialize: function(string): any
    unserialise: function(string): any
    unserializeJSON: function(string, ? UnserializeJSONOptions): any
    unserialiseJSON: function(string, ? UnserializeJSONOptions): any
    urlEncode: function(string): string
    complete: function(string, ? any): {string}
end

global record turtle
    craft: function(number): boolean
    forward: function(): boolean
    back: function(): boolean
    up: function(): boolean
    down: function(): boolean
    turnLeft: function(): boolean
    turnRight: function(): boolean
    select: function(number): boolean
    getSelectedSlot: function(): number
    getItemCount: function(? number): number
    getItemSpace: function(? number): number
    getItemDetail: function(? number): any
    equipLeft: function(): boolean
    equipRight: function(): boolean
    attack: function(? string): boolean
    attackUp: function(? string): boolean
    attackDown: function(? string): boolean
    dig: function(? string): boolean
    digUp: function(? string): boolean
    digDown: function(? string): boolean
    place: function(? string): boolean
    placeUp: function(? string): boolean
    placeDown: function(? string): boolean
    detect: function(? string): boolean
    detectUp: function(? string): boolean
    detectDown: function(? string): boolean
    inspect: function(? string): boolean, any
    inspectUp: function(? string): boolean, any
    inspectDown: function(? string): boolean, any
    compare: function(? string): boolean
    compareUp: function(? string): boolean
    compareDown: function(? string): boolean
    drop: function(? string): boolean
    dropUp: function(? string): boolean
    dropDown: function(? string): boolean
    suck: function(? string): boolean
    suckUp: function(? string): boolean
    suckDown: function(? string): boolean
    refuel: function(): boolean
    refuel: function(number): boolean
    getFuelLevel: function(): number
    getFuelLimit: function(): number
    transferTo: function(number, ? number): boolean
end

global record vector
    new: function(number, number, number): Vector
end

global record window
    create: function(number, number, number, number, ? boolean): Window
end
