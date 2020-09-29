local record url
   record ParsedUrl
      url: string
      scheme: string
      authority: string
      path: string
      params: string
      query: string
      fragment: string
      userinfo: string
      host: string
      port: string
      user: string
      password: string
   end

   absolute: function(string, string): string
   build: function(ParsedUrl): string
   build_path: function({string}, any): string
   escape: function(string): string
   parse: function(string, table): ParsedUrl
   parse_path: function(string): {string}
   unescape: function(string): string
end
return url
