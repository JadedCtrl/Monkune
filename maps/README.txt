MAP EDITING
================================================================================
Monkune maps are made using Tiled (https://mapeditor.org), and are made up of
rectangle objects and text-boxes. No tilesets are used.

Rectangles will be filled with a random color.
Text-box formatting will be ignored, but the text is used.

You can set the spawn point of the monkey party with a point object of type
"spawn". Otherwise, it defaults to (100,100).

Export your map to Lua, put it in a custom "maps" folder, and you're good to go!
