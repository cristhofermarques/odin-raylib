package raylib

VERSION_MAJOR :: 5
VERSION_MINOR :: 1
VERSION_PATCH :: 0
VERSION :: "5.1-dev"

PI :: 3.14159265358979323846
DEG_TO_RAD :: PI / 180.0
RAD_TO_DEG :: 180.0 / PI

LIGHT_GRAY  :: Color{200, 200, 200, 255 }   // Light Gray
GRAY        :: Color{130, 130, 130, 255 }   // Gray
DARK_GRAY   :: Color{80, 80, 80, 255 }      // Dark Gray
YELLOW      :: Color{253, 249, 0, 255 }     // Yellow
GOLD        :: Color{255, 203, 0, 255 }     // Gold
ORANGE      :: Color{255, 161, 0, 255 }     // Orange
PINK        :: Color{255, 109, 194, 255 }   // Pink
RED         :: Color{230, 41, 55, 255 }     // Red
MAROON      :: Color{190, 33, 55, 255 }     // Maroon
GREEN       :: Color{0, 228, 48, 255 }      // Green
LIME        :: Color{0, 158, 47, 255 }      // Lime
DARK_GREEN  :: Color{0, 117, 44, 255 }      // Dark Green
SKY_BLUE    :: Color{102, 191, 255, 255 }   // Sky Blue
BLUE        :: Color{0, 121, 241, 255 }     // Blue
DARK_BLUE   :: Color{0, 82, 172, 255 }      // Dark Blue
PURPLE      :: Color{200, 122, 255, 255 }   // Purple
VIOLET      :: Color{135, 60, 190, 255 }    // Violet
DARK_PURPLE :: Color{112, 31, 126, 255 }    // Dark Purple
BEIGE       :: Color{211, 176, 131, 255 }   // Beige
BROWN       :: Color{127, 106, 79, 255 }    // Brown
DARK_BROWN  :: Color{76, 63, 47, 255 }      // Dark Brown

WHITE     :: Color{255, 255, 255, 255 }   // White
BLACK     :: Color{0, 0, 0, 255 }         // Black
BLANK     :: Color{0, 0, 0, 0 }           // Blank (Transparent)
MAGENTA   :: Color{255, 0, 255, 255 }     // Magenta
RAY_WHITE :: Color{245, 245, 245, 255 }   // My own White (raylib logo)

// Vector2, 2 components
Vector2 :: [2]f32

// Vector3, 3 components
Vector3 :: [3]f32

// Vector4, 4 components
Vector4 :: [4]f32

// Quaternion, 4 components (Vector4 alias)
Quaternion :: quaternion128

// Matrix, 4x4 components, column major, OpenGL style, right-handed
Matrix :: matrix[4, 4]f32

// Color, 4 components, R8G8B8A8 (32bit)
Color :: [4]u8

// Rectangle, 4 components
Rectangle :: struct
{
    x,                // Rectangle top-left corner position x
    y,                // Rectangle top-left corner position y
    width,            // Rectangle width
    height: f32,           // Rectangle height
}

// Image, pixel data stored in CPU memory (RAM)
Image :: struct
{
    data: rawptr,       // Image raw data
    width,              // Image base width
    height,             // Image base height
    mipmaps,            // Mipmap levels, 1 by default
    format: Pixel_Format,        // Data format (PixelFormat type)
}

// Texture, tex data stored in GPU memory (VRAM)
Texture :: struct
{
    id: u32,              // OpenGL texture id
    width,                // Texture base width
    height,               // Texture base height
    mipmaps,              // Mipmap levels, 1 by default
    format: Pixel_Format, // Data format (PixelFormat type)
}

// Texture2D, same as Texture
Texture2D :: Texture

// TextureCubemap, same as Texture
Texture_Cubemap :: Texture

// RenderTexture, fbo for texture rendering
Render_Texture :: struct
{
    id: u32,        // OpenGL framebuffer object id
    texture,        // Color buffer attachment texture
    depth: Texture,          // Depth buffer attachment texture
}

// RenderTexture2D, same as RenderTexture
Render_Texture2D :: Render_Texture

// NPatchInfo, n-patch layout info
NPatch_Info :: struct
{
    source: Rectangle,       // Texture source rectangle
    left,               // Left border offset
    top,                // Top border offset
    right,              // Right border offset
    bottom,             // Bottom border offset
    layout: i32,             // Layout of the n-patch: 3x3, 1x3 or 3x1
}

// GlyphInfo, font characters glyphs info
Glyph_Info :: struct
{
    value,              // Character value (Unicode)
    offset_x,            // Character offset X when drawing
    offset_y,            // Character offset Y when drawing
    advance_x: i32,           // Character advance position X
    image: Image,            // Character image data
}

// Font, font texture and GlyphInfo array data
Font :: struct
{
    base_size,           // Base size (default chars height)
    glyph_count,         // Number of glyph characters
    glyph_padding: i32,       // Padding around the glyph characters
    texture: Texture2D,      // Texture atlas containing the glyphs
    recs: [^]Rectangle,        // Rectangles in texture for the glyphs
    glyphs: [^]Glyph_Info,      // Glyphs info data
}

// Camera, defines position/orientation in 3d space
Camera3D :: struct
{
    position,       // Camera position
    target,         // Camera target it looks-at
    up: Vector3,             // Camera up vector (rotation over its axis)
    fovy: f32,             // Camera field-of-view aperture in Y (degrees) in perspective, used as near plane width in orthographic
    projection: Camera_Projection         // Camera projection: CAMERA_PERSPECTIVE or CAMERA_ORTHOGRAPHIC
}

Camera :: Camera3D    // Camera type fallback, defaults to Camera3D

// Camera2D, defines position/orientation in 2d space
Camera2D :: struct
{
    offset,         // Camera offset (displacement from target)
    target: Vector2,         // Camera target (rotation and zoom origin)
    rotation,         // Camera rotation in degrees
    zoom: f32,             // Camera zoom (scaling), should be 1.0f by default
}

// Mesh, vertex data and vao/vbo
Mesh :: struct
{
    vertex_count,        // Number of vertices stored in arrays
    triangle_count: i32,      // Number of triangles stored (indexed or not)

    // Vertex attributes data
    vertices,        // Vertex position (XYZ - 3 components per vertex) (shader-location = 0)
    texcoords,       // Vertex texture coordinates (UV - 2 components per vertex) (shader-location = 1)
    texcoords2,      // Vertex texture second coordinates (UV - 2 components per vertex) (shader-location = 5)
    normals,         // Vertex normals (XYZ - 3 components per vertex) (shader-location = 2)
    tangents: [^]f32,        // Vertex tangents (XYZW - 4 components per vertex) (shader-location = 4)
    colors: [^]u8,      // Vertex colors (RGBA - 4 components per vertex) (shader-location = 3)
    indices: [^]u16,    // Vertex indices (in case vertex data comes indexed)

    // Animation vertex data
    anim_vertices,    // Animated vertex positions (after bones transformations)
    anim_normals: [^]f32,     // Animated normals (after bones transformations)
    bone_ids: [^]u8, // Vertex bone ids, max 255 bone ids, up to 4 bones influence by vertex (skinning)
    bone_weights: [^]f32,     // Vertex bone weight, up to 4 bones influence by vertex (skinning)

    // OpenGL identifiers
    vao_id: u32,     // OpenGL Vertex Array Object id
    vbo_id: ^u32,    // OpenGL Vertex Buffer Objects id (default vertex data)
}

// Shader
Shader :: struct
{
    id: u32,        // Shader program id
    locs: ^i32,              // Shader locations array (RL_MAX_SHADER_LOCATIONS)
}

// MaterialMap
Material_Map :: struct
{
    texture: Texture2D,      // Material map texture
    color: Color,            // Material map color
    value: f32,            // Material map value
}

// Material, includes shader and maps
Material :: struct
{
    shader: Shader,          // Material shader
    maps: [^]Material_Map,      // Material maps array (MAX_MATERIAL_MAPS)
    params: [4]f32,        // Material generic parameters (if required)
}

// Transform, vertex transformation data
Transform :: struct
{
    translation: Vector3,    // Translation
    rotation: Quaternion,    // Rotation
    scale: Vector3,          // Scale
}

// Bone, skeletal animation bone
Bone_Info :: struct
{
    name: [32]u8,          // Bone name
    parent: i32,           // Bone parent
}

// Model, meshes, materials and animation data
Model :: struct
{
    transform: Matrix,       // Local transform matrix

    mesh_count: i32,          // Number of meshes
    material_count: i32,      // Number of materials
    meshes: [^]Mesh,           // Meshes array
    materials: [^]Material,    // Materials array
    mesh_material: ^i32,      // Mesh material number

    // Animation data
    bone_count: i32,          // Number of bones
    bones: [^]Bone_Info,        // Bones information (skeleton)
    bind_pose: ^Transform,    // Bones base transformation (pose)
}

// ModelAnimation
Model_Animation :: struct
{
    boneCount,          // Number of bones
    frameCount: i32,         // Number of animation frames
    bones: [^]Bone_Info,        // Bones information (skeleton)
    frame_poses: ^[^]Transform, // Poses array by frame
    name: [32]u8,          // Animation name
}

// Ray, ray for raycasting
Ray :: struct
{
    position,       // Ray position (origin)
    direction: Vector3,      // Ray direction
}

// RayCollision, ray hit information
Ray_Collision :: struct
{
    hit: bool,               // Did the ray hit something?
    distance: f32,         // Distance to the nearest hit
    point,          // Point of the nearest hit
    normal: Vector3,         // Surface normal of hit
}

// BoundingBox
Bounding_Box :: struct
{
    min,            // Minimum vertex box-corner
    max: Vector3,            // Maximum vertex box-corner
}

// Wave, audio wave data
Wave :: struct
{
    frame_count,    // Total number of frames (considering channels)
    sample_rate,    // Frequency (samples per second)
    sample_size,    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    channels: u32,      // Number of channels (1-mono, 2-stereo, ...)
    data: rawptr,                 // Buffer data pointer
}

// Opaque structs declaration
// NOTE: Actual structs are defined internally in raudio module
Audio_Buffer :: struct {}
Audio_Processor :: struct {}

// AudioStream, custom audio stream
Audio_Stream :: struct
{
    buffer: ^Audio_Buffer,       // Pointer to internal data used by the audio system
    processor: ^Audio_Processor, // Pointer to internal data processor, useful for audio effects

    sample_rate,    // Frequency (samples per second)
    sample_size,    // Bit depth (bits per sample): 8, 16, 32 (24 not supported)
    channels: u32,      // Number of channels (1-mono, 2-stereo, ...)
}

// Sound
Sound :: struct
{
    stream: Audio_Stream,         // Audio stream
    frame_count: u32,    // Total number of frames (considering channels)
}

// Music, audio stream, anything longer than ~10 seconds should be streamed
Music :: struct
{
    stream: Audio_Stream,         // Audio stream
    frame_count: u32,    // Total number of frames (considering channels)
    looping: bool,               // Music looping enable

    ctx_type: i32,                // Type of music context (audio filetype)
    ctx_data: rawptr,              // Audio context data, depends on type
}

// VrDeviceInfo, Head-Mounted-Display device parameters
VR_Device_Info :: struct
{
    h_resolution,                // Horizontal resolution in pixels
    v_resolution: i32,                // Vertical resolution in pixels
    h_screen_size,              // Horizontal size in meters
    v_screen_size,              // Vertical size in meters
    v_screen_center,            // Screen center in meters
    eye_to_screen_distance,      // Distance between eye and display in meters
    lens_separation_distance,   // Lens separation distance in meters
    interpupillary_distance: f32,   // IPD (distance between pupils) in meters
    lens_distortion_calues: [4]f32, // Lens distortion constant parameters
    chroma_ab_correction: [4]f32,   // Chromatic aberration correction parameters
}

// VrStereoConfig, VR stereo rendering configuration for simulator
VR_Stereo_Config :: struct
{
    projection,          // VR projection matrices (per eye)
    view_offset: [2]Matrix,           // VR view offset matrices (per eye)
    left_lens_center,        // VR left lens center
    right_lens_center,       // VR right lens center
    left_screen_center,      // VR left screen center
    right_screen_center,     // VR right screen center
    scale,                 // VR distortion scale
    scale_in: [2]f32,               // VR distortion scale in
}

// File path list
File_Path_List :: struct
{
    capacity,          // Filepaths max entries
    count: u32,             // Filepaths entries count
    paths: ^[^]cstring,                   // Filepaths entries
}

// Automation event
Automation_Event :: struct
{
    frame,             // Event frame
    type: u32,              // Event type (AutomationEventType)
    params: [4]i32,                  // Event parameters (if required)
}

// Automation event list
Automation_Event_List :: struct
{
    capacity,          // Events max entries (MAX_AUTOMATION_EVENTS)
    count: u32,             // Events entries count
    events: [^]Automation_Event,        // Events entries
}

//----------------------------------------------------------------------------------
// Enumerators Definition
//----------------------------------------------------------------------------------
// System/Window config flags
// NOTE: Every bit registers one state (use it with bit masks)
// By default all flags are set to 0
Config_Flags :: enum i32
{
    VSync_Hint         = 0x00000040,   // Set to try enabling V-Sync on GPU
    Fullscreen_Mode    = 0x00000002,   // Set to run program in fullscreen
    Window_Resizable   = 0x00000004,   // Set to allow resizable window
    Window_Undecorated = 0x00000008,   // Set to disable window decoration (frame and buttons)
    Window_Hidden      = 0x00000080,   // Set to hide window
    Window_Minimized   = 0x00000200,   // Set to minimize window (iconify)
    Window_Maximized   = 0x00000400,   // Set to maximize window (expanded to monitor)
    Window_Unfocused   = 0x00000800,   // Set to window non focused
    Window_Top_Most    = 0x00001000,   // Set to window always on top
    Window_Always_Run  = 0x00000100,   // Set to allow windows running while minimized
    Window_Transparent = 0x00000010,   // Set to allow transparent framebuffer
    Window_High_DPI    = 0x00002000,   // Set to support HighDPI
    Window_Mouse_Passthrough = 0x00004000, // Set to support mouse passthrough, only supported when FLAG_WINDOW_UNDECORATED
    Borderless_Windowed_Mode = 0x00008000, // Set to run program in borderless windowed mode
    MSAA_4X_Hint       = 0x00000020,   // Set to try enabling MSAA 4X
    Interlaced_Hint    = 0x00010000    // Set to try enabling interlaced video format (for V3D)
}

// Trace log level
// NOTE: Organized by priority level
Trace_Log_Level :: enum i32
{
    All = 0,        // Display all logs
    Trace,          // Trace logging, intended for internal use only
    Debug,          // Debug logging, used for internal debugging, it should be disabled on release builds
    Info,           // Info logging, used for program execution info
    Warning,        // Warning logging, used on recoverable failures
    Error,          // Error logging, used on unrecoverable failures
    Fatal,          // Fatal logging, used to abort program: exit(EXIT_FAILURE)
    None            // Disable logging
}

// Keyboard keys (US keyboard layout)
// NOTE: Use GetKeyPressed() to allow redefining
// required keys for alternative layouts
Keyboard_Key :: enum i32
{
    Null            = 0,        // Key: NULL, used for no key pressed

    // Alphanumeric keys
    Apostrophe      = 39,       // Key: '
    Comma           = 44,       // Key: ,
    Minus           = 45,       // Key: -
    Period          = 46,       // Key: .
    Slash           = 47,       // Key: /
    Zero            = 48,       // Key: 0
    One             = 49,       // Key: 1
    Two             = 50,       // Key: 2
    Three           = 51,       // Key: 3
    Four            = 52,       // Key: 4
    Five            = 53,       // Key: 5
    Six             = 54,       // Key: 6
    Seven           = 55,       // Key: 7
    Eight           = 56,       // Key: 8
    Nine            = 57,       // Key: 9
    Semicolon       = 59,       // Key: ;
    Equal           = 61,       // Key: =
    A               = 65,       // Key: A | a
    B               = 66,       // Key: B | b
    C               = 67,       // Key: C | c
    D               = 68,       // Key: D | d
    E               = 69,       // Key: E | e
    F               = 70,       // Key: F | f
    G               = 71,       // Key: G | g
    H               = 72,       // Key: H | h
    I               = 73,       // Key: I | i
    J               = 74,       // Key: J | j
    K               = 75,       // Key: K | k
    L               = 76,       // Key: L | l
    M               = 77,       // Key: M | m
    N               = 78,       // Key: N | n
    O               = 79,       // Key: O | o
    P               = 80,       // Key: P | p
    Q               = 81,       // Key: Q | q
    R               = 82,       // Key: R | r
    S               = 83,       // Key: S | s
    T               = 84,       // Key: T | t
    U               = 85,       // Key: U | u
    V               = 86,       // Key: V | v
    W               = 87,       // Key: W | w
    X               = 88,       // Key: X | x
    Y               = 89,       // Key: Y | y
    Z               = 90,       // Key: Z | z
    Left_Bracket    = 91,       // Key: [
    Backslash       = 92,       // Key: '\'
    Right_Bracket   = 93,       // Key: ]
    Grace           = 96,       // Key: `

    // Function keys
    Space           = 32,       // Key: Space
    Escape          = 256,      // Key: Esc
    Enter           = 257,      // Key: Enter
    Tab             = 258,      // Key: Tab
    Backspace       = 259,      // Key: Backspace
    Insert          = 260,      // Key: Ins
    Delete          = 261,      // Key: Del
    Right           = 262,      // Key: Cursor right
    Left            = 263,      // Key: Cursor left
    Down            = 264,      // Key: Cursor down
    Up              = 265,      // Key: Cursor up
    Page_Up         = 266,      // Key: Page up
    Page_Down       = 267,      // Key: Page down
    Home            = 268,      // Key: Home
    End             = 269,      // Key: End
    Caps_Lock       = 280,      // Key: Caps lock
    Scroll_Lock     = 281,      // Key: Scroll down
    Num_Lock        = 282,      // Key: Num lock
    Print_Screen    = 283,      // Key: Print screen
    Pause           = 284,      // Key: Pause
    F1              = 290,      // Key: F1
    F2              = 291,      // Key: F2
    F3              = 292,      // Key: F3
    F4              = 293,      // Key: F4
    F5              = 294,      // Key: F5
    F6              = 295,      // Key: F6
    F7              = 296,      // Key: F7
    F8              = 297,      // Key: F8
    F9              = 298,      // Key: F9
    F10             = 299,      // Key: F10
    F11             = 300,      // Key: F11
    F12             = 301,      // Key: F12
    Left_Shift      = 340,      // Key: Shift left
    Left_Control    = 341,      // Key: Control left
    Left_Alt        = 342,      // Key: Alt left
    Left_Super      = 343,      // Key: Super left
    Right_Shift     = 344,      // Key: Shift right
    Right_Control   = 345,      // Key: Control right
    Right_Alt       = 346,      // Key: Alt right
    Right_Super     = 347,      // Key: Super right
    KB_Menu         = 348,      // Key: KB menu

    // Keypad keys
    KP_0            = 320,      // Key: Keypad 0
    KP_1            = 321,      // Key: Keypad 1
    KP_2            = 322,      // Key: Keypad 2
    KP_3            = 323,      // Key: Keypad 3
    KP_4            = 324,      // Key: Keypad 4
    KP_5            = 325,      // Key: Keypad 5
    KP_6            = 326,      // Key: Keypad 6
    KP_7            = 327,      // Key: Keypad 7
    KP_8            = 328,      // Key: Keypad 8
    KP_9            = 329,      // Key: Keypad 9
    KP_Decimal      = 330,      // Key: Keypad .
    KP_Divide       = 331,      // Key: Keypad /
    KP_Multiply     = 332,      // Key: Keypad *
    KP_Subtract     = 333,      // Key: Keypad -
    KP_Add          = 334,      // Key: Keypad +
    KP_Enter        = 335,      // Key: Keypad Enter
    KP_Equal        = 336,      // Key: Keypad =

    // Android key buttons
    Back            = 4,        // Key: Android back button
    Menu            = 82,       // Key: Android menu button
    Volume_Up       = 24,       // Key: Android volume up button
    Volume_Down     = 25        // Key: Android volume down button
}

// Mouse buttons
Mouse_Button :: enum i32
{
    Left    = 0,       // Mouse button left
    Right   = 1,       // Mouse button right
    Middle  = 2,       // Mouse button middle (pressed wheel)
    Side    = 3,       // Mouse button side (advanced mouse device)
    Extra   = 4,       // Mouse button extra (advanced mouse device)
    Forward = 5,       // Mouse button forward (advanced mouse device)
    Back    = 6,       // Mouse button back (advanced mouse device)
}

// Mouse cursor
Mouse_Cursor :: enum i32
{
    Default       = 0,     // Default pointer shape
    Arrow         = 1,     // Arrow shape
    IBeam         = 2,     // Text writing cursor shape
    Crosshair     = 3,     // Cross shape
    Pointing_Hand = 4,     // Pointing hand cursor
    Resize_EW     = 5,     // Horizontal resize/move arrow shape
    Resize_NS     = 6,     // Vertical resize/move arrow shape
    Resize_NWSE   = 7,     // Top-left to bottom-right diagonal resize/move arrow shape
    Resize_NESW   = 8,     // The top-right to bottom-left diagonal resize/move arrow shape
    Resize_All    = 9,     // The omnidirectional resize/move cursor shape
    Not_Allowed   = 10     // The operation-not-allowed shape
}

// Gamepad buttons
Gamepad_Button :: enum i32
{
    Unknown = 0,         // Unknown button, just for error checking
    Left_Face_Up,        // Gamepad left DPAD up button
    Left_Face_Right,     // Gamepad left DPAD right button
    Left_Face_Down,      // Gamepad left DPAD down button
    Left_Face_Left,      // Gamepad left DPAD left button
    Right_Face_Up,       // Gamepad right button up (i.e. PS3: Triangle, Xbox: Y)
    Right_Face_Right,    // Gamepad right button right (i.e. PS3: Square, Xbox: X)
    Right_Face_Down,     // Gamepad right button down (i.e. PS3: Cross, Xbox: A)
    Right_Face_Left,     // Gamepad right button left (i.e. PS3: Circle, Xbox: B)
    Left_Trigger_1,      // Gamepad top/back trigger left (first), it could be a trailing button
    Left_Trigger_2,      // Gamepad top/back trigger left (second), it could be a trailing button
    Right_Trigger_1,     // Gamepad top/back trigger right (one), it could be a trailing button
    Right_Trigger_2,     // Gamepad top/back trigger right (second), it could be a trailing button
    Middle_Left,         // Gamepad center buttons, left one (i.e. PS3: Select)
    Middle,              // Gamepad center buttons, middle one (i.e. PS3: PS, Xbox: XBOX)
    Middle_Right,        // Gamepad center buttons, right one (i.e. PS3: Start)
    Left_Thumb,          // Gamepad joystick pressed button left
    Right_Thumb          // Gamepad joystick pressed button right
}

// Gamepad axis
Gamepad_Axis :: enum i32
{
    Left_X        = 0,     // Gamepad left stick X axis
    Left_Y        = 1,     // Gamepad left stick Y axis
    Right_X       = 2,     // Gamepad right stick X axis
    Right_Y       = 3,     // Gamepad right stick Y axis
    Left_Trigger  = 4,     // Gamepad back trigger left, pressure level: [1..-1]
    Right_Trigger = 5      // Gamepad back trigger right, pressure level: [1..-1]
}

// Albedo material (same as: MATERIAL_MAP_DIFFUSE)
MATERIAL_MAP_ALBEDO :: 0

// Metalness material (same as: MATERIAL_MAP_SPECULAR)
MATERIAL_MAP_METALNESS :: 1

// Normal material
MATERIAL_MAP_NORMAL :: 2

// Roughness material
MATERIAL_MAP_ROUGHNESS :: 3

// Ambient occlusion material
MATERIAL_MAP_OCCLUSION :: 4

// Emission material
MATERIAL_MAP_EMISSION :: 5

// Heightmap material
MATERIAL_MAP_HEIGHT :: 6

// Cubemap material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
MATERIAL_MAP_CUBEMAP :: 7

// Irradiance material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
MATERIAL_MAP_IRRADIANCE :: 8

// Prefilter material (NOTE: Uses GL_TEXTURE_CUBE_MAP)
MATERIAL_MAP_PREFILTER :: 9

// Brdf material
MATERIAL_MAP_BRDF :: 10

// Shader location: vertex attribute: position
SHADER_LOC_VERTEX_POSITION :: 0

// Shader location: vertex attribute: texcoord01
SHADER_LOC_VERTEX_TEXCOORD01 :: 1

// Shader location: vertex attribute: texcoord02
SHADER_LOC_VERTEX_TEXCOORD02 :: 2

// Shader location: vertex attribute: normal
SHADER_LOC_VERTEX_NORMAL :: 3

// Shader location: vertex attribute: tangent
SHADER_LOC_VERTEX_TANGENT :: 4

// Shader location: vertex attribute: color
SHADER_LOC_VERTEX_COLOR :: 5

// Shader location: matrix uniform: model-view-projection
SHADER_LOC_MATRIX_MVP :: 6

// Shader location: matrix uniform: view (camera transform)
SHADER_LOC_MATRIX_VIEW :: 7

// Shader location: matrix uniform: projection
SHADER_LOC_MATRIX_PROJECTION :: 8

// Shader location: matrix uniform: model (transform)
SHADER_LOC_MATRIX_MODEL :: 9

// Shader location: matrix uniform: normal
SHADER_LOC_MATRIX_NORMAL :: 10

// Shader location: vector uniform: view
SHADER_LOC_VECTOR_VIEW :: 11

// Shader location: vector uniform: diffuse color
SHADER_LOC_COLOR_DIFFUSE :: 12

// Shader location: vector uniform: specular color
SHADER_LOC_COLOR_SPECULAR :: 13

// Shader location: vector uniform: ambient color
SHADER_LOC_COLOR_AMBIENT :: 14

// Shader location: sampler2d texture: albedo (same as: SHADER_LOC_MAP_DIFFUSE)
SHADER_LOC_MAP_ALBEDO :: 15

// Shader location: sampler2d texture: metalness (same as: SHADER_LOC_MAP_SPECULAR)
SHADER_LOC_MAP_METALNESS :: 16

// Shader location: sampler2d texture: normal
SHADER_LOC_MAP_NORMAL :: 17

// Shader location: sampler2d texture: roughness
SHADER_LOC_MAP_ROUGHNESS :: 18

// Shader location: sampler2d texture: occlusion
SHADER_LOC_MAP_OCCLUSION :: 19

// Shader location: sampler2d texture: emission
SHADER_LOC_MAP_EMISSION :: 20

// Shader location: sampler2d texture: height
SHADER_LOC_MAP_HEIGHT :: 21

// Shader location: samplerCube texture: cubemap
SHADER_LOC_MAP_CUBEMAP :: 22

// Shader location: samplerCube texture: irradiance
SHADER_LOC_MAP_IRRADIANCE :: 23

// Shader location: samplerCube texture: prefilter
SHADER_LOC_MAP_PREFILTER :: 24

// Shader location: sampler2d texture: brdf
SHADER_LOC_MAP_BRDF :: 25

// Shader uniform data type
Shader_Uniform_Data_Type :: enum i32
{
    Float = 0,       // Shader uniform type: float
    Vec2,            // Shader uniform type: vec2 (2 float)
    Vec3,            // Shader uniform type: vec3 (3 float)
    Vec4,            // Shader uniform type: vec4 (4 float)
    Int,             // Shader uniform type: int
    IVec2,           // Shader uniform type: ivec2 (2 int)
    IVec3,           // Shader uniform type: ivec3 (3 int)
    IVec4,           // Shader uniform type: ivec4 (4 int)
    Sampler2D        // Shader uniform type: sampler2d
}

// Shader attribute data types
Shader_Attribute_Data_Type :: enum i32
{
    Float = 0,        // Shader attribute type: float
    Vec2,             // Shader attribute type: vec2 (2 float)
    Vec3,             // Shader attribute type: vec3 (3 float)
    Vec4              // Shader attribute type: vec4 (4 float)
}

// Pixel formats
// NOTE: Support depends on OpenGL version and platform
Pixel_Format :: enum i32
{
    Uncompressed_GRAYSCALE = 1, // 8 bit per pixel (no alpha)
    Uncompressed_GRAY_ALPHA,    // 8*2 bpp (2 channels)
    Uncompressed_R5G6B5,        // 16 bpp
    Uncompressed_R8G8B8,        // 24 bpp
    Uncompressed_R5G5B5A1,      // 16 bpp (1 bit alpha)
    Uncompressed_R4G4B4A4,      // 16 bpp (4 bit alpha)
    Uncompressed_R8G8B8A8,      // 32 bpp
    Uncompressed_R32,           // 32 bpp (1 channel - float)
    Uncompressed_R32G32B32,     // 32*3 bpp (3 channels - float)
    Uncompressed_R32G32B32A32,  // 32*4 bpp (4 channels - float)
    Uncompressed_R16,           // 16 bpp (1 channel - half float)
    Uncompressed_R16G16B16,     // 16*3 bpp (3 channels - half float)
    Uncompressed_R16G16B16A16,  // 16*4 bpp (4 channels - half float)
    Compressed_DXT1_RGB,        // 4 bpp (no alpha)
    Compressed_DXT1_RGBA,       // 4 bpp (1 bit alpha)
    Compressed_DXT3_RGBA,       // 8 bpp
    Compressed_DXT5_RGBA,       // 8 bpp
    Compressed_ETC1_RGB,        // 4 bpp
    Compressed_ETC2_RGB,        // 4 bpp
    Compressed_ETC2_EAC_RGBA,   // 8 bpp
    Compressed_PVRT_RGB,        // 4 bpp
    Compressed_PVRT_RGBA,       // 4 bpp
    Compressed_ASTC_4x4_RGBA,   // 8 bpp
    Compressed_ASTC_8x8_RGBA    // 2 bpp
}

// Texture parameters: filter mode
// NOTE 1: Filtering considers mipmaps if available in the texture
// NOTE 2: Filter is accordingly set for minification and magnification
Texture_Filter :: enum i32
{
    Point = 0,               // No filter, just pixel approximation
    Bilinear,                // Linear filtering
    Trilinear,               // Trilinear filtering (linear with mipmaps)
    Anisotropic_4X,          // Anisotropic filtering 4x
    Anisotropic_8X,          // Anisotropic filtering 8x
    Anisotropic_16X,         // Anisotropic filtering 16x
}

// Texture parameters: wrap mode
Texture_Wrap :: enum i32
{
    Repeat = 0,                // Repeats texture in tiled mode
    Clamp,                     // Clamps texture to edge pixel in tiled mode
    Mirror_Repeat,             // Mirrors and repeats the texture in tiled mode
    Mirror_Clamp               // Mirrors and clamps to border the texture in tiled mode
}

// Cubemap layouts
Cubemap_Layout :: enum i32
{
    Auto_Detect = 0,         // Automatically detect layout type
    Line_Vertical,           // Layout is defined by a vertical line with faces
    Line_Horizontal,         // Layout is defined by a horizontal line with faces
    Cross_Three_By_Four,     // Layout is defined by a 3x4 cross with cubemap faces
    Cross_Four_By_Three,     // Layout is defined by a 4x3 cross with cubemap faces
    Panorama                 // Layout is defined by a panorama image (equirrectangular map)
}

// Font type, defines generation method
Font_Type :: enum i32
{
    Default = 0,               // Default font generation, anti-aliased
    Bitmap,                    // Bitmap font generation, no anti-aliasing
    SDF                        // SDF font generation, requires external shader
}

// Color blending modes (pre-defined)
Blend_Mode :: enum i32
{
    Alpha = 0,                // Blend textures considering alpha (default)
    Additive,                 // Blend textures adding colors
    Multiplied,               // Blend textures multiplying colors
    Add_Colors,               // Blend textures adding colors (alternative)
    Subtract_Colors,          // Blend textures subtracting colors (alternative)
    Alpha_Premultiply,        // Blend premultiplied textures considering alpha
    Custom,                   // Blend textures using custom src/dst factors (use rlSetBlendFactors())
    Custom_Separate           // Blend textures using custom rgb/alpha separate src/dst factors (use rlSetBlendFactorsSeparateustom
}

// Gesture
// NOTE: Provided as bit-wise flags to enable only desired gestures
Gesture :: enum i32
{
    None        = 0,        // No gesture
    Tap         = 1,        // Tap gesture
    Double_Tap  = 2,        // Double tap gesture
    Hold        = 4,        // Hold gesture
    Drag        = 8,        // Drag gesture
    Swipe_Right= 16,       // Swipe right gesture
    Swipe_Left  = 32,       // Swipe left gesture
    Swipe_Up    = 64,       // Swipe up gesture
    Swipe_Down  = 128,      // Swipe down gesture
    Pinch_In    = 256,      // Pinch in gesture
    Pinch_Out   = 512       // Pinch out gesture
}

// Camera system modes
Camera_Mode :: enum
{
    Custom = 0,              // Custom camera
    Free,                    // Free camera
    Orbital,                 // Orbital camera
    First_Person,            // First person camera
    Third_Person             // Third person camera
}

// Camera projection
Camera_Projection :: enum i32
{
    Perspective = 0,         // Perspective projection
    Orthographic             // Orthographic projection
}

// N-patch layout
NPatch_Layout :: enum i32
{
    Nine_Patch = 0,          // Npatch layout: 3x3 tiles
    Three_Patch_Vertical,    // Npatch layout: 1x3 tiles
    Three_Patch_Horizontal   // Npatch layout: 3x1 tiles
}