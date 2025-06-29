# ashes_of_nim_481
**Author**: Alexandro Nino  
**Section**: CPSC 481-02  
**Email**: alexandro.nino@csu.fullerton.edu  

---

## Overview

Ashes of Nim is a 3D implementation of the classic Game of Nim using the Godot game engine. The main feature of this project is an AI opponent with varying difficulty levels (easy, medium, and hard), which can be set by the player.

---

## Project Structure
Some files are excluded; see the 'Excluded Files' section.

```
ashes_of_nim_481/
    EndGame/                # Handles end-of-game logic and GUI
        end_game.gd              # Displays winner in GUI and updates game records
    Extras/                 # Font and Global scripts
        PlayfairDisplay-VariableFont_wght.ttf  # Font used in the GUI
        Records.gd               # Tracks total games played and player wins
        algorithms.gd            # Random, Minimax, and Alpha-Beta algorithms
        game_manager.gd          # Controls turn logic and game flow
        game_of_nim.gd           # Defines GameOfNim class and related logic
        game_settings.gd         # Stores chosen algorithm, match array, and depth limit
        game_state.gd            # Defines GameState class
    MainMenu/               # Main menu GUI
        main_menu.gd             # Handles menu navigation (Buttons)
    MatchStick/             # Matchstick 3D models and shader
        flame_shader.gdshader    # Shader for animated match flame effect
        match_stick.gd           # Script for matchstick selection and interaction
    NimGameGUI/             # GUI during active gameplay
        nim_game_gui.gd          # Script handling gameplay UI elements
    NimGameScene/           # 3D game scene and logic during active gameplay
        camera_3d.gd             # Handles camera movement and behavior
        nin_game_scene.gd        # Controls game scene layout and matchstick spawning
    Settings/               # Difficulty and game customization settings
        settings.gd              # Handles buttons, generates match array, calculates depth limit, and updates settings text
```

---

## Excluded Files
Some files and directories (e.g., `.import/`, `.godot/`, `icon.png`, autogenerated configs) are excluded from this README as they are standard or self-explanatory within the Godot engine context.

**Overview of select excluded files:**  
- `.gd.uid`: A unique identifier used by Godot 4 to reliably track script files across the project, even if they’re moved or renamed.
- `.tscn`: A Godot scene file that defines the structure and properties of game objects. Scenes can be reused like templates and can include **nodes**, scripts, and settings.
    - **Node**: The basic building block in Godot. Each scene is made up of nodes (e.g., sprites, scripts, cameras), which are organized in a tree structure to define behavior and appearance.
- `.import`: Auto-generated by Godot to store optimized versions of imported assets (like models, textures, fonts).

---

## External Libraries & References
- Godot Game Engine: https://godotengine.org/
- AIMA Minimax/Alpha-Beta Python code (adapted): https://github.com/aimacode/aima-python

---

## Data

This project does not use external datasets. All matchstick configurations are generated at runtime by the game logic. No third-party data was collected or used.

---