-- https://docs.mamedev.org/luascript/ref-common.html
global type Container<K, V> = interface
  metamethod __len: function(self): integer
  metamethod __index: function(self, key: K): V
  -- __pairs and __ipairs not handled by teal
  empty: function(self): boolean
  get: function(k: K): V
  at: function(i: integer): V
  find: function(v: V): K
  index_of: function(v: V): integer
end

global record emu
  wait: function(duration: Attotime | number, ...: any): boolean
  wait_next_update: function(...: any)
  wait_next_frame: function(...: any)
  add_machine_reset_notifier: function(callback: function()): NotifierSubscription
  add_machine_stop_notifier: function(callback: function()): NotifierSubscription
  add_machine_pause_notifier: function(callback: function()): NotifierSubscription
  add_machine_resume_notifier: function(callback: function()): NotifierSubscription
  add_machine_frame_notifier: function(callback: function()): NotifierSubscription
  add_machine_pre_save_notifier: function(callback: function()): NotifierSubscription
  add_machine_post_load_notifier: function(callback: function()): NotifierSubscription
  register_sound_update: function(callback: function({string: {{number}}})): NotifierSubscription
  print_error: function(message: string)
  print_warning: function(message: string)
  print_info: function(message: string)
  print_verbose: function(message: string)
  print_debug: function(message: string)
  lang_translate: function(context?: string, message: string): string
  subst_env: function(string): string

  record attotime
    metamethod __call: function(self): Attotime
  	metamethod __call: function(self, seconds: number, attoseconds: number): Attotime
    metamethod __call: function(self, Attotime): Attotime
  
    from_double: function(seconds: number): Attotime
	  from_ticks: function(periods: integer, frequency: integer): Attotime
	  from_seconds: function(seconds: integer): Attotime
	  from_msec: function(milliseconds: integer): Attotime
	  from_usec: function(microseconds: integer): Attotime
	  from_nsec: function(nanoseconds: integer): Attotime
  end

  driver_find: function(name: string): GameDriver

  device_enumerator: function(device: Device, depth?: integer): DeviceEnumerator<Device>
  palette_enumerator: function(device: Device, depth?: integer): DeviceEnumerator<PaletteInterface>
  screen_enumerator: function(device: Device, depth?: integer): DeviceEnumerator<ScreenDevice>
  cassette_enumerator: function(device: Device, depth?: integer): DeviceEnumerator<CassetteImageDevice>
  image_enumerator: function(device: Device, depth?: integer): DeviceEnumerator<ImageInterface>
  slot_enumerator: function(device: Device, depth?: integer): DeviceEnumerator<SlotInterface>

  input_seq: function(): InputSeq
  input_seq: function(seq: InputSeq): InputSeq

  render_bounds: function(): RenderBounds
  render_bounds: function(left: number, top: number, right: number, bottom: number): RenderBounds
  render_color: function(): RenderColor
  render_color: function(a: number, r: number, g: number, b: number): RenderColor
  palette: function(colors: integer, groups?: integer): Palette
  bitmap_ind8: function(palette: Palette): Bitmap
  bitmap_ind8: function(palette: Palette, width: integer, height: integer): Bitmap
  bitmap_ind8: function(palette: Palette, width: integer, height: integer, xslop: integer, yslop: integer): Bitmap
  bitmap_ind16: function(palette: Palette): Bitmap
  bitmap_ind16: function(palette: Palette, width: integer, height: integer): Bitmap
  bitmap_ind16: function(palette: Palette, width: integer, height: integer, xslop: integer, yslop: integer): Bitmap
  bitmap_ind32: function(palette: Palette): Bitmap
  bitmap_ind32: function(palette: Palette, width: integer, height: integer): Bitmap
  bitmap_ind32: function(palette: Palette, width: integer, height: integer, xslop: integer, yslop: integer): Bitmap
  bitmap_ind64: function(palette: Palette): Bitmap
  bitmap_ind64: function(palette: Palette, width: integer, height: integer): Bitmap
  bitmap_ind64: function(palette: Palette, width: integer, height: integer, xslop: integer, yslop: integer): Bitmap
  bitmap_yuy16: function(): Bitmap
  bitmap_yuy16: function(width: integer, height: integer): Bitmap
  bitmap_yuy16: function(width: integer, height: integer, xslop: integer, yslop: integer): Bitmap
  bitmap_rgb32: function(): Bitmap
  bitmap_rgb32: function(width: integer, height: integer): Bitmap
  bitmap_rgb32: function(width: integer, height: integer, xslop: integer, yslop: integer): Bitmap
  bitmap_ind8: function(source: Bitmap): Bitmap
  bitmap_ind8: function(source: Bitmap, x0: integer, y0: integer, x1: integer, y1: integer): Bitmap
  bitmap_ind16: function(source: Bitmap): Bitmap
  bitmap_ind16: function(source: Bitmap, x0: integer, y0: integer, x1: integer, y1: integer): Bitmap
  bitmap_ind32: function(source: Bitmap): Bitmap
  bitmap_ind32: function(source: Bitmap, x0: integer, y0: integer, x1: integer, y1: integer): Bitmap
  bitmap_ind64: function(source: Bitmap): Bitmap
  bitmap_ind64: function(source: Bitmap, x0: integer, y0: integer, x1: integer, y1: integer): Bitmap
  bitmap_yuy16: function(source: Bitmap): Bitmap
  bitmap_yuy16: function(source: Bitmap, x0: integer, y0: integer, x1: integer, y1: integer): Bitmap
  bitmap_rgb32: function(source: Bitmap): Bitmap
  bitmap_rgb32: function(source: Bitmap, x0: integer, y0: integer, x1: integer, y1: integer): Bitmap

  record bitmap_argb32
    metamethod __call: function(self): Bitmap
    metamethod __call: function(self, width: integer, height: integer): Bitmap
    metamethod __call: function(self, width: integer, height: integer, xslop: integer, yslop: integer): Bitmap
    metamethod __call: function(self, source: Bitmap): Bitmap
    metamethod __call: function(self, source: Bitmap, x0: integer, y0: integer, x1: integer, y1: integer): Bitmap
    load: function(data: string): Bitmap
  end

  symbol_table: function(machine: RunningMachine): SymbolTable
  symbol_table: function(parent: SymbolTable, device?: Device): SymbolTable
  symbol_table: function(device: Device): SymbolTable
  parsed_expression: function(symbols: SymbolTable): ParsedExpression
  parsed_expression: function(symbols: SymbolTable, string, default_base?: integer): ParsedExpression
end

-- https://docs.mamedev.org/luascript/ref-core.html
global type NotifierSubscription = interface
  unsubscribe: function(self)
  is_active: boolean
end

global type Attotime = interface
  as_double: function(self): number
  as_hz: function(self): number
  as_khz: function(self): number
  as_mhz: function(self): number
  as_ticks: function(self, frequency: number): integer
  
  is_zero: boolean
  is_never: boolean
  attoseconds: integer
  seconds: integer
  msec: integer
  usec: integer
  nsec: integer
end

global type MachineManager = interface
  machine: RunningMachine
  ui: UiManager
  options: EmuOptions
  plugins: Container<string, LuaPlugin>
end

global manager: MachineManager

global type RunningMachine = interface
  exit: function(self)
  hard_reset: function(self)
  soft_reset: function(self)
  save: function(self, filename: string)
  load: function(self, filename: string)
  popmessage: function(self, msg?: string)
  logerror: function(self, msg: string)
  side_effects_disabled: function(): boolean
  
  time: Attotime
  system: GameDriver
  parameters: ParametersManager
  video: VideoManager
  sound: SoundManager
  output: OutputManager
  memory: MemoryManager
  ioport: IoPortManager
  input: InputManager
  natkeyboard: NaturalKeyboard
  uiinput: UiInputManager
  render: RenderManager
  debugger: DebuggerManager
  options: EmuOptions
  samplerate: integer
  paused: boolean
  exit_pending: boolean
  hard_reset_pending: boolean
  devices: DeviceEnumerator<Device>
  palettes: DeviceEnumerator<PaletteInterface>
  screens: DeviceEnumerator<ScreenDevice>
  cassettes: DeviceEnumerator<CassetteImageDevice>
  images: DeviceEnumerator<ImageInterface>
  slots: DeviceEnumerator<SlotInterface>
  sounds: DeviceEnumerator<SoundInterface>
end

global type VideoManager = interface
  frame_update: function(self)
  snapshot: function(self)
  begin_recording: function(self, filename: string, format: string)
  end_recording: function(self)
  snapshot_size: function(self): (number, number)
  snapshot_pixels: function(self): string

  speed_factor: integer
  throttled: boolean
  throttle_rate: boolean
  frameskip: boolean
  speed_percent: number
  effective_frameskip: integer
  skip_this_frame: boolean
  snap_native: boolean
  is_recording: boolean
  snapshot_target: RenderTarget
end

global type SoundManager = interface
  start_recording: function(self, filename?: string): boolean
  stop_recording: function(self)
  get_samples: function(self): string

  muted: boolean
  ui_mute: boolean
  debugger_mute: boolean
  system_mute: boolean
  volume: number
  recording: boolean
end

global type OutputManager = interface
  set_value: function(self, name: string, val: integer)
  set_indexed_value: function(self, prefix: string, index: integer, val: integer)
  get_value: function(self, name: string): integer
  get_indexed_value: function(self, prefix: string, index: integer): integer
  name_to_id: function(name: string): integer
  id_to_name: function(id: integer): string
end

global type ParametersManager = interface
  lookup: function(self, tag: string): string
  add: function(self, tag: string, value: string)
end

global type UiManager = interface
  get_char_width: function(self, ch: integer): number
  get_string_width: function(self, str: string): number
  set_aggressive_input_focus: function(self, enable: boolean)
  get_general_input_setting: function(self, type: integer, player?: integer): InputSeq
end

global type GameDriver = interface
  name: string
  description: string
  year: string
  manufacturer: string
  parent: string
  compatible_with: string
  source_file: string
  rotation: string
  not_working: boolean
  supports_save: boolean
  no_cocktail: boolean
  is_bios_root: boolean
  requires_artwork: boolean
  unofficial: boolean
  no_sound_hw: boolean
  mechanical: boolean
  is_incomplete: boolean
end

global type LuaPlugin = interface
  name: string
  description: string
  type: string
  directory: string
  start: boolean
end

-- https://docs.mamedev.org/luascript/ref-devices.html
global type DeviceEnumerator<V> = interface is Container<string, V> end

global type Device = interface
  subtag: function(self, tag: string)
  siblingtag: function(self, tag: string)
  memshare: function(self, tag: string): MemoryShare
  membank: function(self, tag: string): MemoryBank
  memregion: function(self, tag: string): MemoryRegion
  ioport: function(self, tag: string): IoPort
  subdevice: function(self, tag: string): Device
  siblingdevice: function(self, tag: string): Device
  parameter: function(self, tag: string): string

  tag: string
  basetag: string
  name: string
  shortname: string
  owner: Device
  configured: boolean
  started: boolean
  debug: DeviceDebugger
  state: Container<string, DeviceStateEntry>
  spaces: Container<string, AddressSpace>
end

global type PaletteInterface = interface
  pen: function(self, index: integer): integer
  pen_color: function(self, pen: integer): integer
  pen_contrast: function(self, pen: integer): number
  pen_indirect: function(self, index: integer): integer
  indirect_color: function(self, index: integer): integer
  set_pen_color: function(self, pen: integer, color: integer)
  set_pen_color: function(self, pen: integer, red: integer, green: integer, blue: integer)
  set_pen_red_level: function(self, pen: integer, level: integer)
  set_pen_green_level: function(self, pen: integer, level: integer)
  set_pen_blue_level: function(self, pen: integer, level: integer)
  set_pen_contrast: function(self, pen: integer, factor: number)
  set_pen_indirect: function(self, pen: integer, index: integer)
  set_indirect_color: function(self, index: integer, color: integer)
  set_indirect_color: function(self, index: integer, r: integer, g: integer, b: integer)
  set_shadow_factor: function(self, factor: number)
  set_highlight_factor: function(self, factor: number)
  set_shadow_mode: function(self, mode: integer)

  palette: Palette
  entries: integer
  indirect_entries: integer
  black_pen: integer
  white_pen: integer
  shadows_enabled: boolean
  highlights_enabled: boolean
  device: Device
end

global type TextJustify = enum
  "left"
  "center"
  "right"
end

global type ScreenDevice = interface is Device
  orientation: function(self): integer
  time_until_pos: function(self, v: integer, h?: integer): number
  time_until_vblank_end: function(self): number
  snapshot: function(self, filename?: string)
  pixel: function(self, x: integer, y: integer): integer
  pixels: function(self): string
  draw_box: function(self, left: number, top: number, right: number, bottom: number, line?: integer, fill?: integer)
  draw_line: function(self, x0: number, y0: number, x1: number, y1: number, color?: integer)
  draw_text: function(self, x: number, y: number, text: string, foreground?: integer, background?: integer)
  draw_text: function(self, justify: TextJustify, y: number, text: string, foreground?: integer, background?: integer)

  width: integer
  height: integer
  refresh: number
  refresh_attoseconds: integer
  xoffset: number
  yoffset: number
  xscale: number
  yscale: number
  pixel_period: number
  scan_period: number
  frame_period: number
  frame_number: integer
  container: RenderContainer
  palette: PaletteInterface
end

global type ImageInterface = interface
  load: function(self, filename: string)
  load_software: function(self, name: string)
  unload: function(self)
  create: function(self, filename: string)
  display: function(self)
  add_media_change_notifier: function(self, callback: function(state: Loaded)): NotifierSubscription

  enum Loaded
    "loaded"
    "unloaded"
  end

  is_readable: boolean
  is_writeable: boolean
  must_be_loaded: boolean
  is_reset_on_load: boolean
  image_type_name: string
  instance_name: string
  brief_instance_name: string
  formatlist: Container<string, ImageFormat>
  exists: boolean
  readonly: boolean
  filename: string
  crc: integer
  loaded_through_softlist: boolean
  software_list_name: string
  software_longname: string
  software_publisher: string
  software_year: string
  software_parent: string
  device: Device
end

global type CassetteImageDevice = interface is Device, ImageInterface
  stop: function(self)
  play: function(self)
  forward: function(self)
  reverse: function(self)
  seek: function(self, time: number, whence: Whence)

  enum Whence
    "set"
    "cur"
    "end"
  end

  is_stopped: boolean
  is_playing: boolean
  is_recording: boolean
  motor_state: boolean
  speaker_state: boolean
  position: number
  length: number
end

global type SoundInterface = interface
  inputs: integer
  outputs: integer
  microphone: boolean
  speaker: boolean
  io_positions: {{number, number, number}}
  io_names: {string}
  hook: boolean
  device: Device
end

global type SlotInterface = interface
  fixed: boolean
  has_selectable_options: boolean
  options: Container<string, SlotOption>
  device: Device

  interface SlotOption
    name: string
    device_fullname: string
    device_shortname: string
    selectable: boolean
    default_bios: string
    clock: integer
  end
end

global type DeviceStateEntry = interface
  value: integer | number
  symbol: string
  visible: boolean
  writeable: boolean
  is_float: boolean
  datamask: integer
  datasize: integer
  max_length: integer
end

global type ImageFormat = interface
  name: string
  description: string
  extensions: {string}
  option_spec: string
end

-- https://docs.mamedev.org/luascript/ref-mem.html
global type MemoryManager = interface
  shares: Container<string, MemoryShare>
  banks: Container<string, MemoryBank>
  regions: Container<string, MemoryRegion>
end

global type AddressSpace = interface
  read_i8: function(self, addr: integer): integer
  read_u8: function(self, addr: integer): integer
  write_i8: function(self, addr: integer, val: integer)
  write_u8: function(self, addr: integer, val: integer)
  readv_i8: function(self, addr: integer): integer
  readv_u8: function(self, addr: integer): integer
  writev_i8: function(self, addr: integer, val: integer)
  writev_u8: function(self, addr: integer, val: integer)
  read_direct_i8: function(self, addr: integer): integer
  read_direct_u8: function(self, addr: integer): integer
  write_direct_i8: function(self, addr: integer, val: integer)
  write_direct_u8: function(self, addr: integer, val: integer)
  read_i16: function(self, addr: integer): integer
  read_u16: function(self, addr: integer): integer
  write_i16: function(self, addr: integer, val: integer)
  write_u16: function(self, addr: integer, val: integer)
  readv_i16: function(self, addr: integer): integer
  readv_u16: function(self, addr: integer): integer
  writev_i16: function(self, addr: integer, val: integer)
  writev_u16: function(self, addr: integer, val: integer)
  read_direct_i16: function(self, addr: integer): integer
  read_direct_u16: function(self, addr: integer): integer
  write_direct_i16: function(self, addr: integer, val: integer)
  write_direct_u16: function(self, addr: integer, val: integer)
  read_i32: function(self, addr: integer): integer
  read_u32: function(self, addr: integer): integer
  write_i32: function(self, addr: integer, val: integer)
  write_u32: function(self, addr: integer, val: integer)
  readv_i32: function(self, addr: integer): integer
  readv_u32: function(self, addr: integer): integer
  writev_i32: function(self, addr: integer, val: integer)
  writev_u32: function(self, addr: integer, val: integer)
  read_direct_i32: function(self, addr: integer): integer
  read_direct_u32: function(self, addr: integer): integer
  write_direct_i32: function(self, addr: integer, val: integer)
  write_direct_u32: function(self, addr: integer, val: integer)
  read_i64: function(self, addr: integer): integer
  read_u64: function(self, addr: integer): integer
  write_i64: function(self, addr: integer, val: integer)
  write_u64: function(self, addr: integer, val: integer)
  readv_i64: function(self, addr: integer): integer
  readv_u64: function(self, addr: integer): integer
  writev_i64: function(self, addr: integer, val: integer)
  writev_u64: function(self, addr: integer, val: integer)
  read_direct_i64: function(self, addr: integer): integer
  read_direct_u64: function(self, addr: integer): integer
  write_direct_i64: function(self, addr: integer, val: integer)
  write_direct_u64: function(self, addr: integer, val: integer)
  read_range: function(self, start_addr: integer, end_addr: integer, width: integer, step?: integer): string
  add_change_notifier: function(self, callback: function(change: HandlerChange)): NotifierSubscription
  install_read_tap: function(self, start_addr: integer, end_addr: integer, name: string, callback: function(offset: integer, data: integer, mask: integer): integer...): PassthroughHandler
  install_write_tap: function(self, start_addr: integer, end_addr: integer, name: string, callback: function(offset: integer, data: integer, mask: integer): integer...): PassthroughHandler

  enum HandlerChange
    "r"
    "w"
    "rw"
  end

  name: string
  shift: integer
  index: integer
  address_mask: integer
  data_width: integer
  endianness: Endianness
  map: AddressMap
end

global type Endianness = enum
  "big"
  "little"
end

global type PassthroughHandler = interface
  reinstall: function(self)
  remove: function(self)

  addrstart: integer
  addrend: integer
  name: string
end

global type AddressMap = interface
  spacenum: integer
  device: Device
  unmap_value: integer
  global_mask: integer
  entries: Container<integer, Entry>

  interface Entry
    address_start: integer
    address_end: integer
    address_mirror: integer
    address_mask: integer
    mask: integer
    cswidth: integer
    read: HandlerData
    write: HandlerData
    share: string
    region: string
    region_offset: integer
  end

  interface HandlerData
    handlertype: Type
    bits: integer
    name: string
    tag: string

    enum Type
      "none"
      "ram"
      "rom"
      "nop"
      "unmap"
      "delegate"
      "port"
      "bank"
      "submap"
      "unknown"
    end
  end
end

global type MemoryShare = interface
  read_i8: function(self, offs: integer): integer
  read_u8: function(self, offs: integer): integer
  write_i8: function(self, offs: integer, val: integer)
  write_u8: function(self, offs: integer, val: integer)
  read_i16: function(self, offs: integer): integer
  read_u16: function(self, offs: integer): integer
  write_i16: function(self, offs: integer, val: integer)
  write_u16: function(self, offs: integer, val: integer)
  read_i32: function(self, offs: integer): integer
  read_u32: function(self, offs: integer): integer
  write_i32: function(self, offs: integer, val: integer)
  write_u32: function(self, offs: integer, val: integer)
  read_i64: function(self, offs: integer): integer
  read_u64: function(self, offs: integer): integer
  write_i64: function(self, offs: integer, val: integer)
  write_u64: function(self, offs: integer, val: integer)
  tag: string
  size: integer
  length: integer
  endianness: Endianness
  bitwidth: integer
  bytewidth: integer
end

global type MemoryBank = interface
  tag: string
  entry: integer
end

global type MemoryRegion = interface
  read: function(self, offs: integer, len: integer): string
  read_i8: function(self, offs: integer): integer
  read_u8: function(self, offs: integer): integer
  write_i8: function(self, offs: integer, val: integer)
  write_u8: function(self, offs: integer, val: integer)
  read_i16: function(self, offs: integer): integer
  read_u16: function(self, offs: integer): integer
  write_i16: function(self, offs: integer, val: integer)
  write_u16: function(self, offs: integer, val: integer)
  read_i32: function(self, offs: integer): integer
  read_u32: function(self, offs: integer): integer
  write_i32: function(self, offs: integer, val: integer)
  write_u32: function(self, offs: integer, val: integer)
  read_i64: function(self, offs: integer): integer
  read_u64: function(self, offs: integer): integer
  write_i64: function(self, offs: integer, val: integer)
  write_u64: function(self, offs: integer, val: integer)
  
  tag: string
  size: integer
  length: integer
  endianness: Endianness
  bitwidth: integer
  bytewidth: integer
end

-- https://docs.mamedev.org/luascript/ref-input.html
global type IoPortManager = interface
  count_players: function(self): integer
  type_pressed: function(self, type: integer, player?: integer): boolean
  type_pressed: function(self, type: InputType): boolean
  type_name: function(self, type: integer, player?: integer): string
  type_name: function(self, type: InputType): string
  type_group: function(self, type: integer, player: integer): integer
  type_seq: function(self, type: integer, player?: integer, seqtype?: InputSeqType): InputSeq
  type_seq: function(self, type: InputType, seqtype?: InputSeqType): InputSeq
  set_type_seq: function(self, type: integer, player?: integer, seqtype: InputSeqType, seq: InputSeq)
  set_type_seq: function(self, type: InputType, seqtype: InputSeqType, seq: InputSeq)
  token_to_input_type: function(self, string): number, number
  input_type_to_token: function(self, type: integer, player?: integer): string

  types: Container<integer, InputType>
  ports: Container<string, IoPort>
end

global type InputSeqType = enum
  "standard"
  "increment"
  "decrement"
end

global type NaturalKeyboard = interface
  post: function(self, text: string)
  post_coded: function(self, text: string)
  paste: function(self)
  dump: function(self): string

  empty: boolean
  full: boolean
  can_post: boolean
  is_posting: boolean
  in_use: boolean
  keyboards: Container<string, KeyboardDevice>
end

global type KeyboardDevice = interface
  device: Device
  tag: string
  basetag: string
  name: string
  shortname: string
  is_keypad: boolean
  enabled: boolean
end

global type IoPort = interface
  read: function(self): integer
  write: function(self, value: integer, mask: integer)
  field: function(self, mask: integer): IoPortField

  device: Device
  tag: string
  active: boolean
  live: IoPortFieldLiveState
  fields: Container<string, IoPortField>
end

global type IoPortField = interface
  set_value: function(self, value: integer)
  clear_value: function(self)
  set_sensitivity: function(self, sensitivity: integer)
  set_keydelta: function(self, sensitivity: integer)
  set_centerdelta: function(self, sensitivity: integer)
  set_analog_reverse: function(self, reverse: boolean)
  set_input_seq: function(self, seqtype: InputSeqType, seq: InputSeq)
  input_seq: function(self, seqtype: InputSeqType): InputSeq
  set_default_input_seq: function(self, seqtype: InputSeqType, seq: InputSeq)
  default_input_seq: function(self, seqtype: InputSeqType): InputSeq
  keyboard_codes: function(self, shift: integer): {integer}

  device: Device
  port: IoPort
  live: IoPortFieldLiveState
  type: integer
  name: string
  default_name: string
  player: integer
  mask: integer
  defvalue: integer
  minvalue: integer
  maxvalue: integer
  sensitivity: integer
  default_sensitivity: integer
  keydelta: integer
  default_keydelta: integer
  centerdelta: integer
  default_centerdelta: integer
  analog_reverse: boolean
  default_analog_reverse: boolean
  way: integer
  type_class: TypeClass
  is_analog: boolean
  is_digital_joystick: boolean
  enabled: boolean
  cocktail: boolean
  toggle: boolean
  analog_reset: boolean
  analog_wraps: boolean
  analog_invert: boolean
  impulse: boolean
  crosshair_scale: number
  crosshair_offset: number
  user_value: integer
  settings: {integer: string}

  enum TypeClass
    "keyboard"
    "controller"
    "config"
    "dipswitch"
    "misc"
  end
end

global type IoPortFieldLiveState = interface
  name: string
end

global type InputType = interface
  type: integer
  group: integer
  player: integer
  token: string
  name: string
  is_analog: boolean
end

global type InputCode = interface
  -- TODO ???
end

global type InputManager = interface
  code_value: function(self, code: InputCode): integer
  code_pressed: function(self, code: InputCode): boolean
  code_pressed_once: function(self, code: InputCode): boolean
  code_name: function(self, code: InputCode): string
  code_to_token: function(self, code: InputCode): string
  code_from_token: function(self, token: string): InputCode
  seq_pressed: function(self, seq: InputSeq): boolean
  seq_clean: function(self, seq: InputSeq): InputSeq
  seq_name: function(self, seq: InputSeq): string
  seq_to_tokens: function(self, seq: InputSeq): string
  seq_from_tokens: function(self, tokens: string): InputSeq
  axis_code_poller: function(self): InputCodePoller
  switch_code_poller: function(self): InputCodePoller
  keyboard_code_poller: function(self): InputCodePoller
  axis_sequence_poller: function(self): InputSeqPoller
  switch_sequence_poller: function(self): InputSeqPoller
  
  device_classes: {string: InputDeviceClass}
end

global type InputCodePoller = interface
  reset: function(self)
  poll: function(self): InputCode
end

global type InputSeqPoller = interface
  start: function(self, seq?: InputSeq)
  poll: function(self): boolean

  sequence: InputSeq
  valid: boolean
  modified: boolean
end

global type InputSeq = interface
  reset: function(self)
  set_default: function(self)

  empty: boolean
  length: integer
  is_valid: boolean
  is_default: boolean
end

global type InputDeviceClass = interface
  name: string
  enabled: boolean
  multi: boolean
  devices: {integer: InputDevice}
end

global type InputDevice = interface
  name: string
  id: string
  devindex: integer
  items: {integer: Item}

  interface Item
    name: string
    code: integer
    token: string
    current: integer
  end
end

global type UiInputManager = interface
  reset: function(self)
  pressed: function(self, type: integer): boolean
  pressed_repeat: function(self, type: integer, speed: number): boolean

  presses_enabled: boolean
end

-- https://docs.mamedev.org/luascript/ref-render.html
global type RenderBounds = interface
  includes: function(self, x: number, y: number): boolean
  set_xy: function(self, left: number, top: number, right: number, bottom: number)
  set_wh: function(self, left: number, top: number, width: number, height: number)

  x0: number
  x1: number
  y0: number
  y1: number
  width: number
  height: number
  aspect: number
end

global type RenderColor = interface
  set: function(self, a: number, r: number, g: number, b: number)
  
  a: number
  r: number
  g: number
  b: number
end

global type Palette = interface
  entry_color: function(self, index: integer): integer
  entry_contrast: function(self, index: integer): number
  entry_adjusted_color: function(self, index: integer, group?: integer): integer
  entry_set_color: function(self, index: integer, color: integer)
  entry_set_color: function(self, index: integer, red: integer, green: integer, blue: integer)
  entry_set_red_level: function(self, index: integer, level: integer)
  entry_set_green_level: function(self, index: integer, level: integer)
  entry_set_blue_level: function(self, index: integer, level: integer)
  entry_set_contrast: function(self, index: integer, level: number)
  group_set_brightness: function(self, group: integer, brightness: number)
  group_set_contrast: function(self, group: integer, contrast: number)

  colors: integer
  groups: integer
  max_index: integer
  black_entry: integer
  white_entry: integer
  brightness: number
  contrast: number
  gamma: number
end

global type Bitmap = interface
  cliprect: function(self): (integer, integer, integer, integer)
  reset: function(self)
  allocate: function(self, width: integer, height: integer)
  allocate: function(self, width: integer, height: integer, xslop: integer, yslop: integer)
  resize: function(self, width: integer, height: integer)
  resize: function(self, width: integer, height: integer, xslop: integer, yslop: integer)
  wrap: function(self, source: Bitmap)
  wrap: function(self, source: Bitmap, x0: integer, y0: integer, x1: integer, y1: integer)
  pix: function(self, x: integer, y: integer): integer
  pixels: function(self): string
  pixels: function(self, x0: integer, y0: integer, x1: integer, y1: integer): string
  fill: function(self, color: integer)
  fill: function(self, color: integer, x0: integer, y0: integer, x1: integer, y1: integer)
  plot: function(self, x: integer, y: integer, color: integer)
  plot_box: function(self, x: integer, y: integer, width: integer, height: integer, color: integer)
  resample: function(self, dest: Bitmap, color?: RenderColor)

  palette: Palette
  width: integer
  height: integer
  rowpixels: integer
  rowbytes: integer
  bpp: integer
  valid: boolean
  locked: boolean
end

global type RenderTexture = interface
  free: function(self)
  valid: boolean
end

global type RenderManager = interface
  texture_alloc: function(self, bitmap: Bitmap): RenderTexture

  max_update_rate: number
  ui_target: RenderTarget
  ui_container: RenderContainer
  targets: Container<integer, RenderTarget>
end

global type RenderTarget = interface
  ui_container: RenderContainer
  index: integer
  width: integer
  height: integer
  pixel_aspect: number
  hidden: boolean
  is_ui_target: boolean
  max_update_rate: integer
  orientation: integer
  view_names: Container<integer, string>
  current_view: LayoutView
  view_index: integer
  visibility_mask: integer
  screen_overlay: boolean
  zoom_to_screen: boolean
end

global type RenderContainer = interface
  draw_box: function(self, left: number, top: number, right: number, bottom: number, line?: integer, fill?: integer)
  draw_line: function(self, x0: number, y0: number, x1: number, y1: number, color?: integer)
  draw_quad: function(self, x0: number, y0: number, x1: number, y1: number, color?: integer)
  draw_text: function(self, x: number, y: number, text: string, foreground?: integer, background?: integer)
  draw_text: function(self, justify: TextJustify, y: number, text: string, foreground?: integer, background?: integer)

  interface UserSettings
    orientation: integer
    brightness: number
    contrast: number
    gamma: number
    xscale: number
    yscale: number
    xoffset: number
    yoffset: number
  end

  user_settings: UserSettings
  orientation: integer
  xscale: number
  yscale: number
  xoffset: number
  yoffset: number
  is_empty: boolean
end

global type LayoutFile = interface
  set_resolve_tags_callback: function(cb: function())

  device: Device
  elements: Container<string, LayoutElement>
  views: Container<string, LayoutView>
end

global type LayoutView = interface
  has_screen: function(self, screen: LayoutViewItem): boolean
  set_prepare_items_callback: function(self, cb: function())
  set_preload_callback: function(self, cb: function())
  set_recomputed_callback: function(self, cb: function())
  set_pointer_updated_callback: function(self, cb: function(
    pointer_type: PointerType,
    pointer_id: integer,
    device_id: integer,
    x: number,
    y: number,
    pressed: integer,
    new_pressed: integer,
    new_released: integer,
    click_count: integer
  ))
  set_pointer_left_callback: function(self, cb: function(
    pointer_type: PointerType,
    pointer_id: integer,
    device_id: integer,
    x: number,
    y: number,
    new_released: integer,
    click_count: integer
  ))
  set_pointer_aborted_callback: function(self, cb: function(
    pointer_type: PointerType,
    pointer_id: integer,
    device_id: integer,
    x: number,
    y: number,
    new_released: integer,
    click_count: integer
  ))
  set_forget_pointers_callback: function(self, cb: function())

  items: Container<string, LayoutViewItem>
  name: string
  unqualified_name: string
  visible_screen_count: integer
  effective_aspect: number
  bounds: RenderBounds
  has_art: boolean
  show_pointers: boolean
  hide_inactive_pointers: boolean
end

global type PointerType = enum
  "mouse"
  "pen"
  "touch"
  "unknown"
end

global type LayoutViewItem = interface
  set_state: function(self, state: integer)
  set_element_state_callback: function(self, cb: function(): integer)
  set_animation_state_callback: function(self, cb: function(): integer)
  set_bounds_callback: function(self, cb: function(): RenderBounds)
  set_color_callback: function(self, cb: function(): RenderColor)
  set_scroll_size_x_callback: function(self, cb: function(): number)
  set_scroll_size_y_callback: function(self, cb: function(): number)
  set_scroll_pos_x_callback: function(self, cb: function(): number)
  set_scroll_pos_y_callback: function(self, cb: function(): number)

  id: string
  element: LayoutElement
  bounds_animated: boolean
  color_animated: boolean
  bounds: RenderBounds
  color: RenderColor
  scroll_wrap_x: boolean
  scroll_wrap_y: boolean
  scroll_size_x: number
  scroll_size_y: number
  scroll_pos_x: number
  scroll_pos_y: number
  blend_mode: integer
  orientation: integer
  element_state: integer
  animation_state: integer
end

global type LayoutElement = interface
  invalidate: function(self)
  set_draw_callback: function(self, cb: function(state: integer, bitmap: Bitmap))
  default_state: integer
end

-- https://docs.mamedev.org/luascript/ref-debugger.html
global type SymbolTable = interface
  set_memory_modified_func: function(self, cb: function())
  add: function(self, name: string, value?: integer): SymbolEntry
  add: function(self, name: string, getter: (function(): integer), setter?: function(integer), format?: string): SymbolEntry
  add: function(self, name: string, minparams: integer, maxparams: integer, execute: function(integer...): integer): SymbolEntry
  find: function(self, name: string): SymbolEntry
  find_deep: function(self, name: string): SymbolEntry
  value: function(self, name: string): integer
  set_value: function(self, name: string, value: integer)
  memory_value: function(self, name: string, space: string, offset: integer, size: integer, disable_se: boolean): integer
  set_memory_value: function(self, name: string, space: string, offset: integer, value: integer, size: integer, disable_se: boolean)
  read_memory: function(self, space: string, address: integer, size: integer, apply_translation: boolean): integer
  write_memory: function(self, space: string, address: integer, data: integer, size: integer, apply_translation: boolean)

  entries: Container<string, SymbolEntry>
  parent: SymbolTable
end

global type ParsedExpression = interface
  set_default_base: function(self, base: integer)
  parse: function(self, string)
  execute: function(): integer

  is_empty: boolean
  original_string: string
  symbols: SymbolTable
end

global type SymbolEntry = interface
  name: string
  format: string
  is_function: boolean
  is_lval: boolean
  value: integer
end

global type DebuggerManager = interface
  command: function(self, string)

  consolelog: Container<integer, string>
  errorlog: Container<integer, string>
  visible_cpu: Device
  execution_state: ExecutionState

  enum ExecutionState
    "run"
    "stop"
  end
end

global type WatchpointType = enum
  "r"
  "w"
  "rw"
end

global type DeviceDebugger = interface
  step: function(self, cnt?: integer)
  go: function(self)
  bpset: function(self, addr: integer, cond: string, act: string): integer
  bpenable: function(self, bp?: integer)
  bpdisable: function(self, bp?: integer)
  bpclear: function(self, bp?: integer)
  bplist: function(self): {integer: Breakpoint}
  wpset: function(self, space: string, type: WatchpointType, addr: integer, len: integer, cond: string, act: string): integer
  wpenable: function(self, wp?: integer)
  wpdisable: function(self, wp?: integer)
  wpclear: function(self, wp?: integer)
  wplist: function(self, space: string): {integer: Watchpoint}
end

global type Breakpoint = interface
  index: integer
  enabled: boolean
  address: integer
  condition: string
  action: string
end

global type Watchpoint = interface
  index: integer
  enabled: boolean
  type: WatchpointType
  address: integer
  length: integer
  condition: string
  action: string
end

-- other stuff
global type CoreOptionsEntry = interface
  value: function(new_value: boolean | integer | number | string)
  value: function(): boolean | integer | number | string
  
  description: string
  -- todo finish the rest https://github.com/mamedev/mame/blob/b8b6c5967e1e769c394916f0c9a4383a4eedf9a9/src/frontend/mame/luaengine.cpp#L1354
end

global type CoreOptions = interface
  help: function(self): string
  command: function(command: string): string
  
  entries: {string: CoreOptionsEntry}
end

global type EmuOptions = interface is CoreOptions
  slot_option: function(name: string): SlotOption

  interface SlotOption
    specify: function(card: string, bios?: string)
  
    value: string
    specified_value: string
    bios: string
    default_card_software: string
  end
end

global type Plugin = interface
  name: string
  version: string
  description: string
  author: string
  startplugin: function()
end
