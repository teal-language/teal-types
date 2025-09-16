-- vim: ft=teal expandtab sw=3 ts=3
local type luv = require("luv")

global record vim
   -- TODO: Either find a way to generate these or at least find a comprehensive list to put a bunch of 'TODO' stub definitions here
   --    Sadly, there doesn't seem to be a nice way to serialize all of these
   --    since they're lazily brought in as you call them
   --    this might be the only way since user defined functions are also called here
   --    ex vim.fn["MyPlugin#MyFunction"]() so
   -- VIM_fn = record -- if record maps were a thing
   --    {string:function(...: any): (any)}
   --    mode: function(): Mode
   --    ...
   -- end

   -- TODO:
   -- vim.treesitter

   loop: luv
   uv: luv

   type WindowId = integer
   type BufferId = integer
   type TabpageId = integer
   type NamespaceId = integer
   type AutocmdId = integer
   type AutocmdGroupId = integer

   interface DecorationProviderCallbacks
      on_start: function(string, integer): boolean
      on_buf: function(string, BufferId, integer): boolean
      on_win: function(string, WindowId, BufferId, integer, integer): boolean
      on_line: function(string, WindowId, BufferId, integer): boolean
      on_end: function(string, integer): boolean
   end

   enum OptionScope
      "global"
      "local"
   end

   interface OptionInfo2Opts
      scope: OptionScope
      win: WindowId
      buf: BufferId
   end

   interface OptionInfo
      name: string
      shortname: string
      type: string
      default: any
      was_set: boolean
      last_set_sid: integer
      last_set_linenr: integer
      last_set_chan: integer
      scope: string
      global_local: boolean
      commalist: boolean
      flaglist: boolean
   end

   interface GetOptionValueOpts
      scope: OptionScope
      win: WindowId
      buf: BufferId
      filetype: string
   end

   interface AutocmdCallbackData
      id: AutocmdId
      event: string
      group: AutocmdGroupId
      file: string
      match: string
      buf: BufferId
      data: any
   end

   record AutocmdOpts
      group: string | AutocmdId
      pattern: string | {string}
      buffer: BufferId
      desc: string
      callback: string | function(AutocmdCallbackData): any
      command: string
      once: boolean
      nested: boolean
   end

   record AugroupOpts
      clear: boolean
   end

   enum UserCommandComplete
      "arglist"
      "augroup"
      "breakpoint"
      "buffer"
      "color"
      "command"
      "compiler"
      "diff_buffer"
      "dir"
      "dir_in_path"
      "environment"
      "event"
      "expression"
      "file"
      "file_in_path"
      "filetype"
      "function"
      "help"
      "highlight"
      "history"
      "keymap"
      "locale"
      "lua"
      "mapclear"
      "mapping"
      "menu"
      "messages"
      "option"
      "packadd"
      "runtime"
      "scriptnames"
      "shellcmd"
      "shellcmdline"
      "sign"
      "syntax"
      "syntime"
      "tag"
      "tag_listfiles"
      "user"
      "var"
      --"custom"
      --"customlist"
   end

   interface CreateUserCommandOpts
      name: string
      desc: string
      force: boolean
      preview: function(CommandArguments, NamespaceId, BufferId): integer
      bang: boolean
      nargs: integer | string
      complete: UserCommandComplete | function(string, string, integer): string | {string}
      range: boolean | string | integer
      count: integer
      addr: string
      bar: boolean
      register: boolean
      buffer: boolean
      keepscript: boolean
   end

   interface CommandArguments
      name: string
      args: string
      fargs: {string}
      nargs: integer
      bang: boolean
      line1: integer
      line2: integer
      range: integer
      count: integer
      reg: string
      mods: string
      smods: table
   end

   fn: {string:function(...: any): (any)}
   cmd: function(cmd: string)
   call: function(func: string, ...: any)
   call: function(string, ...: any): any

   enum Mode
      "n" -- Normal
      "no" -- Operator-pending
      "nov" -- Operator-pending (forced charwise |o_v|)
      "noV" -- Operator-pending (forced linewise |o_V|)
      "no" -- Operator-pending (forced blockwise |o_CTRL-V|)
      "niI" -- Normal using |i_CTRL-O| in |Insert-mode|
      "niR" -- Normal using |i_CTRL-O| in |Replace-mode|
      "niV" -- Normal using |i_CTRL-O| in |Virtual-Replace-mode|
      "v" -- Visual by character
      "V" -- Visual by line
      "" -- Visual blockwise
      "s" -- Select by character
      "S" -- Select by line
      "" -- Select blockwise
      "i" -- Insert
      "ic" -- Insert mode completion |compl-generic|
      "ix" -- Insert mode |i_CTRL-X| completion
      "R" -- Replace |R|
      "Rc" -- Replace mode completion |compl-generic|
      "Rv" -- Virtual Replace |gR|
      "Rx" -- Replace mode |i_CTRL-X| completion
      "c" -- Command-line editing
      "cv" -- Vim Ex mode |gQ|
      "ce" -- Normal Ex mode |Q|
      "r" -- Hit-enter prompt
      "rm" -- The -- more -- prompt
      "r?" -- |:confirm| query of some sort
      "!" -- Shell or external command is executing
      "t" -- Terminal mode: keys go to the job
   end

   record InspectOpts
      depth: integer
      newline: string
      indent: string
      process: function(any, {string}): any
   end
   inspect: function(any, ?InspectOpts): string

   interface BlockingMode
      mode: Mode
      blocking: boolean
   end

   record log
      record levels
         DEBUG: integer
         INFO: integer
         HINT: integer
         WARN: integer
         ERROR: integer
      end
   end
   notify: function(msg: string, log_level: integer, opts: table)
   notify_once: function(msg: string, level: integer, opt: table)
   paste: function({string}, integer): boolean
   schedule_wrap: function(function): function
   deep_equal: function(any, any): boolean
   deepcopy: function<T>(T): T
   defer_fn: function(function, integer)
   startswith: function(string, string): boolean
   endswith: function(string, string): boolean
   gsplit: function(string, string, boolean): function(): string
   is_callable: function(any): boolean
   list_extend: function<T>({T}, {T}, integer, integer): {T}
   list_extend: function<T, K>({T}, {K}, integer, integer): {T|K}
   list_slice: function<T>({T}, integer, integer): {T}
   pesc: function(string): string
   split: function(string, string, boolean): {string}
   wait: function(integer)

   tbl_add_reverse_lookup: function(table)
   tbl_contains: function<T>({T}, T): boolean

   tbl_count: function(table): integer

   enum ExtendBehavior
      "error"
      "keep"
      "force"
   end
   tbl_extend: function(ExtendBehavior, table, table, ...: table): table
   tbl_extend: function<T>(ExtendBehavior, {T:any}, {T:any}, ...: {T:any}): {T:any}
   tbl_extend: function<T>(ExtendBehavior, {any:T}, {any:T}, ...: {any:T}): {any:T}
   tbl_extend: function<T,V>(ExtendBehavior, {T:V}, {T:V}, ...: {T:V}): {T:V}
   tbl_deep_extend: function(ExtendBehavior, table, table, ...: table): table
   tbl_deep_extend: function<T>(ExtendBehavior, {T:any}, {T:any}, ...: {T:any}): {T:any}
   tbl_deep_extend: function<T>(ExtendBehavior, {any:T}, {any:T}, ...: {any:T}): {any:T}
   tbl_deep_extend: function<T,V>(ExtendBehavior, {T:V}, {T:V}, ...: {T:V}): {T:V}

   tbl_filter: function<T>(function(T): (boolean), {T})
   tbl_filter: function(function(any): (boolean), {any})

   tbl_flatten: function<T>({T|{T}}): {T}
   tbl_flatten: function({any|{any}}): {any}

   tbl_isempty: function(table): boolean

   tbl_islist: function(table): boolean

   tbl_keys: function<T>({T:any}): {T}

   tbl_values: function<T>({any:T}): {T}

   tbl_map: function<A, B, C>(function(B): (C), {A:B}): {A:C}
   tbl_map: function(function(any): (any), table): table

   trim: function(string): string

   enum TypeName
      "table" "t"
      "string" "s"
      "number" "n"
      "boolean" "b"
      "function" "f"
      "nil"
      "thread"
      "userdata"
   end
   -- Technically, this should be a union of tuples since the types are dependent and this allows for invalid combos
   validate: function({string:{any, TypeName | {TypeName} | function(any): (boolean, string), boolean | string}})
   -- should be {string:{any, TypeName, boolean} | {any, function(any): (boolean, string)}, string}}

   record Regex
      match_str: function(Regex, string): integer, integer
      match_line: function(Regex, integer, integer, integer, integer): integer, integer
   end
   regex: function(string): Regex

   diff: function(a: string, b: string): string
   -- TODO
   -- diff: function(a: string, b: string, options: DiffOptions): string | {integer}

   record VersionInfo
      api_compatible: integer
      api_level: integer
      api_prerelease: integer
      major: integer
      minor: integer
      patch: integer
   end

   version: function(): VersionInfo

   uri_from_bufnr: function(bufnr: BufferId): string
   uri_from_fname: function(path: string): string
   uri_to_bufnr: function(uri: string): integer
   uri_to_fname: function(uri: string): string

   pretty_print: function(obj: any): string

   region: function(bufnr: BufferId, pos1: {integer}, pos2: {integer}, regtype: string, inclusive: boolean): {integer:{integer}}

   record filetype
      -- TODO - replace table with options record
      add: function(filetypes: table)

      match: function(name: string, bufnr: BufferId)
   end

   record mpack
      encode: function(obj: any): string
      decode: function(str: string): any
   end

   record spell
      check: function(str: string): {{string | integer}}
   end

   in_fast_event: function(): boolean

   -- special nil for filling tables in rpc stuff
   interface NIL is userdata
   end

   empty_dict: function(): table
   on_key: function(function(string), integer): integer

   rpcnotify: function(integer, string, ...: string)
   rpcrequest: function(integer, string, ...: string)

   stricmp: function(string, string): integer
   str_utfindex: function(string, integer): integer, integer
   str_byteindex: function(string, integer, boolean): integer

   schedule: function(function)

   schedule_wrap: function(function): function

   type_idx: boolean

   val_idx: boolean

   types: {string|integer:string|integer}

   record keymap
      record DelOpts
         buffer: boolean | integer
      end

      record SetOpts
         buffer: boolean | integer
         callback: function
         desc: string
         expr: boolean
         nowait: boolean
         remap: boolean
         replace_keycodes: boolean
         script: boolean
         silent: boolean
         unique: boolean
      end

      set: function(mode: string|{string}, lhs: string, rhs: string|function(), opts: SetOpts)
      del: function(modes: string|{string}, lhs: string, opts: DelOpts)
   end

   record EventData --TODO: this is a vim thing, so types aren't really documented
      abort: any
      chan: integer
      cmdlevel: any
      cmdtype: any
      cwd: string
      inclusive: boolean
      scope: any
      operator: any
      regcontents: any
      regname: any
      regtype: any
      visual: any
      completed_item: any
      height: any
      width: any
      row: integer
      col: integer
      size: any
      scrollbar: any
      changed_window: any
   end

   record hl
      record Opts
         higroup: string
         timeout: integer
         on_macro: boolean
         on_visual: boolean
         event: EventData
      end
      on_yank: function(Opts)
      range: function(
         bufnr: BufferId,
         ns: NamespaceId,
         higroup: string,
         start: {integer, integer},
         finish: {integer, integer},
         options: table
      )
   end
   highlight: hl

   record diagnostic
      type Severity = integer
      record severity is {string} -- would be great if this could be a tuplerecord
         ERROR: Severity
         WARN: Severity
         INFO: Severity
         HINT: Severity
         E: Severity
         W: Severity
         I: Severity
         H: Severity
      end

      record Diagnostic
         lnum: integer -- The starting line of the diagnostic
         end_lnum: integer -- The final line of the diagnostic
         col: integer -- The starting column of the diagnostic
         end_col: integer -- The final column of the diagnostic
         severity: Severity -- The severity of the diagnostic |vim.diagnostic.severity|
         message: string -- The diagnostic text
         source: string -- The source of the diagnostic
      end
      record ConfigOpts
         record UnderlineOpts
            severity: Severity
         end
         record VirtualTextOpts
            severity: Severity
            source: string
            format: function(diagnostic: Diagnostic): string
         end
         record SignsOpts
            severity: Severity
            priority: integer
         end

         underline: boolean|UnderlineOpts
         virtual_text: boolean|VirtualTextOpts
         signs: boolean|SignsOpts
         float: OpenFloatOpts
         update_in_insert: boolean
         severity_sort: boolean
      end
      record GetOpts
         namespace: NamespaceId
         lnum: integer
         severity: Severity
      end
      record GotoOpts
         namespace: NamespaceId
         cursor_position: {integer, integer}
         wrap: boolean
         severity: Severity
         float: boolean|OpenFloatOpts
         win_id: WindowId
      end
      record OpenFloatOpts
         enum Scope
            "buffer"
            "line"
            "cursor"
         end

         namespace: NamespaceId
         scope: Scope
         pos: integer|{integer, integer}
         severity_sort: boolean
         severity: Severity
         header: string|{string, string}
         source: string
         format: function(diagnostic: Diagnostic): string
         prefix: string|{string, string}|function(diagnostic: Diagnostic, i: integer, total: integer): string, string
      end
      record SetLocListOpts
         namespace: NamespaceId
         winnr: WindowId
         open: boolean
         title: string
         severity: Severity
      end
      record SetQfListOpts
         namespace: NamespaceId
         open: boolean
         title: string
         severity: Severity
      end
      config: function(opts: ConfigOpts, namespace: NamespaceId)
      disable: function(bufnr: BufferId, namespace: NamespaceId)
      enable: function(bufnr: BufferId, namespace: NamespaceId)
      fromqflist: function(list: {any}): {Diagnostic}
      get: function(bufnr: BufferId, opts: GetOpts)
      get_namespace: function(namespace: NamespaceId): {string:integer}
      get_namespace: function(namespace: NamespaceId): {{string:integer}}
      get_next: function(opts: GotoOpts): Diagnostic
      get_next_pos: function(opts: GotoOpts): {integer, integer}
      get_prev: function(opts: GotoOpts): Diagnostic
      get_prev_pos: function(opts: GotoOpts): {integer, integer}
      goto_next: function(opts: GotoOpts)
      goto_prev: function(opts: GotoOpts)
      hide: function(namespace: NamespaceId, bufnr: BufferId)
      match: function(str: string, pat: string, groups: {string}, severity_map: {string:string}, defaults: {string:any}): Diagnostic
      open_float: function(opts: OpenFloatOpts): {integer, integer}
      reset: function(namespace: NamespaceId, bufnr: BufferId)
      set: function(namespace: NamespaceId, bufnr: BufferId, diagnostics: {Diagnostic}, opts: ConfigOpts)
      setloclist: function(opts: SetLocListOpts)
      setqflist: function(opts: SetQfListOpts)
      show: function(namespace: NamespaceId, bufnr: BufferId, diagnostics: {Diagnostic}, opts: ConfigOpts)
      toqflist: function({Diagnostic}): {string:any}
   end

   record lsp
      record buf
         hover: function
      end
      buf_attach_client: function(bufnr: BufferId, client_id: integer)
      buf_get_clients: function(bufnr: BufferId)
      buf_is_attached: function(bufnr: BufferId, client_id: integer)
      buf_notify: function(bufnr: BufferId, method: string, params: string): boolean
      buf_request: function(bufnr: BufferId, method: string, params: table, handler: function): {integer:integer}, function
      buf_request_sync: function(bufnr: BufferId, method: string, params: table, timeout_ms: integer): {integer:integer}, string

      record Client
         request: function(Client)
      end
      client: function(): Client
   end

   record Option
      append: function(Option, string)
      prepend: function(Option, string)
      remove: function(Option, string)
      get: function(Option): any

      metamethod __add: function(Option, string): Option
      metamethod __sub: function(Option, string): Option
      metamethod __pow: function(Option, string): Option
   end
   opt: {string:Option}
   opt_local: {string:Option}
   opt_global: {string:Option}

   g: {string:any}
   t: {string:any}
   v: {string:any}
   b: {string:any}
   w: {string:any}
   env: {string:any}

   record AllOptions
      acd: boolean
      ai: boolean
      al: number
      aleph: number
      allowrevins: boolean
      ambiwidth: string
      ambw: string
      ar: boolean
      arab: boolean
      arabic: boolean
      arabicshape: boolean
      ari: boolean
      arshape: boolean
      autochdir: boolean
      autoindent: boolean
      autoread: boolean
      autowrite: boolean
      autowriteall: boolean
      aw: boolean
      awa: boolean
      background: string
      backspace: string
      backup: boolean
      backupcopy: string
      backupdir: string
      backupext: string
      backupskip: string
      bdir: string
      belloff: string
      bex: string
      bg: string
      bh: string
      bin: boolean
      binary: boolean
      bk: boolean
      bkc: string
      bl: boolean
      bo: string
      bomb: boolean
      breakat: string
      breakindent: boolean
      breakindentopt: string
      bri: boolean
      briopt: string
      brk: string
      browsedir: string
      bs: string
      bsdir: string
      bsk: string
      bt: string
      bufhidden: string
      buflisted: boolean
      buftype: string
      casemap: string
      cb: string
      cc: string
      ccv: string
      cd: string
      cdh: boolean
      cdhome: boolean
      cdpath: string
      cedit: string
      cf: boolean
      cfu: string
      ch: number
      channel: number
      charconvert: string
      ci: boolean
      cia: string
      cin: boolean
      cindent: boolean
      cink: string
      cinkeys: string
      cino: string
      cinoptions: string
      cinscopedecls: string
      cinsd: string
      cinw: string
      cinwords: string
      clipboard: string
      cmdheight: number
      cmdwinheight: number
      cmp: string
      cms: string
      co: number
      cocu: string
      cole: number
      colorcolumn: string
      columns: number
      com: string
      comments: string
      commentstring: string
      compatible: boolean
      complete: string
      completefunc: string
      completeitemalign: string
      completeopt: string
      completeslash: string
      concealcursor: string
      conceallevel: number
      confirm: boolean
      copyindent: boolean
      cot: string
      cp: boolean
      cpo: string
      cpoptions: string
      cpt: string
      crb: boolean
      csl: string
      cuc: boolean
      cul: boolean
      culopt: string
      cursorbind: boolean
      cursorcolumn: boolean
      cursorline: boolean
      cursorlineopt: string
      cwh: number
      debug: string
      deco: boolean
      def: string
      define: string
      delcombine: boolean
      dex: string
      dg: boolean
      dict: string
      dictionary: string
      diff: boolean
      diffexpr: string
      diffopt: string
      digraph: boolean
      dip: string
      dir: string
      directory: string
      display: string
      dy: string
      ea: boolean
      ead: string
      eadirection: string
      eb: boolean
      ed: boolean
      edcompatible: boolean
      ef: string
      efm: string
      ei: string
      eiw: string
      emo: boolean
      emoji: boolean
      enc: string
      encoding: string
      endoffile: boolean
      endofline: boolean
      eof: boolean
      eol: boolean
      ep: string
      equalalways: boolean
      equalprg: string
      errorbells: boolean
      errorfile: string
      errorformat: string
      et: boolean
      eventignore: string
      eventignorewin: string
      ex: boolean
      expandtab: boolean
      exrc: boolean
      fcl: string
      fcs: string
      fdc: string
      fde: string
      fdi: string
      fdl: number
      fdls: number
      fdm: string
      fdn: number
      fdo: string
      fdt: string
      fen: boolean
      fenc: string
      fencs: string
      fex: string
      ff: string
      ffs: string
      ffu: string
      fic: boolean
      fileencoding: string
      fileencodings: string
      fileformat: string
      fileformats: string
      fileignorecase: boolean
      filetype: string
      fillchars: string
      findfunc: string
      fixendofline: boolean
      fixeol: boolean
      flp: string
      fml: number
      fmr: string
      fo: string
      foldclose: string
      foldcolumn: string
      foldenable: boolean
      foldexpr: string
      foldignore: string
      foldlevel: number
      foldlevelstart: number
      foldmarker: string
      foldmethod: string
      foldminlines: number
      foldnestmax: number
      foldopen: string
      foldtext: string
      formatexpr: string
      formatlistpat: string
      formatoptions: string
      formatprg: string
      fp: string
      fs: boolean
      fsync: boolean
      ft: string
      gcr: string
      gd: boolean
      gdefault: boolean
      gfm: string
      gfn: string
      gfw: string
      go: string
      gp: string
      grepformat: string
      grepprg: string
      gtl: string
      gtt: string
      guicursor: string
      guifont: string
      guifontwide: string
      guioptions: string
      guitablabel: string
      guitabtooltip: string
      helpfile: string
      helpheight: number
      helplang: string
      hf: string
      hh: number
      hi: number
      hid: boolean
      hidden: boolean
      highlight: string
      history: number
      hk: boolean
      hkmap: boolean
      hkmapp: boolean
      hkp: boolean
      hl: string
      hlg: string
      hls: boolean
      hlsearch: boolean
      ic: boolean
      icm: string
      icon: boolean
      iconstring: string
      ignorecase: boolean
      im: boolean
      imc: boolean
      imcmdline: boolean
      imd: boolean
      imdisable: boolean
      imi: number
      iminsert: number
      ims: number
      imsearch: number
      inc: string
      inccommand: string
      include: string
      includeexpr: string
      incsearch: boolean
      inde: string
      indentexpr: string
      indentkeys: string
      indk: string
      inex: string
      inf: boolean
      infercase: boolean
      insertmode: boolean
      is: boolean
      isf: string
      isfname: string
      isi: string
      isident: string
      isk: string
      iskeyword: string
      isp: string
      isprint: string
      joinspaces: boolean
      jop: string
      js: boolean
      jumpoptions: string
      keymap: string
      keymodel: string
      keywordprg: string
      km: string
      kmp: string
      kp: string
      langmap: string
      langmenu: string
      langnoremap: boolean
      langremap: boolean
      laststatus: number
      lazyredraw: boolean
      lbr: boolean
      lcs: string
      linebreak: boolean
      lines: number
      linespace: number
      lisp: boolean
      lispoptions: string
      lispwords: string
      list: boolean
      listchars: string
      lm: string
      lmap: string
      lnr: boolean
      loadplugins: boolean
      lop: string
      lpl: boolean
      lrm: boolean
      ls: number
      lsp: number
      lw: string
      lz: boolean
      ma: boolean
      magic: boolean
      makeef: string
      makeencoding: string
      makeprg: string
      mat: number
      matchpairs: string
      matchtime: number
      maxcombine: number
      maxfuncdepth: number
      maxmapdepth: number
      maxmempattern: number
      mco: number
      mef: string
      menc: string
      menuitems: number
      messagesopt: string
      mfd: number
      mh: boolean
      mis: number
      mkspellmem: string
      ml: boolean
      mle: boolean
      mls: number
      mmd: number
      mmp: number
      mod: boolean
      modeline: boolean
      modelineexpr: boolean
      modelines: number
      modifiable: boolean
      modified: boolean
      mopt: string
      more: boolean
      mouse: string
      mousef: boolean
      mousefocus: boolean
      mousehide: boolean
      mousem: string
      mousemev: boolean
      mousemodel: string
      mousemoveevent: boolean
      mouses: string
      mousescroll: string
      mouseshape: string
      mouset: number
      mousetime: number
      mp: string
      mps: string
      msm: string
      nf: string
      nrformats: string
      nu: boolean
      number: boolean
      numberwidth: number
      nuw: number
      odev: boolean
      ofu: string
      omnifunc: string
      opendevice: boolean
      operatorfunc: string
      opfunc: string
      pa: string
      packpath: string
      para: string
      paragraphs: string
      paste: boolean
      pastetoggle: string
      patchexpr: string
      patchmode: string
      path: string
      pb: number
      pex: string
      ph: number
      pi: boolean
      pm: string
      pp: string
      preserveindent: boolean
      previewheight: number
      previewwindow: boolean
      prompt: boolean
      pt: string
      pumblend: number
      pumheight: number
      pumwidth: number
      pvh: number
      pvw: boolean
      pw: number
      pyx: number
      pyxversion: number
      qe: string
      qftf: string
      quickfixtextfunc: string
      quoteescape: string
      rdb: string
      rdt: number
      re: number
      readonly: boolean
      redrawdebug: string
      redrawtime: number
      regexpengine: number
      relativenumber: boolean
      remap: boolean
      report: number
      revins: boolean
      ri: boolean
      rightleft: boolean
      rightleftcmd: string
      rl: boolean
      rlc: string
      rnu: boolean
      ro: boolean
      rtp: string
      ru: boolean
      ruf: string
      ruler: boolean
      rulerformat: string
      runtimepath: string
      sb: boolean
      sbo: string
      sbr: string
      sc: boolean
      scb: boolean
      scbk: number
      scl: string
      scr: number
      scroll: number
      scrollback: number
      scrollbind: boolean
      scrolljump: number
      scrolloff: number
      scrollopt: string
      scs: boolean
      sd: string
      sdf: string
      sect: string
      sections: string
      secure: boolean
      sel: string
      selection: string
      selectmode: string
      sessionoptions: string
      sft: boolean
      sh: string
      shada: string
      shadafile: string
      shcf: string
      shell: string
      shellcmdflag: string
      shellpipe: string
      shellquote: string
      shellredir: string
      shellslash: boolean
      shelltemp: boolean
      shellxescape: string
      shellxquote: string
      shiftround: boolean
      shiftwidth: number
      shm: string
      shortmess: string
      showbreak: string
      showcmd: boolean
      showcmdloc: string
      showfulltag: boolean
      showmatch: boolean
      showmode: boolean
      showtabline: number
      shq: string
      si: boolean
      sidescroll: number
      sidescrolloff: number
      signcolumn: string
      siso: number
      sj: number
      slm: string
      sloc: string
      sm: boolean
      smartcase: boolean
      smartindent: boolean
      smarttab: boolean
      smc: number
      smd: boolean
      smoothscroll: boolean
      sms: boolean
      so: number
      softtabstop: number
      sol: boolean
      sp: string
      spc: string
      spell: boolean
      spellcapcheck: string
      spellfile: string
      spelllang: string
      spelloptions: string
      spellsuggest: string
      spf: string
      spk: string
      spl: string
      splitbelow: boolean
      splitkeep: string
      splitright: boolean
      spo: string
      spr: boolean
      sps: string
      sr: boolean
      srr: string
      ss: number
      ssl: boolean
      ssop: string
      sta: boolean
      stal: number
      startofline: boolean
      statuscolumn: string
      statusline: string
      stc: string
      stl: string
      stmp: boolean
      sts: number
      su: string
      sua: string
      suffixes: string
      suffixesadd: string
      sw: number
      swapfile: boolean
      swb: string
      swf: boolean
      switchbuf: string
      sxe: string
      sxq: string
      syn: string
      synmaxcol: number
      syntax: string
      tabclose: string
      tabline: string
      tabpagemax: number
      tabstop: number
      tag: string
      tagbsearch: boolean
      tagcase: string
      tagfunc: string
      taglength: number
      tagrelative: boolean
      tags: string
      tagstack: boolean
      tal: string
      tbidi: boolean
      tbs: boolean
      tc: string
      tcl: string
      tenc: string
      termbidi: boolean
      termencoding: string
      termguicolors: boolean
      termpastefilter: string
      termsync: boolean
      terse: boolean
      textwidth: number
      tf: boolean
      tfu: string
      tgc: boolean
      tgst: boolean
      thesaurus: string
      thesaurusfunc: string
      tildeop: boolean
      timeout: boolean
      timeoutlen: number
      title: boolean
      titlelen: number
      titleold: string
      titlestring: string
      tl: number
      tm: number
      to: boolean
      top: boolean
      tpf: string
      tpm: number
      tr: boolean
      ts: number
      tsr: string
      tsrfu: string
      ttimeout: boolean
      ttimeoutlen: number
      ttm: number
      ttyfast: boolean
      tw: number
      uc: number
      udf: boolean
      udir: string
      ul: number
      undodir: string
      undofile: boolean
      undolevels: number
      undoreload: number
      updatecount: number
      updatetime: number
      ur: number
      ut: number
      varsofttabstop: string
      vartabstop: string
      vb: boolean
      vbs: number
      vdir: string
      ve: string
      verbose: number
      verbosefile: string
      vfile: string
      viewdir: string
      viewoptions: string
      virtualedit: string
      visualbell: boolean
      vop: string
      vsts: string
      vts: string
      wa: boolean
      wak: string
      warn: boolean
      wb: boolean
      wbr: string
      wc: number
      wcm: number
      wd: number
      wfb: boolean
      wfh: boolean
      wfw: boolean
      wh: number
      whichwrap: string
      wi: number
      wic: boolean
      wig: string
      wildchar: number
      wildcharm: number
      wildignore: string
      wildignorecase: boolean
      wildmenu: boolean
      wildmode: string
      wildoptions: string
      wim: string
      winaltkeys: string
      winbar: string
      winbl: number
      winblend: number
      winborder: string
      window: number
      winfixbuf: boolean
      winfixheight: boolean
      winfixwidth: boolean
      winheight: number
      winhighlight: string
      winhl: string
      winminheight: number
      winminwidth: number
      winwidth: number
      wiw: number
      wm: number
      wmh: number
      wmnu: boolean
      wmw: number
      wop: string
      wrap: boolean
      wrapmargin: number
      wrapscan: boolean
      write: boolean
      writeany: boolean
      writebackup: boolean
      writedelay: number
      ws: boolean
      ww: string
   end
   o: AllOptions

   record GlobalOptions
      acd: boolean
      al: number
      aleph: number
      allowrevins: boolean
      ambiwidth: string
      ambw: string
      arabicshape: boolean
      ari: boolean
      arshape: boolean
      autochdir: boolean
      autowrite: boolean
      autowriteall: boolean
      aw: boolean
      awa: boolean
      background: string
      backspace: string
      backup: boolean
      backupdir: string
      backupext: string
      backupskip: string
      bdir: string
      belloff: string
      bex: string
      bg: string
      bk: boolean
      bo: string
      breakat: string
      brk: string
      browsedir: string
      bs: string
      bsdir: string
      bsk: string
      casemap: string
      cb: string
      ccv: string
      cd: string
      cdh: boolean
      cdhome: boolean
      cdpath: string
      cedit: string
      cf: boolean
      ch: number
      charconvert: string
      cia: string
      clipboard: string
      cmdheight: number
      cmdwinheight: number
      cmp: string
      co: number
      columns: number
      compatible: boolean
      completeitemalign: string
      confirm: boolean
      cp: boolean
      cpo: string
      cpoptions: string
      cwh: number
      debug: string
      deco: boolean
      delcombine: boolean
      dex: string
      dg: boolean
      diffexpr: string
      diffopt: string
      digraph: boolean
      dip: string
      dir: string
      directory: string
      display: string
      dy: string
      ea: boolean
      ead: string
      eadirection: string
      eb: boolean
      ed: boolean
      edcompatible: boolean
      ef: string
      ei: string
      emo: boolean
      emoji: boolean
      enc: string
      encoding: string
      equalalways: boolean
      errorbells: boolean
      errorfile: string
      eventignore: string
      ex: boolean
      exrc: boolean
      fcl: string
      fdls: number
      fdo: string
      fencs: string
      ffs: string
      fic: boolean
      fileencodings: string
      fileformats: string
      fileignorecase: boolean
      foldclose: string
      foldlevelstart: number
      foldopen: string
      fs: boolean
      fsync: boolean
      gcr: string
      gd: boolean
      gdefault: boolean
      gfm: string
      gfn: string
      gfw: string
      go: string
      grepformat: string
      gtl: string
      gtt: string
      guicursor: string
      guifont: string
      guifontwide: string
      guioptions: string
      guitablabel: string
      guitabtooltip: string
      helpfile: string
      helpheight: number
      helplang: string
      hf: string
      hh: number
      hi: number
      hid: boolean
      hidden: boolean
      highlight: string
      history: number
      hk: boolean
      hkmap: boolean
      hkmapp: boolean
      hkp: boolean
      hl: string
      hlg: string
      hls: boolean
      hlsearch: boolean
      ic: boolean
      icm: string
      icon: boolean
      iconstring: string
      ignorecase: boolean
      im: boolean
      imc: boolean
      imcmdline: boolean
      imd: boolean
      imdisable: boolean
      inccommand: string
      incsearch: boolean
      insertmode: boolean
      is: boolean
      isf: string
      isfname: string
      isi: string
      isident: string
      isp: string
      isprint: string
      joinspaces: boolean
      jop: string
      js: boolean
      jumpoptions: string
      keymodel: string
      km: string
      langmap: string
      langmenu: string
      langnoremap: boolean
      langremap: boolean
      laststatus: number
      lazyredraw: boolean
      lines: number
      linespace: number
      lm: string
      lmap: string
      lnr: boolean
      loadplugins: boolean
      lpl: boolean
      lrm: boolean
      ls: number
      lsp: number
      lz: boolean
      magic: boolean
      makeef: string
      mat: number
      matchtime: number
      maxcombine: number
      maxfuncdepth: number
      maxmapdepth: number
      maxmempattern: number
      mco: number
      mef: string
      menuitems: number
      messagesopt: string
      mfd: number
      mh: boolean
      mis: number
      mkspellmem: string
      mle: boolean
      mls: number
      mmd: number
      mmp: number
      modelineexpr: boolean
      modelines: number
      mopt: string
      more: boolean
      mouse: string
      mousef: boolean
      mousefocus: boolean
      mousehide: boolean
      mousem: string
      mousemev: boolean
      mousemodel: string
      mousemoveevent: boolean
      mouses: string
      mousescroll: string
      mouseshape: string
      mouset: number
      mousetime: number
      msm: string
      odev: boolean
      opendevice: boolean
      operatorfunc: string
      opfunc: string
      packpath: string
      para: string
      paragraphs: string
      paste: boolean
      pastetoggle: string
      patchexpr: string
      patchmode: string
      pb: number
      pex: string
      ph: number
      pm: string
      pp: string
      previewheight: number
      prompt: boolean
      pt: string
      pumblend: number
      pumheight: number
      pumwidth: number
      pvh: number
      pw: number
      pyx: number
      pyxversion: number
      qftf: string
      quickfixtextfunc: string
      rdb: string
      rdt: number
      re: number
      redrawdebug: string
      redrawtime: number
      regexpengine: number
      remap: boolean
      report: number
      revins: boolean
      ri: boolean
      rtp: string
      ru: boolean
      ruf: string
      ruler: boolean
      rulerformat: string
      runtimepath: string
      sb: boolean
      sbo: string
      sc: boolean
      scrolljump: number
      scrollopt: string
      scs: boolean
      sd: string
      sdf: string
      sect: string
      sections: string
      secure: boolean
      sel: string
      selection: string
      selectmode: string
      sessionoptions: string
      sft: boolean
      sh: string
      shada: string
      shadafile: string
      shcf: string
      shell: string
      shellcmdflag: string
      shellpipe: string
      shellquote: string
      shellredir: string
      shellslash: boolean
      shelltemp: boolean
      shellxescape: string
      shellxquote: string
      shiftround: boolean
      shm: string
      shortmess: string
      showcmd: boolean
      showcmdloc: string
      showfulltag: boolean
      showmatch: boolean
      showmode: boolean
      showtabline: number
      shq: string
      sidescroll: number
      sj: number
      slm: string
      sloc: string
      sm: boolean
      smartcase: boolean
      smarttab: boolean
      smd: boolean
      sol: boolean
      sp: string
      spellsuggest: string
      spk: string
      splitbelow: boolean
      splitkeep: string
      splitright: boolean
      spr: boolean
      sps: string
      sr: boolean
      srr: string
      ss: number
      ssl: boolean
      ssop: string
      sta: boolean
      stal: number
      startofline: boolean
      stmp: boolean
      su: string
      suffixes: string
      swb: string
      switchbuf: string
      sxe: string
      sxq: string
      tabclose: string
      tabline: string
      tabpagemax: number
      tagbsearch: boolean
      taglength: number
      tagrelative: boolean
      tagstack: boolean
      tal: string
      tbidi: boolean
      tbs: boolean
      tcl: string
      tenc: string
      termbidi: boolean
      termencoding: string
      termguicolors: boolean
      termpastefilter: string
      termsync: boolean
      terse: boolean
      tf: boolean
      tgc: boolean
      tgst: boolean
      tildeop: boolean
      timeout: boolean
      timeoutlen: number
      title: boolean
      titlelen: number
      titleold: string
      titlestring: string
      tl: number
      tm: number
      to: boolean
      top: boolean
      tpf: string
      tpm: number
      tr: boolean
      ttimeout: boolean
      ttimeoutlen: number
      ttm: number
      ttyfast: boolean
      uc: number
      udir: string
      undodir: string
      undoreload: number
      updatecount: number
      updatetime: number
      ur: number
      ut: number
      vb: boolean
      vbs: number
      vdir: string
      verbose: number
      verbosefile: string
      vfile: string
      viewdir: string
      viewoptions: string
      visualbell: boolean
      vop: string
      wa: boolean
      wak: string
      warn: boolean
      wb: boolean
      wc: number
      wcm: number
      wd: number
      wh: number
      whichwrap: string
      wi: number
      wic: boolean
      wig: string
      wildchar: number
      wildcharm: number
      wildignore: string
      wildignorecase: boolean
      wildmenu: boolean
      wildmode: string
      wildoptions: string
      wim: string
      winaltkeys: string
      winborder: string
      window: number
      winheight: number
      winminheight: number
      winminwidth: number
      winwidth: number
      wiw: number
      wmh: number
      wmnu: boolean
      wmw: number
      wop: string
      wrapscan: boolean
      write: boolean
      writeany: boolean
      writebackup: boolean
      writedelay: number
      ws: boolean
      ww: string
   end
   go: GlobalOptions

   record BufferOptions
      ai: boolean
      ar: boolean
      autoindent: boolean
      autoread: boolean
      backupcopy: string
      bh: string
      bin: boolean
      binary: boolean
      bkc: string
      bl: boolean
      bomb: boolean
      bt: string
      bufhidden: string
      buflisted: boolean
      buftype: string
      cfu: string
      channel: number
      ci: boolean
      cin: boolean
      cindent: boolean
      cink: string
      cinkeys: string
      cino: string
      cinoptions: string
      cinscopedecls: string
      cinsd: string
      cinw: string
      cinwords: string
      cms: string
      com: string
      comments: string
      commentstring: string
      complete: string
      completefunc: string
      completeopt: string
      completeslash: string
      copyindent: boolean
      cot: string
      cpt: string
      csl: string
      def: string
      define: string
      dict: string
      dictionary: string
      efm: string
      endoffile: boolean
      endofline: boolean
      eof: boolean
      eol: boolean
      ep: string
      equalprg: string
      errorformat: string
      et: boolean
      expandtab: boolean
      fenc: string
      fex: string
      ff: string
      ffu: string
      fileencoding: string
      fileformat: string
      filetype: string
      findfunc: string
      fixendofline: boolean
      fixeol: boolean
      flp: string
      fo: string
      formatexpr: string
      formatlistpat: string
      formatoptions: string
      formatprg: string
      fp: string
      ft: string
      gp: string
      grepprg: string
      imi: number
      iminsert: number
      ims: number
      imsearch: number
      inc: string
      include: string
      includeexpr: string
      inde: string
      indentexpr: string
      indentkeys: string
      indk: string
      inex: string
      inf: boolean
      infercase: boolean
      isk: string
      iskeyword: string
      keymap: string
      keywordprg: string
      kmp: string
      kp: string
      lisp: boolean
      lispoptions: string
      lispwords: string
      lop: string
      lw: string
      ma: boolean
      makeencoding: string
      makeprg: string
      matchpairs: string
      menc: string
      ml: boolean
      mod: boolean
      modeline: boolean
      modifiable: boolean
      modified: boolean
      mp: string
      mps: string
      nf: string
      nrformats: string
      ofu: string
      omnifunc: string
      pa: string
      path: string
      pi: boolean
      preserveindent: boolean
      qe: string
      quoteescape: string
      readonly: boolean
      ro: boolean
      scbk: number
      scrollback: number
      shiftwidth: number
      si: boolean
      smartindent: boolean
      smc: number
      softtabstop: number
      spc: string
      spellcapcheck: string
      spellfile: string
      spelllang: string
      spelloptions: string
      spf: string
      spl: string
      spo: string
      sts: number
      sua: string
      suffixesadd: string
      sw: number
      swapfile: boolean
      swf: boolean
      syn: string
      synmaxcol: number
      syntax: string
      tabstop: number
      tag: string
      tagcase: string
      tagfunc: string
      tags: string
      tc: string
      textwidth: number
      tfu: string
      thesaurus: string
      thesaurusfunc: string
      ts: number
      tsr: string
      tsrfu: string
      tw: number
      udf: boolean
      ul: number
      undofile: boolean
      undolevels: number
      varsofttabstop: string
      vartabstop: string
      vsts: string
      vts: string
      wm: number
      wrapmargin: number
   end
   bo: BufferOptions

   record WindowOptions
      arab: boolean
      arabic: boolean
      breakindent: boolean
      breakindentopt: string
      bri: boolean
      briopt: string
      cc: string
      cocu: string
      cole: number
      colorcolumn: string
      concealcursor: string
      conceallevel: number
      crb: boolean
      cuc: boolean
      cul: boolean
      culopt: string
      cursorbind: boolean
      cursorcolumn: boolean
      cursorline: boolean
      cursorlineopt: string
      diff: boolean
      eiw: string
      eventignorewin: string
      fcs: string
      fdc: string
      fde: string
      fdi: string
      fdl: number
      fdm: string
      fdn: number
      fdt: string
      fen: boolean
      fillchars: string
      fml: number
      fmr: string
      foldcolumn: string
      foldenable: boolean
      foldexpr: string
      foldignore: string
      foldlevel: number
      foldmarker: string
      foldmethod: string
      foldminlines: number
      foldnestmax: number
      foldtext: string
      lbr: boolean
      lcs: string
      linebreak: boolean
      list: boolean
      listchars: string
      nu: boolean
      number: boolean
      numberwidth: number
      nuw: number
      previewwindow: boolean
      pvw: boolean
      relativenumber: boolean
      rightleft: boolean
      rightleftcmd: string
      rl: boolean
      rlc: string
      rnu: boolean
      sbr: string
      scb: boolean
      scl: string
      scr: number
      scroll: number
      scrollbind: boolean
      scrolloff: number
      showbreak: string
      sidescrolloff: number
      signcolumn: string
      siso: number
      smoothscroll: boolean
      sms: boolean
      so: number
      spell: boolean
      statuscolumn: string
      statusline: string
      stc: string
      stl: string
      ve: string
      virtualedit: string
      wbr: string
      wfb: boolean
      wfh: boolean
      wfw: boolean
      winbar: string
      winbl: number
      winblend: number
      winfixbuf: boolean
      winfixheight: boolean
      winfixwidth: boolean
      winhighlight: string
      winhl: string
      wrap: boolean
   end
   wo: WindowOptions

   record api
      --[[
         API version Information
            neovim version: 0.11.3

            compatible: 0
            level: 13
            prerelease: false
      --]]

      --[[
         Vim Type -> Teal Type
         Array -> {any}
         Boolean -> boolean
         Buffer -> BufferId
         Dict -> {string:any}
         Dictionary -> {string:any}
         Float -> number
         Integer -> integer
         Number -> number
         Object -> any
         String -> string
         Tabpage -> TabpageId
         Window -> WindowId
         none of the above -> any
      --]]

      nvim_buf_attach: function(BufferId, boolean, {string:any}): boolean
      nvim_buf_call: function<Ret>(BufferId, function(): Ret): Ret
      nvim_buf_clear_namespace: function(BufferId, integer, integer, integer)
      nvim_buf_create_user_command: function(BufferId, string, string | function(CommandArguments), CreateUserCommandOpts)
      nvim_buf_del_extmark: function(BufferId, integer, integer): boolean
      nvim_buf_del_keymap: function(BufferId, string, string)
      nvim_buf_del_mark: function(BufferId, string): boolean
      nvim_buf_del_user_command: function(BufferId, string)
      nvim_buf_del_var: function(BufferId, string)
      nvim_buf_delete: function(BufferId, {string:any})
      nvim_buf_detach: function(BufferId): boolean
      nvim_buf_get_changedtick: function(BufferId): integer
      nvim_buf_get_commands: function(BufferId, {string:any}): {string:any}
      nvim_buf_get_extmark_by_id: function(BufferId, integer, integer, {string:any}): {integer}
      nvim_buf_get_extmarks: function(BufferId, integer, any, any, {string:any}): {any}
      nvim_buf_get_keymap: function(BufferId, string): {{string:any}}
      nvim_buf_get_lines: function(BufferId, integer, integer, boolean): {string}
      nvim_buf_get_mark: function(BufferId, string): {integer,integer}
      nvim_buf_get_name: function(BufferId): string
      nvim_buf_get_offset: function(BufferId, integer): integer
      nvim_buf_get_text: function(BufferId, integer, integer, integer, integer, {string:any}): {string}
      nvim_buf_get_var: function(BufferId, string): any
      nvim_buf_is_loaded: function(BufferId): boolean
      nvim_buf_is_valid: function(BufferId): boolean
      nvim_buf_line_count: function(BufferId): integer
      nvim_buf_set_extmark: function(BufferId, integer, integer, integer, {string:any}): integer
      nvim_buf_set_keymap: function(BufferId, string, string, string, {string:any})
      nvim_buf_set_lines: function(BufferId, integer, integer, boolean, {string})
      nvim_buf_set_mark: function(BufferId, string, integer, integer, {string:any}): boolean
      nvim_buf_set_name: function(BufferId, string)
      nvim_buf_set_text: function(BufferId, integer, integer, integer, integer, {string})
      nvim_buf_set_var: function(BufferId, string, any)
      nvim_call_dict_function: function(any, string, {any}): any
      nvim_call_function: function(string, {any}): any
      nvim_chan_send: function(integer, string)
      nvim_clear_autocmds: function({string:any})
      nvim_cmd: function({string:any}, {string:any}): string
      nvim_command: function(string)
      nvim_create_augroup: function(string, AugroupOpts): AutocmdGroupId
      nvim_create_autocmd: function(string|{string}, AutocmdOpts): AutocmdId
      nvim_create_buf: function(boolean, boolean): BufferId
      nvim_create_namespace: function(string): NamespaceId
      nvim_create_user_command: function(string, string | function(CommandArguments), CreateUserCommandOpts)
      nvim_del_augroup_by_id: function(integer)
      nvim_del_augroup_by_name: function(string)
      nvim_del_autocmd: function(integer)
      nvim_del_current_line: function()
      nvim_del_keymap: function(string, string)
      nvim_del_mark: function(string): boolean
      nvim_del_user_command: function(string)
      nvim_del_var: function(string)
      nvim_echo: function({any}, boolean, {string:any})
      nvim_eval: function(string): any
      nvim_eval_statusline: function(string, {string:any}): {string:any}
      nvim_exec2: function(string, {string:any}): {string:any}
      nvim_exec_autocmds: function(any, {string:any})
      nvim_exec_lua: function(string, {any}): any
      nvim_feedkeys: function(string, string, boolean)
      nvim_get_all_options_info: function(): {string:any}
      nvim_get_api_info: function(): {any}
      nvim_get_autocmds: function({string:any}): {any}
      nvim_get_chan_info: function(integer): {string:any}
      nvim_get_color_by_name: function(string): integer
      nvim_get_color_map: function(): {string:any}
      nvim_get_commands: function({string:any}): {string:any}
      nvim_get_context: function({string:any}): {string:any}
      nvim_get_current_buf: function(): BufferId
      nvim_get_current_line: function(): string
      nvim_get_current_tabpage: function(): TabpageId
      nvim_get_current_win: function(): WindowId
      nvim_get_hl: function(integer, {string:any}): {string:any}
      nvim_get_hl_id_by_name: function(string): integer
      nvim_get_hl_ns: function({string:any}): integer
      nvim_get_keymap: function(string): {{string:any}}
      nvim_get_mark: function(string, {string:any}): {any}
      nvim_get_mode: function(): BlockingMode
      nvim_get_namespaces: function(): {string:any}
      nvim_get_option_info2: function(string, OptionInfo2Opts): OptionInfo
      nvim_get_option_value: function(string, GetOptionValueOpts): any
      nvim_get_proc: function(integer): any
      nvim_get_proc_children: function(integer): {any}
      nvim_get_runtime_file: function(string, boolean): {string}
      nvim_get_var: function(string): any
      nvim_get_vvar: function(string): any
      nvim_input: function(string): integer
      nvim_input_mouse: function(string, string, string, integer, integer, integer)
      nvim_list_bufs: function(): {BufferId}
      nvim_list_chans: function(): {any}
      nvim_list_runtime_paths: function(): {string}
      nvim_list_tabpages: function(): {TabpageId}
      nvim_list_uis: function(): {any}
      nvim_list_wins: function(): {WindowId}
      nvim_load_context: function({string:any}): any
      nvim_open_term: function(BufferId, {string:any}): integer
      nvim_open_win: function(BufferId, boolean, {string:any}): WindowId
      nvim_parse_cmd: function(string, {string:any}): {string:any}
      nvim_parse_expression: function(string, string, boolean): {string:any}
      nvim_paste: function(string, boolean, integer): boolean
      nvim_put: function({string}, string, boolean, boolean)
      nvim_replace_termcodes: function(string, boolean, boolean, boolean): string
      nvim_select_popupmenu_item: function(integer, boolean, boolean, {string:any})
      nvim_set_client_info: function(string, {string:any}, string, {string:any}, {string:any})
      nvim_set_current_buf: function(BufferId)
      nvim_set_current_dir: function(string)
      nvim_set_current_line: function(string)
      nvim_set_current_tabpage: function(TabpageId)
      nvim_set_current_win: function(WindowId)
      nvim_set_decoration_provider: function(NamespaceId, DecorationProviderCallbacks)
      nvim_set_hl: function(integer, string, {string:any})
      nvim_set_hl_ns: function(integer)
      nvim_set_hl_ns_fast: function(integer)
      nvim_set_keymap: function(string, string, string, {string:any})
      nvim_set_option_value: function(string, any, {string:any})
      nvim_set_var: function(string, any)
      nvim_set_vvar: function(string, any)
      nvim_strwidth: function(string): integer
      nvim_tabpage_del_var: function(TabpageId, string)
      nvim_tabpage_get_number: function(TabpageId): integer
      nvim_tabpage_get_var: function(TabpageId, string): any
      nvim_tabpage_get_win: function(TabpageId): WindowId
      nvim_tabpage_is_valid: function(TabpageId): boolean
      nvim_tabpage_list_wins: function(TabpageId): {WindowId}
      nvim_tabpage_set_var: function(TabpageId, string, any)
      nvim_tabpage_set_win: function(TabpageId, WindowId)
      nvim_ui_attach: function(integer, integer, {string:any})
      nvim_ui_detach: function()
      nvim_ui_pum_set_bounds: function(number, number, number, number)
      nvim_ui_pum_set_height: function(integer)
      nvim_ui_set_focus: function(boolean)
      nvim_ui_set_option: function(string, any)
      nvim_ui_term_event: function(string, any)
      nvim_ui_try_resize: function(integer, integer)
      nvim_ui_try_resize_grid: function(integer, integer, integer)
      nvim_win_call: function<Ret>(WindowId, function(): Ret): Ret
      nvim_win_close: function(WindowId, boolean)
      nvim_win_del_var: function(WindowId, string)
      nvim_win_get_buf: function(WindowId): BufferId
      nvim_win_get_config: function(WindowId): {string:any}
      nvim_win_get_cursor: function(WindowId): {integer,integer}
      nvim_win_get_height: function(WindowId): integer
      nvim_win_get_number: function(WindowId): integer
      nvim_win_get_position: function(WindowId): {integer,integer}
      nvim_win_get_tabpage: function(WindowId): TabpageId
      nvim_win_get_var: function(WindowId, string): any
      nvim_win_get_width: function(WindowId): integer
      nvim_win_hide: function(WindowId)
      nvim_win_is_valid: function(WindowId): boolean
      nvim_win_set_buf: function(WindowId, BufferId)
      nvim_win_set_config: function(WindowId, {string:any})
      nvim_win_set_cursor: function(WindowId, {integer,integer})
      nvim_win_set_height: function(WindowId, integer)
      nvim_win_set_hl_ns: function(WindowId, integer)
      nvim_win_set_var: function(WindowId, string, any)
      nvim_win_set_width: function(WindowId, integer)
      nvim_win_text_height: function(WindowId, {string:any}): {string:any}
   end


   record json
      record DecodeOpts
         record Luanil
            object: boolean
            array: boolean
         end

         luanil: Luanil
      end

      encode: function(string)
      decode: function(string, DecodeOpts)
   end

   record ui
      record InputOpts
         prompt: string
         completion: string
         highlight: function()
      end
      input: function(InputOpts, function(string))

      record SelectOpts
         prompt: string
         format_item: function(any): string
         kind: string
      end
      select: function(any, SelectOpts, function(any, integer))
   end
end

