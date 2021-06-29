local record md5
   sum: function(message: string): string  -- #res == 8
   sumhexa: function(message: string): string  -- #res == 16 (hex chars)

   -- both strings must have same length:
   exor: function(s1: string, s2: string): string

   -- weak encryption via MD5 in CFB
   crypt: function(message: string, key: string): string
   crypt: function(message: string, key: string, seed: string): string
   -- md5.decrypt(md5.crypt(message, key, seed), key) == message:
   decrypt: function(message: string, key: string): string
end

return md5
