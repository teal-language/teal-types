local record SLAXDOM
    enum NodeType
        "pi"
        "comment"
        "text"
        "attribute"
        "element"
        "document"
    end

    record Node
        type: NodeType
        name: string
    end

    record Document
        type: NodeType
        name: string
        kids: {Node} -- {ProcessingInstruction | Element | Comment}
        root: Element
    end

    record Element
        type: NodeType
        name: string
        nsURI: string
        nsPrefix: string
        attr: {string:Attribute} -- FIXME: {string:Attribute} | {Attribute}
        kids: {Node} -- {Element | Text | Comment | ProcessingInstruction}
        el: {Element}
        parent: Node -- Document | Element
    end

    record Attribute
        type: NodeType
        name: string
        value: string
        nsURI: string
        nsPrefix: string
        parent: Element
    end

    record Text
        type: NodeType
        name: string
        cdata: boolean
        value: string
        parent: Element
    end

    record Comment
        type: NodeType
        name: string
        value: string
        parent: Node -- Document | Element
    end

    record ProcessingInstruction
        type: NodeType
        name: string
        value: string
        parent: Node -- Document | Element
    end

    record DomConfig
        stripWhitespace: boolean
        simple: boolean -- TODO: support simple DOM
    end

    record SerializationConfig
        indent: number | string -- each pi/comment/element/text node on its own line, indented by this many spaces, or supply a custom string to use for indentation
        sort: boolean -- sort attributes by name, with no-namespace attributes coming first
        omit: {string} -- an array of namespace URIs; removes elements and attributes in these namespaces
    end

    dom: function(self: SLAXDOM, xml: string, config: DomConfig): Document

    xml: function(self: SLAXDOM, doc: Document, config: SerializationConfig): string
end

return SLAXDOM
