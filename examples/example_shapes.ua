# Experimental!
R ~ "../lib"

# This example demonstrates how to draw shapes.

R~InitWindow 640 480 "Rayua shapes example"
R~SetTargetFPS 60

Labeled! ← (
  ⊃(⊙∘|⊙∘|⋅∘)
  R~DrawText ⊃(⊙∘|20|R~Color~Black)
  +[:10 +5R~MeasureText⊙20]
  ^0
  +[0 25]
)

MainLoop ← (
  R~ClearBackground R~Color~SkyBlue
  R~BeginDrawing

  # Offset for the first element
  [10 10]

  # "Labeled!" is a helper macro that draws a label
  # and returns offset for the next element.

  $ Pixels
  Labeled!(
    ⟜R~DrawPixel⊃(∘|R~Color~Black)
    ⟜R~DrawPixel⊃(∘|R~Color~Red) +[5 0]
    ⟜R~DrawPixel⊃(∘|R~Color~Blue) +[5 0]
    R~DrawPixel⊃(∘|R~Color~Green) +[5 0]
  )

  $ Line
  Labeled!(
    +[50 0].
    R~DrawLine⊃(⊙∘|R~Color~Black)
  )

  $ Line \w weight
  Labeled!(
    ⊃(+[50 5]|-[0 5])
    R~DrawLineEx⊃(⊙∘|6|R~Color~Black)
  )

  $ Strip
  Labeled!(
    # Generate random strip
    memo(⍉+⊟×10⇡⟜[⍥(-5×10⚂)]10)
    R~DrawLineStrip ⊙R~Color~Black
  )

  $ Bezier
  Labeled!(
    ⊃(+[20 5]|-[0 5])
    R~DrawLineBezier ⊃(⊙∘|2|R~Color~Black)
  )

  $ Circles
  Labeled!(
    ⟜R~DrawCircle ⊃(∘|10|R~Color~Black) +[10 0]
    ⟜R~DrawCircleLines ⊃(∘|10|R~Color~Black) +[25 0]
    ⟜R~DrawCircleSector ⊃(∘|10|90|270|12|R~Color~Black) +[25 0]
    R~DrawCircleSectorLines ⊃(∘|10|¯90|90|12|R~Color~Black)+[5 0]
  )

  $ Ellipses
  Labeled!(
    ⟜R~DrawEllipse ⊃(∘|20|10|R~Color~Black) +[20 0]
    R~DrawEllipseLines ⊃(∘|20|10|R~Color~Black) +[45 0]
  )

  $ Rings
  Labeled!(
    ⟜R~DrawRing ⊃(∘|5|10|0|360|32|R~Color~Black) +[10 0]
    ⟜R~DrawRing ⊃(∘|5|10|90|270|32|R~Color~Black) +[25 0]
    ⟜R~DrawRingLines ⊃(∘|5|10|0|360|32|R~Color~Black) +[15 0]
    R~DrawRingLines ⊃(∘|5|10|90|270|32|R~Color~Black) +[25 0]
  )

  $ Rectangles
  Labeled!(
    ⟜R~DrawRectangle ⊃(∘|[40 20]|R~Color~Black) +[0 ¯10]
    R~DrawRectangleLines ⊃(∘|[40 20]|R~Color~Black) +[45 0]
  )

  $ Triangles
  Labeled!(
    ⟜R~DrawTriangle ⊃(∘|+[20 20]|+[20 0]|R~Color~Black) +[0 ¯10]
    R~DrawTriangleLines ⊃(∘|+[20 20]|+[20 0]|R~Color~Black) +[25 0]
  )

  $ Polygon
  Labeled!(
    ⟜R~DrawPoly ⊃(∘|5|10|0|R~Color~Black) +[10 0]
    R~DrawPolyLines ⊃(∘|6|10|0|R~Color~Black) +[25 0]
  )

  ◌

  R~EndDrawing
)

⍢(MainLoop|¬R~WindowShouldClose)
R~CloseWindow
