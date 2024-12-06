# Experimental!
R ~ "../lib"

# This is an example of a minimal Rayua application.
# It creates a window and sets the background to a color.
# Extend it to do more, by adding code to the MainLoop function.
# See other examples for more how to use specific functions

R~InitWindow 640 480 "Rayua minimal example"
R~SetTargetFPS 60

MainLoop ← (
  R~ClearBackground R~Color~SkyBlue
  R~BeginDrawing
  # <do stuff here>
  R~EndDrawing
)

⍢(MainLoop|¬R~WindowShouldClose)
R~CloseWindow
