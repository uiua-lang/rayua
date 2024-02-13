# Experimental!
DllPath ← ⍤"RAYLIB_PATH not set"±⧻. &var "RAYLIB_PATH"
Rl ← &ffi ⊂□DllPath
InitWindow ← ◌Rl {"void" "InitWindow" "int" "int" "const char*"} {⊓°⊟∘}
SetTargetFPS ← ◌Rl {"void" "SetTargetFPS" "int"} {∘}
WindowShouldClose ← (Rl {"int" "WindowShouldClose"} {})
CloseWindow ← (◌Rl {"void" "CloseWindow"} {})
BeginDrawing ← (◌Rl {"void" "BeginDrawing"} {})
EndDrawing ← (◌Rl {"void" "EndDrawing"} {})
Color ← "{char; char; char; char}"
DrawText ← ◌Rl {"void" "DrawText" "const char*" "int" "int" "int" Color} {⊓(∘|°⊟|⊙∘)}
ClearBackground ← ◌Rl {"void" "ClearBackground" Color} {∘}
