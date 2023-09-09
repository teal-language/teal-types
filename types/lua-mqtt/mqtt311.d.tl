--
-- https://luarocks.org/modules/fperrad/lua-mqtt
--

local record MQTT
   _NAME: string
   _VERSION: string
   _DESCRIPTION: string
   _COPYRIGHT: string
   PORT: string
   PORT_TLS: string

   record Client
      record Packet
         enum Type
            "CONNACK"
            "PUBLISH"
            "PUBACK"
            "PUBREL"
            "PUBREC"
            "PUBCOMP"
            "SUBACK"
            "UNSUBACK"
            "PINGRESP"
         end

         dup: boolean
         id: integer
         payload: string|{integer}
         qos: integer
         retain: boolean
         rc: integer
         sp: boolean
         topic: string
         type: Type
      end

      record Connect
         record Will
            {string}
            qos: integer
            retain: boolean
         end

         clean: boolean
         keep_alive: integer
         id: string
         will: Will
         username: string
         password: string
      end

      record Publish
         qos: integer
         retain: boolean
      end

      connect: function(self: Client, options: Connect)
      reconnect: function(self: Client, socket: any)
      publish: function(self: Client, topic: string, payload: string, options: Publish)
      subscribe: function(self: Client, list: {integer|string})
      unsubscribe: function(self: Client, list: {string})
      ping: function(self: Client)
      disconnect: function(self: Client)
      read: function(self: Client): Packet, string
   end

   record Params
      logger: any
      max_packet_size: integer
      on_connect: function(reason_code: integer, session_present: boolean)
      on_error: function(): boolean, string
      on_message: function(topic: string, payload: string)
      socket: any
   end

   match: function(name: string, filter: string): boolean

   metamethod __call: function(_: MQTT, t: Params): Client
end

return MQTT
