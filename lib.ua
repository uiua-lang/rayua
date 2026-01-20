# Experimental!
GetLibraryPath ← memo(
  {os arch}
  $"bin/raylib_" ⍣(
    "_win32.dll" °{"windows" "x86"}
  | "_win64.dll" °{"windows" "x86_64"}
  | ⍩(⍤"Unsupported architecture."0) ◌ °{"windows" ∘}
  | ".dylib" °{"macos" "aarch64"}
  | ".so"
  )
  {"." ThisFileDir ∘}
  /($"___" ⊙pathsep)
)

Rl             ← &ffi ⊂□GetLibraryPath
LibraryVersion ← "5.5"

# Utils

Types! ↚^ $"⊓(_)" /$"_|_" ⍚(⍥$"⍜°_∘"⊸(˜∊1±)) ⊙◌

# Structs

~Window {Width Height Title}
~Image {Data Width Height Mipmaps Format}
~Texture {Id Width Height Mipmaps Format}
~RenderTexture {Id Texture Depth}
~Vector₃ [X Y Z]
~Vector₂ [X Y]
~Rectangle [X Y Width Height]
~Font {BaseSize GlyphCount GlyphPadding Texture Recs Glyphs}
~Wave {FrameCount SampleRate SampleSize Channels Data}
~AudioStream {Buffer Processor SampleRate SampleSize Channels}
~Sound {AudioStream FrameCount}
~CameraThreeD {Position Target Up FovY Projection}
~Mesh {VertexCount TriangleCount Vertices TexCoords TexCoords₂ Normals Tangents Colors Indices AnimVertices AnimNormals BoneIds BoneWeights BoneMatrices BoneCount VaoId VboId}
~Model {TransformMatrix MeshCount MaterialCount Meshes Materials MeshMaterial BoneCount Bones BindPose}
~Shader {Id Locs}
~MaterialMap {Texture Color Value}
~Material {Shader Maps Params}

# FFI Structs

FFIVector₃       ← "float[3]"
FFIVector₂       ← "float[2]"
FFIColor         ← "uchar[4]"
FFIImage         ← "{uchar*; int; int; int; int}"
FFITexture       ← "{uint; int; int; int; int}"
FFIRenderTexture ← ˙$"{uint; _; _}" FFITexture
FFIRectangle     ← "float[4]"
FFIFont          ← $"{int; int; int; _; void*; void*}" FFITexture
FFIWave          ← "{uint; uint; uint; uint; uchar*}"
FFIAudioStream   ← "{void*; void*; uint; uint; uint}"
FFISound         ← $"{_; uint}" FFIAudioStream
FFICameraThreeD  ← ˙$"{_; _; _; float; int}" FFIVector₃
FFIMesh          ← "{int; int; float*; float*; float*; float*; float*; uchar*; ushort*; void*; void*; void*; void*; void*; int; uint; void*}"
FFIMatrix        ← "float[16]"
FFIShader        ← "{uint; int*}"
FFIMaterialMap   ← $"{_; _; float}" FFITexture FFIColor
FFIMaterial      ← $"{_; _*; float[4]}" FFIShader FFIMaterialMap
FFIModel         ← $"{_; int; int; _*; _*; int*; int; void*; void*}" FFIMatrix FFIMesh FFIMaterial

┌─╴Color
  ~ [R G B A]

  LightGray  ← $LightGray New 200 200 200 255
  Gray       ← $Gray New 130 130 130 255
  DarkGray   ← $DarkGray New 80 80 80 255
  Yellow     ← $Yellow New 253 249 0 255
  Gold       ← $Gold New 255 203 0 255
  Orange     ← $Orange New 255 161 0 255
  Pink       ← $Pink New 255 109 194 255
  Red        ← $Red New 230 41 55 255
  Maroon     ← $Maroon New 190 33 55 255
  Green      ← $Green New 0 228 48 255
  Lime       ← $Lime New 0 158 47 255
  DarkGreen  ← $DarkGreen New 0 117 44 255
  SkyBlue    ← $SkyBlue New 102 191 255 255
  Blue       ← $Blue New 0 121 241 255
  DarkBlue   ← $DarkBlue New 0 82 172 255
  Purple     ← $Purple New 200 122 255 255
  Violet     ← $Violet New 135 60 190 255
  DarkPurple ← $DarkPurple New 112 31 126 255
  Beige      ← $Beige New 211 176 131 255
  Brown      ← $Brown New 127 106 79 255
  DarkBrown  ← $DarkBrown New 76 63 47 255
  White      ← $White New 255 255 255 255
  Black      ← $Black New 0 0 0 255
  Blank      ← $Blank New 0 0 0 0
  Magenta    ← $Magenta New 255 0 255 255
  RayWhite   ← $RayWhite New 245 245 245 255
└─╴

┌─╴MouseButton
  Left    ← 0
  Right   ← 1
  Middle  ← 2
  Side    ← 3
  Extra   ← 4
  Forward ← 5
  Back    ← 6
└─╴

┌─╴Key
  Escape       ← 256
  Enter        ← 257
  Tab          ← 258
  Backspace    ← 259
  Insert       ← 260
  Delete       ← 261
  Right        ← 262
  Left         ← 263
  Down         ← 264
  Up           ← 265
  PageUp       ← 266
  PageDown     ← 267
  Home         ← 268
  End          ← 269
  CapsLock     ← 280
  ScrollLock   ← 281
  NumLock      ← 282
  PrintScreen  ← 283
  Pause        ← 284
  F₁           ← 290
  F₂           ← 291
  F₃           ← 292
  F₄           ← 293
  F₅           ← 294
  F₆           ← 295
  F₇           ← 296
  F₈           ← 297
  F₉           ← 298
  F₁₀          ← 299
  F₁₁          ← 300
  F₁₂          ← 301
  LeftShift    ← 340
  LeftControl  ← 341
  LeftAlt      ← 342
  LeftSuper    ← 343
  RightShift   ← 344
  RightControl ← 345
  RightAlt     ← 346
  RightSuper   ← 347
  Menu         ← 348

  Kp₀        ← 320
  Kp₁        ← 321
  Kp₂        ← 322
  Kp₃        ← 323
  Kp₄        ← 324
  Kp₅        ← 325
  Kp₆        ← 326
  Kp₇        ← 327
  Kp₈        ← 328
  Kp₉        ← 329
  KpDecimal  ← 330
  KpDivide   ← 331
  KpMultiply ← 332
  KpSubtract ← 333
  KpAdd      ← 334
  KpEnter    ← 335
  KpEqual    ← 336
└─╴

┌─╴GamepadButton
  Unknown        ← 0
  LeftFaceUp     ← 1
  LeftFaceRight  ← 2
  LeftFaceDown   ← 3
  LeftFaceLeft   ← 4
  RightFaceUp    ← 5
  RightFaceRight ← 6
  RightFaceDown  ← 7
  RightFaceLeft  ← 8
  LeftTrigger₁   ← 9
  LeftTrigger₂   ← 10
  RightTrigger₁  ← 11
  RightTrigger₂  ← 12
  MiddleLeft     ← 13
  Middle         ← 14
  MiddleRight    ← 15
  LeftThumb      ← 16
  RightThumb     ← 17
└─╴

┌─╴GamepadAxis
  LeftX        ← 0
  LeftY        ← 1
  RightX       ← 2
  RightY       ← 3
  LeftTrigger  ← 4
  RightTrigger ← 5
└─╴

┌─╴ConfigFlags
  VSyncHint              ← 64    # 0x00000040
  FullscreenMode         ← 2     # 0x00000002
  WindowResizable        ← 4     # 0x00000004
  WindowUndecorated      ← 8     # 0x00000008
  WindowHidden           ← 128   # 0x00000080
  WindowMinimized        ← 512   # 0x00000200
  WindowMaximized        ← 1024  # 0x00000400
  WindowUnfocused        ← 2048  # 0x00000800
  WindowTopmost          ← 4096  # 0x00001000
  WindowAlwaysRun        ← 256   # 0x00000100
  WindowTransparent      ← 16    # 0x00000010
  WindowHighDPI          ← 8192  # 0x00002000
  WindowMousePassthrough ← 16384 # 0x00004000
  BorderlessWindowedMode ← 32768 # 0x00008000
  MSAAHint₄              ← 32    # 0x00000020
  InterlacedHint         ← 65536 # 0x00010000
└─╴

┌─╴TraceLogLevel
  All     ← 0
  Trace   ← 1
  Debug   ← 2
  Info    ← 3
  Warning ← 4
  Error   ← 5
  Fatal   ← 6
  None    ← 7
└─╴

┌─╴CameraMode
  Custom      ← 0
  Free        ← 1
  Orbital     ← 2
  FirstPerson ← 3
  ThirdPerson ← 4
└─╴

┌─╴CameraProjection
  Perspective  ← 0
  Orthographic ← 1
└─╴

# Core Module

# Initialize window and OpenGL context.
# This should be called before any other Raylib functions.
# ? WindowWidth WindowHeight WindowTitle
InitWindow ← ◌Rl {"void" "InitWindow" "int" "int" "char*"} Window

# Set the current threshold (minimum) log level
# ? LogLevel
SetTraceLogLevel ← ◌ Rl {"void" "SetTraceLogLevel" "int"} □₁

# Set the target FPS (maximum).
# ? TargetFPS
SetTargetFPS ← ◌Rl {"void" "SetTargetFPS" "int"} {∘}

# Get time in seconds for last frame drawn (delta time)
# FrameTime ?
GetFrameTime ← (Rl {"float" "GetFrameTime"} {})

# Get elapsed time in seconds since InitWindow
# ElapsedTime ?
GetTime ← (Rl {"double" "GetTime"} {})

# Get current FPS
# FPS ?
GetFPS ← (Rl {"int" "GetFPS"} {})

# Check if application should close (KEY_ESCAPE pressed or windows close icon clicked)
# Boolean ?
WindowShouldClose ← (Rl {"int" "WindowShouldClose"} {})

# Check if window has been initialized successfully
# Boolean ?
IsWindowReady ← (Rl {"bool" "IsWindowReady"} {})

# Check if window is currently fullscreen
# Boolean ?
IsWindowFullscreen ← (Rl {"bool" "IsWindowFullscreen"} {})

# Check if window is currently hidden
# Boolean ?
IsWindowHidden ← (Rl {"bool" "IsWindowHidden"} {})

# Check if window is currently minimized
# Boolean ?
IsWindowMinimized ← (Rl {"bool" "IsWindowMinimized"} {})

# Check if window is currently maximized
# Boolean ?
IsWindowMaximized ← (Rl {"bool" "IsWindowMaximized"} {})

# Check if window is currently focused
# Boolean ?
IsWindowFocused ← (Rl {"bool" "IsWindowFocused"} {})

# Check if window has been resized last frame
# Boolean ?
IsWindowResized ← (Rl {"bool" "IsWindowResized"} {})

# Check if one specific window flag is enabled
# Boolean ? Flag
IsWindowState ← (Rl {"bool" "IsWindowState" "uint"} {∘})

# Set window configuration state using flags
# ? Flags
SetWindowState ← (◌Rl {"void" "SetWindowState" "uint"} {∘})

# Clear window configuration state flags
# ? Flags
ClearWindowState ← (◌Rl {"void" "ClearWindowState" "uint"} {∘})

# Setup init configuration flags (view ConfigFlags)
# ? Flags
SetConfigFlags ← (◌Rl {"void" "SetConfigFlags" "uint"} {∘})

# Toggle window state: fullscreen/windowed, resizes monitor to match window resolution
ToggleFullscreen ← (◌ Rl {"void" "ToggleFullscreen"} {})

# Close window and unload OpenGL context.
CloseWindow ← (◌Rl {"void" "CloseWindow"} {})

# Get current screen width
# Width ?
GetScreenWidth ← (Rl {"int" "GetScreenWidth"} {})

# Get current screen height
# Height ?
GetScreenHeight ← (Rl {"int" "GetScreenHeight"} {})

# Get current render width (it considers HiDPI)
# Width ?
GetRenderWidth ← (Rl {"int" "GetRenderWidth"} {})

# Get current render height (it considers HiDPI)
# Height ?
GetRenderHeight ← (Rl {"int" "GetRenderHeight"} {})

# Get window scale DPI factor
# DPIScale ?
GetWindowScaleDPI ← (Types!Vector₂ Rl {FFIVector₂ "GetWindowScaleDPI"} {})

# Get current monitor where window is placed
# Monitor ?
GetCurrentMonitor ← (Rl {"int" "GetCurrentMonitor"} {})

# Get specified monitor width (current video mode used by monitor)
# Width ? Monitor
GetMonitorWidth ← (Rl {"int" "GetMonitorWidth" "int"} {∘})

# Get specified monitor height (current video mode used by monitor)
# Height ? Monitor
GetMonitorHeight ← (Rl {"int" "GetMonitorHeight" "int"} {∘})

# Set window dimensions
# ? WindowWidth WindowHeight
SetWindowSize ← (◌Rl {"void" "SetWindowSize" "int" "int"} {⊙∘})

# Set background color (framebuffer clear color)
# ? Color
ClearBackground ← ◌Rl {"void" "ClearBackground" FFIColor} {Types!(Color)}

# Setup canvas (framebuffer) to start drawing.
BeginDrawing ← (◌Rl {"void" "BeginDrawing"} {})

# End canvas drawing and swap buffers (double buffering).
EndDrawing ← (◌Rl {"void" "EndDrawing"} {})

# Begin 3D mode with custom camera (3D)
# ? Camera
BeginModeThreeD ← ◌ Rl {"void" "BeginMode3D" FFICameraThreeD} {Types!(CameraThreeD)}

# Ends 3D mode and returns to default 2D orthographic mode
EndModeThreeD ← (◌ Rl {"void" "EndMode3D"} {})

# Update camera position for selected mode
# Camera ? Camera Mode
UpdateCamera ← Types!(CameraThreeD) Rl {"void" "UpdateCamera" $"out _"FFICameraThreeD "int"} {Types!(CameraThreeD|∘)}

# Update camera movement/rotation
# Camera ? Camera Movement Rotation Zoom
UpdateCameraPro ← (
  {Types!(CameraThreeD|Vector₃|Vector₃|∘)}
  Types!(CameraThreeD) Rl {"void" "UpdateCameraPro" $"out _"FFICameraThreeD FFIVector₃ FFIVector₃ "float"}
)

# Check if a mouse button has been pressed once.
# Boolean ? MouseButton
IsMouseButtonPressed ← Rl {"bool" "IsMouseButtonPressed" "int"} {∘}

# Check if a mouse button is being pressed.
# Boolean ? MouseButton
IsMouseButtonDown ← Rl {"bool" "IsMouseButtonDown" "int"} {∘}

# Check if a mouse button has been released once.
# Boolean ? MouseButton
IsMouseButtonReleased ← Rl {"bool" "IsMouseButtonReleased" "int"} {∘}

# Check if a mouse button is NOT being pressed.
# Boolean ? MouseButton
IsMouseButtonUp ← Rl {"bool" "IsMouseButtonUp" "int"} {∘}

# Get the current mouse position.
# Vector2 ?
GetMousePosition ← (Types!Vector₂ (Rl {FFIVector₂ "GetMousePosition"} {}))

# Get mouse delta between frames.
# Vector2 ?
GetMouseDelta ← (Types!Vector₂ (Rl {FFIVector₂ "GetMouseDelta"} {}))

# Set mouse position.
# ? Vector2
SetMousePosition ← ◌Rl {"void" "SetMousePosition" "int" "int"} {°⊟⁅}

# Get mouse wheel movement for X or Y, whichever is larger
GetMouseWheelMove ← (Rl {"float" "GetMouseWheelMove"} {})

# Get mouse wheel movement for both X and Y
GetMouseWheelMoveV ← (Types!Vector₂ Rl {FFIVector₂ "GetMouseWheelMoveV"} {})

# Shows cursor.
ShowCursor ← (◌Rl {"void" "ShowCursor"} {})

# Hides cursor.
HideCursor ← (◌Rl {"void" "HideCursor"} {})

# Check if cursor is not visible
# Boolean ?
IsCursorHidden ← (Rl {"bool" "IsCursorHidden"} {})

# Check if cursor is on the screen
# Boolean ?
IsCursorOnScreen ← (Rl {"bool" "IsCursorOnScreen"} {})

# Enables cursor (unlock cursor)
EnableCursor ← (◌ Rl {"void" "EnableCursor"} {})

# Disables cursor (lock cursor)
DisableCursor ← (◌ Rl {"void" "DisableCursor"} {})

KeyCode ↚ ⍥(-@\0⌵)⊸type

# Check if a key has been pressed once.
# Boolean ? Char
IsKeyPressed ← Rl {"bool" "IsKeyPressed" "int"} {KeyCode}

# Check if a key has been pressed again.
# Boolean ? Char
IsKeyPressedRepeat ← Rl {"bool" "IsKeyPressedRepeat" "int"} {KeyCode}

# Check if a key is being pressed.
# Boolean ? Char
IsKeyDown ← Rl {"bool" "IsKeyDown" "int"} {KeyCode}

# Check if a key has been released once.
# Boolean ? Char
IsKeyReleased ← Rl {"bool" "IsKeyReleased" "int"} {KeyCode}

# Check if a key is NOT being pressed.
# Boolean ? Char
IsKeyUp ← Rl {"bool" "IsKeyUp" "int"} {KeyCode}

# Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty.
# Int ?
GetKeyPressed ← (Rl {"int" "GetKeyPressed"} {})

# Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty.
# Char ?
GetCharPressed ← (+@\0 Rl {"int" "GetCharPressed"} {})

# Set a custom key to exit program (default is ESC).
# ? Char
SetExitKey ← ◌Rl {"void" "SetExitKey" "int"} {KeyCode}

# Check if a gamepad is available
# IsAvailable ? Gamepad
IsGamepadAvailable ← Rl {"bool" "IsGamepadAvailable" "int"} □₁

# Get gamepad internal name id
# Name ? Gamepad
GetGamepadName ← Rl {"char*" "GetGamepadName" "int"} □₁

# Check if a gamepad button has been pressed once
# HasBeenPressed ? Gamepad Button
IsGamepadButtonPressed ← Rl {"bool" "IsGamepadButtonPressed" "int" "int"} □₂

# Check if a gamepad button is being pressed
# IsPressed ? Gamepad Button
IsGamepadButtonDown ← Rl {"bool" "IsGamepadButtonDown" "int" "int"} □₂

# Check if a gamepad button has been released once
# HasBeenReleased ? Gamepad Button
IsGamepadButtonReleased ← Rl {"bool" "IsGamepadButtonReleased" "int" "int"} □₂

# Check if a gamepad button is NOT being pressed
# IsReleased ? Gamepad Button
IsGamepadButtonUp ← Rl {"bool" "IsGamepadButtonUp" "int" "int"} □₂

# Get the last gamepad button pressed
# ButtonPressed ?
GetGamepadButtonPressed ← Rl {"int" "GetGamepadButtonPressed"} {}

# Get gamepad axis count for a gamepad
# NumAxes ? Gamepad
GetGamepadAxisCount ← Rl {"int" "GetGamepadAxisCount" "int"} □₁

# Get axis movement value for a gamepad axis
# AxisMovement ? Gamepad Axis
GetGamepadAxisMovement ← Rl {"float" "GetGamepadAxisMovement" "int" "int"} □₂

# Set internal gamepad mappings (SDL_GameControllerDB)
# Success ? SpecificationString
SetGamepadMappings ← Rl {"int" "SetGamepadMappings" "char*"} □₁

# Set gamepad vibration for both motors (duration in seconds)
# ? Gamepad LeftAmount RightAmount Duration
SetGamepadVibration ← ◌Rl {"void" "SetGamepadVibration" "int" "float" "float" "float"} □₄

# Shape Module

# Draw a pixel using geometry [Can be slow, use with care].
# ? Position Color
DrawPixel ← (
  {Types!(Vector₂|Color)}
  ◌Rl {"void" "DrawPixelV" FFIVector₂ FFIColor}
)

# Draw a line.
# ? VectorFrom VectorTo Color
DrawLine ← (
  {Types!(Vector₂|Vector₂|Color)}
  ◌Rl {"void" "DrawLineV" FFIVector₂ FFIVector₂ FFIColor}
)

# Draw a line with thickness.
# ? VectorFrom VectorTo Thickness Color
DrawLineEx ← (
  {Types!(Vector₂|Vector₂|∘|Color)}
  ◌Rl {"void" "DrawLineEx" FFIVector₂ FFIVector₂ "float" FFIColor}
)

# Draw a line strip.
# ? Vectors Color
DrawLineStrip ← (
  {Types!(≡Vector₂|Color)}
  ◌Rl {"void" "DrawLineStrip" $"_:1"FFIVector₂ "int" FFIColor}
)

# Draw line segment cubic-bezier in-out interpolation.
# ? StartPos EndPos Thickness Color
DrawLineBezier ← ◌Rl {"void" "DrawLineBezier" FFIVector₂ FFIVector₂ "float" FFIColor} {⊙⊙⊙∘}

# Draw a color-filled circle.
# ? Center Radius Color
DrawCircle ← ◌Rl {"void" "DrawCircleV" FFIVector₂ "float" FFIColor} {⊙⊙∘}

# Draw circle outline.
# ? Center Radius Color
DrawCircleLines ← ◌Rl {"void" "DrawCircleLinesV" FFIVector₂ "float" FFIColor} {⊙⊙∘}

# Draw a color-filled piece of a circle.
# ? Center Radius StartAngle EndAngle Segments Color
DrawCircleSector ← (
  {Types!(Vector₂|∘|∘|∘|⁅|Color)}
  ◌Rl {"void" "DrawCircleSector" FFIVector₂ "float" "float" "float" "int" FFIColor}
)

# Draw circle sector outline.
# ? Center Radius StartAngle EndAngle Segments Color
DrawCircleSectorLines ← (
  {Types!(Vector₂|∘|∘|∘|⁅|Color)}
  ◌Rl {"void" "DrawCircleSectorLines" FFIVector₂ "float" "float" "float" "int" FFIColor}
)

# Draw a color-filled ellipse.
# ? Center HorizontalRadius VerticalRadius Color
DrawEllipse ← (
  {Types!(°⊟⁅|∘|∘|Color)}
  ◌Rl {"void" "DrawEllipse" "int" "int" "float" "float" FFIColor}
)

# Draw ellipse outline.
# ? Center HorizontalRadius VerticalRadius Color
DrawEllipseLines ← (
  {Types!(°⊟⁅|∘|∘|Color)}
  ◌Rl {"void" "DrawEllipseLines" "int" "int" "float" "float" FFIColor}
)

# Draw a color-filled ring.
# ? Center InnerRadius OuterRadius StartAngle EndAngle Segments Color
DrawRing ← (
  {Types!(Vector₂|∘|∘|∘|∘|⁅|Color)}
  ◌Rl {"void" "DrawRing" FFIVector₂ "float" "float" "float" "float" "int" FFIColor}
)

# Draw ring outline.
# ? Center InnerRadius OuterRadius StartAngle EndAngle Segments FFIColor
DrawRingLines ← ◌Rl {"void" "DrawRingLines" FFIVector₂ "float" "float" "float" "float" "int" FFIColor} {⊙⊙⊙⊙⊙⊙∘}

# Draw a color-filled rectangle.
# ? Position Size Color
DrawRectangle ← ◌Rl {"void" "DrawRectangleV" FFIVector₂ FFIVector₂ FFIColor} {⊙⊙∘}

# Draw rectangle outline.
# ? Position Size Color
DrawRectangleLines ← ◌Rl {"void" "DrawRectangleLines" "int" "int" "int" "int" FFIColor} {∩°⊟⊓∩⁅∘}

# Draw a color-filled triangle.
# ? Point1 Point2 Point3 Color
DrawTriangle ← ◌Rl {"void" "DrawTriangle" FFIVector₂ FFIVector₂ FFIVector₂ FFIColor} {⊙⊙⊙∘}

# Draw a triangle outline.
# ? Point1 Point2 Point3 Color
DrawTriangleLines ← ◌Rl {"void" "DrawTriangleLines" FFIVector₂ FFIVector₂ FFIVector₂ FFIColor} {⊙⊙⊙∘}

# Draw a color-filled polygon with n sides.
# ? Center Sides Radius Rotation Color
DrawPoly ← ◌Rl {"void" "DrawPoly" FFIVector₂ "int" "float" "float" FFIColor} {⊙⊙⊙⊙∘}

# Draw a color-filled polygon outline with n sides.
# ? Center Sides Radius Rotation Color
DrawPolyLines ← ◌Rl {"void" "DrawPolyLines" FFIVector₂ "int" "float" "float" FFIColor} {⊙⊙⊙⊙∘}

# Get the default Font
GetFontDefault ← (Types!Font Rl {FFIFont "GetFontDefault"} {})

# Load font from file into GPU memory (VRAM)
LoadFont ← Types!Font Rl {FFIFont "LoadFont" "char*"} □₁

# Load font from file with extended parameters, use NULL for codepoints and 0 for codepointCount to load the default character set, font size is provided in pixels height
# ? FileName FontSize Codepoints
LoadFontEx ← Types!Font Rl {FFIFont "LoadFontEx" "char*" "int" "int:3" "int"} □₃

# Check if a font is valid (font data loaded, WARNING: GPU texture not checked)
IsFontValid ← Rl {"bool" "IsFontValid" FFIFont} {Types!Font}

# Unload font from GPU memory (VRAM)
UnloadFont ← ◌ Rl {"void" "UnloadFont" FFIFont} {Types!Font}

# Draw text using default font.
# ? Text Position Size Color
DrawText ← ◌ Rl {"void" "DrawText" "char*" "int" "int" "int" FFIColor} {⊓(∘|°⊟⁅|⊙∘)}

# Draw text using font and additional parameters
# ? Font Text Position FontSize Spacing Tint
DrawTextEx ← ◌ Rl {"void" "DrawTextEx" FFIFont "char*" FFIVector₂ "float" "float" FFIColor} {Types!(Font|∘|Vector₂|∘|∘|Color)}

# Measure string width for default font.
# Width ? Text Size
MeasureText ← Rl {"int" "MeasureText" "char*" "int"} {⊙∘}

# Measure string size for Font
# ? Font Text FontSize Spacing
MeasureTextEx ← Types!Vector₂ Rl {FFIVector₂ "MeasureTextEx" FFIFont "char*" "float" "float"} {Types!(Font|∘|∘|∘)}

# Draw text using the default font, centered around the given position.
# ? Text Position Size Color
DrawTextCentered ← DrawText ∪⌞∘-÷2⊟ ◡⊸∪MeasureText

# Models

# Draw cube
# ? Position Size Color
DrawCube ← ◌ Rl {"void" "DrawCubeV" FFIVector₃ FFIVector₃ FFIColor} {Types!(Vector₃|Vector₃|Color)}

# Draw cube wires
# ? Position Size Color
DrawCubeWires ← ◌ Rl {"void" "DrawCubeWiresV" FFIVector₃ FFIVector₃ FFIColor} {Types!(Vector₃|Vector₃|Color)}

# Upload mesh vertex data in GPU and provide VAO/VBO ids
# Mesh ? Mesh Dynamic
UploadMesh ← Types!(Mesh) Rl {"void" "UploadMesh" $"out _"FFIMesh "uchar"} {Types!(Mesh|∘)}

# Generate polygonal mesh
# Mesh ? Sides Radius
GenMeshPoly ← Types!(Mesh) Rl {FFIMesh "GenMeshPoly" "int" "float"} □₂

# Generate plane mesh (with subdivisions)
# Mesh ? Width Length ResX ResZ
GenMeshPlane ← Types!(Mesh) Rl {FFIMesh "GenMeshPlane" "float" "float" "int" "int"} □₄

# Generate cuboid mesh
# Mesh ? Width Height Length
GenMeshCube ← Types!(Mesh) Rl {FFIMesh "GenMeshCube" "float" "float" "float"} □₃

# Generate sphere mesh (standard sphere)
# Mesh ? Radius Rings Slices
GenMeshSphere ← Types!(Mesh) Rl {FFIMesh "GenMeshSphere" "float" "int" "int"} □₃

# TODO:
# bool IsModelValid(Model model);                                                       // Check if a model is valid (loaded in GPU, VAO/VBOs)
# void UnloadModel(Model model);                                                        // Unload model (including meshes) from memory (RAM and/or VRAM)

# Load model from files (meshes and materials)
# Model ? FileName
LoadModel ← Types!(Model) Rl {FFIModel "LoadModel" "char*"} □₁

# Load model from generated mesh (default material)
# Model ? Mesh
LoadModelFromMesh ← Types!(Model) Rl {FFIModel "LoadModelFromMesh" FFIMesh} {Types!(Mesh)}

# Draw a model (with texture if set)
# ? Model Position Scale Color
DrawModel ← ◌ Rl {"void" "DrawModel" FFIModel FFIVector₃ "float" FFIColor} {Types!(Model|Vector₃|∘|Color)}

# Draw a model with extended parameters
# ? Model Position RotationAxis RotationAngle Scale Tint
DrawModelEx ← ◌ Rl {"void" "DrawModel" FFIModel FFIVector₃ FFIVector₃ "float" FFIVector₃ FFIColor} {Types!(Model|Vector₃|Vector₃|∘|Vector₃|Color)}

# Generate image: plain color
# ? Width Height Color
GenImageColor ← (
  {Types!(∘|∘|Color)}
  Rl {FFIImage "GenImageColor" "int" "int" FFIColor}
  Types!Image
)

# Unload image from CPU memory (RAM)
# ? Image
UnloadImage ← ◌ Rl {"void" "UnloadImage" FFIImage} {Types!Image}

# Load image from screen buffer and (screenshot)
LoadImageFromScreen ← (Types!Image Rl {FFIImage "LoadImageFromScreen"} {})

# Load image from GPU texture data
# ? Texture
LoadImageFromTexture ← Types!Image Rl {FFIImage "LoadImageFromTexture" FFITexture} {Types!Texture}

# Load texture from image data
# ? Image
LoadTextureFromImage ← Types!Texture Rl {FFITexture "LoadTextureFromImage" FFIImage} {Types!Image}

# Load texture from file into GPU memory
# ? Path
LoadTexture ← Types!Texture Rl {FFITexture "LoadTexture" "char*"} {∘}

# Update GPU texture with new data
# ? Texture Pixels
UpdateTexture ← ◌Rl {"void" "UpdateTexture" FFITexture "uchar*"} □₂

# Update GPU texture rectangle with new data
# ? Texture Rectangle Pixels
UpdateTextureRec ← (
  {Types!(Texture|Rectangle|∘)}
  ◌Rl {"void" "UpdateTextureRec" FFITexture FFIRectangle "uchar*"}
)

# Unload texture from GPU memory
# ? Texture
UnloadTexture ← ◌Rl {"void" "UnloadTexture" FFITexture} {Types!Texture}

# Draw a texture.
# ? Texture Position TintColor
DrawTexture ← ◌Rl {"void" "DrawTextureV" FFITexture FFIVector₂ FFIColor} {Types!(Texture|Vector₂|Color)}

# Draw a texture with extended parameters.
# ? Texture Position Rotation Scale TintColor
DrawTextureEx ← (
  {Types!(Texture|Vector₂|∘|∘|Color)}
  ◌Rl {"void" "DrawTextureEx" FFITexture FFIVector₂ "float" "float" FFIColor}
)

# Draw a part of a texture.
# ? Texture SourceRectangle Position TintColor
DrawTextureRec ← (
  {Types!(Texture|Rectangle|Vector₂|Color)}
  ◌Rl {"void" "DrawTextureRec" FFITexture FFIRectangle FFIVector₂ FFIColor}
)

# Draw a part of a texture defined by a rectangle with 'pro' parameters
# ? Texture SourceRectangle DestinationRectangle Origin Rotation TintColor
DrawTexturePro ← (
  {Types!(Texture|Rectangle|Rectangle|Vector₂|∘|Color)}
  ◌Rl {"void" "DrawTexturePro" FFITexture FFIRectangle FFIRectangle FFIVector₂ "float" FFIColor}
)

# Load texture for rendering (framebuffer)
# RenderTexture ? Width Height
LoadRenderTexture ← Types!RenderTexture Rl {FFIRenderTexture "LoadRenderTexture" "int" "int"} □₂

# Unload render texture from GPU memory (VRAM)
# ? RenderTexture
UnloadRenderTexture ← ◌ Rl {"void" "UnloadRenderTexture" FFIRenderTexture} {Types!RenderTexture}

# Begin drawing to render texture
# ? RenderTexture
BeginTextureMode ← ◌Rl {"void" "BeginTextureMode" FFIRenderTexture} {Types!RenderTexture}

# Ends drawing to render texture
EndTextureMode ← ◌Rl{"void" "EndTextureMode"} □₀

# Check collision between two rectangles.
# Boolean ? Rectangle Rectangle
CheckCollisionRecs ← (
  {Types!(Rectangle|Rectangle)}
  Rl {"uchar" "CheckCollisionRecs" FFIRectangle FFIRectangle}
)

# Check collision between two circles.
# Boolean ? Center1 Radius1 Center2 Radius2
CheckCollisionCircles ← (
  {Types!(Vector₂|∘|Vector₂|∘)}
  Rl {"uchar" "CheckCollisionCircles" FFIVector₂ "float" FFIVector₂ "float"}
)

# Check collision between circle and rectangle.
# Boolean ? Center Radius Rectangle
CheckCollisionCircleRec ← (
  {Types!(Vector₂|∘|Rectangle)}
  Rl {"uchar" "CheckCollisionCircleRec" FFIVector₂ "float" FFIRectangle}
)

# Check if circle collides with a line created between two points.
# Boolean ? Center Radius Point1 Point2
CheckCollisionCircleLine ← (
  {Types!(Vector₂|∘|Vector₂|Vector₂)}
  Rl {"uchar" "CheckCollisionCircleLine" FFIVector₂ "float" FFIVector₂ FFIVector₂}
)

# Check if point is inside rectangle.
# Boolean ? Point Rectangle
CheckCollisionPointRec ← (
  {Types!(Vector₂|Rectangle)}
  Rl {"uchar" "CheckCollisionPointRec" FFIVector₂ FFIRectangle}
)

# Check if point is inside circle.
# Boolean ? Point Center Radius
CheckCollisionPointCircle ← (
  {Types!(Vector₂|Vector₂|∘)}
  Rl {"uchar" "CheckCollisionPointCircle" FFIVector₂ FFIVector₂ "float"}
)

# Check if point is inside a triangle.
# Boolean ? Point Point1 Point2 Point3
CheckCollisionPointTriangle ← (
  {Types!(Vector₂|Vector₂|Vector₂|Vector₂)}
  Rl {"uchar" "CheckCollisionPointTriangle" FFIVector₂ FFIVector₂ FFIVector₂ FFIVector₂}
)

# Check if point belongs to line created between two points.
# Boolean ? Point Point1 Point2 Threshold
CheckCollisionPointLine ← (
  {Types!(Vector₂|Vector₂|Vector₂|∘)}
  Rl {"uchar" "CheckCollisionPointLine" FFIVector₂ FFIVector₂ FFIVector₂ "int"}
)

# Check if point is within a polygon described by array of vertices.
# Boolean ? Point Points
CheckCollisionPointPoly ← (
  {Types!(Vector₂|≡Vector₂)}
  Rl {"uchar" "CheckCollisionPointPoly" FFIVector₂ $"_:2"FFIVector₂ "int"}
)

# Check the collision between two lines defined by two points each.
# Boolean ? StartPos1 EndPos1 StartPos2 EndPos2
CheckCollisionLines ← (
  {Types!(Vector₂|Vector₂|Vector₂|Vector₂)}
  Rl {"uchar" "CheckCollisionLines" FFIVector₂ FFIVector₂ FFIVector₂ FFIVector₂}
)

# Get the intersection of two rectangles.
# Rectangle ? Rectangle Rectangle
GetCollisionRec ← (
  {Types!(Rectangle|Rectangle)}
  Rl {FFIRectangle "GetCollisionRec" FFIRectangle FFIRectangle}
  Types!Rectangle
)

# Initialize audio device and context
InitAudioDevice ← (◌Rl {"void" "InitAudioDevice"} {})

# Close the audio device and context
CloseAudioDevice ← (◌Rl {"void" "CloseAudioDevice"} {})

# Check if audio device has been initialized successfully
IsAudioDeviceReady ← (Rl {"bool" "IsAudioDeviceReady"} {})

# Set master volume (listener)
SetMasterVolume ← ◌Rl {"void" "SetMasterVolume" "float"} □₁

# Get master volume (listener)
GetMasterVolume ← (Rl {"float" "SetMasterVolume"} {})

# Load wave data from file
LoadWave ← Types!Wave Rl {FFIWave "LoadWave" "char*"} □₁

# Load wave from memory buffer, fileType refers to extension: i.e. '.wav'
# ? FileType FileData
LoadWaveFromMemory ← Types!Wave Rl {FFIWave "LoadWaveFromMemory" "char*" "uchar:2" "int"} □₂

# Checks if wave data is valid (data loaded and parameters)
IsWaveValid ← Rl {"bool" "IsWaveValid" FFIWave} {Types!Wave}

# Load sound from file
LoadSound ← Types!Sound Rl {FFISound "LoadSound" "char*"} □₁

# Load sound from wave data 
LoadSoundFromWave ← Types!Sound Rl {FFISound "LoadSoundFromWave" FFIWave} {Types!Wave}

# Create a new sound that shares the same sample data as the source sound, does not own the sound data
LoadSoundAlias ← Types!Sound Rl {FFISound "LoadSoundAlias" FFISound} {Types!Sound}

# Checks if a sound is valid (data loaded and buffers initialized)
IsSoundValid ← Rl {"bool" "IsSoundValid" FFISound} {Types!Sound}

# Update sound buffer with new data
# ? Sound Data SampleCount
UpdateSound ← ◌ Rl {"void" "UpdateSound" FFISound "uchar*" "int"} {Types!(Sound|∘|∘)}

# Unload wave data
UnloadWave ← ◌ Rl {"void" "UnloadWave" FFIWave} {Types!Wave}

# Unload sound 
UnloadSound ← ◌ Rl {"void" "UnloadSound" FFISound} {Types!Sound}

# Unload a sound alias (does not deallocate sample data)
UnloadSoundAlias ← ◌Rl{"void" "UnloadSoundAlias" FFISound} {Types!Sound}

# Play a sound
PlaySound ← ◌ Rl {"void" "PlaySound" FFISound} {Types!Sound}

# Stop playing a sound
StopSound ← ◌ Rl {"void" "StopSound" FFISound} {Types!Sound}

# Pause a sound
PauseSound ← ◌ Rl {"void" "PauseSound" FFISound} {Types!Sound}

# Resume a paused sound
ResumeSound ← ◌ Rl {"void" "ResumeSound" FFISound} {Types!Sound}

# Check if a sound is currently playing
IsSoundPlaying ← Rl {"bool" "IsSoundPlaying" FFISound} {Types!Sound}

# Set volume for a sound (1.0 is max level)
SetSoundVolume ← ◌ Rl {"void" "SetSoundVolume" FFISound "float"} {Types!(Sound|∘)}
