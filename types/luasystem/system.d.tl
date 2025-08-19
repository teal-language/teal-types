-- TODO: fill this out and upstream it to teal-types
local record system
   getenv: function(string): string
   getenvs: function(): {string:string}

   setenv: function(string, ?string): boolean

   random: function(integer): string, string
   isatty: function(FILE): boolean

   termsize: function(): integer, integer | string

   getconsoleflags: function(FILE): bitflags, string
   listconsoleflags: function(FILE)
   setconsoleflags: function(FILE, bitflags): boolean, string

   detachfds: function(): boolean
   getnonblock: function(FILE): boolean, string, integer
   listtermflags: function(FILE)
   setnonblock: function(FILE, boolean): boolean, string, integer
   tcgetattr: function(FILE): termios, string, integer
   tcsetattr: function(FILE, integer, termios): boolean, string, integer

   _readkey: function(): integer, string, integer
   readansi: function(integer, (function(number, ?integer): boolean, any)): string, string, string
   readkey: function(integer, (function(number, ?integer): boolean, any)): integer, string

   getconsolecp: function(): integer
   getconsoleoutputcp: function(): integer
   setconsolecp: function(integer): boolean
   setconsoleoutputcp: function(integer): boolean

   utf8cwidth: function(string | integer): integer, string
   utf8swidth: function(string): integer, string

   gettime: function(): number
   sleep: function(number, ?integer): boolean, any

   autotermrestore: function(): boolean, string
   termbackup: function(): table
   termrestore: function(table): boolean
   termwrap: function<F>(F): F

   record termios
      iflag: bitflags
      oflag: bitflags
      lflag: bitflags
   end

   bitflag: function(?integer): bitflags

   record bitflags is userdata
      has_all_of: function(self, self): boolean
      has_any_of: function(self, self): boolean
      value: function(self): number

      metamethod __index: function(self, integer): self
      metamethod __newindex: function(self, integer, boolean)

      metamethod __add: function(self, self): self
      metamethod __sub: function(self, self): self
      metamethod __eq: function(self, self): boolean
   end

   windows: boolean

   CODEPAGE_UTF8: integer
   TCSADRAIN: integer
   TCSAFLUSH: integer
   TCSANOW: integer
   _VERSION: string

   CIF_AUTO_POSITION: bitflags
   CIF_ECHO_INPUT: bitflags
   CIF_EXTENDED_FLAGS: bitflags
   CIF_INSERT_MODE: bitflags
   CIF_LINE_INPUT: bitflags
   CIF_MOUSE_INPUT: bitflags
   CIF_PROCESSED_INPUT: bitflags
   CIF_QUICK_EDIT_MODE: bitflags
   CIF_VIRTUAL_TERMINAL_INPUT: bitflags
   CIF_WINDOW_INPUT: bitflags
   COF_DISABLE_NEWLINE_AUTO_RETURN: bitflags
   COF_ENABLE_LVB_GRID_WORLDWIDE: bitflags
   COF_PROCESSED_OUTPUT: bitflags
   COF_VIRTUAL_TERMINAL_PROCESSING: bitflags
   COF_WRAP_AT_EOL_OUTPUT: bitflags
   I_BRKINT: bitflags
   I_ICRNL: bitflags
   I_IGNBRK: bitflags
   I_IGNCR: bitflags
   I_IGNPAR: bitflags
   I_IMAXBEL: bitflags
   I_INLCR: bitflags
   I_INPCK: bitflags
   I_ISTRIP: bitflags
   I_IUCLC: bitflags
   I_IXANY: bitflags
   I_IXOFF: bitflags
   I_IXON: bitflags
   I_PARMRK: bitflags
   L_ECHO: bitflags
   L_ECHOCTL: bitflags
   L_ECHOE: bitflags
   L_ECHOK: bitflags
   L_ECHOKE: bitflags
   L_ECHONL: bitflags
   L_ECHOPRT: bitflags
   L_FLUSHO: bitflags
   L_ICANON: bitflags
   L_IEXTEN: bitflags
   L_ISIG: bitflags
   L_NOFLSH: bitflags
   L_PENDIN: bitflags
   L_TOSTOP: bitflags
   L_XCASE: bitflags
   O_BSDLY: bitflags
   O_CRDLY: bitflags
   O_FFDLY: bitflags
   O_NLDLY: bitflags
   O_OCRNL: bitflags
   O_OFDEL: bitflags
   O_OFILL: bitflags
   O_OLCUC: bitflags
   O_ONLCR: bitflags
   O_ONLRET: bitflags
   O_ONOCR: bitflags
   O_OPOST: bitflags
   O_TABDLY: bitflags
   O_VTDLY: bitflags
end

return system
