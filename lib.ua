# Experimental!
DllPath ← &var "RAYLIB_PATH"
Rl ← &ffi ⊂□DllPath

# Structs

VectorII ← "{float; float}"
Color ← "{unsigned char; unsigned char; unsigned char; unsigned char}"

# Core Module

# window size, window title
InitWindow ← ◌Rl {"void" "InitWindow" "int" "int" "const char*"} {⊓°⊟∘}
SetTargetFPS ← ◌Rl {"void" "SetTargetFPS" "int"} {∘}
GetFrameTime ← (Rl {"int" "GetFrameTime"} {})
GetTime ← (Rl {"int" "GetTime"} {})
GetFPS ← (Rl {"int" "GetFPS"} {})
WindowShouldClose ← (Rl {"int" "WindowShouldClose"} {})
CloseWindow ← (◌Rl {"void" "CloseWindow"} {})

BeginDrawing ← (◌Rl {"void" "BeginDrawing"} {})
EndDrawing ← (◌Rl {"void" "EndDrawing"} {})
ClearBackground ← ◌Rl {"void" "ClearBackground" Color} {∘}

IsMouseButtonPressed ← Rl {"char" "IsMouseButtonPressed" "int"} {∘}
IsMouseButtonDown ← Rl {"char" "IsMouseButtonDown" "int"} {∘}
IsMouseButtonReleased ← Rl {"char" "IsMouseButtonReleased" "int"} {∘}
IsMouseButtonUp ← Rl {"char" "IsMouseButtonUp" "int"} {∘}
GetMousePosition ← (Rl {VectorII "GetMousePosition"} {})
GetMouseDelta ← (Rl {VectorII "GetMouseDelta"} {})
SetMousePosition ← ◌Rl {"void" "SetMousePosition" "int" "int"} {°⊟⁅}
ShowCursor ← (◌Rl {"void" "ShowCursor"} {})
HideCursor ← (◌Rl {"void" "HideCursor"} {})

KeyCode ↚ ⍥(-@\0⌵)÷2type.
IsKeyPressed ← Rl {"char" "IsKeyPressed" "int"} {KeyCode}
IsKeyPressedRepeat ← Rl {"char" "IsKeyPressedRepeat" "int"} {KeyCode}
IsKeyDown ← Rl {"char" "IsKeyDown" "int"} {KeyCode}
IsKeyReleased ← Rl {"char" "IsKeyReleased" "int"} {KeyCode}
IsKeyUp ← Rl {"char" "IsKeyUp" "int"} {KeyCode}
GetKeyPressed ← (Rl {"int" "GetKeyPressed"} {})
GetCharPressed ← (+@\0 Rl {"int" "GetCharPressed"} {})
SetExitKey ← ◌Rl {"void" "SetExitKey" "int"} {KeyCode}

KeyEscape ← 256
KeyEnter ← 257
KeyTab ← 258
KeyBackspace ← 259
KeyInsert ← 260
KeyDelete ← 261
KeyRight ← 262
KeyLeft ← 263
KeyDown ← 264
KeyUp ← 265
KeyPageUp ← 266
KeyPageDown ← 267
KeyHome ← 268
KeyEnd ← 269
KeyCapsLock ← 280
KeyScrollLock ← 281
KeyNumLock ← 282
KeyPrintScreen ← 283
KeyPause ← 284
KeyFOne ← 290
KeyFTwo ← 291
KeyFThree ← 292
KeyFFour ← 293
KeyFFive ← 294
KeyFSix ← 295
KeyFSeven ← 296
KeyFEight ← 297
KeyFNine ← 298
KeyFTen ← 299
KeyFEleven ← 300
KeyFTwelve ← 301
KeyLeftShift ← 340
KeyLeftControl ← 341
KeyLeftAlt ← 342
KeyLeftSuper ← 343
KeyRightShift ← 344
KeyRightControl ← 345
KeyRightAlt ← 346
KeyRightSuper ← 347
KeyKbMenu ← 348

KeyKpZero ← 320
KeyKpOne ← 321
KeyKpTwo ← 322
KeyKpThree ← 323
KeyKpFour ← 324
KeyKpFive ← 325
KeyKpSix ← 326
KeyKpSeven ← 327
KeyKpEight ← 328
KeyKpNine ← 329
KeyKpDecimal ← 330
KeyKpDivide ← 331
KeyKpMultiply ← 332
KeyKpSubtract ← 333
KeyKpAdd ← 334
KeyKpEnter ← 335
KeyKpEqual ← 336

# Shape Module

# position, color
DrawPixel ← ◌Rl {"void" "DrawPixelV" VectorII Color} {⊙∘}
# start pos, end pos, color
DrawLine ← ◌Rl {"void" "DrawLineV" VectorII VectorII Color} {⊙⊙∘}
# start pos, end pos, thickness, color
DrawLineEx ← ◌Rl {"void" "DrawLineEx" VectorII VectorII "float" Color} {⊙⊙⊙∘}
# points, color
DrawLineStrip ← ◌Rl {"void" "DrawLineStrip" $"const _:1"VectorII "int" Color} {⊙∘}
# start pos, end pos, thickness, color
DrawLineBezier ← ◌Rl {"void" "DrawLineBezier" VectorII VectorII "float" Color} {⊙⊙⊙∘}
# center, radius, color
DrawCircle ← ◌Rl {"void" "DrawCircleV" VectorII "float" Color} {⊙⊙∘}
# center, radius, color
DrawCircleLines ← ◌Rl {"void" "DrawCircleLinesV" VectorII "float" Color} {⊙⊙∘}
# center, radius, start angle, end angle, segments, color
DrawCircleSector ← ◌Rl {"void" "DrawCircleSector" VectorII "float" "float" "float" "int" Color} {⊙⊙⊙⊙⊙∘}
# center, radius, start angle, end angle, segments, color
DrawCircleSectorLines ← ◌Rl {"void" "DrawCircleSectorLines" VectorII "float" "float" "float" "int" Color} {⊙⊙⊙⊙⊙∘}
# center, horizontal radius, vertical radius, color
DrawEllipse ← ◌Rl {"void" "DrawEllipse" "int" "int" "float" "float" Color} {°⊟⁅⊙⊙⊙∘}
# center, horizontal radius, vertical radius, color
DrawEllipseLines ← ◌Rl {"void" "DrawEllipseLines" "int" "int" "float" "float" Color} {°⊟⁅⊙⊙⊙∘}
# center, inner radius, outer radius, start angle, end angle, segments, color
DrawRing ← ◌Rl {"void" "DrawRing" VectorII "float" "float" "float" "float" "int" Color} {⊙⊙⊙⊙⊙⊙∘}
# center, inner radius, outer radius, start angle, end angle, segments, color
DrawRingLines ← ◌Rl {"void" "DrawRingLines" VectorII "float" "float" "float" "float" "int" Color} {⊙⊙⊙⊙⊙⊙∘}
# position, size, color
DrawRectangle ← ◌Rl {"void" "DrawRectangleV" VectorII VectorII Color} {⊙⊙∘}
# position, size, color
DrawRectangleLines ← ◌Rl {"void" "DrawRectangleLines" "int" "int" "int" "int" Color} {∩°⊟⊓∩⁅∘}
# point 1, point 2, point 3, color
DrawTriangle ← ◌Rl {"void" "DrawTriangle" VectorII VectorII VectorII Color} {⊙⊙⊙∘}
# point 1, point 2, point 3, color
DrawTriangleLines ← ◌Rl {"void" "DrawTriangleLines" VectorII VectorII VectorII Color} {⊙⊙⊙∘}
# center, sides, radius, rotation, color
DrawPoly ← ◌Rl {"void" "DrawPoly" VectorII "int" "float" "float" Color} {⊙⊙⊙⊙∘}
# center, sides, radius, rotation, color
DrawPolyLines ← ◌Rl {"void" "DrawPolyLines" VectorII "int" "float" "float" Color} {⊙⊙⊙⊙∘}

# Textures Module

# text, position, size, color
DrawText ← ◌Rl {"void" "DrawText" "const char*" "int" "int" "int" Color} {⊓(∘|°⊟⁅|⊙∘)}
