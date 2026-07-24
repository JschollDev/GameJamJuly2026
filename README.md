1. **Project / Version Control** — repo structure, Godot config, project organization, Git settings.
    - [ ]  Create the Godot project and Git repository
    - [ ]  Set up base folders and naming conventions
    - [ ]  Configure `.gitignore`, `.gitattributes`, and tracked project settings
    - [ ]  Confirm the project opens and syncs correctly from Git
    - [ ]  Create a clean starting commit / jam-ready baseline
2. **Settings / Global Configuration** — shared config, audio/display/input preferences, global values.
    - [ ]  Create the global settings/config structure
    - [ ]  Add only required setting categories
    - [ ]  Connect settings to the systems they control
    - [ ]  Add persistence between launches
    - [ ]  Verify settings apply and restore correctly
3. **Game Data / Resources** — reusable data structures and configurable Godot resources.
    - [ ] Testing Textures / Images (I think these were made by Kenny)
	- [ ]  Identify what game information should be data-driven
    - [ ]  Create the minimum required resource/data structures
    - [ ]  Move shared values out of individual scripts where useful
    - [ ]  Connect gameplay systems to those resources
    - [ ]  Clean up and remove data structures that are not actually being used
4. **Player Control / Interaction** — core input handling and how the player acts in the world.
    - [ ]  Define required player actions
    - [ ]  Map keyboard and controller inputs
    - [ ]  Implement basic player control
    - [ ]  Add required interaction/action behavior
    - [ ]  Test responsiveness and remove unnecessary complexity
5. **Core Gameplay Systems** — the actual mechanics the game is built around.
    - [ ]  Define the minimum playable mechanic
    - [ ]  Build the first functional version
    - [ ]  Connect supporting gameplay rules
    - [ ]  Playtest and adjust the mechanic
    - [ ]  Lock the gameplay scope and stop adding systems
6. **Game Flow / State** — menu, active play, pause, restart, win/loss, transitions.
    - [ ]  Establish the major game states
    - [ ]  Connect starting and entering gameplay
    - [ ]  Add pause and resume behavior
    - [ ]  Add win/loss and restart behavior
    - [ ]  Test the complete start-to-finish game loop
7. **Scene / Level Structure** — how gameplay spaces, levels, or encounters are organized.
    - [ ]  Establish the base scene hierarchy
    - [ ]  Build the first playable environment
    - [ ]  Organize gameplay objects and reusable scene pieces
    - [ ]  Complete the required level/content layout
    - [ ]  Test scene loading, restarting, and progression
8. **UI / HUD** — menus, prompts, HUD elements, and player-facing feedback.
    - [ ]  Create the primary menu structure
    - [ ]  Add the minimum gameplay HUD
    - [ ]  Add keyboard/controller prompts where needed
    - [ ]  Connect UI to actual gameplay state/data
    - [ ]  Clean up readability, navigation, and visual consistency
9. **Audio System** — music, gameplay sounds, UI sounds, routing, and volume control.
    - [ ]  Establish audio buses/categories
    - [ ]  Add essential gameplay sounds
    - [ ]  Add essential UI sounds
    - [ ]  Add music/ambient audio if appropriate
    - [ ]  Balance levels and confirm settings control everything correctly
10. **Visual / Art Foundation** — common materials, UI theme, shaders, effects, reusable visual assets.
	- [ ]  Establish the game's basic visual direction
	- [ ]  Replace temporary assets that materially affect readability
	- [ ]  Apply consistent materials, colors, and UI styling
	- [ ]  Add only the effects that improve gameplay feedback
	- [ ]  Perform a final visual consistency/polish pass

11. **Build / Export / Submission** — export presets, build testing, packaging, and final jam submission.
	- [ ]  Configure export presets early
	- [ ]  Produce and test an initial standalone build
	- [ ]  Re-test builds as major systems are completed
	- [ ]  Prepare final executable/package and submission materials
	- [ ]  Perform a clean-machine-style final test and submit
