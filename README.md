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

## Build and use notes
* The tiny holes in the bearing blocks are for brass wire to retain the bearings.  This is a lot easier to use than *#$&^%@ snap rings.
* The "Nozzle High" customizer setting is the one I prefer.  It mounts the Hemera fairly high and well in between the guide rods.  The other setting has it squarely straddling the lower bearing block.
* The square tunnel under the left-hand (looking from the front) bearing block is so that the wiring harness from a BLTouch can pass neatly under.  It has a pair of holes on each side of the tunnel for cable ties to strain-relieve the wiring.
* The screw hole pattern on the right-hand bearing block, which matches the pattern a normal, detached bearing block would have, is for affixing extra items to the frot of the plate.  I use the upper row to attach my cable chain. Note that in the "Nozzle high" position, the lower row of holes is nearly useless, since it is partly covered by the drive motor on the Hemera.

## Status Updates
* As of Feb. 21, 2020, I have been printing using this mount on my printer.   It took about 3 hours from opening the Hemera box until I got my first print.  
* 2020-02-23 Moved screw holes on BLTouch mount out 1 mm to eliminate collision between power connector on BLTouch and Hemerea body.  With them in their previous position, the BLTouch was slightly angled because of this collision. It works fine, nonetheless.
* 2020-02-24 Working on actually documenting the project so it is useful on GitHub

## License
CC BY-NC-SA 4.0 ([https://creativecommons.org/licenses/by-nc-sa/4.0/]())
Non-commercial sharing permitted with attribution.


