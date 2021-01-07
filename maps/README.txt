MAP EDITING
================================================================================
Monkune maps are made using Tiled (https://mapeditor.org), and are made up of
rectangle objects and text-boxes. No tilesets are used.

Rectangles will be filled with a random color.
Text-box formatting will be ignored, but the text is used.

You can set the spawn point of the monkey party with a point object of type
"spawn". Otherwise, it defaults to (100,100).

You can place the bannanas in the map with a point object of type "bannana".
Otherwise... it'll just pop up in (200,200).

Export your map to Lua, put it in a custom "maps" folder, and you're good to go!


Useful bits
----------------------------------------
The farthest a monkey can jump horizontally is 15 16x16 squares
The highest a monkey can jump vertically is 5 16x16 squares
