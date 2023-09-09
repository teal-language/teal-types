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

   enum Prop
      "PAYLOAD_FORMAT_INDICATOR"
      "MESSAGE_EXPIRY_INTERVAL"
      "CONTENT_TYPE"
      "RESPONSE_TOPIC"
      "CORRELATION_DATA"
      "SUBSCRIPTION_IDENTIFIER"
      "SESSION_EXPIRY_INTERVAL"
      "ASSIGNED_CLIENT_IDENTIFIER"
      "SERVER_KEEP_ALIVE"
      "AUTHENTICATION_METHOD"
      "AUTHENTICATION_DATA"
      "REQUEST_PROBLEM_INFORMATION"
      "WILL_DELAY_INTERVAL"
      "REQUEST_RESPONSE_INFORMATION"
      "RESPONSE_INFORMATION"
      "SERVER_REFERENCE"
      "REASON_STRING"
      "RECEIVE_MAXIMUM"
      "TOPIC_ALIAS_MAXIMUM"
      "TOPIC_ALIAS"
      "MAXIMUM_QOS"
      "RETAIN_AVAILABLE"
      "USER_PROPERTY"
      "MAXIMUM_PACKET_SIZE"
      "WILDCARD_SUB_AVAILABLE"
      "SUBSCRIPTION_ID_AVAILABLE"
      "SHARED_SUB_AVAILABLE"
   end
   PROP: {Prop:integer}

   type Properties = {integer|string|table}

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
            "DISCONNECT"
            "AUTH"
         end

         dup: boolean
         id: integer
         payload: string|{integer}
         props: Properties
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
            props: Properties
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

      connect: function(self: Client, options: Connect, props: Properties)
      reconnect: function(self: Client, socket: any)
      publish: function(self: Client, topic: string, payload: string, options: Publish, props: Properties)
      subscribe: function(self: Client, list: {integer|string}, props: Properties)
      unsubscribe: function(self: Client, list: {string}, props: Properties)
      ping: function(self: Client)
      disconnect: function(self: Client, reason_code: integer, props: Properties)
      auth: function(self: Client, reason_code: integer, props: Properties)
      read: function(self: Client): Packet, string
   end

   record Params
      logger: any
      on_connect: function(reason_code: integer, session_present: boolean, props: Properties)
      on_message: function(topic: string, payload: string, props: Properties)
      on_disconnect: function(reason_code: integer, props: Properties)
      on_error: function(): boolean, string
      socket: any
   end

   match: function(name: string, filter: string): boolean

   metamethod __call: function(_: MQTT, t: Params): Client
end

return MQTT
