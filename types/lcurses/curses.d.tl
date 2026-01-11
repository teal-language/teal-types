local record curses
   --+ Constant Types +--
   type AlternateCharacter = integer
   type Attribute = integer
   type Color = integer
   type Key = integer

   --+ Extended Types +--
   type ColorPairId = integer
   type ColorPair = Attribute

   --+ Functions +--
   baudrate:        function():                    integer
   beep:            function():                    boolean
   cbreak:          function(on: boolean | nil):   boolean
   color_pair:      function(pair: ColorPairId):   ColorPair
   color_pairs:     function():                    integer
   colors:          function():                    integer
   cols:            function():                    integer
   curs_set:        function(integer):             integer | nil
   delay_output:    function(ms: integer):         boolean
   doupdate:        function():                    boolean
   echo:            function(on: boolean | nil):   boolean
   endwin:          function():                    boolean
   erasechar:       function():                    integer
   flash:           function():                    boolean
   flushinp:        function():                    boolean
   halfdelay:       function(tenths: integer):     boolean
   has_colors:      function():                    boolean
   has_il:          function():                    boolean
   init_pair:       function(
      pair: ColorPairId, f: Color, b: Color
   ):                                              boolean
   initscr:         function():                    window
   isendwin:        function():                    boolean
   keyname:         function(c: Key):              string
   killchar:        function():                    integer
   lines:           function():                    integer
   longname:        function():                    string
   napms:           function(ms: integer):         boolean
   new_chstr:       function(len: integer):        chstr
   newpad:          function(
      nlines: integer, ncols: integer
   ): boolean
   newwin:          function(
      nlines: integer,
      ncols: integer,
      begin_y: integer,
      begin_x: integer
   ):                                              window
   nl:              function(on: boolean | nil):   boolean
   pair_content:    function(pair: ColorPairId):   (Color, Color)
   raw:             function(on: boolean | nil):   boolean
   resizeterm:      function(
      nlines: integer, ncols: integer
   ):                                              boolean
   ripoffline:      function(
      top_line: boolean, callback: function
   ):                                              boolean
   slk_attroff:     function(attrs: Attribute):    boolean
   slk_attron:      function(attrs: Attribute):    boolean
   slk_attrset:     function(attrs: Attribute):    boolean
   slk_clear:       function():                    boolean
   slk_init:        function(fmt: integer):        boolean
   slk_label:       function(labnum: integer):     string
   slk_noutrefresh: function():                    boolean
   slk_refresh:     function():                    boolean
   slk_restore:     function():                    boolean
   slk_set:         function(
      labnum: integer, label: string, fmt: integer
   ):                                              boolean
   slk_touch:       function():                    boolean
   start_color:     function():                    boolean
   stdscr:          function():                    window
   termattrs:       function(a: Attribute | nil):  boolean | integer
   termname:        function():                    string
   tigetflag:       function(capname: string):     boolean
   tigetnum:        function(capname: string):     integer
   unctrl:          function(c: integer):          string
   ungetch:         function(c: integer):          boolean
   use_default_colors: function():                 boolean

   --+ String buffer +--
   record chstr
      -- Methods
      dup:     function(self: chstr):             chstr
      get:     function(self: chstr, o: integer):   (
         integer, integer, integer
      )
      len:     function(self: chstr, cs: chstr):    integer
      set_ch:  function(
         self: chstr,
         o:    integer,
         int:  string,
         attr: Attribute | nil,
         rep:  integer | nil
      )
      set_str: function(
         self: chstr,
         o:    integer,
         s:    string,
         attr: Attribute | nil,
         rep:  integer | nil
      ):                                            nil

      -- Methamethods
      __call:  function(self: chstr, len: integer): chstr
   end

   --+ Window +--    
   record window
      -- Methods
      addch:          function(self: window, ch: integer):       boolean
      addchstr:       function(
         self: window, chstr: chstr, n: integer | nil
      ):                                                         boolean
      addstr:         function(
         self: window, str: string, n: integer | nil
      ):                                                         boolean
      attroff:        function(self: window, attrs: Attribute):  boolean
      attron:         function(self: window, attrs: Attribute):  boolean
      attrset:        function(self: window, attrs: Attribute):  boolean
      border:         function(
         self: window,
         ls: integer,
         rs: integer,
         ts: integer,
         bs: integer,
         tl: integer,
         tr: integer,
         bl: integer,
         br: integer
      ):                                                         boolean
      box:            function(
         self: window, verch: integer, horch: integer
      ):                                                         boolean
      clear:          function(self: window):                    boolean
      clearok:        function(self: window):                    boolean
      close:          function(self: window)
      clrtobot:       function(self: window):                    boolean
      clrtoeol:       function(self: window):                    boolean
      copywin:        function(
         self:     window,
         dst:      window,
         st:       integer,
         sl:       integer,
         dt:       integer,
         dl:       integer,
         db:       integer,
         dr:       integer,
         overlay:  boolean
      ):                                                         boolean
      cursyncup:      function(self: window)
      delch:          function(self: window):                    boolean
      derive:         function(
         self: window, 
         nlines:  integer,
         ncols:   integer,
         begin_y: integer,
         begin_x: integer
      ):                                                         window
      echoch:         function(self: window, ch: integer):       boolean
      erase:          function(self: window):                    boolean
      getbegyx:       function(self: window):                    (
         integer, integer, boolean
      )
      getbkgd:        function(self: window):                    Attribute
      getch:          function(self: window):                    integer
      getmaxyx:       function(self: window):                    (integer, integer)
      getstr:         function(self: window, n: integer | nil):  string
      getyx:          function(self: window):                    (integer, integer)
      hline:          function(
         self: window, ch: integer, n: integer
      ):                                                         boolean
      idcok:          function(self: window, bf: boolean):       boolean
      idlok:          function(self: window, bf: boolean):       boolean
      immedok:        function(self: window, bf: boolean):       boolean
      insertln:       function(self: window):                    boolean
      intrflush:      function(self: window, bf: boolean):       boolean
      is_linetouched: function(self: window, line: integer):     boolean
      is_wintouched:  function(self: window):                    boolean
      keypad:         function(self: window, on: boolean | nil): boolean
      leaveok:        function(self: window, bf: boolean):       boolean
      meta:           function(self: window, on: boolean):       boolean
      move:           function(
         self: window,
         y: integer,
         x: integer
      ):                                                         boolean
      move_derived:   function(
         self: window,
         par_y: integer,
         par_x: integer
      ):                                                         boolean
      move_window:    function(
         self: window,
         y: integer,
         x: integer
      ):                                                         boolean
      mvaddch:        function(
         self: window,
         y: integer,
         x: integer,
         ch: integer
      ):                                                         boolean
      mvaddchstr:     function(
         self: window,
         y: integer,
         x: integer,
         n: integer | nil
      ):                                                         boolean
      mvaddstr:       function(
         self: window,
         y: integer,
         x: integer,
         str: string,
         n: integer | nil
      ):                                                         boolean
      mvdelch:        function(
         self: window,
         y: integer,
         x: integer
      ):                                                         boolean
      mvgetch:        function(
         self: window,
         y: integer,
         x: integer
      ):                                                         boolean
      mvgetstr:       function(
         self: window,
         y: integer,
         x: integer,
         n: integer | nil
      ):                                                         string
      mvhline:        function(
         self: window,
         y: integer,
         x: integer,
         ch: integer,
         n: integer
      ):                                                         boolean
      mvvline:        function(
         self: window,
         y: integer,
         x: integer,
         ch: integer,
         n: integer
      ):                                                         boolean
      mvwinch:        function(
         self: window,
         y: integer,
         x: integer
      ):                                                         boolean
      mvwinchnstr:    function(
         self: window,
         y: integer,
         x: integer,
         n: integer
      ):                                                         boolean
      mvwinnstr:      function(
         self: window,
         y: integer,
         x: integer,
         n: integer
      ):                                                         boolean
      mvwinsch:       function(
         self: window,
         y: integer,
         x: integer,
         ch: integer
      ):                                                         boolean
      mvwinsnstr:     function(
         self: window,
         y: integer,
         x: integer,
         str: string,
         n: integer
      ):                                                         boolean
      mvwinsstr:      function(
         self: window,
         y: integer,
         x: integer,
         str: string
      ):                                                         boolean
      nodelay:        function(self: window, on: boolean):       boolean
      notimeout:      function(self: window, bf: boolean):       boolean
      noutrefresh:    function(self: window):                    boolean
      overlay:        function(self: window, dst: window):       boolean
      pechochar:      function(self: window, ch: integer):       boolean
      pnoutrefresh:   function(
         self: window,
         st: integer,
         sl: integer,
         dt: integer,
         dl: integer,
         db: integer,
         dr: integer
      ):                                                         boolean
      prefresh:       function(
         self: window,
         st: integer,
         sl: integer,
         dt: integer,
         dl: integer,
         db: integer,
         dr: integer
      ):                                                         boolean
      redrawln:       function(
         self: window, beg_line: integer, num_lines: integer
      ):                                                         boolean
      redrawwin:      function(self: window):                    boolean
      refresh:        function(self: window):                    boolean
      resize:         function(
         self: window, height: integer, width: integer
      ):                                                         boolean
      scrollok:       function(self: window, bf: boolean):       boolean
      standend:       function(self: window):                    boolean
      standout:       function(self: window):                    boolean
      sub:            function(
         self:    window, 
         nlines:  integer,
         ncols:   integer,
         begin_y: integer,
         begin_x: integer
      ):                                                         window
      subpad:         function(
         self:    window, 
         nlines:  integer,
         ncols:   integer,
         begin_y: integer,
         begin_x: integer
      ):                                                         window
      syncdown:       function(self: window):                    nil
      syncok:         function(self: window, bf: boolean):       boolean
      syncup:         function(self: window):                    nil
      timeout:        function(self: window, delay: integer):    nil
      touch:          function(
         self: window, changed: boolean | nil
      ):                                                         boolean
      touchline:      function(
         self: window,
         y: integer,
         x: integer,
         touched: boolean | nil
      ):                                                         boolean
      vline:          function(
         self: window, ch: integer, n: integer
      ):                                                         boolean
      wbkgd:          function(
         self: window, ch: integer
      ):                                                         boolean
      wbkgdset:       function(self: window, ch: integer):       nil
      winch:          function(self: window):                    integer
      winchnstr:      function(
         self: window, n: integer
      ):                                                         chstr
      winnstr:        function(
         self: window, n: integer
      ):                                                         string
      winsch:         function(
         self: window, ch: integer
      ):                                                         boolean
      winsdelln:      function(
         self: window, n: integer
      ):                                                         boolean
      winsnstr:       function(
         self: window, str: string, n: integer
      ):                                                         boolean
      winsstr:        function(
         self: window, str: string
      ):                                                         boolean
      wsetscrreg:     function(
         self: window, top: integer, bot: integer
      ):                                                         boolean
      -- Methamethods
      __tostring:     function(self: window):                    string
   end

   --+ Constants +--
   ACS_BLOCK:    AlternateCharacter
   ACS_BOARD:    AlternateCharacter
   ACS_BTEE:     AlternateCharacter
   ACS_BULLET:   AlternateCharacter
   ACS_CKBOARD:  AlternateCharacter
   ACS_DARROW:   AlternateCharacter
   ACS_DEGREE:   AlternateCharacter
   ACS_DIAMOND:  AlternateCharacter
   ACS_HLINE:    AlternateCharacter
   ACS_LANTERN:  AlternateCharacter
   ACS_LARROW:   AlternateCharacter
   ACS_LLCORNER: AlternateCharacter
   ACS_LRCORNER: AlternateCharacter
   ACS_LTEE:     AlternateCharacter
   ACS_PLMINUS:  AlternateCharacter
   ACS_PLUS:     AlternateCharacter
   ACS_RARROW:   AlternateCharacter
   ACS_RTEE:     AlternateCharacter
   ACS_S1:       AlternateCharacter
   ACS_S9:       AlternateCharacter
   ACS_TTEE:     AlternateCharacter
   ACS_UARROW:   AlternateCharacter
   ACS_ULCORNER: AlternateCharacter
   ACS_URCORNER: AlternateCharacter
   ACS_VLINE:    AlternateCharacter

   A_ALTCHARSET: Attribute
   A_ATTRIBUTES: Attribute
   A_BLINK:      Attribute
   A_BOLD:       Attribute
   A_CHARTEXT:   Attribute
   A_COLOR:      Attribute
   A_DIM:        Attribute
   A_INVIS:      Attribute
   A_NORMAL:     Attribute
   A_PROTECT:    Attribute
   A_REVERSE:    Attribute
   A_STANDOUT:   Attribute
   A_UNDERLINE:  Attribute

   COLOR_BLACK:   Color
   COLOR_BLUE:    Color
   COLOR_CYAN:    Color
   COLOR_GREEN:   Color
   COLOR_MAGENTA: Color
   COLOR_RED:     Color
   COLOR_WHITE:   Color
   COLOR_YELLOW:  Color

   KEY_A1:        Key
   KEY_A3:        Key
   KEY_B2:        Key
   KEY_BACKSPACE: Key
   KEY_BEG:       Key
   KEY_BREAK:     Key
   KEY_BTAB:      Key
   KEY_C1:        Key
   KEY_C3:        Key
   KEY_CANCEL:    Key
   KEY_CATAB:     Key
   KEY_CLEAR:     Key
   KEY_CLOSE:     Key
   KEY_COMMAND:   Key
   KEY_COPY:      Key
   KEY_CREATE:    Key
   KEY_CTAB:      Key
   KEY_DC:        Key
   KEY_DL:        Key
   KEY_DOWN:      Key
   KEY_EIC:       Key
   KEY_END:       Key
   KEY_ENTER:     Key
   KEY_EOL:       Key
   KEY_EOS:       Key
   KEY_EXIT:      Key
   KEY_F0:        Key
   KEY_F1:        Key
   KEY_F2:        Key
   KEY_F3:        Key
   KEY_F4:        Key
   KEY_F5:        Key
   KEY_F6:        Key
   KEY_F7:        Key
   KEY_F8:        Key
   KEY_F9:        Key
   KEY_F10:       Key
   KEY_F11:       Key
   KEY_F12:       Key
   KEY_F13:       Key
   KEY_F14:       Key
   KEY_F15:       Key
   KEY_F16:       Key
   KEY_F17:       Key
   KEY_F18:       Key
   KEY_F19:       Key
   KEY_F20:       Key
   KEY_F21:       Key
   KEY_F22:       Key
   KEY_F23:       Key
   KEY_F24:       Key
   KEY_F25:       Key
   KEY_F26:       Key
   KEY_F27:       Key
   KEY_F28:       Key
   KEY_F29:       Key
   KEY_F30:       Key
   KEY_F31:       Key
   KEY_F32:       Key
   KEY_F33:       Key
   KEY_F34:       Key
   KEY_F35:       Key
   KEY_F36:       Key
   KEY_F37:       Key
   KEY_F38:       Key
   KEY_F39:       Key
   KEY_F40:       Key
   KEY_F41:       Key
   KEY_F42:       Key
   KEY_F43:       Key
   KEY_F44:       Key
   KEY_F45:       Key
   KEY_F46:       Key
   KEY_F47:       Key
   KEY_F48:       Key
   KEY_F49:       Key
   KEY_F50:       Key
   KEY_F51:       Key
   KEY_F52:       Key
   KEY_F53:       Key
   KEY_F54:       Key
   KEY_F55:       Key
   KEY_F56:       Key
   KEY_F57:       Key
   KEY_F58:       Key
   KEY_F59:       Key
   KEY_F60:       Key
   KEY_F61:       Key
   KEY_F62:       Key
   KEY_F63:       Key
   KEY_FIND:      Key
   KEY_HELP:      Key
   KEY_HOME:      Key
   KEY_IC:        Key
   KEY_IL:        Key
   KEY_LEFT:      Key
   KEY_LL:        Key
   KEY_MARK:      Key
   KEY_MESSAGE:   Key
   KEY_MOUSE:     Key
   KEY_MOVE:      Key
   KEY_NEXT:      Key
   KEY_NPAGE:     Key
   KEY_OPEN:      Key
   KEY_OPTIONS:   Key
   KEY_PPAGE:     Key
   KEY_PREVIOUS:  Key
   KEY_PRINT:     Key
   KEY_REDO:      Key
   KEY_REFERENCE: Key
   KEY_REFRESH:   Key
   KEY_REPLACE:   Key
   KEY_RESET:     Key
   KEY_RESIZE:    Key
   KEY_RESTART:   Key
   KEY_RESUME:    Key
   KEY_RIGHT:     Key
   KEY_SAVE:      Key
   KEY_SBEG:      Key
   KEY_SCANCEL:   Key
   KEY_SCOMMAND:  Key
   KEY_SCOPY:     Key
   KEY_SCREATE:   Key
   KEY_SDC:       Key
   KEY_SDL:       Key
   KEY_SELECT:    Key
   KEY_SEND:      Key
   KEY_SEOL:      Key
   KEY_SEXIT:     Key
   KEY_SF:        Key
   KEY_SFIND:     Key
   KEY_SHELP:     Key
   KEY_SHOME:     Key
   KEY_SIC:       Key
   KEY_SLEFT:     Key
   KEY_SMESSAGE:  Key
   KEY_SMOVE:     Key
   KEY_SNEXT:     Key
   KEY_SOPTIONS:  Key
   KEY_SPREVIOUS: Key
   KEY_SPRINT:    Key
   KEY_SR:        Key
   KEY_SREDO:     Key
   KEY_SREPLACE:  Key
   KEY_SRESET:    Key
   KEY_SRIGHT:    Key
   KEY_SRSUME:    Key
   KEY_SSAVE:     Key
   KEY_SSUSPEND:  Key
   KEY_STAB:      Key
   KEY_SUNDO:     Key
   KEY_SUSPEND:   Key
   KEY_UNDO:      Key
   KEY_UP:        Key
end

return curses
