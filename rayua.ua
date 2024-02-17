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

# Shape Module
DrawRectangle ← ◌Rl {"void" "DrawRectangleV" VectorII VectorII Color} {⊙⊙∘}

# Textures Module
DrawText ← ◌Rl {"void" "DrawText" "const char*" "int" "int" "int" Color} {⊓(∘|°⊟|⊙∘)}
