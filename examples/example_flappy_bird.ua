# Experimental!
R ~ "../lib"

# This is an example of a Flappy Bird game.
# It demonstrates how to create multiple game screens, handle user input, render textures.

# The main idea for different screens is to use a state value with the properties of that state.
# The state is then pattern matched to determine which handler to use.
# - The main menu state does not have any properties, it just waits for the user to press space and transitions to the game state.
# - The game state has properties for the bird, pipes, and score.
# - The game over state has a property for the score.

# The handler state takes the current state and returns the next state.
# In the main menu and game over states, the handler just draws the corresponding screen and waits for the user to press space.
# to transition to the next state - the game state. The game state then handles the main game logic:
# - Checking if the bird is colliding with anything
# - Updating applying gravity to the bird
# - Moving the pipes
# - Scoring points
# - Drawing the screen
# - Handling user input

BirdX             ← 100
Gravity           ← 0.5
JumpSpeed         ← ¯10
PipeSpawnPosition ← 640
PipeGap           ← 90
PipeMovementSpeed ← 4
GapsBetweenPipes  ← 300

WindowWidth  ← 640
WindowHeight ← 480

R~InitWindow WindowWidth WindowHeight "Rayua Flappy Bird"
R~SetTargetFPS 60

# ? X Y W H
CenteredRect ← ⊂-÷2,∩⊟

# ? X Y Size
CenteredSquare ← CenteredRect ⊙⊙.

┌─╴Bird
  ~[
    Y ← ÷2WindowHeight
    YSpeed ← 0
  ]

  Size         ← ⊟.48
  SpriteOrigin ← ÷2Size
  # Assumes sprite-centered origin
  RenderRect ← ⊂[BirdX Y]⟜Size
  HitboxRect ← CenteredSquare ⊃(BirdX|+2 Y|35)
└─╴

┌─╴Pipe
  ~[X Top Bottom Scored Id]

  TopRect    ← [⊃(X|0|64|Top)]
  BottomRect ← [⊃(X|Bottom|64|-:WindowHeight Bottom)]
└─╴

┌─╴State
  |Menu {HighScore}
  |Game {Bird Pipes Score HighScore}
  |GameOver {Bird Pipes Score HighScore DeathTime}
└─╴

RelativeFile ← $".____" Sep ThisFileDir Sep

SpawnPipe ← Pipe ⊙(⊃-+ PipeGap +140×-280WindowHeight⚂ 0 ⌊×1000⚂)
CreateGameState ← State~Game ⊃(
  Bird!(°⊸YSpeed JumpSpeed New)
| ≡SpawnPipe +50+WindowWidth×GapsBetweenPipes⇡4
| 0)

# ? AnimateSpeed Bird
DrawBird ← (
  # Uncomment the following line to display the hitbox
  # ⟜(R~DrawRectangleLines ⊃(∩⊟°⊟₄Bird~HitboxRect|R~Color~Green))

  ⊙(⟜($rotation ×3Bird~YSpeed)
    ⟜($origin Bird~SpriteOrigin)
    $destination Bird~RenderRect)
  $source [×16◿4⌊×8×R~GetTime ⊙(0 16 16)]
  R~DrawTexturePro ⊓(°□get "bird_sprite" °◌|⊙∘|∘|∘|R~Color~White)
)

HandleMenuState ← |1 (
  DrawBird 0.5 Bird

  R~DrawTextCentered "Uiua Bird" [÷2WindowWidth 180] 60 R~Color~Black

  ⊸±⊸State~Menu~HighScore
  ⨬⋅"Press space to start" $"High score: _"
  R~DrawTextCentered ⊙([÷2WindowWidth 280] 40 R~Color~Black)

  # When space is pressed - create a new game state
  R~IsKeyPressed @\s
  ⍥(CreateGameState State~Menu~HighScore)
)

# ? Pipe
DrawTopPipe ← |1.0 (
  # Uncomment the following line to display the hitbox
  # ⟜(R~DrawRectangleLines ⊃(∩⊟°⊟₄Pipe~TopRect|R~Color~Green))

  Pipe!⊃(
    $source [×32◿4 Id ⊙(48 32 32)]
  | $destination [⊃(X|-64Top|64|64)]
  | $source [×32◿4 Id ⊙(24 32 32)]
  | $destination [⊃(X|0|64|-64Top)])
  ∩(R~DrawTexturePro ⊓(°□get "pipes_sprite" °◌|⊙∘|[0 0]|0|R~Color~White))
)

# ? Pipe
DrawBottomPipe ← |1.0 (
  # Uncomment the following line to display the hitbox
  # ⟜(R~DrawRectangleLines ⊃(∩⊟°⊟₄Pipe~BottomRect|R~Color~Green))

  Pipe!⊃(
    $source [×32◿4 Id ⊙(0 32 32)]
  | $destination [⊃(X|Bottom|64|64)]
  | $source [×32◿4 Id ⊙(24 32 32)]
  | $destination [⊃(X|+64Bottom|64|-:WindowHeight Bottom)]
  )
  ∩(R~DrawTexturePro ⊓(°□get "pipes_sprite" °◌|⊙∘|[0 0]|0|R~Color~White))
)

# ? Pipes
DrawPipes ← ≡⊃(DrawTopPipe+1)DrawBottomPipe

# ? Score
DrawScore ← R~DrawText⊃($"Score: _"|[20 20]|20|R~Color~Black)

ShouldBeScored ← ×Pipe!⊃(< BirdX +64X|¬Scored)

IsOutOfBounds ← ↥⊃<₀(>WindowHeight) Bird~Y State~Game~Bird
IsCollidingWithPipes ← (
  ⊃(¤Bird~HitboxRect State~Game~Bird
  | ♭₂[≡Pipe!⊃TopRect BottomRect] State~Game~Pipes)
  /↥≡R~CheckCollisionRecs
)
IsBirdDead ← ↥⊃IsOutOfBounds IsCollidingWithPipes

HandleGameState ← (
  ¬⊸IsBirdDead
  ⨬( # The bird collided with something, go to game over state and log the time of death
    State!(GameOver °Game) ⊙R~GetTime
  | # The bird is still alive, update the game state

    # Add speed to bird position
    ⍜State~Game~Bird Bird!(⍜Y+⟜YSpeed)

    # Increment vertical bird speed
    ⍜(Bird~YSpeed State~Game~Bird|+Gravity)

    # Move the pipes
    ⍜(≡Pipe~X State~Game~Pipes|-PipeMovementSpeed)

    # Find the number of unscored pipes that are past the screen
    # (Should normally be at most 1 at a time)
    ⟜(/+≡ShouldBeScored State~Game~Pipes)

    # Increment the score for each of them
    ⍜State~Game~Score+

    # Mark the pipes past the bird as scored
    ⍜(▽⌅⊸≡ShouldBeScored State~Game~Pipes|≡°⊸Pipe~Scored 1)

    # Remove pipes off screen
    ⍜State~Game~Pipes(▽⊸≡(>¯64Pipe~X))

    # Spawn new pipes when there aren't enough
    <4⧻⊸State~Game~Pipes
    ⍥⍜State~Game~Pipes(⊂SpawnPipe +240 ×3GapsBetweenPipes)

    # Draw screen
    ⟜(DrawPipes State~Game~Pipes)
    ⟜(DrawBird 1 State~Game~Bird)
    ⟜(DrawScore State~Game~Score)

    # When space is pressed - jump
    R~IsKeyPressed @\s
    ⍥(°⊸(Bird~YSpeed State~Game~Bird) JumpSpeed)
  )
)

HandleGameOverState ← (
  # Add speed to bird position
  ⍜State~GameOver~Bird Bird!(
    ⍜Y+⟜YSpeed
    # If the bird goes below the screen, clamp position and
    # set speed so that the rotation is straight down
    ⤚>-⊢SpriteOrigin WindowHeight⊸Y
    ⨬⋅∘(°⊸YSpeed 30 ⍜⊙Y⊙◌)
  )

  # Increment vertical bird speed
  ⍜(Bird~YSpeed State~GameOver~Bird|+Gravity)

  # Draw screen
  ⟜(DrawPipes State~GameOver~Pipes)
  ⟜(DrawBird 0 State~GameOver~Bird)
  ⟜(DrawScore State~GameOver~Score)

  R~DrawTextCentered "Game over" [÷2WindowWidth 180] 40 R~Color~Black
  ⟜(R~DrawTextCentered ⊓(
      $"Your score: _" State~GameOver~Score
    | [÷2WindowWidth 250] 40 R~Color~Black))
  R~DrawTextCentered "Press space to restart" [÷2WindowWidth 320] 20 R~Color~Black

  # Draw white flash with opacity based on the time elapsed since game over
  ↥0+1-R~GetTime⊸State~GameOver~DeathTime
  R~DrawRectangle [0 0] [WindowWidth WindowHeight] ⍜⊣× R~Color~White

  # When space is pressed - create a new game state
  R~IsKeyPressed @\s
  ⍥(State~Menu ↥State~GameOver!⊃Score HighScore)
)

TestFor! ←^ $"_°_".⊢

MainLoop ← (
  R~ClearBackground R~Color~SkyBlue
  R~BeginDrawing

  # Note the usage of ⍩ - it allows errors to happen in that branch.
  # Without it, if the pattern matching passes and something
  # goes wrong in the handler - it will try the next state branch,
  # which is not what we want.

  ⍣(⍩HandleMenuState TestFor!State~Menu
  | ⍩HandleGameState TestFor!State~Game
  | ⍩HandleGameOverState TestFor!State~GameOver
  | ⍤$"Invalid state: _":0
  )

  R~EndDrawing
)

State~Menu 0

map {} {}
insert∩□ "bird_sprite" R~LoadTexture RelativeFile "bird.png"
insert∩□ "pipes_sprite" R~LoadTexture RelativeFile "pipes.png"

⬚∘⍢MainLoop(¬R~WindowShouldClose)
R~CloseWindow
