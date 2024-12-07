# Experimental!
R ~ "../lib"

# This is an example of drawing a texture to a screen.
# The texture is loaded from a file and saved to a map.
# "⬚ fill" is then used to give main loop context of the texture.
# Then "°un ◌pop" is used in the function call to get the texture from the map.
# This is a neat way to organize textures and other resources in a game
# without having to pass them around in the stack.

RelativeFile ← $".____" Sep ⊙Sep ThisFileDir

R~InitWindow 720 720 "Rayua minimal example"
R~SetTargetFPS 60

MainLoop ← (
  R~ClearBackground R~Color~SkyBlue
  R~BeginDrawing

  # Draw the full cats texture, with a dark gray tint
  R~DrawTexture ⊃(get "cats_texture" °◌|[0 0]|R~Color~DarkGray)

  # Draw the same texture, but at half scale and rotated 45 degrees
  R~DrawTextureEx ⊃(get "cats_texture" °◌|[360 130]|45|0.5|R~Color~White)

  # Crop and draw Louie's face from the texture
  R~DrawTextureRec ⊃(get "cats_texture" °◌|[340 180 200 200]|[25 25]|R~Color~Green)
  
  # Crop and draw Murphy's face from the texture, but streched out
  R~DrawTexturePro ⊃(get "cats_texture" °◌|[30 220 200 200]|[600 100 100 200]|[100 100]|¯15|R~Color~Red)

  R~EndDrawing
)

⬚(map {} {}
  insert "cats_texture" R~LoadTexture RelativeFile "cats.png"
)⍢(MainLoop|¬R~WindowShouldClose)
R~CloseWindow
