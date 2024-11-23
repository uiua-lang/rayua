# Experimental!
R ~ "../lib"

Time ← ($"_:_:_"°[⊙⊙∘]≡(⬚@0↙¯2°⋕) ⌊[◿12 ⍥(⊃÷◿60)2 now])

R~InitWindow [800 450] "Rayua!"
R~SetTargetFPS 60
⍢(R~BeginDrawing

  R~ClearBackground [127 127 255 255]
  R~DrawText $"It is _" Time [12 12] 50 [...255]

  [0 (×R~IsMouseButtonDown 0 255) 127 255]
  -:R~GetMousePosition ÷2.[200 150]
  R~DrawRectangle

  R~EndDrawing
| ¬R~WindowShouldClose
)
R~CloseWindow
