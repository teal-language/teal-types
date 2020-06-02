function dofile(filename: string)
end

function dump(x: any): string -- TODO
end

function math.ceil(x: number): number
end

function table.copy<T>(x: T): T
end

global Stack = record
end

global ItemStack = function(x: string): Stack
end

global vector = record
    x: number
    y: number
    z: number

    floor: function(vector): vector
    add: function(vector, vector): vector
end

global PointedThing = record
    type: string
    under: vector
end

global ObjectRef = record
    get_inventory: function(ObjectRef): InvRef
    get_player_name: function(ObjectRef): string
    is_player: function(ObjectRef)
    set_inventory_formspec: function(ObjectRef, string)
    get_pos: function(ObjectRef): vector
end

global ToolCapabilities = record
    full_punch_interval: number
    max_drop_level: number
    groupcaps: {string: GroupCap}
    damage_groups: {string: number}
end

global GroupCap = record
    times: {number: number}
    uses: number
    maxlevel: number
end

global Tile = record
    name: string
    tileable_vertical: boolean
end

global Color = record
    a: number
    r: number
    g: number
    b: number
end

global NodeBox = record
    type: string
    fixed: {number | {number}}
end

global Node = record
    name: string
    param1: number
    param2: number
end

global Meta = record
    set_string: function(Meta, string, ...: string)
    get_string: function(Meta, string)
    get_inventory: function(Meta): InvRef
    set_int: function(Meta, string, number)
    get_int: function(Meta, string): number
    mark_as_private: function(Meta, {string})
end

global DetachedInventoryCallbacks = record -- TODO
    allow_move: function
    allow_put: function
    allow_take: function
    on_move: function
    on_put: function
    on_take: function
end

global Timer = record
    start: function(Timer, number, number)
end

global Animation = record
    type: string

    frames_w: number
    frames_h: number
    frame_length: number

    aspect_w: number
    aspect_h: number
    length: number
end

global SoundDef = record
    name: string
    gain: number
end

global ItemDef = record
    type: string
    wield_image: string
    wield_scale: vector
    tool_capabilities: ToolCapabilities
end

global ToolDef = record -- TODO: inheritance?
    description: string
    inventory_image: string
    stack_max: number
    liquids_pointable: boolean
    groups: {string: number}
    on_use: function(Stack, ObjectRef | nil, PointedThing): Stack | nil
    sound: {string: SoundDef}
    tool_capabilities: ToolCapabilities
end

global CraftitemDef = record -- TODO: inheritance?
    description: string
    inventory_image: string
    on_use: function(Stack, ObjectRef | nil, PointedThing): Stack | nil
    sound: {string: SoundDef}
end

global NodeDef = record -- TODO: inheritance?
    description: string
    drawtype: string
    tiles: {any} -- TODO: string and/or Tile
    special_tiles: {any} -- TODO: string and/or Tile?
    node_box: NodeBox
    selection_box: NodeBox
    alpha: number
    inventory_image: string
    wield_image: string
    paramtype: string
    paramtype2: string
    drop: string
    light_source: number
    walkable: boolean
    climbable: boolean
    pointable: boolean
    diggable: boolean
    buildable_to: boolean
    is_ground_content: boolean
    sunlight_propagates: boolean
    drowning: number
    damage_per_second: number
    liquids_pointable: boolean
    liquidtype: string
    liquid_alternative_flowing: string
    liquid_alternative_source: string
    liquid_viscosity: number
    liquid_renewable: boolean
    liquid_range: number
    post_effect_color: Color
    groups: {string: number}
    sounds: {string: SoundDef}
    on_use: function(Stack, ObjectRef | nil, PointedThing): Stack | nil
    on_construct: function(vector)
    can_dig: function(vector, ObjectRef): boolean
    on_receive_fields: function(vector, string, {string: any}, any) -- TODO
    after_place_node: function(vector, ObjectRef | nil)
    on_destruct: function(vector)
    after_destruct: function(vector)
    after_dig_node: function(vector, any, any, any) -- TODO
    on_timer: function(vector, any): boolean | nil -- TODO
    on_rightclick: function(vector, Node, ObjectRef)
end

global CommandDef = record
    params: string
    privs: {string: boolean}
    description: string
    func: function(string, string): boolean, string
end

global InvRef = record
    contains_item: function(InvRef, string, string): boolean
    add_item: function(InvRef, string, string | Stack)
    set_size: function(InvRef, string, number)
    is_empty: function(InvRef, string): boolean
    set_list: function(InvRef, string, {any}) -- TODO
end

global Particle = record
    pos: vector
    velocity: vector
    acceleration: vector
    expirationtime: number
    collisiondetection: boolean
    texture: string
    animation: Animation
    size: number
    glow: number
end

global BiomeDef = record
    name: string
    node_top: string
    depth_top: number
    node_filler: string
    depth_filler: number
    node_riverbed: string
    depth_riverbed: number
    node_cave_liquid: string | {string}
    node_dungeon: string
    node_dungeon_alt: string
    node_dungeon_stair: string
    y_max: number
    y_min: number
    heat_point: number
    humidity_point: number
end

global ModChannel = record
    is_writeable: function(ModChannel): boolean
    send_all: function(ModChannel, string)
    leave: function(ModChannel)
end

global SoundPlay = record
    pos: vector
    max_hear_distance: number
end

global minetest = record
    LIGHT_MAX: number
    EMERGE_CANCELLED: number
    EMERGE_ERRORED: number
    EMERGE_FROM_MEMORY: number
    EMERGE_FROM_DISK: number
    EMERGE_GENERATED: number
    registered_nodes: {string: NodeDef}
    registered_items: {string: ItemDef}

    settings = record
        get_bool: function(settings, string, boolean): boolean
    end

    register_item: function(string, ItemDef)
    register_craftitem: function(string, CraftitemDef)
    register_tool: function(string, ToolDef)
    register_node: function(string, NodeDef)
    register_chatcommand: function(string, CommandDef)
    register_alias: function(string, string)
    register_biome: function(BiomeDef)
    clear_registered_biomes: function()
    clear_registered_decorations: function()
    register_on_newplayer: function(function(ObjectRef))
    register_on_mods_loaded: function(function())
    register_on_joinplayer: function(function(ObjectRef))
    register_on_modchannel_message: function(function(string, string, string))
    get_player_by_name: function(string): ObjectRef
    log: function(string, string)
    item_eat: function(number): function(Stack, ObjectRef | nil, PointedThing): Stack | nil
    get_node: function(vector): Node
    add_node: function(vector, Node)
    set_node: function(vector, Node)
    get_meta: function(vector): Meta
    create_detached_inventory: function(string, DetachedInventoryCallbacks): InvRef
    get_item_group: function(string, string): number
    formspec_escape: function(string): string
    get_modpath: function(string): string
    chat_send_all: function(string)
    chat_send_player: function(string, string)
    get_current_modname: function(): string
    get_worldpath: function(): string
    bulk_set_node: function({vector}, Node)
    get_us_time: function(): number
    emerge_area: function<P>(vector, vector, function(vector, number, number, P), P)
    get_node_timer: function(vector): Timer
    pos_to_string: function(vector): string
    get_pointed_thing_position: function(PointedThing, boolean): vector
    add_particle: function(Particle)
    after: function<P>(number, function(P), P) -- TODO
    mod_channel_join: function(string): ModChannel
    sound_play: function(string, SoundPlay)
end
