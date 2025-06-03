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

Type!    ↚^ $"⍜°_∘"⊢
Prepare! ↚^ $"⊃(_)" /$"_|_"≡(□$"_(_)"▽:@⋅:)⟜(⇡⧻)

# Structs

~Window {Width Height Title}
~Texture {Id Width Height Mipmaps Format}
~Vector₂ [X Y]
~Rectangle [X Y Width Height]

┌─╴Color
  ~[R G B A]

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

# FFI Structs

FFIVector₂   ↚ "{float; float}"
FFIColor     ↚ "{unsigned char; unsigned char; unsigned char; unsigned char}"
FFITexture   ↚ "{unsigned int; int; int; int; int}"
FFIRectangle ↚ "{float; float; float; float}"

# Core Module

# Initialize window and OpenGL context.
# This should be called before any other Raylib functions.
# ? WindowWidth WindowHeight WindowTitle
InitWindow ← ◌Rl {"void" "InitWindow" "int" "int" "const char*"} Window

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
IsWindowReady ← (Rl {"int" "IsWindowReady"} {})

# Check if window is currently fullscreen
# Boolean ?
IsWindowFullscreen ← (Rl {"int" "IsWindowFullscreen"} {})

# Check if window is currently hidden
# Boolean ?
IsWindowHidden ← (Rl {"int" "IsWindowHidden"} {})

# Check if window is currently minimized
# Boolean ?
IsWindowMinimized ← (Rl {"int" "IsWindowMinimized"} {})

# Check if window is currently maximized
# Boolean ?
IsWindowMaximized ← (Rl {"int" "IsWindowMaximized"} {})

# Check if window is currently focused
# Boolean ?
IsWindowFocused ← (Rl {"int" "IsWindowFocused"} {})

# Check if window has been resized last frame
# Boolean ?
IsWindowResized ← (Rl {"int" "IsWindowResized"} {})

# Check if one specific window flag is enabled
# Boolean ? Flag
IsWindowState ← (Rl {"int" "IsWindowState" "unsigned int"} {∘})

# Set window configuration state using flags
# ? Flags
SetWindowState ← (◌Rl {"void" "SetWindowState" "unsigned int"} {∘})

# Clear window configuration state flags
# ? Flags
ClearWindowState ← (◌Rl {"void" "ClearWindowState" "Unsigned int"} {∘})

# Setup init configuration flags (view ConfigFlags)
# ? Flags
SetConfigFlags ← (◌Rl {"void" "SetConfigFlags" "unsigned int"} {∘})

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
ClearBackground ← ◌Rl {"void" "ClearBackground" FFIColor} {Type!(Color)}

# Setup canvas (framebuffer) to start drawing.
BeginDrawing ← (◌Rl {"void" "BeginDrawing"} {})

# End canvas drawing and swap buffers (double buffering).
EndDrawing ← (◌Rl {"void" "EndDrawing"} {})

# Check if a mouse button has been pressed once.
# Boolean ? MouseButton
IsMouseButtonPressed ← Rl {"char" "IsMouseButtonPressed" "int"} {∘}

# Check if a mouse button is being pressed.
# Boolean ? MouseButton
IsMouseButtonDown ← Rl {"char" "IsMouseButtonDown" "int"} {∘}

# Check if a mouse button has been released once.
# Boolean ? MouseButton
IsMouseButtonReleased ← Rl {"char" "IsMouseButtonReleased" "int"} {∘}

# Check if a mouse button is NOT being pressed.
# Boolean ? MouseButton
IsMouseButtonUp ← Rl {"char" "IsMouseButtonUp" "int"} {∘}

# Get the current mouse position.
# Vector2 ?
GetMousePosition ← (
  (Rl {FFIVector₂ "GetMousePosition"} {})
  Type!Vector₂
)

# Get mouse delta between frames.
# Vector2 ?
GetMouseDelta ← (
  (Rl {FFIVector₂ "GetMouseDelta"} {})
  Type!Vector₂
)

# Set mouse position.
# ? Vector2
SetMousePosition ← (
  Type!Vector₂ {°⊟⁅}
  ◌Rl {"void" "SetMousePosition" "int" "int"}
)

# Shows cursor.
ShowCursor ← (◌Rl {"void" "ShowCursor"} {})

# Hides cursor.
HideCursor ← (◌Rl {"void" "HideCursor"} {})

# Check if cursor is not visible
# Boolean ?
IsCursorHidden ← (Rl {"int" "IsCursorHidden"} {})

# Check if cursor is on the screen
# Boolean ?
IsCursorOnScreen ← (Rl {"int" "IsCursorOnScreen"} {})

KeyCode ↚ ⍥(-@\0⌵)⊸type

# Check if a key has been pressed once.
# Boolean ? Char
IsKeyPressed ← Rl {"char" "IsKeyPressed" "int"} {KeyCode}

# Check if a key has been pressed again.
# Boolean ? Char
IsKeyPressedRepeat ← Rl {"char" "IsKeyPressedRepeat" "int"} {KeyCode}

# Check if a key is being pressed.
# Boolean ? Char
IsKeyDown ← Rl {"char" "IsKeyDown" "int"} {KeyCode}

# Check if a key has been released once.
# Boolean ? Char
IsKeyReleased ← Rl {"char" "IsKeyReleased" "int"} {KeyCode}

# Check if a key is NOT being pressed.
# Boolean ? Char
IsKeyUp ← Rl {"char" "IsKeyUp" "int"} {KeyCode}

# Get key pressed (keycode), call it multiple times for keys queued, returns 0 when the queue is empty.
# Int ?
GetKeyPressed ← (Rl {"int" "GetKeyPressed"} {})

# Get char pressed (unicode), call it multiple times for chars queued, returns 0 when the queue is empty.
# Char ?
GetCharPressed ← (+@\0 Rl {"int" "GetCharPressed"} {})

# Set a custom key to exit program (default is ESC).
# ? Char
SetExitKey ← ◌Rl {"void" "SetExitKey" "int"} {KeyCode}

# Shape Module

# Draw a pixel using geometry [Can be slow, use with care].
# ? Position Color
DrawPixel ← (
  {Prepare!(Type!Vector₂|Type!Color)}
  ◌Rl {"void" "DrawPixelV" FFIVector₂ FFIColor}
)

# Draw a line.
# ? VectorFrom VectorTo Color
DrawLine ← (
  {Prepare!(Type!Vector₂|Type!Vector₂|Type!Color)}
  ◌Rl {"void" "DrawLineV" FFIVector₂ FFIVector₂ FFIColor}
)

# Draw a line with thickness.
# ? VectorFrom VectorTo Thickness Color
DrawLineEx ← (
  {Prepare!(Type!Vector₂|Type!Vector₂|∘|Type!Color)}
  ◌Rl {"void" "DrawLineEx" FFIVector₂ FFIVector₂ "float" FFIColor}
)

# Draw a line strip.
# ? Vectors Color
DrawLineStrip ← (
  {Prepare!(≡Type!Vector₂|Type!Color)}
  ◌Rl {"void" "DrawLineStrip" $"const _:1"FFIVector₂ "int" FFIColor}
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
  {Prepare!(Type!Vector₂|∘|∘|∘|⁅|Type!Color)}
  ◌Rl {"void" "DrawCircleSector" FFIVector₂ "float" "float" "float" "int" FFIColor}
)

# Draw circle sector outline.
# ? Center Radius StartAngle EndAngle Segments Color
DrawCircleSectorLines ← (
  {Prepare!(Type!Vector₂|∘|∘|∘|⁅|Type!Color)}
  ◌Rl {"void" "DrawCircleSectorLines" FFIVector₂ "float" "float" "float" "int" FFIColor}
)

# Draw a color-filled ellipse.
# ? Center HorizontalRadius VerticalRadius Color
DrawEllipse ← (
  {Prepare!(°⊟⁅Type!Vector₂|∘|∘|Type!Color)}
  ◌Rl {"void" "DrawEllipse" "int" "int" "float" "float" FFIColor}
)

# Draw ellipse outline.
# ? Center HorizontalRadius VerticalRadius Color
DrawEllipseLines ← (
  {Prepare!(°⊟⁅Type!Vector₂|∘|∘|Type!Color)}
  ◌Rl {"void" "DrawEllipseLines" "int" "int" "float" "float" FFIColor}
)

# Draw a color-filled ring.
# ? Center InnerRadius OuterRadius StartAngle EndAngle Segments Color
DrawRing ← (
  {Prepare!(Type!Vector₂|∘|∘|∘|∘|⁅|Type!Color)}
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

# Draw text using default font.
# ? Text Position Size Color
DrawText ← ◌Rl {"void" "DrawText" "const char*" "int" "int" "int" FFIColor} {⊓(∘|°⊟⁅|⊙∘)}

# Measure string width for default font.
# Width ? Text Size
MeasureText ← (
  {⊙∘}
  Rl {"int" "MeasureText" "const char*" "int"}
)

# Draw text using the default font, centered around the given position.
# ? Text Position Size Color
DrawTextCentered ← (
  ◡⊃(MeasureText ⊙⋅∘|⋅⋅∘)
  DrawText :-⊙:÷2⊟
)

# Load texture from file into GPU memory
# ? Path
LoadTexture ← (
  {∘}
  Rl {FFITexture "LoadTexture" "const char*"}
  Type!Texture
)

# Unload texture from GPU memory
# ? Texture
UnloadTexture ← (
  {Type!Texture}
  ◌Rl {"void" "UnloadTexture" FFITexture}
)

# Draw a texture.
# ? Texture Position TintColor
DrawTexture ← (
  {Prepare!(Type!Texture|Type!Vector₂|Type!Color)}
  ◌Rl {"void" "DrawTextureV" FFITexture FFIVector₂ FFIColor}
)

# Draw a texture with extended parameters.
# ? Texture Position Rotation Scale TintColor
DrawTextureEx ← (
  {Prepare!(Type!Texture|Type!Vector₂|∘|∘|Type!Color)}
  ◌Rl {"void" "DrawTextureEx" FFITexture FFIVector₂ "float" "float" FFIColor}
)

# Draw a part of a texture.
# ? Texture SourceRectangle Position TintColor
DrawTextureRec ← (
  {Prepare!(Type!Texture|Type!Rectangle|Type!Vector₂|Type!Color)}
  ◌Rl {"void" "DrawTextureRec" FFITexture FFIRectangle FFIVector₂ FFIColor}
)

# Draw a part of a texture defined by a rectangle with 'pro' parameters
# ? Texture SourceRectangle DestinationRectangle Origin Rotation TintColor
DrawTexturePro ← (
  {Prepare!(Type!Texture|Type!Rectangle|Type!Rectangle|Type!Vector₂|∘|Type!Color)}
  ◌Rl {"void" "DrawTexturePro" FFITexture FFIRectangle FFIRectangle FFIVector₂ "float" FFIColor}
)

# Check collision between two rectangles.
# Boolean ? Rectangle Rectangle
CheckCollisionRecs ← (
  {Prepare!(Type!Rectangle|Type!Rectangle)}
  Rl {"char" "CheckCollisionRecs" FFIRectangle FFIRectangle}
)

# Check collision between two circles.
# Boolean ? Center1 Radius1 Center2 Radius2
CheckCollisionCircles ← (
  {Prepare!(Type!Vector₂|∘|Type!Vector₂|∘)}
  Rl {"char" "CheckCollisionCircles" FFIVector₂ "float" FFIVector₂ "float"}
)

# Check collision between circle and rectangle.
# Boolean ? Center Radius Rectangle
CheckCollisionCircleRec ← (
  {Prepare!(Type!Vector₂|∘|Type!Rectangle)}
  Rl {"char" "CheckCollisionCircleRec" FFIVector₂ "float" FFIRectangle}
)

# Check if circle collides with a line created between two points.
# Boolean ? Center Radius Point1 Point2
CheckCollisionCircleLine ← (
  {Prepare!(Type!Vector₂|∘|Type!Vector₂|Type!Vector₂)}
  Rl {"char" "CheckCollisionCircleLine" FFIVector₂ "float" FFIVector₂ FFIVector₂}
)

# Check if point is inside rectangle.
# Boolean ? Point Rectangle
CheckCollisionPointRec ← (
  {Prepare!(Type!Vector₂|Type!Rectangle)}
  Rl {"char" "CheckCollisionPointRec" FFIVector₂ FFIRectangle}
)

# Check if point is inside circle.
# Boolean ? Point Center Radius
CheckCollisionPointCircle ← (
  {Prepare!(Type!Vector₂|Type!Vector₂|∘)}
  Rl {"char" "CheckCollisionPointCircle" FFIVector₂ FFIVector₂ "float"}
)

# Check if point is inside a triangle.
# Boolean ? Point Point1 Point2 Point3
CheckCollisionPointTriangle ← (
  {Prepare!(Type!Vector₂|Type!Vector₂|Type!Vector₂|Type!Vector₂)}
  Rl {"char" "CheckCollisionPointTriangle" FFIVector₂ FFIVector₂ FFIVector₂ FFIVector₂}
)

# Check if point belongs to line created between two points.
# Boolean ? Point Point1 Point2 Threshold
CheckCollisionPointLine ← (
  {Prepare!(Type!Vector₂|Type!Vector₂|Type!Vector₂|∘)}
  Rl {"char" "CheckCollisionPointLine" FFIVector₂ FFIVector₂ FFIVector₂ "int"}
)

# Check if point is within a polygon described by array of vertices.
# Boolean ? Point Points
CheckCollisionPointPoly ← (
  {Prepare!(Type!Vector₂|≡Type!Vector₂)}
  Rl {"char" "CheckCollisionPointPoly" FFIVector₂ $"const _:2"FFIVector₂ "int"}
)

# Check the collision between two lines defined by two points each.
# Boolean ? StartPos1 EndPos1 StartPos2 EndPos2
CheckCollisionLines ← (
  {Prepare!(Type!Vector₂|Type!Vector₂|Type!Vector₂|Type!Vector₂)}
  Rl {"char" "CheckCollisionLines" FFIVector₂ FFIVector₂ FFIVector₂ FFIVector₂}
)

# Get the intersection of two rectangles.
# Rectangle ? Rectangle Rectangle
GetCollisionRec ← (
  {Prepare!(Type!Rectangle|Type!Rectangle)}
  Rl {FFIRectangle "GetCollisionRec" FFIRectangle FFIRectangle}
  Type!Rectangle
)
