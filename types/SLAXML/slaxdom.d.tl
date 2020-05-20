local SLAXDOM = record
    NodeType = enum
        "pi"
        "comment"
        "text"
        "attribute"
        "element"
        "document"
    end

    Node = record
        type: NodeType
        name: string
    end

    Document = record
        type: NodeType
        name: string
        kids: {Node} -- {ProcessingInstruction | Element | Comment}
        root: Element
    end

    Element = record
        type: NodeType
        name: string
        nsURI: string
        nsPrefix: string
        attr: {string:Attribute} -- FIXME: {string:Attribute} | {Attribute}
        kids: {Node} -- {Element | Text | Comment | ProcessingInstruction}
        el: {Element}
        parent: Node -- Document | Element
    end

    Attribute = record
        type: NodeType
        name: string
        value: string
        nsURI: string
        nsPrefix: string
        parent: Element
    end

    Text = record
        type: NodeType
        name: string
        cdata: boolean
        value: string
        parent: Element
    end

    Comment = record
        type: NodeType
        name: string
        value: string
        parent: Node -- Document | Element
    end

    ProcessingInstruction = record
        type: NodeType
        name: string
        value: string
        parent: Node -- Document | Element
    end

    DomConfig = record
        stripWhitespace: boolean
        simple: boolean -- TODO: support simple DOM
    end

    SerializationConfig = record
        indent: number | string -- each pi/comment/element/text node on its own line, indented by this many spaces, or supply a custom string to use for indentation
        sort: boolean -- sort attributes by name, with no-namespace attributes coming first
        omit: {string} -- an array of namespace URIs; removes elements and attributes in these namespaces
    end

    dom: function(self: SLAXDOM, xml: string, config: DomConfig): Document

    xml: function(self: SLAXDOM, doc: Document, config: SerializationConfig): string
end

return SLAXDOM
