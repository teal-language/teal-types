local SLAXML = record
    Parser = record
        ParserConfig = record
            stripWhitespace: boolean
        end

        parse: function(self: Parser, xml: string, config: ParserConfig)
    end

    ParserCallbacks = record
        startElement: function(name: string, nsURI: string, nsPrefix: string)
        attribute: function(name: string, value: string, nsURI: string, nsPrefix: string)
        closeElement: function(name: string, nsURI: string)
        text: function(text: string, cdata: boolean)
        comment: function(content: string)
        pi: function(target: string, content: string)
    end

    parse: function(self: SLAXML, xml: string)

    parser: function(self: SLAXML, callbacks: ParserCallbacks): Parser
end

return SLAXML
