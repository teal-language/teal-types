local record des56
   -- weak encryption using traditional 56-bits DES
   crypt: function(message: string, key: string): string
   -- des56.decrypt(des56.crypt(message, key), key) == message:
   decrypt: function(message: string, key: string): string
end

return des56
