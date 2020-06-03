function loadstring(x: string): any, string -- TODO: add to tl
end

function setfenv(x: any, y: any) -- TODO: add to tl
end

function dofile(filename: string) -- TODO: add to tl
end

function dump(x: any): string -- TODO
end

function table.copy<T>(x: T): T -- TODO
end

global ItemStack = record
    name: string
    get_meta: function(ItemStack): MetaDataRef
    get_name: function(ItemStack): string
    get_count: function(ItemStack): number
    take_item: function(ItemStack)
    to_string: function(ItemStack): string
    is_empty: function(ItemStack): boolean
end

global ItemStack = function(x: string): ItemStack -- TODO
end

global Vec = record
    x: number
    y: number
    z: number
end

global vector = record
    floor: function(Vec): Vec
    add: function(Vec, Vec): Vec
    round: function(Vec): Vec
    distance: function(Vec, Vec): number
    multiply: function(Vec, number): Vec
end

global Vec2 = record
    x: number
    y: number
end

global PseudoRandom = record
    next: function(PseudoRandom, number, number): number
end

global PseudoRandom = function(seed: number): PseudoRandom -- TODO
end

global PointedThing = record
    type: string

    -- node
    under: Vec
    above: Vec

    -- object
    ref: ObjectRef
end

global PlayerControl = record
    jump: boolean
    right: boolean
    left: boolean
    LMB: boolean
    RMB: boolean
    sneak: boolean
    aux1: boolean
    down: boolean
    up: boolean
end

global LuaEntity = record
    name: string
    object: ObjectRef
end

global ObjectRef = record
    get_inventory: function(ObjectRef): InvRef
    get_player_name: function(ObjectRef): string
    is_player: function(ObjectRef)
    set_inventory_formspec: function(ObjectRef, string)
    get_pos: function(ObjectRef): Vec
    set_armor_groups: function(ObjectRef, {string: number})
    set_sprite: function(ObjectRef, Vec2, number, number, boolean)
    get_player_control: function(ObjectRef): PlayerControl
    get_wielded_item: function(ObjectRef): ItemStack
    set_wielded_item: function(ObjectRef, ItemStack)
    remove: function(ObjectRef)
    get_rotation: function(ObjectRef): Vec
    set_rotation: function(ObjectRef, Vec)
    get_look_horizontal: function(ObjectRef): number
    get_look_vertical: function(ObjectRef): number
    set_pos: function(ObjectRef, Vec)
    get_properties: function(ObjectRef): ObjectProps
    set_properties: function(ObjectRef, ObjectProps)
    get_luaentity: function(ObjectRef): LuaEntity
    get_attach: function(ObjectRef): any -- TODO
    set_attach: function(ObjectRef, ObjectRef, string, Vec, Vec)
    set_detach: function(ObjectRef)
    hud_set_hotbar_itemcount: function(ObjectRef, number): boolean
    set_hp: function(ObjectRef, number)
end

global ToolCapabilities = record
    full_punch_interval: number
    max_drop_level: number
    groupcaps: {string: ToolGroupCap}
    damage_groups: {string: number}
end

global ToolGroupCap = record
    times: {number: number}
    uses: number
    maxlevel: number
end

global ColorSpec = record
    a: number
    r: number
    g: number
    b: number
end

global TileDef = record
    name: string
    backface_culling: boolean
    tileable_vertical: boolean
    tileable_horizontal: boolean
    align_style: string
    scale: number
    animation: TileAnimDef
    color: ColorSpec | number | string

    -- deprecated
    image: string
end

global NodeBox = record
    type: string

    -- fixed
    fixed: {number | {number}}

    -- wallmounted
    wall_top: {number}
    wall_bottom: {number}
    wall_side: {number}
end

global Node = record
    name: string
    param1: number
    param2: number
end

global MetaDataRef = record
    set_string: function(MetaDataRef, string, ...: string)
    get_string: function(MetaDataRef, string): string
    get_inventory: function(MetaDataRef): InvRef
    set_int: function(MetaDataRef, string, number)
    get_int: function(MetaDataRef, string): number
    set_float: function(MetaDataRef, string, number)
    get_float: function(MetaDataRef, string): number
    mark_as_private: function(MetaDataRef, string | {string})
    to_table: function(MetaDataRef): any -- TODO
    from_table: function(MetaDataRef, any) -- TODO
    contains: function(MetaDataRef, string): boolean
end

global DetachedInvCallbacks = record -- TODO
    allow_move: function
    allow_put: function
    allow_take: function
    on_move: function
    on_put: function
    on_take: function
end

global NodeTimerRef = record
    start: function(NodeTimerRef, number, number)
end

global TileAnimDef = record
    type: string

    frames_w: number
    frames_h: number
    frame_length: number

    aspect_w: number
    aspect_h: number
    length: number
end

global SimpleSoundSpec = record
    name: string
    gain: number
    pitch: number
end

global ItemDef = record
    type: string
    wield_image: string
    wield_scale: Vec
    tool_capabilities: ToolCapabilities
end

global ToolDef = record -- TODO: inheritance?
    description: string
    inventory_image: string
    stack_max: number
    liquids_pointable: boolean
    groups: {string: number}
    on_use: function(ItemStack, ObjectRef | nil, PointedThing): ItemStack | nil
    on_secondary_use: function(ItemStack, ObjectRef | nil, PointedThing): ItemStack | nil
    on_place: function(ItemStack, ObjectRef | nil, PointedThing): ItemStack | nil
    sound: {string: SimpleSoundSpec}
    tool_capabilities: ToolCapabilities
end

global CraftItemDef = record -- TODO: inheritance?
    description: string
    inventory_image: string
    liquids_pointable: boolean
    groups: {string: number}
    on_use: function(ItemStack, ObjectRef | nil, PointedThing): ItemStack | nil
    sound: {string: SimpleSoundSpec}
end

global NodeDropEntry = record
    items: {string}
    rarity: number
    inherit_color: boolean
    tools: {string}
end

global NodeDrop = record
    max_items: number
    items: {NodeDropEntry}
end

global NodeDef = record -- TODO: inheritance?
    description: string
    drawtype: string
    visual_scale: number
    tiles: {string | TileDef}
    special_tiles: {string | TileDef}
    node_box: NodeBox
    selection_box: NodeBox
    alpha: number
    inventory_image: string
    wield_image: string
    paramtype: string
    paramtype2: string
    drop: string | NodeDrop
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
    post_effect_color: ColorSpec | number | string
    groups: {string: number}
    sounds: {string: SimpleSoundSpec}
    on_use: function(ItemStack, ObjectRef | nil, PointedThing): ItemStack | nil
    on_construct: function(Vec)
    can_dig: function(Vec, ObjectRef): boolean
    on_receive_fields: function(Vec, string, {string: any}, any) -- TODO
    after_place_node: function(Vec, ObjectRef | nil)
    on_destruct: function(Vec)
    after_destruct: function(Vec)
    after_dig_node: function(Vec, any, any, any) -- TODO
    on_timer: function(Vec, any): boolean | nil -- TODO
    on_rightclick: function(Vec, Node, ObjectRef)
    on_receive_fields: function(Vec, string, {string: string}, ObjectRef)
    allow_metadata_inventory_move: function -- TODO: (Vec, string?, number?, string?, number?, number, ObjectRef): number
    allow_metadata_inventory_put: function -- TODO: (Vec, string?, number?, ItemStack, ObjectRef): number
    allow_metadata_inventory_take: function -- TODO: (Vec, string?, number?, ItemStack, ObjectRef): number
    on_metadata_inventory_move: function -- TODO: see above allow_metadata_*
    on_metadata_inventory_put: function -- TODO: see above allow_metadata_*
    on_metadata_inventory_take: function -- TODO: see above allow_metadata_*

    legacy_mineral: boolean
    legacy_wallmounted: boolean
    legacy_facedir_simple: boolean
end

global ChatCommandDef = record
    params: string
    privs: {string: boolean}
    description: string
    func: function(string, string): boolean, string
end

global InvRef = record
    contains_item: function(InvRef, string, string | ItemStack, boolean): boolean
    add_item: function(InvRef, string, string | ItemStack)
    set_size: function(InvRef, string, number)
    is_empty: function(InvRef, string): boolean
    set_list: function(InvRef, string, {ItemStack})
    get_list: function(InvRef, string): {ItemStack}
    room_for_item: function(InvRef, string, ItemStack): boolean
    get_stack: function(InvRef, string, number): ItemStack
    set_stack: function(InvRef, string, number, ItemStack)
end

global ParticleDef = record
    pos: Vec
    velocity: Vec
    acceleration: Vec
    expirationtime: number
    collisiondetection: boolean
    texture: string
    animation: TileAnimDef
    size: number
    glow: number
    playername: string
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

global SoundParams = record
    pos: Vec
    gain: number
    max_hear_distance: number
end

global ObjectProps = record
    hp_max: number
    physical: boolean
    collisionbox: {number}
    selectionbox: {number}
    visual: string
    visual_size: Vec
    wield_item: string
    mesh: string
    textures: {string}
    spritediv: Vec2
    initial_sprite_basepos: Vec2
    on_activate: function -- TODO
    zoom_fov: number
end

global EntityDef = record -- TODO
    initial_properties: ObjectProps
    visual: string
    textures: {string}
    on_activate: function
    on_punch: function
    on_rightclick: function
    on_death: function
    on_attach_child: function
    on_detach_child: function
    on_detach: function
    on_step: function
    get_staticdata: function
end

global TextListEvent = record
    type: string
    index: number
end

global CraftRecipe = record
    type: string

    output: string
    recipe: {{string}} | string

    -- toolrepair
    additional_wear: number

    -- fuel
    burntime: number
end

global AbmDef = record
    nodenames: {string}
    interval: number
    chance: number
    action: function -- TODO
end

global CraftInput = record
    method: string
    width: number
    items: {ItemStack}
end

global CraftOutput = record
    item: ItemStack
    time: number
    replacements: {ItemStack}
end

global VoxelManip = record
    read_from_map: function(VoxelManip, Vec, Vec): Vec, Vec
    get_data: function(VoxelManip, {number} | nil): {number}
    set_data: function(VoxelManip, {number})
    write_to_map: function(VoxelManip, boolean)
    update_map: function(VoxelManip)
end

global VoxelArea = record
    MinEdge: Vec
    MaxEdge: Vec

    new: function(VoxelArea, VoxelArea): VoxelArea
    index: function(VoxelArea, number, number, number): number
    contains: function(VoxelArea, number, number, number): boolean
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
    registered_entities: {string: EntityDef}

    settings = record
        get: function(settings, string): string
        get_bool: function(settings, string, boolean): boolean
    end

    register_item: function(string, ItemDef)
    register_craftitem: function(string, CraftItemDef)
    register_tool: function(string, ToolDef)
    register_node: function(string, NodeDef)
    register_chatcommand: function(string, ChatCommandDef)
    register_alias: function(string, string)
    register_entity: function(string, EntityDef)
    register_biome: function(BiomeDef)
    register_craft: function(CraftRecipe)
    register_abm: function(AbmDef)
    clear_registered_biomes: function()
    clear_registered_decorations: function()
    register_globalstep: function(function(any)) -- TODO
    register_on_newplayer: function(function(ObjectRef))
    register_on_mods_loaded: function(function())
    register_on_joinplayer: function(function(ObjectRef))
    register_on_modchannel_message: function(function(string, string, string))
    register_on_placenode: function(function(Vec, Node, ObjectRef, Node, ItemStack)) -- TODO: returns boolean or nil/void
    register_on_punchnode: function(function(Vec, Node))
    register_on_dignode: function(function(Vec, Node))
    get_player_by_name: function(string): ObjectRef
    log: function(string, string)
    item_eat: function(number): function(ItemStack, ObjectRef | nil, PointedThing): ItemStack | nil
    get_node: function(Vec): Node
    add_node: function(Vec, Node)
    set_node: function(Vec, Node)
    swap_node: function(Vec, Node)
    remove_node: function(Vec)
    spawn_falling_node: function(Vec): boolean
    get_meta: function(Vec): MetaDataRef
    create_detached_inventory: function(string, DetachedInvCallbacks): InvRef
    get_item_group: function(string, string): number
    formspec_escape: function(string): string
    get_modpath: function(string): string
    chat_send_all: function(string)
    chat_send_player: function(string, string)
    get_current_modname: function(): string
    get_worldpath: function(): string
    bulk_set_node: function({Vec}, Node)
    get_us_time: function(): number
    emerge_area: function<P>(Vec, Vec, function(Vec, number, number, P), P)
    get_node_timer: function(Vec): NodeTimerRef
    pos_to_string: function(Vec): string
    get_pointed_thing_position: function(PointedThing, boolean): Vec
    add_particle: function(ParticleDef)
    after: function<P>(number, function(P), P) -- TODO
    mod_channel_join: function(string): ModChannel
    sound_play: function(string, SoundParams)
    get_translator: function(string): function(string, ...: any): string -- TODO
    register_on_player_receive_fields: function(function(ObjectRef, string, {string: string}))
    show_formspec: function(string, string, string)
    find_path: function(Vec, Vec, number, number, number, string): {Vec}
    yaw_to_dir: function(number): Vec
    add_entity: function(Vec, string)
    get_player_privs: function(string): {string: string}
    explode_textlist_event: function(string): TextListEvent
    is_creative_enabled: function(string): boolean
    get_objects_inside_radius: function(Vec, number): {ObjectRef}
    handle_node_drops: function(pos: Vec, drops: {ItemStack}, digger: ObjectRef): ItemStack
    inventorycube: function(string, string, string): string
    check_for_falling: function(Vec)
    get_craft_result: function(CraftInput): CraftOutput, CraftInput
    get_content_id: function(string): number
    get_node_light: function(Vec, number | nil): number | nil
    get_voxel_manip: function(Vec, Vec): VoxelManip
end
