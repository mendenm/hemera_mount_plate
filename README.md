# Hemera Extruder Mounting Plate for Anet A8 - type printers
Designed by Marcus Mendenhall, February, 2020
## Purpose
This project is to develop an very easy-to-use, 3D printable,  adapter plate to mount an E3D Hemera Extruder ([https://e3d-online.com/e3d-hemera]()) on a 3d printer of the type similar to an Anet A8, Ender 3, or (probably) most Prusa I3-derived printers.

## Features

The design of plate incorporates a number of critical features. 

1.  The bearing mounting blocks are printed directly onto the plate, greatly reducing the number of screws required to assemble, and the weight.
1. The bottom bearing block is self-aligning.  The design makes it fairly insensitive to the spacing between the guides rods on the printer, and also fairly robust against inaccuracies in the printing itself.  Any rod spacing between 45 mm and 48 mm should work without even modifying the design.
1. The design is in OpenSCAD ([https://www.openscad.org]()), making it very easy to customize.  It is set up with OpenSCAD Customizer-compatible parameters at the top, making simple changes to the design as easy as filling in a dialog box.
1. The plate has an integrated mount for a BLTouch bed sensor ([https://www.antclabs.com]()), tightly fit inbetween the Hemera and the guide rods, putting it only 25 mm from the nozzle, with zero x offset.

## Status Updates
* As of Feb. 21, 2020, I have been printing using this mount on my printer.   It took about 3 hours from opening the Hemera box until I got my first print.  
* 2020-02-23 Moved screw holes on BLTouch mount out 1 mm to eliminate collision between power connector on BLTouch and Hemerea body.  With them in their previous position, the BLTouch was slightly angled because of this collision. It works fine, nonetheless.
* 2020-02-24 Working on actually documenting the project so it is useful on GitHub

## License
CC BY-NC-SA 4.0 ([https://creativecommons.org/licenses/by-nc-sa/4.0/]())
Non-commercial sharing permitted with attribution.


