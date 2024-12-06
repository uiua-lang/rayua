# Experimental!
R ~ "../lib"

# This example demonstrates how to use the mouse input (position and buttons).
# It draws a circle who's halves change color when the left or right mouse button is pressed.
# It also draws a trail of red lines following the mouse cursor.

R~InitWindow 640 480 "Rayua mouse example"
R~SetTargetFPS 60

MouseButtonColor ← ⨬(R~Color~LightGray|R~Color~Green)R~IsMouseButtonDown

DrawFauxCursor ← (
  ⟜R~DrawCircleSector ⊃(∘|30|90|270|12|MouseButtonColor R~MouseButton~Left)
  R~DrawCircleSector ⊃(∘|30|¯90|90|12|MouseButtonColor R~MouseButton~Right)
)

DrawTrail ← (
  ⧈∘2
  ≡(R~DrawLineEx ⊃(°⊟|5|R~Color~Red))
)

[] # trail path

MainLoop ← (
  R~ClearBackground R~Color~SkyBlue
  R~BeginDrawing

  # Add mouse position to a trail
  ⬚0↙20 ⊂¤R~GetMousePosition

  # Draw the trail at the last position
  ⟜(DrawFauxCursor⊢)

  # Draw the trail
  ⟜DrawTrail

  R~EndDrawing
)

◌⍢(MainLoop|¬R~WindowShouldClose)
R~CloseWindow
