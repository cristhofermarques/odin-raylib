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

// Ray_Collision, ray hit information
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
    Semicolon       = 59,       // Key:  ---
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
    Int,             // Shader uniform type: i32
    IVec2,           // Shader uniform type: ivec2 (2 i32)
    IVec3,           // Shader uniform type: ivec3 (3 i32)
    IVec4,           // Shader uniform type: ivec4 (4 i32)
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

/* Callbacks to hook some internal functions */
// WARNING: These callbacks are intended for advance users

import c "core:c/libc"

// Logging: Redirect trace log messages
Trace_Log_Callback :: #type proc "c" (log_level: Trace_Log_Level, text: cstring, args: c.va_list)

// FileIO: Load binary data
Load_File_Data_Callback :: #type proc "c" (file_name: cstring, data_size: ^i32) -> [^]u8

// FileIO: Save binary data
Save_File_Data_Callback :: #type proc "c" (file_name: cstring, data: rawptr, data_size: i32) -> bool

// FileIO: Load text data
Load_File_Text_Callback :: #type proc "c" (file_name: cstring) -> cstring

// FileIO: Save text data
Save_File_Text_Callback :: #type proc "c" (file_name, text: cstring) -> bool

Audio_Callback :: #type proc "c" (buffer_data: rawptr, frames: u32)

when #config(RAYLIB_SHARED, false)
{
    when ODIN_OS == .Windows && ODIN_ARCH == .amd64 do foreign import raylib "binaries/windows_amd64/raylibdll.lib"
}
else
{
    when ODIN_OS == .Windows && ODIN_ARCH == .amd64 do foreign import raylib {
        "binaries/windows_amd64/raylib.lib",
        "system:gdi32.lib",
        "system:user32.lib",
        "system:shell32.lib",
        "system:winmm.lib",
        "system:msvcrt.lib",
        "system:libcmt.lib",
    }
}

@(default_calling_convention="c")
foreign raylib
{
    /* Window-related functions */

    
    // Initialize window and OpenGL context
    @(link_name="InitWindow")
    init_window :: proc(width, height: i32, title: cstring) ---
    
    // Close window and unload OpenGL context
    @(link_name="CloseWindow")
    close_window :: proc() ---
    
    // Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
    @(link_name="WindowShouldClose")
    window_should_close :: proc() -> bool ---
    
    // Check if window has been initialized successfully
    @(link_name="IsWindowReady")
    is_window_ready :: proc() -> bool ---
    
    // Check if window is currently fullscreen
    @(link_name="IsWindowFullscreen")
    is_window_fullscreen :: proc() -> bool ---
    
    // Check if window is currently hidden (only PLATFORM_DESKTOP)
    @(link_name="IsWindowHidden")
    is_window_hidden :: proc() -> bool ---
    
    // Check if window is currently minimized (only PLATFORM_DESKTOP)
    @(link_name="IsWindowMinimized")
    is_window_minimized :: proc() -> bool ---
    
    // Check if window is currently maximized (only PLATFORM_DESKTOP)
    @(link_name="IsWindowMaxmized")
    is_window_maximized :: proc() -> bool ---
    
    // Check if window is currently focused (only PLATFORM_DESKTOP)
    @(link_name="IsWindowFocused")
    IsWindowFocused :: proc() -> bool ---
    
    // Check if window has been resized last frame
    @(link_name="IsWindowResized")
    is_window_resized :: proc() -> bool ---
    
    // Check if one specific window flag is enabled
    @(link_name="IsWindowState")
    is_window_state :: proc(flag: u32) -> bool ---
    
    // Set window configuration state using flags (only PLATFORM_DESKTOP)
    @(link_name="SetWindowState")
    set_window_state :: proc(flags: u32) ---
    
    // Clear window configuration state flags
    @(link_name="ClearWindowState")
    clear_window_state :: proc(flags: u32) ---
    
    // Toggle window state: fullscreen/windowed (only PLATFORM_DESKTOP)
    @(link_name="ToggleFullscreen")
    toggle_fullscreen :: proc() ---
    
    // Toggle window state: borderless windowed (only PLATFORM_DESKTOP)
    @(link_name="ToggleBorderlessWindowed")
    toggle_borderless_windowed :: proc() ---
    
    // Set window state: maximized, if resizable (only PLATFORM_DESKTOP)
    @(link_name="MaximizeWindow")
    maximize_window :: proc() ---
    
    // Set window state: minimized, if resizable (only PLATFORM_DESKTOP)
    @(link_name="MinimizeWindow")
    minimize_window :: proc() ---
    
    // Set window state: not minimized/maximized (only PLATFORM_DESKTOP)
    @(link_name="RestoreWindow")
    restore_window :: proc() ---
    
    // Set icon for window (single image, RGBA 32bit, only PLATFORM_DESKTOP)
    @(link_name="SetWindowIcon")
    set_window_icon :: proc(image: Image) ---
    
    // Set icon for window (multiple images, RGBA 32bit, only PLATFORM_DESKTOP)
    @(link_name="SetWindowIcons")
    set_window_icons :: proc(images: [^]Image, count: i32) ---
    
    // Set title for window (only PLATFORM_DESKTOP and PLATFORM_WEB)
    @(link_name="SetWindowTitle")
    set_window_title :: proc(title: cstring) ---
    
    // Set window position on screen (only PLATFORM_DESKTOP)
    @(link_name="SetWindowPosition")
    set_window_position :: proc(x, y: i32) ---
    
    // Set monitor for the current window
    @(link_name="SetWindowMonitor")
    set_window_monitor :: proc(monitor: i32) ---
    
    // Set window minimum dimensions (for FLAG_WINDOW_RESIZABLE)
    @(link_name="SetWindowMinSize")
    set_window_min_size :: proc(width, height: i32) ---
    
    // Set window maximum dimensions (for FLAG_WINDOW_RESIZABLE)
    @(link_name="SetWindowMaxSize")
    set_window_max_size :: proc(width, height: i32) ---
    
    // Set window dimensions
    @(link_name="SetWindowSize")
    set_window_size :: proc(width, height: i32) ---
    
    // Set window opacity [0.0f..1.0f] (only PLATFORM_DESKTOP)
    @(link_name="SetWindowOpacity")
    set_window_opacity :: proc(opacity: f32) ---
    
    // Set window focused (only PLATFORM_DESKTOP)
    @(link_name="SetWindowFocused")
    set_window_focused :: proc() ---
    
    // Get native window handle
    @(link_name="GetWindowHandle")
    get_window_handle :: proc() -> rawptr ---
    
    // Get current screen width
    @(link_name="GetScreenWidth")
    get_screen_width :: proc() -> i32 ---
    
    // Get current screen height
    @(link_name="GetScreenHeight")
    get_screen_height :: proc() -> i32 ---
    
    // Get current render width (it considers HiDPI)
    @(link_name="GetRenderWidth")
    get_render_width :: proc() -> i32 ---
    
    // Get current render height (it considers HiDPI)
    @(link_name="GetRenderHeight")
    get_render_height :: proc() -> i32 ---
    
    // Get number of connected monitors
    @(link_name="GetMonitorCount")
    get_monitor_count :: proc() -> i32 ---
    
    // Get current connected monitor
    @(link_name="GetCurrentMonitor")
    get_current_monitor :: proc() -> i32 ---
    
    // Get specified monitor position
    @(link_name="GetMonitorPosition")
    get_monitor_position :: proc(monitor: i32) -> Vector2 ---
    
    // Get specified monitor width (current video mode used by monitor)
    @(link_name="GetMonitorWidth")
    get_monitor_width :: proc(monitor: i32) -> i32 ---
    
    // Get specified monitor height (current video mode used by monitor)
    @(link_name="GetMonitorHeight")
    get_monitor_height :: proc(monitor: i32) -> i32 ---
    
    // Get specified monitor physical width in millimetres
    @(link_name="GetMonitorPhysicalWidth")
    get_monitor_physical_width :: proc(monitor: i32) -> i32 ---
    
    // Get specified monitor physical height in millimetres
    @(link_name="GetMonitorPhysicalHeight")
    get_monitor_physical_height :: proc(monitor: i32) -> i32 ---
    
    // Get specified monitor refresh rate
    @(link_name="GetMonitorRefreshRate")
    get_monitor_refresh_rate :: proc(monitor: i32) -> i32 ---
    
    // Get window position XY on monitor
    @(link_name="GetWindowPosition")
    get_window_position :: proc() -> Vector2 ---
    
    // Get window scale DPI factor
    @(link_name="GetWindowScaleDPI")
    get_window_scale_dpi :: proc() -> Vector2 ---
    
    // Get the human-readable, UTF-8 encoded name of the specified monitor
    @(link_name="GetMonitorName")
    get_monitor_name :: proc(monitor: i32) -> cstring ---
    
    // Set clipboard text content
    @(link_name="SetClipboardText")
    set_clipboard_text :: proc(text: cstring) ---
    
    // Get clipboard text content
    @(link_name="GetClipboardText")
    get_clipboard_text :: proc() -> cstring ---
    
    // Enable waiting for events on EndDrawing(), no automatic event polling
    @(link_name="EnableEventWaiting")
    enable_event_waiting :: proc() ---
    
    // Disable waiting for events on EndDrawing(), automatic events polling
    @(link_name="DisableEventWaiting")
    disable_event_waiting :: proc() ---


    /* Cursor-related functions */


    // Shows cursor
    @(link_name="ShowCursor")
    show_cursor :: proc() ---


    // Hides cursor
    @(link_name="HideCursor")
    hide_cursor :: proc() ---

    // Check if cursor is not visible
    @(link_name="IsCursorHidden")
    is_cursor_hidden :: proc() -> bool ---

    // Enables cursor (unlock cursor)
    @(link_name="EnableCursor")
    enable_cursor :: proc() ---

    // Disables cursor (lock cursor)
    @(link_name="DisableCursor")
    disable_cursor :: proc() ---

    // Check if cursor is on the screen
    @(link_name="IsCursorOnScreen")
    is_cursor_on_screen :: proc() -> bool ---


    /* Drawing-related functions */


    // Set background color (framebuffer clear color)
    @(link_name="ClearBackground")
    clear_background :: proc(color: Color) ---

    // Setup canvas (framebuffer) to start drawing
    @(link_name="BeginDrawing")
    begin_drawing :: proc() ---

    // End canvas drawing and swap buffers (double buffering)
    @(link_name="EndDrawing")
    end_drawing :: proc() ---

    // Begin 2D mode with custom camera (2D)
    @(link_name="BeginMode2D")
    begin_mode2d :: proc(camera: Camera2D) ---

    // Ends 2D mode with custom camera
    @(link_name="EndMode2D")
    end_mode2d :: proc() ---

    // Begin 3D mode with custom camera (3D)
    @(link_name="BeginMode3D")
    begin_mode3d :: proc(camera: Camera3D) ---

    // Ends 3D mode and returns to default 2D orthographic mode
    @(link_name="EndMode3D")
    end_mode3d :: proc() ---

    // Begin drawing to render texture
    @(link_name="BeginTextureMode")
    begin_texture_mode :: proc(target: Render_Texture2D) ---

    // Ends drawing to render texture
    @(link_name="EndTextureMode")
    end_texture_mode :: proc() ---

    // Begin custom shader drawing
    @(link_name="BeginShaderMode")
    begin_shader_mode :: proc(shader: Shader) ---

    // End custom shader drawing (use default shader)
    @(link_name="EndShaderMode")
    end_shader_mode :: proc() ---

    // Begin blending mode (alpha, additive, multiplied, subtract, custom)
    @(link_name="BeginBlendMode")
    begin_blend_mode :: proc(mode: i32) ---

    // End blending mode (reset to default: alpha blending)
    @(link_name="EndBlendMode")
    end_blend_mode :: proc() ---

    // Begin scissor mode (define screen area for following drawing)
    @(link_name="BeginScissorMode")
    begin_scissor_mode :: proc(x, y, width, height: i32) ---

    // End scissor mode
    @(link_name="EndScissorMode")
    end_scissor_mode :: proc() ---

    // Begin stereo rendering (requires VR simulator)
    @(link_name="BeginVrStereoMode")
    begin_vr_stereo_mode :: proc(config: VR_Stereo_Config) ---

    // End stereo rendering (requires VR simulator)
    @(link_name="EndVrStereoMode")
    end_vr_stereo_mode :: proc() ---


    /* VR stereo config functions for VR simulator */


    // Load VR stereo config for VR simulator device parameters
    @(link_name="LoadVrStereoConfig")
    load_vr_stereo_config :: proc(device: VR_Device_Info) -> VR_Stereo_Config ---

    // Unload VR stereo config
    @(link_name="UnloadVrStereoConfig")
    unload_vr_stereo_config :: proc(config: VR_Stereo_Config) ---


    /* Shader management functions */
    // NOTE: Shader functionality is not available on OpenGL 1.1


    // Load shader from files and bind default locations
    @(link_name="LoadShader")
    load_shader :: proc(vs_file_name, fs_file_name: cstring) -> Shader ---

    // Load shader from code strings and bind default locations
    @(link_name="LoadShaderFromMemory")
    load_shader_from_memory :: proc(vs_code, fs_code: cstring) -> Shader ---

    // Check if a shader is ready
    @(link_name="IsShaderReady")
    is_shader_ready :: proc(shader: Shader) -> bool ---

    // Get shader uniform location
    @(link_name="GetShaderLocation")
    get_shader_location :: proc(shader: Shader, uniform_name: cstring) -> i32 ---

    // Get shader attribute location
    @(link_name="GetShaderLocationAttrib")
    get_shader_location_attrib :: proc(shader: Shader, attrib_name: cstring)  -> i32 ---

    // Set shader uniform value
    @(link_name="SetShaderValue")
    set_shader_value :: proc(shader: Shader, loc_index: i32, value: rawptr, uniform_type: i32) ---

    // Set shader uniform value vector
    @(link_name="SetShaderValueV")
    set_shader_value_v :: proc(shader: Shader, loc_index: i32, value: rawptr, uniform_type, count: i32) ---

    // Set shader uniform value (matrix 4x4)
    @(link_name="SetShaderValueMatrix")
    set_shader_value_matrix :: proc(shader: Shader, loc_index: i32, mat: Matrix) ---

    // Set shader uniform value for texture (sampler2d)
    @(link_name="SetShaderValueTexture")
    set_shader_value_texture :: proc(shader: Shader, loc_index: i32, texture: Texture2D) ---

    // Unload shader from GPU memory (VRAM)
    @(link_name="UnloadShader")
    unload_shader :: proc(shader: Shader) ---


    /* Screen-space-related functions */


    // Get a ray trace from mouse position
    @(link_name="GetMouseRay")
    get_mouse_ray :: proc(mouse_position: Vector2, camera: Camera) -> Ray ---

    // Get camera transform matrix (view matrix)
    @(link_name="GetCameraMatrix")
    get_camera_matrix :: proc(camera: Camera) -> Matrix ---

    // Get camera 2d transform matrix
    @(link_name="GetCameraMatrix2D")
    get_camera_matrix2d :: proc(camera: Camera2D) -> Matrix ---

    // Get the screen space position for a 3d world space position
    @(link_name="GetWorldToScreen")
    get_world_to_screen :: proc(position: Vector3, camera: Camera) -> Vector2 ---

    // Get the world space position for a 2d camera screen space position
    @(link_name="GetScreenToWorld2D")
    get_screen_to_world2d :: proc(position: Vector2, camera: Camera2D) -> Vector2 ---

    // Get size position for a 3d world space position
    @(link_name="GetWorldToScreenEx")
    get_world_to_screen_ex :: proc(position: Vector3, camera: Camera, width, height: i32) -> Vector2 ---

    // Get the screen space position for a 2d camera world space position
    @(link_name="GetWorldToScreen2D")
    get_world_to_screen2d :: proc(position: Vector2, camera: Camera2D) -> Vector2 ---


    /* Timing-related functions */


    // Set target FPS (maximum)
    @(link_name="SetTargetFPS")
    set_target_fps :: proc(fps: i32) ---

    // Get time in seconds for last frame drawn (delta time)
    @(link_name="GetFrameTime")
    get_frame_time :: proc() -> f32 ---

    // Get elapsed time in seconds since InitWindow()
    @(link_name="GetTime")
    get_time :: proc() -> f64 ---

    // Get current FPS
    @(link_name="GetFPS")
    get_fps :: proc() -> i32 ---


    /* Custom frame control functions */
    // NOTE: Those functions are intended for advance users that want full control over the frame processing
    // By default EndDrawing() does this job: draws everything + SwapScreenBuffer() + manage frame timing + PollInputEvents()
    // To avoid that behaviour and control frame processes manually, enable in config.h: SUPPORT_CUSTOM_FRAME_CONTROL


    // Swap back buffer with front buffer (screen drawing)
    @(link_name="SwapScreenBuffer")
    swap_screen_buffer :: proc() ---

    // Register all input events
    @(link_name="PollInputEvents")
    poll_input_events :: proc() ---

    // Wait for some time (halt program execution)
    @(link_name="WaitTime")
    wait_time :: proc(seconds: f64) ---


    /* Random values generation functions */


    // Set the seed for the random number generator
    @(link_name="SetRandomSeed")
    set_random_seed :: proc(seed: u32) ---

    // Get a random value between min and max (both included)
    @(link_name="GetRandomValue")
    get_random_value :: proc(min, max: i32) -> i32 ---

    // Load random values sequence, no values repeated
    @(link_name="LoadRandomSequence")
    load_random_sequence :: proc(count: u32, min, max: i32) -> [^]i32 ---

    // Unload random values sequence
    @(link_name="UnloadRandomSequence")
    unload_random_sequence :: proc(sequence: [^]i32) ---


    /* Misc. functions */


    // Takes a screenshot of current screen (filename extension defines format)
    @(link_name="TakeScreenshot")
    take_screenshot :: proc(file_name: cstring) ---

    // Setup init configuration flags (view FLAGS)
    @(link_name="SetConfigFlags")
    set_config_flags :: proc(flags: Config_Flags) ---

    // Open URL with default system browser (if available)
    @(link_name="OpenURL")
    open_url :: proc(url: cstring) ---


    // NOTE: Following functions implemented in module [utils]


    // Show trace log messages (LOG_DEBUG, LOG_INFO, LOG_WARNING, LOG_ERROR...)
    @(link_name="TraceLog")
    trace_log :: proc(log_level: Trace_Log_Level, text: cstring, #c_vararg args: ..any) ---

    // Set the current threshold (minimum) log level
    @(link_name="SetTraceLogLevel")
    set_trace_log_level :: proc(log_level: Trace_Log_Level) ---

    // Internal memory allocator
    @(link_name="MemAlloc")
    mem_alloc :: proc(size: u32) -> rawptr ---

    // Internal memory reallocator
    @(link_name="MemRealloc")
    mem_realloc :: proc(ptr: rawptr, size: u32) -> rawptr ---

    // Internal memory free
    @(link_name="MemFree")
    mem_free :: proc(ptr: rawptr) ---


    /* Set custom callbacks */
    // WARNING: Callbacks setup is intended for advance users


    // Set custom trace log
    @(link_name="SetTraceLogCallback")
    set_trace_log_callback :: proc(callback: Trace_Log_Callback) ---
    
    // Set custom file binary data loader
    @(link_name="SetLoadFileDataCallback")
    set_load_file_data_callback :: proc(callback: Load_File_Data_Callback) ---
    
    // Set custom file binary data saver
    @(link_name="SetSaveFileDataCallback")
    set_save_file_data_callback :: proc(callback: Save_File_Data_Callback) ---
    
    // Set custom file text data loader
    @(link_name="SetLoadFileTextCallback")
    set_load_file_text_callback :: proc(callback: Load_File_Text_Callback) ---
    
    // Set custom file text data saver
    @(link_name="SetSaveFileTextCallback")
    set_save_file_text_callback :: proc(callback: Save_File_Text_Callback) ---
    

    /* Files management functions */


    // Load file data as byte array (read)
    @(link_name="LoadFileData")
    load_file_data :: proc(file_name: cstring, data_size: ^i32) -> [^]u8 ---
    
    // Unload file data allocated by LoadFileData()
    @(link_name="UnloadFileData")
    unload_file_data :: proc(data: [^]u8) ---
    
    // Save data to file from byte array (write), returns true on success
    @(link_name="SaveFileData")
    save_file_data :: proc(file_name: cstring, data: rawptr, data_size: i32) -> bool ---
    
    // Export data to code (.h), returns true on success
    @(link_name="ExportDataAsCode")
    export_data_as_code :: proc(data: [^]u8, data_size: i32, file_name: cstring) -> bool ---
    
    // Load text data from file (read), returns a '\0' terminated string
    @(link_name="LoadFileText")
    load_file_text :: proc(file_name: cstring) -> cstring ---
    
    // Unload file text data allocated by LoadFileText()
    @(link_name="UnloadFileText")
    unload_file_text :: proc(text: cstring) ---
    
    // Save text data to file (write), string must be '\0' terminated, returns true on success
    @(link_name="SaveFileText")
    save_file_text :: proc(file_name, text: cstring) -> bool ---


    /* File system functions */


    // Check if file exists
    @(link_name="FileExists")
    file_exists :: proc(file_name: cstring) -> bool ---

    // Check if a directory path exists
    @(link_name="DirectoryExists")
    directory_exists :: proc(dir_path: cstring) -> bool ---

    // Check file extension (including point: .png, .wav)
    @(link_name="IsFileExtension")
    is_file_extension :: proc(file_name, ext: cstring) -> bool ---

    // Get file length in bytes (NOTE: GetFileSize() conflicts with windows.h)
    @(link_name="GetFileLength")
    get_file_length :: proc(file_name: cstring) -> i32 ---

    // Get pointer to extension for a filename string (includes dot: '.png')
    @(link_name="GetFileExtension")
    get_file_extension :: proc(file_name: cstring) -> cstring ---

    // Get pointer to filename for a path string
    @(link_name="GetFileName")
    get_file_name :: proc(file_path: cstring) -> cstring ---

    // Get filename string without extension (uses static string)
    @(link_name="GetFileNameWithoutExt")
    get_file_name_without_ext :: proc(file_path: cstring) -> cstring ---

    // Get full path for a given fileName with path (uses static string)
    @(link_name="GetDirectoryPath")
    get_directory_path :: proc(file_path: cstring) -> cstring ---

    // Get previous directory path for a given path (uses static string)
    @(link_name="GetPrevDirectoryPath")
    get_prev_directory_path :: proc(dir_path: cstring) -> cstring ---

    // Get current working directory (uses static string)
    @(link_name="GetWorkingDirectory")
    get_working_directory :: proc() -> cstring ---

    // Get the directory of the running application (uses static string)
    @(link_name="GetApplicationDirectory")
    get_application_directory :: proc() -> cstring ---

    // Change working directory, return true on success
    @(link_name="ChangeDirectory")
    change_directory :: proc(dir: cstring) -> bool ---

    // Check if a given path is a file or a directory
    @(link_name="IsPathFile")
    is_path_file :: proc(path: cstring) -> bool ---

    // Load directory filepaths
    @(link_name="LoadDirectoryFiles")
    load_directory_files :: proc(dir_path: cstring) -> File_Path_List ---

    // Load directory filepaths with extension filtering and recursive directory scan
    @(link_name="LoadDirectoryFilesEx")
    load_directory_files_ex :: proc(base_path, filter: cstring, scan_subdirs: bool) -> File_Path_List ---

    // Unload filepaths
    @(link_name="UnloadDirectoryFiles")
    unload_directory_files :: proc(files: File_Path_List) ---

    // Check if a file has been dropped into window
    @(link_name="IsFileDropped")
    is_file_dropped :: proc() -> bool ---

    // Load dropped filepaths
    @(link_name="LoadDroppedFiles")
    load_dropped_files :: proc() -> File_Path_List ---

    // Unload dropped filepaths
    @(link_name="UnloadDroppedFiles")
    unload_dropped_files :: proc(files: File_Path_List) ---

    // Get file modification time (last write time)
    @(link_name="GetFileModTime")
    get_file_mod_time :: proc(file_name: cstring) -> i64 ---


    /* Compression/Encoding functionality */
    // Compress data (DEFLATE algorithm), memory must be MemFree()


    @(link_name="CompressData")
    compress_data :: proc(data: [^]u8, data_size: i32, comp_data_size: ^i32) -> [^]u8 ---

    // Decompress data (DEFLATE algorithm), memory must be MemFree()
    @(link_name="DecompressData")
    decompress_data :: proc(comp_data: [^]u8, comp_data_size: i32, data_size: ^i32) -> [^]u8 ---

    // Encode data to Base64 string, memory must be MemFree()
    @(link_name="EncodeDataBase64")
    encode_data_base64 :: proc(data: [^]u8, data_size: i32, output_size: ^i32) -> [^]u8 ---

    // Decode Base64 string data, memory must be MemFree()
    @(link_name="DecodeDataBase64")
    decode_data_base64 :: proc(data: [^]u8, output_size: ^i32) -> [^]u8 ---


    /* Automation events functionality */


    // Load automation events list from file, NULL for empty list, capacity = MAX_AUTOMATION_EVENTS
    @(link_name="LoadAutomationEventList")
    load_automation_event_list :: proc(file_name: cstring) -> Automation_Event_List ---

    // Unload automation events list from file
    @(link_name="UnloadAutomationEventList")
    unload_automation_event_list :: proc(list: ^Automation_Event_List) ---

    // Export automation events list as text file
    @(link_name="ExportAutomationEventList")
    export_automation_event_list :: proc(list: Automation_Event_List, file_name: cstring) -> bool ---

    // Set automation event list to record to
    @(link_name="SetAutomationEventList")
    set_automation_event_list :: proc(list: ^Automation_Event_List) ---

    // Set automation event internal base frame to start recording
    @(link_name="SetAutomationEventBaseFrame")
    set_automation_event_base_frame :: proc(frame: i32) ---

    // Start recording automation events (AutomationEventList must be set)
    @(link_name="StartAutomationEventRecording")
    start_automation_event_recording :: proc() ---

    // Stop recording automation events
    @(link_name="StopAutomationEventRecording")
    stop_automation_event_recording :: proc() ---

    // Play a recorded automation event
    @(link_name="PlayAutomationEvent")
    play_automation_event :: proc(event: Automation_Event) ---


    /* Input-related functions: keyboard */


    // Check if a key has been pressed once
    @(link_name="IsKeyPressed")
    is_key_pressed :: proc(key: i32) -> bool ---

    // Check if a key has been pressed again (Only PLATFORM_DESKTOP)
    @(link_name="IsKeyPressedRepeat")
    is_key_pressed_repeat :: proc(key: i32) -> bool ---

    // Check if a key is being pressed
    @(link_name="IsKeyDown")
    is_key_down :: proc(key: i32) -> bool ---

    // Check if a key has been released once
    @(link_name="IsKeyReleased")
    is_key_released :: proc(key: i32) -> bool ---

    // Check if a key is NOT being pressed
    @(link_name="IsKeyUp")
    is_key_up :: proc(key: i32) -> bool ---

    // Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty
    @(link_name="GetKeyPressed")
    get_key_pressed :: proc() -> i32 ---

    // Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty
    @(link_name="GetCharPressed")
    get_char_pressed :: proc() -> i32 ---

    // Set a custom key to exit program (default is ESC)
    @(link_name="SetExitKey")
    set_exit_key :: proc (key: i32) ---


    // Input-related functions: gamepads
    
    // Check if a gamepad is available
    @(link_name="IsGamepadAvailable")
    is_gamepad_available :: proc(gamepad: i32) -> bool ---
    
    // Get gamepad internal name id
    @(link_name="GetGamepadName")
    get_gamepad_name :: proc(gamepad: i32) -> cstring ---
    
    // Check if a gamepad button has been pressed once
    @(link_name="IsGamepadButtonPressed")
    is_gamepad_button_pressed :: proc(gamepad, button: i32) -> bool ---
    
    // Check if a gamepad button is being pressed
    @(link_name="IsGamepadButtonDown")
    is_gamepad_button_down :: proc(gamepad, button: i32) -> bool ---
    
    // Check if a gamepad button has been released once
    @(link_name="IsGamepadButtonReleased")
    is_gamepad_button_released :: proc(gamepad, button: i32) -> bool ---
    
    // Check if a gamepad button is NOT being pressed
    @(link_name="IsGamepadButtonUp")
    is_gamepad_button_up :: proc(gamepad, button: i32) -> bool ---
    
    // Get the last gamepad button pressed
    @(link_name="GetGamepadButtonPressed")
    get_gamepad_button_pressed :: proc() -> i32 ---
    
    // Get gamepad axis count for a gamepad
    @(link_name="GetGamepadAxisCount")
    get_gamepad_axis_count :: proc(gamepad: i32) -> i32 ---
    
    // Get axis movement value for a gamepad axis
    @(link_name="GetGamepadAxisMovement")
    get_gamepad_axis_movement :: proc(gamepad, axis: i32) -> f32 ---
    
    // Set internal gamepad mappings (SDL_GameControllerDB)
    @(link_name="SetGamepadMappings")
    set_gamepad_mappings :: proc(mappings: cstring) -> i32 ---


    /* Input-related functions: mouse */


    // Check if a mouse button has been pressed once
    @(link_name="IsMouseButtonPressed")
    is_mouse_button_pressed :: proc(button: i32) -> bool ---

    // Check if a mouse button is being pressed
    @(link_name="IsMouseButtonDown")
    is_mouse_button_down :: proc(button: i32) -> bool ---

    // Check if a mouse button has been released once
    @(link_name="IsMouseButtonReleased")
    is_mouse_button_released :: proc(button: i32) -> bool ---

    // Check if a mouse button is NOT being pressed
    @(link_name="IsMouseButtonUp")
    is_mouse_button_up :: proc(button: i32) -> bool ---

    // Get mouse position X
    @(link_name="GetMouseX")
    get_mouse_x :: proc() -> i32 ---

    // Get mouse position Y
    @(link_name="GetMouseY")
    get_mouse_y :: proc() -> i32 ---

    // Get mouse position XY
    @(link_name="GetMousePosition")
    get_mouse_position :: proc() -> Vector2 ---

    // Get mouse delta between frames
    @(link_name="GetMouseDelta")
    get_mouse_delta :: proc() -> Vector2 ---

    // Set mouse position XY
    @(link_name="SetMousePosition")
    set_mouse_position :: proc(x, y: i32) ---

    // Set mouse offset
    @(link_name="SetMouseOffset")
    set_mouse_offset :: proc(offset_x, offset_y: i32) ---

    // Set mouse scaling
    @(link_name="SetMouseScale")
    set_mouse_scale :: proc(scale_x, scale_y: f32) ---

    // Get mouse wheel movement for X or Y, whichever is larger
    @(link_name="GetMouseWheelMove")
    get_mouse_wheel_move :: proc() -> f32 ---

    // Get mouse wheel movement for both X and Y
    @(link_name="GetMouseWheelMoveV")
    get_mouse_wheel_move_v :: proc() -> Vector2 ---

    // Set mouse cursor
    @(link_name="SetMouseCursor")
    set_mouse_cursor :: proc(cursor: i32) ---


    /* Input-related functions: touch */


    // Get touch position X for touch point 0 (relative to screen size)
    @(link_name="GetTouchX")
    get_touch_x :: proc() -> i32 ---
    
    // Get touch position Y for touch point 0 (relative to screen size)
    @(link_name="GetTouchY")
    get_touch_y :: proc() -> i32 ---
    
    // Get touch position XY for a touch point index (relative to screen size)
    @(link_name="GetTouchPosition")
    get_touch_position :: proc(index: i32) -> Vector2 ---
    
    // Get touch point identifier for given index
    @(link_name="GetTouchPointId")
    get_touch_point_id :: proc(index: i32) -> i32 ---
    
    // Get number of touch points
    @(link_name="GetTouchPointCount")
    get_touch_point_count :: proc() -> i32 ---
    
    // Enable a set of gestures using flags
    @(link_name="SetGesturesEnabled")
    set_gestures_enabled :: proc(flags: u32) ---

    // Check if a gesture have been detected
    @(link_name="IsGestureDetected")
    is_gesture_detected :: proc(gesture: u32) -> bool ---

    // Get latest detected gesture
    @(link_name="GetGestureDetected")
    get_gesture_detected :: proc() -> i32 ---

    // Get gesture hold time in milliseconds
    @(link_name="GetGestureHoldDuration")
    get_gesture_hold_duration :: proc() -> f32 ---

    // Get gesture drag vector
    @(link_name="GetGestureDragVector")
    get_gesture_drag_vector :: proc() -> Vector2 ---

    // Get gesture drag angle
    @(link_name="GetGestureDragAngle")
    get_gesture_drag_angle :: proc() -> f32 ---

    // Get gesture pinch delta
    @(link_name="GetGesturePinchVector")
    get_gesture_pinch_vector :: proc() -> Vector2 ---

    // Get gesture pinch angle
    @(link_name="GetGesturePinchAngle")
    get_gesture_pinch_angle :: proc() -> f32 ---

    // Update camera position for selected mode
    @(link_name="UpdateCamera")
    update_camera :: proc(camera: ^Camera, mode: Camera_Mode) ---

    // Update camera movement/rotation
    @(link_name="UpdateCameraPro")
    update_camera_pro :: proc(camera: ^Camera, movement, rotation: Vector3, zoom: f32) ---

    // Set texture and rectangle to be used on shapes drawing
    @(link_name="SetShapesTexture")
    set_shapes_texture :: proc(texture: Texture2D, source: Rectangle) ---


    /* Basic shapes drawing functions */


    // Draw a pixel
    @(link_name="DrawPixel")
    draw_pixel :: proc(pos_x, pos_y: i32, color: Color) ---

    // Draw a pixel (Vector version)
    @(link_name="DrawPixelV")
    draw_pixel_v :: proc(position: Vector2, color: Color) ---

    // Draw a line
    @(link_name="DrawLine")
    draw_line :: proc(start_pos_x, start_pos_y, end_pos_x, end_pos_y: i32, color: Color) ---

    // Draw a line (using gl lines)
    @(link_name="DrawLineV")
    draw_line_v :: proc(start_pos, end_pos: Vector2, color: Color) ---

    // Draw a line (using triangles/quads)
    @(link_name="DrawLineEx")
    draw_line_ex :: proc(start_pos, end_pos: Vector2, thick: f32, color: Color) ---

    // Draw lines sequence (using gl lines)
    @(link_name="DrawLineStrip")
    draw_line_strip :: proc(points: [^]Vector2, point_count: i32, color: Color) ---

    // Draw line segment cubic-bezier in-out interpolation
    @(link_name="DrawLineBezier")
    draw_line_bezier :: proc(start_pos, end_pos: Vector2, thick: f32, color: Color) ---

    // Draw a color-filled circle
    @(link_name="DrawCircle")
    draw_circle :: proc(center_x, center_y: i32, radius: f32, color: Color) ---

    // Draw a piece of a circle
    @(link_name="DrawCircleSector")
    draw_circle_sector :: proc(center: Vector2, radius, start_angle, end_angle: f32, segments: i32, color: Color) ---

    // Draw circle sector outline
    @(link_name="DrawCircleSectorLines")
    draw_circle_sector_lines :: proc(center: Vector2, radius, start_angle, end_angle: f32, segments: i32, color: Color) ---

    // Draw a gradient-filled circle
    @(link_name="DrawCircleGradient")
    draw_circle_gradient :: proc(center_x, center_y: i32, radius: f32, color1, color2: Color) ---

    // Draw a color-filled circle (Vector version)
    @(link_name="DrawCircleV")
    draw_circle_v :: proc(center: Vector2, radius: f32, color: Color) ---

    // Draw circle outline
    @(link_name="DrawCircleLines")
    draw_circle_lines :: proc(center_x, center_y: i32, radius: f32, color: Color) ---

    // Draw circle outline (Vector version)
    @(link_name="DrawCircleLinesV")
    draw_circle_lines_v :: proc(center: Vector2, radius: f32, color: Color) ---

    // Draw ellipse
    @(link_name="DrawEllipse")
    draw_ellipse :: proc(center_x, center_y: i32, radius_h, radius_v: f32, color: Color) ---

    // Draw ellipse outline
    @(link_name="DrawEllipseLines")
    draw_ellipse_lines :: proc(center_x, center_y: i32, radius_h, radius_v: f32, color: Color) ---

    // Draw ring
    @(link_name="DrawRing")
    draw_ring :: proc(center: Vector2, inner_radius, outer_radius, start_angle, end_angle: f32, segments: i32, color: Color) ---

    // Draw ring outline
    @(link_name="DrawRingLines")
    draw_ring_lines :: proc(center: Vector2, inner_radius, outer_radius, start_angle, end_angle: f32, segments: i32, color: Color) ---

    // Draw a color-filled rectangle
    @(link_name="DrawRectangle")
    draw_rectangle :: proc(pos_x, pos_y, width, height: i32, color: Color) ---

    // Draw a color-filled rectangle (Vector version)
    @(link_name="DrawRectangleV")
    draw_rectangle_v :: proc(position, size: Vector2, color: Color) ---

    // Draw a color-filled rectangle
    @(link_name="DrawRectangleRec")
    draw_rectangle_rec :: proc(rec: Rectangle, color: Color) ---

    // Draw a color-filled rectangle with pro parameters
    @(link_name="DrawRectanglePro")
    draw_rectangle_pro :: proc(rec: Rectangle, origin: Vector2, rotation: f32, color: Color) ---

    // Draw a vertical-gradient-filled rectangle
    @(link_name="DrawRectangleGradientV")
    draw_rectangle_gradient_v :: proc(pos_x, pos_y, width, height: i32, color1, color2: Color) ---

    // Draw a horizontal-gradient-filled rectangle
    @(link_name="DrawRectangleGradientH")
    draw_rectangle_gradient_h :: proc(pos_x, pos_y, width, height: i32, color1, color2: Color) ---

    // Draw a gradient-filled rectangle with custom vertex colors
    @(link_name="DrawRectangleGradientEx")
    draw_rectangle_gradient_ex :: proc(rec: Rectangle, col1, col2, col3, col4: Color) ---

    // Draw rectangle outline
    @(link_name="DrawRectangleLines")
    draw_rectangle_lines :: proc(pos_x, pos_y, width, height: i32, color: Color) ---

    // Draw rectangle outline with extended parameters
    @(link_name="DrawRectangleLinesEx")
    draw_rectangle_lines_ex :: proc(rec: Rectangle, line_thick: f32, color: Color) ---

    // Draw rectangle with rounded edges
    @(link_name="DrawRectangleRounded")
    draw_rectangle_rounded :: proc(rec: Rectangle, roundness: f32, segments: i32, color: Color) ---

    // Draw rectangle with rounded edges outline
    @(link_name="DrawRectangleRoundedLines")
    draw_rectangle_rounded_lines :: proc(rec: Rectangle, roundness: f32, segments: i32, line_thick: f32, color: Color) ---

    // Draw a color-filled triangle (vertex in counter-clockwise order!)
    @(link_name="DrawTriangle")
    draw_triangle :: proc(v1, v2, v3: Vector2, color: Color) ---

    // Draw triangle outline (vertex in counter-clockwise order!)
    @(link_name="DrawTriangleLines")
    draw_triangle_lines :: proc(v1, v2, v3: Vector2, color: Color) ---

    // Draw a triangle fan defined by points (first vertex is the center)
    @(link_name="DrawTriangleFan")
    draw_triangle_fan :: proc(points: [^]Vector2, point_count: i32, color: Color) ---

    // Draw a triangle strip defined by points
    @(link_name="DrawTriangleStrip")
    draw_triangle_strip :: proc(points: [^]Vector2, pointCount: i32, color: Color) ---

    // Draw a regular polygon (Vector version)
    @(link_name="DrawPoly")
    draw_poly :: proc(center: Vector2, sides: i32, radius, rotation: f32, color: Color) ---

    // Draw a polygon outline of n sides
    @(link_name="DrawPolyLines")
    draw_poly_lines :: proc(center: Vector2, sides: i32, radius, rotation: f32, color: Color) ---

    // Draw a polygon outline of n sides with extended parameters
    @(link_name="DrawPolyLinesEx")
    draw_poly_lines_ex :: proc(center: Vector2, sides: i32, radius, rotation, line_thick: f32, color: Color) ---


    /* Splines drawing functions */


    // Draw spline: Linear, minimum 2 points
    @(link_name="DrawSplineLinear")
    draw_spline_linear :: proc(points: [^]Vector2, point_count: i32, thick: f32, color: Color) ---

    // Draw spline: B-Spline, minimum 4 points
    @(link_name="DrawSplineBasis")
    draw_spline_basis :: proc(points: [^]Vector2, point_count: i32, thick: f32, color: Color) ---

    // Draw spline: Catmull-Rom, minimum 4 points
    @(link_name="DrawSplineCatmullRom")
    draw_spline_catmull_rom :: proc(points: [^]Vector2, point_count: i32, thick: f32, color: Color) ---

    // Draw spline: Quadratic Bezier, minimum 3 points (1 control point): [p1, c2, p3, c4...]
    @(link_name="DrawSplineBezierQuadratic")
    draw_spline_bezier_quadratic :: proc(points: [^]Vector2, point_count: i32, thick: f32, color: Color) ---

    // Draw spline: Cubic Bezier, minimum 4 points (2 control points): [p1, c2, c3, p4, c5, c6...]
    @(link_name="DrawSplineBezierCubic")
    draw_spline_bezier_cubic :: proc(points: [^]Vector2, point_count: i32, thick: f32, color: Color) ---

    // Draw spline segment: Linear, 2 points
    @(link_name="DrawSplineSegmentLinear")
    draw_spline_segment_linear :: proc(p1, p2: Vector2, thick: f32, color: Color) ---

    // Draw spline segment: B-Spline, 4 points
    @(link_name="DrawSplineSegmentBasis")
    draw_spline_segment_basis :: proc(p1, p2, p3, p4: Vector2, thick: f32, color: Color) ---

    // Draw spline segment: Catmull-Rom, 4 points
    @(link_name="DrawSplineSegmentCatmullRom")
    draw_spline_segment_catmull_rom :: proc(Vector2p1, p2, p3, p4: Vector2, thick: f32, color: Color) ---

    // Draw spline segment: Quadratic Bezier, 2 points, 1 control point
    @(link_name="DrawSplineSegmentBezierQuadratic")
    draw_spline_segment_bezier_quadratic :: proc(p1, c2, p3: Vector2, thick: f32, color: Color) ---

    // Draw spline segment: Cubic Bezier, 2 points, 2 control points
    @(link_name="DrawSplineSegmentBezierCubic")
    draw_spline_segment_bezier_cubic :: proc(p1, c2, c3, p4: Vector2, thick: f32, color: Color) ---


    /* Spline segment point evaluation functions, for a given t [0.0f .. 1.0f] */
    

    // Get (evaluate) spline point: Linear
    @(link_name="GetSplinePointLinear")
    get_spline_point_linear :: proc(start_pos, end_pos: Vector2, t: f32) -> Vector2 ---

    // Get (evaluate) spline point: B-Spline
    @(link_name="GetSplinePointBasis")
    get_spline_point_basis :: proc(p1, p2, p3, p4: Vector2, t: f32) -> Vector2 ---

    // Get (evaluate) spline point: Catmull-Rom
    @(link_name="GetSplinePointCatmullRom")
    get_spline_point_catmull_rom :: proc(p1, p2, p3, p4: Vector2, t: f32) -> Vector2 ---

    // Get (evaluate) spline point: Quadratic Bezier
    @(link_name="GetSplinePointBezierQuad")
    get_spline_point_bezier_quad :: proc(p1, c2, p3: Vector2, t: f32) -> Vector2 ---

    // Get (evaluate) spline point: Cubic Bezier
    @(link_name="GetSplinePointBezierCubic")
    get_spline_point_bezier_cubic :: proc(p1, c2, c3, p4: Vector2, t: f32) -> Vector2 ---


    /* Basic shapes collision detection functions */


    // Check collision between two rectangles
    @(link_name="CheckCollisionRecs")
    check_collision_recs :: proc(rec1, rec2: Rectangle) -> bool ---

    // Check collision between two circles
    @(link_name="CheckCollisionCircles")
    check_collision_circles :: proc(center1: Vector2, radius1: f32, center2: Vector2, radius2: f32) -> bool ---

    // Check collision between circle and rectangle
    @(link_name="CheckCollisionCircleRec")
    check_collision_circle_rec :: proc(center: Vector2, radius: f32, rec: Rectangle) -> bool ---

    // Check if point is inside rectangle
    @(link_name="CheckCollisionPointRec")
    check_collision_point_rec :: proc(point: Vector2, rec: Rectangle) -> bool ---

    // Check if point is inside circle
    @(link_name="CheckCollisionPointCircle")
    check_collision_point_circle :: proc(point, center: Vector2, radius: f32) -> bool ---

    // Check if point is inside a triangle
    @(link_name="CheckCollisionPointTriangle")
    check_collision_point_triangle :: proc(point, p1, p2, p3: Vector2) -> bool ---

    // Check if point is within a polygon described by array of vertices
    @(link_name="CheckCollisionPointPoly")
    check_collision_point_poly :: proc(point: Vector2, points: [^]Vector2, point_count: i32) -> bool ---

    // Check the collision between two lines defined by two points each, returns collision point by reference
    @(link_name="CheckCollisionLines")
    check_collision_lines :: proc(start_pos1: Vector2, end_pos1, start_pos2, end_pos2: Vector2, collision_point: ^Vector2) -> bool ---

    // Check if point belongs to line created between two points [p1] and [p2] with defined margin in pixels [threshold]
    @(link_name="CheckCollisionPointLine")
    check_collision_point_line :: proc(point, p1, p2: Vector2, threshold: i32) -> bool ---

    // Get collision rectangle for two rectangles collision
    @(link_name="GetCollisionRec")
    get_collision_rec :: proc(rec1, rec2: Rectangle) -> Rectangle ---


    /* Image loading functions */
    // NOTE: These functions do not require GPU access


    // Load image from file into CPU memory (RAM)
    @(link_name="LoadImage")
    load_image :: proc(file_name: cstring) -> Image ---

    // Load image from RAW file data
    @(link_name="LoadImageRaw")
    load_image_raw :: proc(file_name: cstring, width, height, format, header_size: i32) -> Image ---

    // Load image from SVG file data or string with specified size
    @(link_name="LoadImageSvg")
    load_image_svg :: proc(file_name_or_string: cstring, width, height: i32) -> Image ---

    // Load image sequence from file (frames appended to image.data)
    @(link_name="LoadImageAnim")
    load_image_anim :: proc(file_name: cstring, frames: ^i32) -> Image ---

    // Load image from memory buffer, fileType refers to extension: i.e. '.png'
    @(link_name="LoadImageFromMemory")
    load_image_from_memory :: proc(file_type: cstring, file_data: [^]u8, data_size: i32) -> Image ---

    // Load image from GPU texture data
    @(link_name="LoadImageFromTexture")
    load_image_from_texture :: proc(texture: Texture2D) -> Image ---

    // Load image from screen buffer and (screenshot)
    @(link_name="LoadImageFromScreen")
    load_image_from_screen :: proc() -> Image ---

    // Check if an image is ready
    @(link_name="IsImageReady")
    is_image_ready :: proc(image: Image) -> bool ---

    // Unload image from CPU memory (RAM)
    @(link_name="UnloadImage")
    unload_image :: proc(image: Image) ---

    // Export image data to file, returns true on success
    @(link_name="ExportImage")
    export_image :: proc(image: Image, file_name: cstring) -> bool ---

    // Export image to memory buffer
    @(link_name="ExportImageToMemory")
    export_image_to_memory :: proc(image: Image, fileType: cstring, file_size: ^i32) -> [^]u8 ---

    // Export image as code file defining an array of bytes, returns true on success
    @(link_name="ExportImageAsCode")
    export_image_as_code :: proc(image: Image, file_name: cstring) -> bool ---


    /* Image generation functions */


    // Generate image: plain color
    @(link_name="GenImageColor")
    gen_image_color :: proc(width, height: i32, color: Color) -> Image ---

    // Generate image: linear gradient, direction in degrees [0..360], 0=Vertical gradient
    @(link_name="GenImageGradientLinear")
    gen_image_gradient_linear :: proc(width, height, direction: i32, start, end: Color) -> Image ---

    // Generate image: radial gradient
    @(link_name="GenImageGradientRadial")
    gen_image_gradient_radial :: proc(width, height: i32, density: f32, inner, outer: Color) -> Image ---

    // Generate image: square gradient
    @(link_name="GenImageGradientSquare")
    gen_image_gradient_square :: proc(width, height: i32, density: f32, inner, outer: Color) -> Image ---

    // Generate image: checked
    @(link_name="GenImageChecked")
    gen_image_checked :: proc(width, height, checks_x, checks_y: i32, col1, col2: Color) -> Image ---

    // Generate image: white noise
    @(link_name="GenImageWhiteNoise")
    gen_image_white_noise :: proc(width, height: i32, factor: f32) -> Image ---

    // Generate image: perlin noise
    @(link_name="GenImagePerlinNoise")
    gen_image_perlin_noise :: proc(width, height, offset_x, offset_y: i32, scale: f32) -> Image ---

    // Generate image: cellular algorithm, bigger tileSize means bigger cells
    @(link_name="GenImageCellular")
    gen_image_cellular :: proc(width, height, tile_size: i32) -> Image ---

    // Generate image: grayscale image from text data
    @(link_name="GenImageText")
    gen_image_text :: proc(width, height: i32, text: cstring) -> Image ---


    /* Image manipulation functions */


    // Create an image duplicate (useful for transformations)
    @(link_name="ImageCopy")
    image_copy :: proc(image: Image) -> Image ---

    // Create an image from another image piece
    @(link_name="ImageFromImage")
    image_from_image :: proc(image: Image, rec: Rectangle) -> Image ---

    // Create an image from text (default font)
    @(link_name="ImageText")
    image_text :: proc(text: cstring, font_size: i32, color: Color) -> Image ---

    // Create an image from text (custom sprite font)
    @(link_name="ImageTextEx")
    image_text_ex :: proc(font: Font, text: cstring, font_size, spacing: f32, tint: Color) -> Image ---

    // Convert image data to desired format
    @(link_name="ImageFormat")
    image_format :: proc(image: ^Image, new_format: Pixel_Format) ---

    // Convert image to POT (power-of-two)
    @(link_name="ImageToPOT")
    image_to_pot :: proc(image: ^Image, fill: Color) ---

    // Crop an image to a defined rectangle
    @(link_name="ImageCrop")
    image_crop :: proc(image: ^Image, crop: Rectangle) ---

    // Crop image depending on alpha value
    @(link_name="ImageAlphaCrop")
    image_alpha_crop :: proc(image: ^Image, threshold: f32) ---

    // Clear alpha channel to desired color
    @(link_name="ImageAlphaClear")
    image_alpha_clear :: proc(image: ^Image, color: Color, threshold: f32) ---

    // Apply alpha mask to image
    @(link_name="ImageAlphaMask")
    image_alpha_mask :: proc(image: ^Image, alpha_mask: Image) ---

    // Premultiply alpha channel
    @(link_name="ImageAlphaPremultiply")
    image_alpha_premultiply :: proc(image: ^Image) ---

    // Apply Gaussian blur using a box blur approximation
    @(link_name="ImageBlurGaussian")
    image_blur_gaussian :: proc(image: ^Image, blur_size: i32) ---

    // Apply Custom Square image convolution kernel
    @(link_name="ImageKernelConvolution")
    image_kernel_convolution :: proc(image: ^Image, kernel: ^f32, kernel_size: i32) ---

    // Resize image (Bicubic scaling algorithm)
    @(link_name="ImageResize")
    image_resize :: proc(image: ^Image, new_width, new_height: i32) ---

    // Resize image (Nearest-Neighbor scaling algorithm)
    @(link_name="ImageResizeNN")
    image_resize_nn :: proc(image: ^Image, new_width, new_height: i32) ---

    // Resize canvas and fill with color
    @(link_name="ImageResizeCanvas")
    image_resize_canvas :: proc(image: ^Image, new_width, new_height, offset_x, offset_y: i32, fill: Color) ---

    // Compute all mipmap levels for a provided image
    @(link_name="ImageMipmaps")
    image_mipmaps :: proc(image: ^Image) ---

    // Dither image data to 16bpp or lower (Floyd-Steinberg dithering)
    @(link_name="ImageDither")
    image_dither :: proc(image: ^Image, r_bpp, g_bpp, b_bpp, a_bpp: i32) ---

    // Flip image vertically
    @(link_name="ImageFlipVertical")
    image_flip_vertical :: proc(image: ^Image) ---

    // Flip image horizontally
    @(link_name="ImageFlipHorizontal")
    image_flip_horizontal :: proc(image: ^Image) ---

    // Rotate image by input angle in degrees (-359 to 359)
    @(link_name="ImageRotate")
    image_rotate :: proc(image: ^Image, degrees: i32) ---

    // Rotate image clockwise 90deg
    @(link_name="ImageRotateCW")
    image_rotate_cw :: proc(image: ^Image) ---

    // Rotate image counter-clockwise 90deg
    @(link_name="ImageRotateCCW")
    image_rotate_ccw :: proc(image: ^Image) ---

    // Modify image color: tint
    @(link_name="ImageColorTint")
    image_color_tint :: proc(image: ^Image, color: Color) ---

    // Modify image color: invert
    @(link_name="ImageColorInvert")
    image_color_invert :: proc(image: ^Image) ---

    // Modify image color: grayscale
    @(link_name="ImageColorGrayscale")
    image_color_grayscale :: proc(image: ^Image) ---

    // Modify image color: contrast (-100 to 100)
    @(link_name="ImageColorContrast")
    image_color_contrast :: proc(image: ^Image, contrast: f32) ---

    // Modify image color: brightness (-255 to 255)
    @(link_name="ImageColorBrightness")
    image_color_brightness :: proc(image: ^Image, brightness: i32) ---

    // Modify image color: replace color
    @(link_name="ImageColorReplace")
    image_color_replace :: proc(image: ^Image, color, replace: Color) ---


    // Load color data from image as a Color array (RGBA - 32bit)
    @(link_name="LoadImageColors")
    load_image_colors :: proc(image: Image) -> [^]Color ---

    // Load colors palette from image as a Color array (RGBA - 32bit)
    @(link_name="LoadImagePalette")
    load_image_palette :: proc(image: Image, max_palette_size: i32, color_count: ^i32) -> [^]Color ---


    // Unload color data loaded with LoadImageColors()
    @(link_name="UnloadImageColors")
    unload_image_colors :: proc(colors: [^]Color) ---

    // Unload colors palette loaded with LoadImagePalette()
    @(link_name="UnloadImagePalette")
    unload_image_palette :: proc(colors: [^]Color) ---

    // Get image alpha border rectangle
    @(link_name="GetImageAlphaBorder")
    get_image_alpha_border :: proc(image: Image, threshold: f32) -> Rectangle ---


    // Get image pixel color at (x, y) position
    @(link_name="GetImageColor")
    get_image_color :: proc(image: Image, x, y: i32) -> Color ---


    /* Image drawing functions */
    // NOTE: Image software-rendering functions (CPU)


    // Clear image background with given color
    @(link_name="ImageClearBackground")
    image_clear_background :: proc(dst: ^Image, color: Color) ---

    // Draw pixel within an image
    @(link_name="ImageDrawPixel")
    image_draw_pixel :: proc(dst: ^Image, pos_x, pos_y: i32, color: Color) ---

    // Draw pixel within an image (Vector version)
    @(link_name="ImageDrawPixelV")
    image_draw_pixel_v :: proc(dst: ^Image, position: Vector2, color: Color) ---

    // Draw line within an image
    @(link_name="ImageDrawLine")
    image_draw_line :: proc(dst: ^Image, start_pos_x, start_pos_y, end_pos_x, end_pos_y: i32, color: Color) ---

    // Draw line within an image (Vector version)
    @(link_name="ImageDrawLineV")
    image_draw_line_v :: proc(dst: ^Image, start, end: Vector2, color: Color) ---

    // Draw a filled circle within an image
    @(link_name="ImageDrawCircle")
    image_draw_circle :: proc(dst: ^Image, center_x, enter_y, radius: i32, color: Color) ---

    // Draw a filled circle within an image (Vector version)
    @(link_name="ImageDrawCircleV")
    image_draw_circle_v :: proc(dst: ^Image, center: Vector2, radius: i32, color: Color) ---

    // Draw circle outline within an image
    @(link_name="ImageDrawCircleLines")
    image_draw_circle_lines :: proc(dst: ^Image, center_x, center_y, radius: i32, color: Color) ---

    // Draw circle outline within an image (Vector version)
    @(link_name="ImageDrawCircleLinesV")
    image_draw_circle_lines_v :: proc(dst: ^Image, center: Vector2, radius: i32, color: Color) ---

    // Draw rectangle within an image
    @(link_name="ImageDrawRectangle")
    image_draw_rectangle :: proc(dst: ^Image, pos_x, pos_y, width, height: i32, color: Color) ---

    // Draw rectangle within an image (Vector version)
    @(link_name="ImageDrawRectangleV")
    image_draw_rectangle_v :: proc(dst: ^Image, position, size: Vector2, color: Color) ---

    // Draw rectangle within an image
    @(link_name="ImageDrawRectangleRec")
    image_draw_rectangle_rec :: proc(dst: ^Image, rec: Rectangle, color: Color) ---

    // Draw rectangle lines within an image
    @(link_name="ImageDrawRectangleLines")
    image_draw_rectangle_lines :: proc(dst: ^Image, rec: Rectangle, thick: i32, color: Color) ---

    // Draw a source image within a destination image (tint applied to source)
    @(link_name="ImageDraw")
    image_draw :: proc(dst: ^Image, src: Image, src_rec, dst_rec: Rectangle, tint: Color) ---

    // Draw text (using default font) within an image (destination)
    @(link_name="ImageDrawText")
    image_draw_text :: proc(dst: ^Image, text: cstring, pos_x, pos_y, font_size: i32, color: Color) ---

    // Draw text (custom sprite font) within an image (destination)
    @(link_name="ImageDrawTextEx")
    image_draw_text_ex :: proc(dst: ^Image, font: Font, text: cstring, position: Vector2, font_size, spacing: f32, tint: Color) ---


    /* Texture loading functions */
    // NOTE: These functions require GPU access

    // Load texture from file into GPU memory (VRAM)
    @(link_name="LoadTexture")
    load_texture :: proc(file_name: cstring) -> Texture2D ---

    // Load texture from image data
    @(link_name="LoadTextureFromImage")
    load_texture_from_image :: proc(image: Image) -> Texture2D ---

    // Load cubemap from image, multiple image cubemap layouts supported
    @(link_name="LoadTextureCubemap")
    load_texture_cubemap :: proc(image: Image, layout: Cubemap_Layout) -> Texture_Cubemap ---

    // Load texture for rendering (framebuffer)
    @(link_name="LoadRenderTexture")
    load_render_texture :: proc(width, height: i32) -> Render_Texture2D ---

    // Check if a texture is ready
    @(link_name="IsTextureReady")
    is_texture_ready :: proc(texture: Texture2D) -> bool ---

    // Unload texture from GPU memory (VRAM)
    @(link_name="UnloadTexture")
    unload_texture :: proc(texture: Texture2D) ---

    // Check if a render texture is ready
    @(link_name="IsRenderTextureReady")
    is_render_texture_ready :: proc(target: Render_Texture2D) -> bool ---

    // Unload render texture from GPU memory (VRAM)
    @(link_name="UnloadRenderTexture")
    unload_render_texture :: proc(target: Render_Texture2D) ---

    // Update GPU texture with new data
    @(link_name="UpdateTexture")
    update_texture :: proc(texture: Texture2D, pixels: rawptr) ---

    // Update GPU texture rectangle with new data
    @(link_name="UpdateTextureRec")
    update_texture_rec :: proc(texture: Texture2D, rec: Rectangle, pixels: rawptr) ---


    /* Texture configuration functions */
    

    // Generate GPU mipmaps for a texture
    @(link_name="GenTextureMipmaps")
    gen_texture_mipmaps :: proc(texture: ^Texture2D) ---
    
    // Set texture scaling filter mode
    @(link_name="SetTextureFilter")
    set_texture_filter :: proc(texture: Texture2D, filter: Texture_Filter) ---
    
    // Set texture wrapping mode
    @(link_name="SetTextureWrap")
    set_texture_wrap :: proc(texture: Texture2D, wrap: Texture_Wrap) ---
    

    /* Texture drawing functions */


    // Draw a Texture2D
    @(link_name="DrawTexture")
    draw_texture :: proc(texture: Texture2D, pos_x, pos_y: i32, tint: Color) ---

    // Draw a Texture2D with position defined as Vector2
    @(link_name="DrawTextureV")
    draw_texture_v :: proc(texture: Texture2D, position: Vector2, tint: Color) ---

    // Draw a Texture2D with extended parameters
    @(link_name="DrawTextureEx")
    draw_texture_ex :: proc(texture: Texture2D, position: Vector2, rotation, scale: f32, tint: Color) ---

    // Draw a part of a texture defined by a rectangle
    @(link_name="DrawTextureRec")
    draw_texture_rec :: proc(texture: Texture2D, source: Rectangle, position: Vector2, tint: Color) ---

    // Draw a part of a texture defined by a rectangle with 'pro' parameters
    @(link_name="DrawTexturePro")
    draw_texture_pro :: proc(texture: Texture2D, source, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) ---

    // Draws a texture (or part of it) that stretches or shrinks nicely
    @(link_name="DrawTextureNPatch")
    draw_texture_npatch :: proc(texture: Texture2D, npatch_info: NPatch_Info, dest: Rectangle, origin: Vector2, rotation: f32, tint: Color) ---


    /* Color/pixel related functions */


    // Get color with alpha applied, alpha goes from 0.0f to 1.0f
    @(link_name="Color")
    fade :: proc(color: Color, alpha: f32) -> Color ---

    // Get hexadecimal value for a Color
    @(link_name="ColorToInt")
    color_to_int :: proc(color: Color) -> i32 ---

    // Get Color normalized as float [0..1]
    @(link_name="ColorNormalize")
    color_normalize :: proc(color: Color) -> Vector4 ---

    // Get Color from normalized values [0..1]
    @(link_name="ColorFromNormalized")
    color_from_normalized :: proc(normalized: Vector4) -> Color ---

    // Get HSV values for a Color, hue [0..360], saturation/value [0..1]
    @(link_name="ColorToHSV")
    color_to_hsv :: proc(color: Color) -> Vector3 ---

    // Get a Color from HSV values, hue [0..360], saturation/value [0..1]
    @(link_name="ColorFromHSV")
    color_from_hsv :: proc(hue, saturation, value: f32) -> Color ---

    // Get color multiplied with another color
    @(link_name="ColorTint")
    color_tint :: proc(color: Color, tint: Color) -> Color ---

    // Get color with brightness correction, brightness factor goes from -1.0f to 1.0f
    @(link_name="ColorBrightness")
    color_brightness :: proc(color: Color, factor: f32) -> Color ---

    // Get color with contrast correction, contrast values between -1.0f and 1.0f
    @(link_name="ColorContrast")
    color_contrast :: proc(color: Color, contrast: f32) -> Color ---

    // Get color with alpha applied, alpha goes from 0.0f to 1.0f
    @(link_name="ColorAlpha")
    color_alpha :: proc(color: Color, alpha: f32) -> Color ---

    // Get src alpha-blended into dst color with tint
    @(link_name="ColorAlphaBlend")
    color_alpha_blend :: proc(dst, src: Color, tint: Color) -> Color ---

    // Get Color structure from hexadecimal value
    @(link_name="GetColor")
    get_color :: proc(hex_value: u32) -> Color ---

    // Get Color from a source pixel pointer of certain format
    @(link_name="GetPixelColor")
    get_pixel_color :: proc(src_ptr: rawptr, format: Pixel_Format) -> Color ---

    // Set color formatted into destination pixel pointer
    @(link_name="SetPixelColor")
    set_pixel_color :: proc(dst_ptr: rawptr, color: Color, format: Pixel_Format) ---

    // Get pixel data size in bytes for certain format
    @(link_name="GetPixelDataSize")
    get_pixel_data_size :: proc(width, height: i32, format: Pixel_Format) -> i32 ---


    /* Font loading/unloading functions */

    
    // Get the default Font
    @(link_name="GetFontDefault")
    get_font_default :: proc() -> Font ---

    // Load font from file into GPU memory (VRAM)
    @(link_name="LoadFont")
    load_font :: proc(file_name: cstring) -> Font ---

    // Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set
    @(link_name="LoadFontEx")
    load_font_ex :: proc(file_name: cstring, font_size: i32, codepoints: [^]rune, codepoint_count: i32) -> Font ---

    // Load font from Image (XNA style)
    @(link_name="LoadFontFromImage")
    load_font_from_image :: proc(image: Image, key: Color, first_char: i32) -> Font ---

    // Load font from memory buffer, fileType refers to extension: i.e. '.ttf'
    @(link_name="LoadFontFromMemory")
    load_font_from_memory :: proc(file_type: cstring, file_data: [^]u8, data_size, font_size: i32, codepoints: [^]rune, codepoint_count: i32) -> Font ---

    // Check if a font is ready
    @(link_name="IsFontReady")
    is_font_ready :: proc(font: Font) -> bool ---

    // Load font data for further use
    @(link_name="LoadFontData")
    load_font_data :: proc(file_data: [^]u8, data_size, font_size: i32, codepoints: [^]rune, codepoint_count: i32, type: Font) -> [^]Glyph_Info ---

    // Generate image font atlas using chars info
    @(link_name="GenImageFontAtlas")
    gen_image_font_atlas :: proc(glyphs: [^]Glyph_Info, glyph_recs: ^[^]Rectangle, glyph_count, font_size, padding: i32, pack_method: i32) -> Image ---

    // Unload font chars info data (RAM)
    @(link_name="UnloadFontData")
    unload_font_data :: proc(glyphs: [^]Glyph_Info, glyph_count: i32) ---

    // Unload font from GPU memory (VRAM)
    @(link_name="UnloadFont")
    unload_font :: proc(font: Font) ---

    // Export font as code file, returns true on success
    @(link_name="ExportFontAsCode")
    export_font_as_code :: proc(font: Font, file_name: cstring) -> bool ---


    /* Text drawing functions */


    // Draw current FPS
    @(link_name="DrawFPS")
    draw_fps :: proc(pos_x, pos_y: i32) ---

    // Draw text (using default font)
    @(link_name="DrawText")
    draw_text :: proc(text: cstring, pos_x, pos_y, font_size: i32, color: Color) ---

    // Draw text using font and additional parameters
    @(link_name="DrawTextEx")
    draw_text_ex :: proc(font: Font, text: cstring, position: Vector2, font_size, spacing: f32, tint: Color) ---

    // Draw text using Font and pro parameters (rotation)
    @(link_name="DrawTextPro")
    draw_text_pro :: proc(font: Font, text: cstring, position, origin: Vector2, rotation, font_size, spacing: f32, tint: Color) ---

    // Draw one character (codepoint)
    @(link_name="DrawTextCodepoint")
    draw_text_codepoint :: proc(font: Font, codepoint: rune, position: Vector2, font_size: f32, tint: Color) ---

    // Draw multiple character (codepoint)
    @(link_name="DrawTextCodepoints")
    draw_text_codepoints :: proc(font: Font, codepoints: [^]rune, codepoint_count: i32, position: Vector2, font_size, spacing: f32, tint: Color) ---


    /* Text font info functions */


    // Set vertical line spacing when drawing with line-breaks
    @(link_name="SetTextLineSpacing")
    set_text_line_spacing :: proc(spacing: i32) ---

    // Measure string width for default font
    @(link_name="MeasureText")
    measure_text :: proc(text: cstring, font_size: i32)  -> i32 ---

    // Measure string size for Font
    @(link_name="MeasureTextEx")
    measure_text_ex :: proc(font: Font, text: cstring, font_size, spacing: f32)  -> Vector2 ---

    // Get glyph index position in font for a codepoint (unicode character), fallback to '?' if not found
    @(link_name="GetGlyphIndex")
    get_glyph_index :: proc(font: Font, codepoint: rune) -> i32 ---

    // Get glyph font info data for a codepoint (unicode character), fallback to '?' if not found
    @(link_name="GetGlyphInfo")
    get_glyph_info :: proc(font: Font, codepoint: rune) -> Glyph_Info ---

    // Get glyph rectangle in font atlas for a codepoint (unicode character), fallback to '?' if not found
    @(link_name="GetGlyphAtlasRec")
    get_glyph_atlas_rec :: proc(font: Font, codepoint: rune) -> Rectangle ---


    /* Text codepoints management functions (unicode characters) */


    // Load UTF-8 text encoded from codepoints array
    @(link_name="LoadUTF8")
    load_utf8 :: proc(codepoints: [^]rune, length: i32) -> [^]u8 ---

    // Unload UTF-8 text encoded from codepoints array
    @(link_name="UnloadUTF8")
    unload_utf8 :: proc(text: cstring) ---

    // Load all codepoints from a UTF-8 text string, codepoints count returned by parameter
    @(link_name="LoadCodepoints")
    load_codepoints :: proc(text: cstring, count: ^i32) -> i32 ---

    // Unload codepoints data from memory
    @(link_name="UnloadCodepoints")
    unload_codepoints :: proc(codepoints: [^]rune) ---

    // Get total number of codepoints in a UTF-8 encoded string
    @(link_name="GetCodepointCount")
    get_codepoint_count :: proc(text: cstring) -> i32 ---

    // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
    @(link_name="GetCodepoint")
    get_codepoint :: proc(text: cstring, codepoint_size: ^i32) -> i32 ---

    // Get next codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
    @(link_name="GetCodepointNext")
    get_codepoint_next :: proc(text: cstring, codepoint_size: ^i32) -> i32 ---

    // Get previous codepoint in a UTF-8 encoded string, 0x3f('?') is returned on failure
    @(link_name="GetCodepointPrevious")
    get_codepoint_previous :: proc(text: cstring, codepoint_size: ^i32) -> i32 ---

    // Encode one codepoint into UTF-8 byte array (array length returned as parameter)
    @(link_name="CodepointToUTF8")
    codepoint_to_utf8 :: proc(codepoint: rune, utf8_size: ^i32) -> cstring ---


    /* Text strings management functions (no UTF-8 strings, only byte chars) */
    // NOTE: Some strings allocate memory internally for returned strings, just be careful!


    // Copy one string to another, returns bytes copied
    @(link_name="TextCopy")
    text_copy :: proc(dst, src: cstring) ---

    // Check if two text string are equal
    @(link_name="TextIsEqual")
    text_is_equal :: proc(text1: cstring, text2: cstring) ---

    // Get text length, checks for '\0' ending
    @(link_name="TextLength")
    text_length :: proc(text: cstring) -> u32 ---

    // Text formatting with variables (sprintf() style)
    @(link_name="TextFormat")
    text_format :: proc(text: cstring, #c_vararg args: ..any)  -> cstring ---

    // Get a piece of a text string
    @(link_name="TextSubtext")
    text_subtext :: proc(text: cstring, position, length: i32) -> cstring ---

    // Replace text string (WARNING: memory must be freed!)
    @(link_name="TextReplace")
    text_replace :: proc(text, replace, by: cstring) -> cstring ---

    // Insert text in a position (WARNING: memory must be freed!)
    @(link_name="TextInsert")
    text_insert :: proc(text, insert: cstring, position: i32) -> cstring ---

    // Join text strings with delimiter
    @(link_name="TextJoin")
    text_join :: proc(text_list: [^]cstring, count: i32, delimiter: cstring) -> cstring ---

    // Split text into multiple strings
    @(link_name="TextSplit")
    text_split :: proc(text: cstring, delimiter: u8, count: ^i32)  -> [^]cstring ---

    // Append text at specific position and move cursor!
    @(link_name="TextAppend")
    text_append :: proc(text, append: cstring, position: i32) ---

    // Find first text occurrence within a string
    @(link_name="TextFindIndex")
    text_find_index :: proc(text, find: cstring) -> i32 ---

    // Get upper case version of provided string
    @(link_name="TextToUpper")
    text_to_upper :: proc(text: cstring) -> cstring ---

    // Get lower case version of provided string
    @(link_name="TextToLower")
    text_to_lower :: proc(text: cstring) -> cstring ---

    // Get Pascal case notation version of provided string
    @(link_name="TextToPascal")
    text_to_pascal :: proc(text: cstring) -> cstring ---

    // Get integer value from text (negative values not supported)
    @(link_name="TextToInteger")
    text_to_integer :: proc(text: cstring) -> i32 ---


    /* Basic geometric 3D shapes drawing functions */


    // Draw a line in 3D world space
    @(link_name="DrawLine3D")
    draw_line_3d :: proc(start_pos, end_pos: Vector3, color: Color) ---
    
    // Draw a point in 3D space, actually a small line
    @(link_name="DrawPoint3D")
    draw_point_3d :: proc(position: Vector3, color: Color) ---
    
    // Draw a circle in 3D world space
    @(link_name="DrawCircle3D")
    draw_circle_3d :: proc(center: Vector3, radius: f32, rotation_axis: Vector3, rotation_angle: f32, color: Color) ---
    
    // Draw a color-filled triangle (vertex in counter-clockwise order!)
    @(link_name="DrawTriangle3D")
    draw_triangle_3d :: proc(v1, v2, v3: Vector3, color: Color) ---
    
    // Draw a triangle strip defined by points
    @(link_name="DrawTriangleStrip3D")
    draw_triangle_strip_3d :: proc(points: [^]Vector3, point_count: i32, color: Color) ---
    
    // Draw cube
    @(link_name="DrawCube")
    draw_cube :: proc(position: Vector3, width, height, length: f32, color: Color) ---
    
    // Draw cube (Vector version)
    @(link_name="DrawCubeV")
    draw_cube_v :: proc(position: Vector3, size: Vector3, color: Color) ---
    
    // Draw cube wires
    @(link_name="DrawCubeWires")
    draw_cube_wires :: proc(position: Vector3, width, height, length: f32, color: Color) ---
    
    // Draw cube wires (Vector version)
    @(link_name="DrawCubeWiresV")
    draw_cube_wires_v :: proc(position: Vector3, size: Vector3, color: Color) ---
    
    // Draw sphere
    @(link_name="DrawSphere")
    draw_sphere :: proc(center_pos: Vector3, radius: f32, color: Color) ---
    
    // Draw sphere with extended parameters
    @(link_name="DrawSphereEx")
    draw_sphere_ex :: proc(center_pos: Vector3, radius: f32, rings, slices: i32, color: Color) ---
    
    // Draw sphere wires
    @(link_name="DrawSphereWires")
    draw_sphere_wires :: proc(center_pos: Vector3, radius: f32, rings, slices: i32, color: Color) ---
    
    // Draw a cylinder/cone
    @(link_name="DrawCylinder")
    draw_cylinder :: proc(position: Vector3, radius_top, radius_bottom, height: f32, slices: i32, color: Color) ---
    
    // Draw a cylinder with base at startPos and top at endPos
    @(link_name="DrawCylinderEx")
    draw_cylinder_ex :: proc(start_pos: Vector3, end_pos: Vector3, start_radius, end_radius: f32, sides: i32, color: Color) ---
    
    // Draw a cylinder/cone wires
    @(link_name="DrawCylinderWires")
    draw_cylinder_wires :: proc(position: Vector3, radius_top, radius_bottom, height: f32, slices: i32, color: Color) ---
    
    // Draw a cylinder wires with base at startPos and top at endPos
    @(link_name="DrawCylinderWiresEx")
    draw_cylinder_wires_ex :: proc(start_pos: Vector3, end_pos: Vector3, start_radius, end_radius: f32, sides: i32, color: Color) ---
    
    // Draw a capsule with the center of its sphere caps at startPos and endPos
    @(link_name="DrawCapsule")
    draw_capsule :: proc(start_pos: Vector3, end_pos: Vector3, radius: f32, slices, rings: i32, color: Color) ---
    
    // Draw capsule wireframe with the center of its sphere caps at startPos and endPos
    @(link_name="DrawCapsuleWires")
    draw_capsule_wires :: proc(start_pos: Vector3, end_pos: Vector3, radius: f32, slices, rings: i32, color: Color) ---
    
    // Draw a plane XZ
    @(link_name="DrawPlane")
    draw_plane :: proc(center_pos: Vector3, size: Vector2, color: Color) ---
    
    // Draw a ray line
    @(link_name="DrawRay")
    draw_ray :: proc(ray: Ray, color: Color) ---
    
    // Draw a grid (centered at (0, 0, 0))
    @(link_name="DrawGrid")
    draw_grid :: proc(slices: i32, spacing: f32) ---


    /* Model management functions */


    // Load model from files (meshes and materials)
    @(link_name="LoadModel")
    load_model :: proc(file_name: cstring) -> Model ---
    
    // Load model from generated mesh (default material)
    @(link_name="LoadModelFromMesh")
    load_model_from_mesh :: proc(mesh: Mesh) -> Model ---
    
    // Check if a model is ready
    @(link_name="IsModelReady")
    is_model_ready :: proc(model: Model) -> bool ---
    
    // Unload model (including meshes) from memory (RAM and/or VRAM)
    @(link_name="UnloadModel")
    unload_model :: proc(model: Model) ---
    
    // Compute model bounding box limits (considers all meshes)
    @(link_name="GetModelBoundingBox")
    get_model_bounding_box :: proc (model: Model) -> Bounding_Box ---


    /* Model drawing functions */


    // Draw a model (with texture if set)
    @(link_name="DrawModel")
    draw_model :: proc(model: Model, position: Vector3, scale: f32, tint: Color) ---

    // Draw a model with extended parameters
    @(link_name="DrawModelEx")
    draw_model_ex :: proc(model: Model, position, rotation_axis: Vector3, rotation_angle: f32, scale: Vector3, tint: Color) ---

    // Draw a model wires (with texture if set)
    @(link_name="DrawModelWires")
    draw_model_wires :: proc(model: Model, position: Vector3, scale: f32, tint: Color) ---

    // Draw a model wires (with texture if set) with extended parameters
    @(link_name="DrawModelWiresEx")
    draw_model_wires_ex :: proc(model: Model, position, rotation_axis: Vector3, rotation_angle: f32, scale: Vector3, tint: Color) ---

    // Draw bounding box (wires)
    @(link_name="DrawBoundingBox")
    draw_bounding_box :: proc(box: Bounding_Box, color: Color) ---

    // Draw a billboard texture
    @(link_name="DrawBillboard")
    draw_billboard :: proc(camera: Camera, texture: Texture2D, position: Vector3, size: f32, tint: Color) ---

    // Draw a billboard texture defined by source
    @(link_name="DrawBillboardRec")
    draw_billboard_rec :: proc(camera: Camera, texture: Texture2D, source: Rectangle, position: Vector3, size: Vector2, tint: Color) ---

    // Draw a billboard texture defined by source and rotation
    @(link_name="DrawBillboardPro")
    draw_billboard_pro :: proc(camera: Camera, texture: Texture2D, source: Rectangle, position, up: Vector3, size, origin: Vector2, rotation: f32, tint: Color) ---


    /* Mesh management functions */

    
    // Upload mesh vertex data in GPU and provide VAO/VBO ids
    @(link_name="UploadMesh")
    upload_mesh :: proc(mesh: ^Mesh, dynamic_: bool) ---

    // Update mesh vertex data in GPU for a specific buffer index
    @(link_name="UpdateMeshBuffer")
    update_mesh_buffer :: proc(mesh: Mesh, index: i32, data: rawptr, data_size, offset: i32) ---

    // Unload mesh data from CPU and GPU
    @(link_name="UnloadMesh")
    unload_mesh :: proc(mesh: Mesh) ---

    // Draw a 3d mesh with material and transform
    @(link_name="DrawMesh")
    draw_mesh :: proc(mesh: Mesh, material: Material, transform: Matrix) ---

    // Draw multiple mesh instances with material and different transforms
    @(link_name="DrawMeshInstanced")
    draw_mesh_instanced :: proc(mesh: Mesh, material: Material, transforms: [^]Matrix, instances: i32) ---

    // Export mesh data to file, returns true on success
    @(link_name="bool")
    export_mesh :: proc(mesh: Mesh, file_name: cstring) -> bool ---

    // Compute mesh bounding box limits
    @(link_name="BoundingBox")
    get_mesh_bounding_box :: proc(mesh: Mesh) -> Bounding_Box ---

    // Compute mesh tangents
    @(link_name="GenMeshTangents")
    gen_mesh_tangents :: proc(mesh: ^Mesh) ---


    /* Mesh generation functions */

    
    // Generate polygonal mesh
    gen_mesh_poly :: proc(sides: i32, radius: f32) -> Mesh ---

    // Generate plane mesh (with subdivisions)
    gen_mesh_plane :: proc(width, length: f32, res_x, res_z: i32) -> Mesh ---

    // Generate cuboid mesh
    gen_mesh_cube :: proc(width, height, length: f32) -> Mesh ---

    // Generate sphere mesh (standard sphere)
    gen_mesh_sphere :: proc(radius: i32, rings, slices: i32) -> Mesh ---

    // Generate half-sphere mesh (no bottom cap)
    gen_mesh_hemi_sphere :: proc(radius: f32, rings, slices: i32) -> Mesh ---

    // Generate cylinder mesh
    gen_mesh_cylinder :: proc(radius, height: f32, slices: i32) -> Mesh ---

    // Generate cone/pyramid mesh
    gen_mesh_cone :: proc(radius, height: f32, slices: i32) -> Mesh ---

    // Generate torus mesh
    gen_mesh_torus :: proc(radius, size: f32, rad_seg, sides: i32) -> Mesh ---

    // Generate trefoil knot mesh
    gen_mesh_knot :: proc(radius, size: f32, rad_seg, sides: i32) -> Mesh ---

    // Generate heightmap mesh from image data
    gen_mesh_heightmap :: proc(heightmap: Image, size: Vector3) -> Mesh ---

    // Generate cubes-based map mesh from image data
    gen_mesh_cubicmap :: proc(cubicmap: Image, cube_size: Vector3) -> Mesh ---


    /* Material loading/unloading functions */

    
    // Load materials from model file
    @(link_name="LoadMaterials")
    load_materials :: proc(file_name: cstring, material_count: ^i32) -> [^]Material ---

    // Load default material (Supports: DIFFUSE, SPECULAR, NORMAL maps)
    @(link_name="LoadMaterialDefault")
    load_material_default :: proc() -> Material ---

    // Check if a material is ready
    @(link_name="IsMaterialReady")
    is_material_ready :: proc(material: Material) -> bool ---

    // Unload material from GPU memory (VRAM)
    @(link_name="UnloadMaterial")
    unload_material :: proc(material: Material) ---

    // Set texture for a material map type (MATERIAL_MAP_DIFFUSE, MATERIAL_MAP_SPECULAR...)
    @(link_name="SetMaterialTexture")
    set_material_texture :: proc(material: ^Material, map_type: i32, texture: Texture2D) ---

    // Set material for a mesh
    @(link_name="SetModelMeshMaterial")
    set_model_mesh_material :: proc(model: ^Model, mesh_id, material_id: i32) ---


    /* Model animations loading/unloading functions */


    // Load model animations from file
    @(link_name="LoadModelAnimations")
    load_model_animations :: proc(file_name: cstring, anim_count: ^i32) -> [^]Model_Animation ---

    // Update model animation pose
    @(link_name="UpdateModelAnimation")
    update_model_animation :: proc(model: Model, anim: Model_Animation, frame: i32) ---

    // Unload animation data
    @(link_name="UnloadModelAnimation")
    unload_model_animation :: proc(anim: Model_Animation) ---

    // Unload animation array data
    @(link_name="UnloadModelAnimations")
    unload_model_animations :: proc(animations: [^]Model_Animation, anim_count: i32) ---

    // Check model animation skeleton match
    @(link_name="IsModelAnimationValid")
    is_model_animation_valid :: proc(model: Model, anim: Model_Animation) -> bool ---


    /* Collision detection functions */


    // Check collision between two spheres
    @(link_name="CheckCollisionSpheres")
    check_collision_spheres :: proc(center1: Vector3, radius1: f32, center2: Vector3, radius2: f32) -> bool ---

    // Check collision between two bounding boxes
    @(link_name="CheckCollisionBoxes")
    check_collision_boxes :: proc(box1, box2: Bounding_Box) -> bool ---

    // Check collision between box and sphere
    @(link_name="CheckCollisionBoxSphere")
    check_collision_box_sphere :: proc(box: Bounding_Box, center: Vector3, radius: f32) -> bool ---

    // Get collision info between ray and sphere
    @(link_name="GetRayCollisionSphere")
    get_ray_collision_sphere :: proc(ray: Ray, center: Vector3, radius: f32) -> Ray_Collision ---

    // Get collision info between ray and box
    @(link_name="GetRayCollisionBox")
    get_ray_collision_box :: proc(ray: Ray, box: Bounding_Box) -> Ray_Collision ---

    // Get collision info between ray and mesh
    @(link_name="GetRayCollisionMesh")
    get_ray_collision_mesh :: proc(ray: Ray, mesh: Mesh, transform: Matrix) -> Ray_Collision ---

    // Get collision info between ray and triangle
    @(link_name="GetRayCollisionTriangle")
    get_ray_collision_triangle :: proc(ray: Ray, p1, p2, p3: Vector3) -> Ray_Collision ---

    // Get collision info between ray and quad
    @(link_name="GetRayCollisionQuad")
    get_ray_collision_quad :: proc(ray: Ray, p1, p2, p3, p4: Vector3) -> Ray_Collision ---

    
    /* Audio device management functions */


    // Initialize audio device and context
    @(link_name="InitAudioDevice")
    init_audio_device :: proc() ---

    // Close the audio device and context
    @(link_name="CloseAudioDevice")
    close_audio_device :: proc() ---

    // Check if audio device has been initialized successfully
    @(link_name="IsAudioDeviceReady")
    is_audio_device_ready :: proc() -> bool ---

    // Set master volume (listener)
    @(link_name="SetMasterVolume")
    set_master_volume :: proc(volume: f32) ---

    // Get master volume (listener)
    @(link_name="GetMasterVolume")
    get_master_volume :: proc() -> f32 ---


    /* Wave/Sound loading/unloading functions */


    // Load wave data from file
    @(link_name="LoadWave")
    LoadWave :: proc(file_name: cstring) -> Wave ---

    // Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
    @(link_name="LoadWaveFromMemory")
    LoadWaveFromMemory :: proc(file_type: cstring, file_data: [^]u8, data_size: i32) -> Wave ---

    // Checks if wave data is ready
    @(link_name="IsWaveReady")
    is_wave_ready :: proc(wave: Wave) -> bool ---

    // Load sound from file
    @(link_name="LoadSound")
    load_sound :: proc(file_name: cstring) -> Sound ---

    // Load sound from wave data
    @(link_name="LoadSoundFromWave")
    load_sound_from_wave :: proc(wave: Wave) -> Sound ---

    // Create a new sound that shares the same sample data as the source sound, does not own the sound data
    @(link_name="LoadSoundAlias")
    load_sound_alias :: proc(source: Sound) -> Sound ---

    // Checks if a sound is ready
    @(link_name="IsSoundReady")
    is_sound_ready :: proc(sound: Sound) -> bool ---

    // Update sound buffer with new data
    @(link_name="UpdateSound")
    update_sound :: proc(sound: Sound, data: rawptr, sample_count: i32) ---

    // Unload wave data
    @(link_name="UnloadWave")
    unload_wave :: proc(wave: Wave) ---

    // Unload sound
    @(link_name="UnloadSound")
    unload_sound :: proc(sound: Sound) ---

    // Unload a sound alias (does not deallocate sample data)
    @(link_name="UnloadSoundAlias")
    unload_sound_alias :: proc(alias: Sound) ---

    // Export wave data to file, returns true on success
    @(link_name="ExportWave")
    export_wave :: proc(wave: Wave, file_name: cstring) -> bool ---

    // Export wave sample data to code (.h), returns true on success
    @(link_name="ExportWaveAsCode")
    export_wave_as_code :: proc(wave: Wave, file_name: cstring) -> bool ---

    /* Wave/Sound management functions */


    // Play a sound
    @(link_name="PlaySound")
    play_sound :: proc(sound: Sound) ---

    // Stop playing a sound
    @(link_name="StopSound")
    stop_sound :: proc(sound: Sound) ---

    // Pause a sound
    @(link_name="PauseSound")
    pause_sound :: proc(sound: Sound) ---

    // Resume a paused sound
    @(link_name="ResumeSound")
    resume_sound :: proc(sound: Sound) ---

    // Check if a sound is currently playing
    @(link_name="IsSoundPlaying")
    is_sound_playing :: proc(sound: Sound) -> bool ---

    // Set volume for a sound (1.0 is max level)
    @(link_name="SetSoundVolume")
    set_sound_volume :: proc(sound: Sound, volume: f32) ---

    // Set pitch for a sound (1.0 is base level)
    @(link_name="SetSoundPitch")
    set_sound_pitch :: proc(sound: Sound, pitch: f32) ---

    // Set pan for a sound (0.5 is center)
    @(link_name="SetSoundPan")
    set_sound_pan :: proc(sound: Sound, pan: f32) ---

    // Copy a wave to a new wave
    @(link_name="WaveCopy")
    wave_copy :: proc(wave: Wave) -> Wave ---

    // Crop a wave to defined samples range
    @(link_name="WaveCrop")
    wave_crop :: proc(wave: ^Wave, init_sample, final_sample: i32) ---

    // Convert wave data to desired format
    @(link_name="WaveFormat")
    wave_format :: proc(wave: ^Wave, sample_rate, sample_size, channels: i32) ---

    // Load samples data from wave as a 32bit float data array
    @(link_name="LoadWaveSamples")
    load_wave_samples :: proc(wave: Wave) -> [^]f32 ---

    // Unload samples data loaded with LoadWaveSamples()
    @(link_name="UnloadWaveSamples")
    unload_wave_samples :: proc(samples: [^]f32) ---


    /* Music management functions */


    // Load music stream from file
    @(link_name="LoadMusicStream")
    load_music_stream :: proc(file_name: cstring) -> Music ---

    // Load music stream from data
    @(link_name="LoadMusicStreamFromMemory")
    load_music_stream_from_memory :: proc(file_type: cstring, data: [^]u8, data_size: i32) -> Music --- 

    // Checks if a music stream is ready
    @(link_name="IsMusicReady")
    is_music_ready :: proc(music: Music) -> bool ---

    // Unload music stream
    @(link_name="UnloadMusicStream")
    unload_music_stream :: proc(music: Music) ---

    // Start music playing
    @(link_name="PlayMusicStream")
    play_music_stream :: proc(music: Music) ---

    // Check if music is playing
    @(link_name="IsMusicStreamPlaying")
    is_music_stream_playing :: proc(music: Music) -> bool ---

    // Updates buffers for music streaming
    @(link_name="UpdateMusicStream")
    update_music_stream :: proc(music: Music) ---

    // Stop music playing
    @(link_name="StopMusicStream")
    stop_music_stream :: proc(music: Music) ---

    // Pause music playing
    @(link_name="PauseMusicStream")
    pause_music_stream :: proc(music: Music) ---

    // Resume playing paused music
    @(link_name="ResumeMusicStream")
    resume_music_stream :: proc(music: Music) ---

    // Seek music to a position (in seconds)
    @(link_name="SeekMusicStream")
    seek_music_stream :: proc(music: Music, position: f32) ---

    // Set volume for music (1.0 is max level)
    @(link_name="SetMusicVolume")
    set_music_volume :: proc(music: Music, volume: f32) ---

    // Set pitch for a music (1.0 is base level)
    @(link_name="SetMusicPitch")
    set_music_pitch :: proc(music: Music, pitch: f32) ---

    // Set pan for a music (0.5 is center)
    @(link_name="Music")
    set_music_pan :: proc(music: Music, pan: f32) ---

    // Get music time length (in seconds)
    @(link_name="GetMusicTimeLength")
    get_music_time_length :: proc(music: Music) -> f32 ---

    // Get current music time played (in seconds)
    @(link_name="GetMusicTimePlayed")
    get_music_time_played :: proc(music: Music) -> f32 ---


    /* AudioStream management functions */


    // Load audio stream (to stream raw audio pcm data)
    @(link_name="LoadAudioStream")
    load_audio_stream :: proc(sample_rate, sample_size, channels: u32) -> Audio_Stream ---

    // Checks if an audio stream is ready
    @(link_name="IsAudioStreamReady")
    IsAudioStreamReady :: proc(stream: Audio_Stream) -> bool ---

    // Unload audio stream and free memory
    @(link_name="UnloadAudioStream")
    UnloadAudioStream :: proc(stream: Audio_Stream) ---

    // Update audio stream buffers with data
    @(link_name="UpdateAudioStream")
    update_audio_stream :: proc(stream: Audio_Stream, data: rawptr, frame_count: i32) ---

    // Check if any audio stream buffers requires refill
    @(link_name="IsAudioStreamProcessed")
    is_audio_stream_processed :: proc(stream: Audio_Stream) -> bool ---

    // Play audio stream
    @(link_name="PlayAudioStream")
    play_audio_stream :: proc(stream: Audio_Stream) ---

    // Pause audio stream
    @(link_name="PauseAudioStream")
    pause_audio_stream :: proc(stream: Audio_Stream) ---

    // Resume audio stream
    @(link_name="ResumeAudioStream")
    resume_audio_stream :: proc(stream: Audio_Stream) ---

    // Check if audio stream is playing
    @(link_name="IsAudioStreamPlaying")
    is_audio_stream_playing :: proc(stream: Audio_Stream) -> bool ---

    // Stop audio stream
    @(link_name="StopAudioStream")
    stop_audio_stream :: proc(stream: Audio_Stream) ---

    // Set volume for audio stream (1.0 is max level)
    @(link_name="SetAudioStreamVolume")
    set_audio_stream_volume :: proc(stream: Audio_Stream, volume: f32) ---

    // Set pitch for audio stream (1.0 is base level)
    @(link_name="SetAudioStreamPitch")
    set_audio_stream_pitch :: proc(stream: Audio_Stream, pitch: f32) ---

    // Set pan for audio stream (0.5 is centered)
    @(link_name="SetAudioStreamPan")
    set_audio_stream_pan :: proc(stream: Audio_Stream, pan: f32) ---

    // Default size for new audio streams
    @(link_name="SetAudioStreamBufferSizeDefault")
    set_audio_stream_buffer_size_default :: proc(size: i32) ---

    // Audio thread callback to request new data
    @(link_name="SetAudioStreamCallback")
    set_audio_stream_callback :: proc(stream: Audio_Stream, callback: Audio_Callback) ---


    // Attach audio stream processor to stream, receives the samples as <float>s
    @(link_name="AttachAudioStreamProcessor")
    attach_audio_stream_processor :: proc(stream: Audio_Stream, processor: Audio_Callback) ---

    // Detach audio stream processor from stream
    @(link_name="DetachAudioStreamProcessor")
    detach_audio_stream_processor :: proc(stream: Audio_Stream, processor: Audio_Callback) ---


    // Attach audio stream processor to the entire audio pipeline, receives the samples as <float>s
    @(link_name="AttachAudioMixedProcessor")
    attach_audio_mixed_processor :: proc(processor: Audio_Callback) ---

    // Detach audio stream processor from the entire audio pipeline
    @(link_name="DetachAudioMixedProcessor")
    detach_audio_mixed_processor :: proc(processor: Audio_Callback) ---

}