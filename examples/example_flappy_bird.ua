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

R~InitWindow 640 480 "Rayua Flappy Bird"
R~SetTargetFPS 60

# ? X Y W H
CenteredRect ← ⊂-÷2,∩⊟

# ? X Y Size
CenteredSquare ← CenteredRect ⊙⊙.

┌─╴Bird
  ~[Y YSpeed]

  RenderRect ← CenteredSquare ⊃(BirdX|Y|48)
  HitboxRect ← CenteredSquare ⊃(BirdX|+2Y|35)
└─╴

┌─╴Pipe
  ~[X Top Bottom Scored Id]

  TopRect    ← [⊃(X|0|64|Top)]
  BottomRect ← [⊃(X|Bottom|64|-:480Bottom)]
└─╴

┌─╴State
  |Menu
  |Game {Bird Pipes Score}
  |GameOver {Score}
└─╴

RelativeFile ← $".____" Sep ThisFileDir Sep

SpawnBird           ← Bird 240 0
SpawnPipe           ← Pipe ⊃(∘|°⊟+⊟¯.PipeGap +150×200⚂|0|⌊×1000⚂)
CreateGameState     ← State~Game⊃(SpawnBird|≡SpawnPipe +500×GapsBetweenPipes⇡4|0)
CreateGameOverState ← State~GameOver $score

HandleMenuState ← |1 (
  R~DrawTextCentered "Uiua Bird" [320 180] 60 R~Color~Black
  R~DrawTextCentered "Press space to start" [320 280] 40 R~Color~Black

  # When space is pressed - create a new game state
  R~IsKeyPressed @\s
  ⍥(CreateGameState◌)
)

# ? Bird
DrawBird ← (
  # Uncomment the following line to display the hitbox
  # ⟜(R~DrawRectangleLines ⊃(∩⊟°⊟₄Bird~HitboxRect|R~Color~Green))

  $destination Bird~RenderRect
  $source [×16◿4⌊×8R~GetTime 0 16 16]
  R~DrawTexturePro ⊃(°□get "bird_sprite" °◌|⊙∘|[0 0]|0|R~Color~White)
)

# ? Pipe
DrawTopPipe ← |1.0 (
  # Uncomment the following line to display the hitbox
  # ⟜(R~DrawRectangleLines ⊃(∩⊟°⊟₄Pipe~TopRect|R~Color~Green))

  ⊃(⊃($source [×32◿4 Pipe~Id ⊙(48 32 32)]
    | $destination [⊃(Pipe~X|-64Pipe~Top|64|64)])
    R~DrawTexturePro ⊃(°□get "pipes_sprite" °◌|⊙∘|[0 0]|0|R~Color~White)
  | ⊃($source [×32◿4 Pipe~Id ⊙(24 32 32)]
    | $destination [⊃(Pipe~X|0|64|-64Pipe~Top)])
    R~DrawTexturePro ⊃(°□get "pipes_sprite" °◌|⊙∘|[0 0]|0|R~Color~White)
  )
)

# ? Pipe
DrawBottomPipe ← |1.0 (
  # Uncomment the following line to display the hitbox
  # ⟜(R~DrawRectangleLines ⊃(∩⊟°⊟₄Pipe~BottomRect|R~Color~Green))

  ⊃(⊃($source [×32◿4 Pipe~Id ⊙(0 32 32)]
    | $destination [⊃(Pipe~X|Pipe~Bottom|64|64)])
    R~DrawTexturePro ⊃(°□get "pipes_sprite" °◌|⊙∘|[0 0]|0|R~Color~White)
  | ⊃($source [×32◿4 Pipe~Id ⊙(24 32 32)]
    | $destination [⊃(Pipe~X|+64Pipe~Bottom|64|-:480Pipe~Bottom)])
    R~DrawTexturePro ⊃(°□get "pipes_sprite" °◌|⊙∘|[0 0]|0|R~Color~White)
  )
)

# ? Pipes
DrawPipes ← ≡⊃(DrawTopPipe+1|DrawBottomPipe)

# ? Score
DrawScore ← R~DrawText⊃($"Score: _"∘|[20 20]|20|R~Color~Black)

ShouldBeScored ← /↧[⊃(< BirdX +64Pipe~X|¬Pipe~Scored)]

IsOutOfBounds ← /↥[⊃(<0|>480)] Bird~Y State~Game~Bird
IsCollidingWithPipes ← (
  ⊃(¤Bird~HitboxRect State~Game~Bird
  | ♭₂[≡⊃(Pipe~TopRect|Pipe~BottomRect)] State~Game~Pipes)
  /↥≡(R~CheckCollisionRecs)
)
IsBirdDead ← /↥[⊃(IsOutOfBounds|IsCollidingWithPipes)]

HandleGameState ← (
  ⊸(¬IsBirdDead)
  ⨬( # the bird colided with something, go to game over state
    CreateGameOverState State~Game~Score
  | # The bird is still alive, update the game state

    # Add speed to bird position
    ⟜(+⊃(Bird~Y|Bird~YSpeed) State~Game~Bird)
    ⍜(Bird~Y State~Game~Bird)⋅∘

    # Increment vertical bird speed
    ⍜(Bird~YSpeed State~Game~Bird|+Gravity)

    # Move the pipes
    ⍜(State~Game~Pipes|≡⍜(Pipe~X|-PipeMovementSpeed))

    # Find the number of unscored pipes that are past the screen
    # (Should normally be at most 1 at a time)
    ⟜(/+≡ShouldBeScored State~Game~Pipes)

    # Increment the score for each of them
    ⍜(State~Game~Score|+)

    # Mark the pipes past the bird as scored
    ⍜(State~Game~Pipes|⍜(▽|≡(⍜Pipe~Scored⋅1)) ⊸≡ShouldBeScored)

    # Remove pipes off screen
    ⍜(State~Game~Pipes|▽≡(>¯64Pipe~X).)

    # Spawn new pipes when there aren't enough
    ⊸(<4⧻State~Game~Pipes)
    ⍥(⍜(State~Game~Pipes|⊂SpawnPipe +240 ×3GapsBetweenPipes))

    # Draw screen
    ⟜(DrawBird State~Game~Bird)
    ⟜(DrawPipes State~Game~Pipes)
    ⟜(DrawScore State~Game~Score)

    # When space is pressed - jump
    R~IsKeyPressed @\s
    ⍥(⍜(Bird~YSpeed State~Game~Bird|⋅JumpSpeed))
  )
)

HandleGameOverState ← (
  R~DrawTextCentered "Game over" [320 180] 40 R~Color~Black
  ⟜(R~DrawTextCentered⊃($"Your score: _" State~GameOver~Score|[320 250] 40 R~Color~Black))
  R~DrawTextCentered "Press space to restart" [320 320] 20 R~Color~Black

  # When space is pressed - create a new game state
  R~IsKeyPressed @\s
  ⍥(CreateGameState◌)
)

TestFor! ←^ $"_°_".⊢

MainLoop ← (
  R~ClearBackground R~Color~SkyBlue
  R~BeginDrawing

  # Note the usage of ⍩ - it allows errors to happen in that branch.
  # Without it, if the pattern matching passes and something
  # goes wrong in the handler - it will try the next state branch,
  # which is not what we want.

  ⍣(⍩(HandleMenuState) TestFor!State~Menu
  | ⍩(HandleGameState) TestFor!State~Game
  | ⍩(HandleGameOverState) TestFor!State~GameOver
  | ⍤$"Invalid state: _":0
  )

  R~EndDrawing
)

State~Menu

map {} {}
insert∩□ "bird_sprite" R~LoadTexture RelativeFile "bird.png"
insert∩□ "pipes_sprite" R~LoadTexture RelativeFile "pipes.png"

⬚∘⍢(MainLoop|¬R~WindowShouldClose)
R~CloseWindow
