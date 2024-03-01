# Experimental!
DllPath ← &var "RAYLIB_PATH"
Rl ← &ffi ⊂□DllPath

# Structs
VectorII ← "{float; float}"
Color ← "{unsigned char; unsigned char; unsigned char; unsigned char}"

# Core Module
InitWindow ← ◌Rl {"void" "InitWindow" "int" "int" "const char*"} {⊓°⊟∘}
SetTargetFPS ← ◌Rl {"void" "SetTargetFPS" "int"} {∘}
WindowShouldClose ← (Rl {"int" "WindowShouldClose"} {})
CloseWindow ← (◌Rl {"void" "CloseWindow"} {})

BeginDrawing ← (◌Rl {"void" "BeginDrawing"} {})
EndDrawing ← (◌Rl {"void" "EndDrawing"} {})
ClearBackground ← ◌Rl {"void" "ClearBackground" Color} {∘}

IsMouseButtonPressed ← Rl {"char" "IsMouseButtonPressed" "int"} {∘}
IsMouseButtonDown ← Rl {"char" "IsMouseButtonDown" "int"} {∘}
IsMouseButtonReleased ← Rl {"char" "IsMouseButtonReleased" "int"} {∘}
GetMousePosition ← (Rl {VectorII "GetMousePosition"} {})

KeyCode ↚ ⟨∘|-@\0⌵⟩÷2type.
IsKeyPressed ← Rl {"char" "IsKeyPressed" "int"} {KeyCode}
IsKeyPressedRepeat ← Rl {"char" "IsKeyPressedRepeat" "int"} {KeyCode}
IsKeyDown ← Rl {"char" "IsKeyDown" "int"} {KeyCode}
IsKeyReleased ← Rl {"char" "IsKeyReleased" "int"} {KeyCode}
IsKeyUp ← Rl {"char" "IsKeyUp" "int"} {KeyCode}
GetKeyPressed ← (Rl {"int" "GetKeyPressed"} {})
GetCharPressed ← (+@\0 Rl {"int" "GetCharPressed"} {})
SetExitKey ← (◌Rl {"void" "SetExitKey" "int"} {KeyCode})

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
DrawRectangle ← ◌Rl {"void" "DrawRectangleV" VectorII VectorII Color} {⊙⊙∘}

# Textures Module
DrawText ← ◌Rl {"void" "DrawText" "const char*" "int" "int" "int" Color} {⊓(∘|°⊟|⊙∘)}
