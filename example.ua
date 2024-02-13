R ~ "rayua"

R~InitWindow [800 450] "Rayua!"
R~SetTargetFPS 60
⍢(
  R~BeginDrawing

  R~ClearBackground [127 127 255 255]
  R~DrawText "Hello, World!" [12 12] 50 [...255]

  R~EndDrawing
| ¬R~WindowShouldClose
)
R~CloseWindow
