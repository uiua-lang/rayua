# Rayua

[Raylib](https://raylib.com) bindings for [Uiua](https://uiua.org)

This is a work in progress and is not yet ready for general use, but feel free to experiment with it and suggest improvements.

Filling out these bindings will be used to test Uiua's [`&ffi`](https://uiua.org/docs/&ffi) function for correctness.

# How to use

To use the library, simply include the repository:
```uiua
R ~ "git: github.com/uiua-lang/rayua"
```

Check out `examples/example_minimal.ua` for minimal setup for a Rayua application. Check out other examples for more usage examples.

# Examples

To run an example - checkout the main branch and run:
```bash
uiua run examples/<filename.ua>
```

Available examples:
- `example_minimal.ua` - Minimal Rayua application.
- `example_mouse.ua` - Demonstrates mouse handling.
- `example_shapes.ua` - Demonstrates drawing shapes.
- `example_textures.ua` - Demonstrates loading and drawing textures.
- `example_flappy_bird.ua` - A flappy bird game example
