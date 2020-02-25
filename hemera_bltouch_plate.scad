inch=25.4+0; // make it an equation to shiwld from customizer

// distance between rods on x-axis
x_rod_spacing=46; 

// distance between centers of top double bearing
bearing_axial_separation=30;

// thickness of back plate
main_plate_thickness=5; // [3:1:10]

// diameter of x guide rods
rod_dia=8.0;

// outside diameter of linear bearing
nominal_bearing_dia=15.0; 

// Length of actual linear bearing
bearing_length=24;  

// print clearance to make bearing fit
bearing_clearance = 0.2; // [0:0.01:0.4]

bearing_dia=nominal_bearing_dia+bearing_clearance; 

// distance of bearing centerline above back plate
bearing_centerline_height=13; 

rod_clearance_dia=rod_dia+2; // room inside bearing housings, wire half spacing

// thickness of bearing outer wall
bearing_sleeve_thickness=2.0; // [1:0.1:4]

bearing_base_thickness=bearing_centerline_height-nominal_bearing_dia/2-2;

// extra length of bearing block over nominal bearing length
bearing_overhang=5.0;

bearing_base_width_1=nominal_bearing_dia+2*bearing_sleeve_thickness+4;
bearing_base_width_2=bearing_base_width_1;

// diameter of hole for wire to keep bearing in block
bearing_retainer_wire_dia=1.0;
bearing_retainer_wire_spacing=bearing_length+bearing_retainer_wire_dia;
bearing_block_total_length=bearing_retainer_wire_spacing+bearing_overhang;

// altitude of lower bearing, probably always zero
lower_bearing_z=0;

// distance between belt holder and bottom rail
belt_offset_from_bottom_rail=17.9;

// from hemera manual
hemera_bottom_screw_to_nozzle=24.2; 
// altitude of bottom screw holes on hemera
hemera_bottom_screw_z=-14;

hemera_nozzle_z=hemera_bottom_screw_z-hemera_bottom_screw_to_nozzle;

// global_rotate sets whether 'z' is up for design, or 'y' is up for printing on its back
global_rotate_x=0; // [0:"world", 90:"printing"]
global_rotate=[global_rotate_x,0,0];

module chamferedBox(shape, depth=1.0, xy=true, yz=true, zx=true)
{
    xw= shape[0]; yw=shape[1]; zw=shape[2];
    l1=sqrt(2)*((xw+yw)/2 - depth);
    l2=sqrt(2)*((xw+zw)/2 - depth);
    l3=sqrt(2)*((yw+zw)/2 - depth);
    
intersection() {
        cube(shape, center=true);
        if(xy) rotate([0,0,45]) 
            cube([l1,l1, zw+2], center=true);
        if(yz) rotate([45,0,0]) 
            cube([xw+2,l3, l3], center=true);
        if(zx) rotate([0,45,0]) 
            cube([l2, yw+2, l2], center=true);
    }    
}


module bearing_screw_pattern(include_hex=false) {
    screw_hole_long_spacing=18;
    screw_hole_transverse_spacing=24;
    screw_hole_dia=4.5; // m4 screw clearance
    screw_head_across_flats=7.2; // m4 hex nut is 7 mm
    for(x=[-1/2,1/2], y=[-1/2, 1/2]) 
        translate([x*screw_hole_long_spacing,
            0, y*screw_hole_transverse_spacing]) 
        rotate([90,0,0]) {
            translate([0,0,-0.1]) cylinder(d=screw_hole_dia, h=20, $fn=20);
            if(include_hex) translate([0,0,-19.99]) 
                cylinder(d=screw_head_across_flats/cos(30), 
                    h=20, $fn=6);
        }
}


// a bltouch2 smart with the top at [0,0,0] 
// and the pin bottom at the trigger height
module bltouch2(nozzle_z) {
    bltouch_flange_top_to_nozzle=44; // trigger height recommended from manual
    bltouch_flange_top_z=nozzle_z+bltouch_flange_top_to_nozzle;
    bltouch_thickness=0.45*inch;
    bltouch_centerline=0; 
    bltouch_magnet_ring_height=7.7; //from manual, a  little less
    bltouch_flange_thickness=2.3; // from manual
    bltouch_flange_bottom_offset=bltouch_flange_top_z-bltouch_flange_thickness;
    bltouch_body_length=26.3;
    bltouch_body_bottom=-(bltouch_flange_thickness+bltouch_magnet_ring_height+bltouch_body_length);
    translate([0,0,bltouch_flange_top_z]) {
    translate([0,0,-bltouch_flange_thickness]) 
    linear_extrude(height=bltouch_flange_thickness) difference() {
        hull() {
                square(11.5, center=true);
                translate([-9,0]) circle(d=8);
                translate([ 9,0]) circle(d=8);
            }
            translate([-9,0]) circle(d=3.2, $fn=20);
            translate([ 9,0]) circle(d=3.2, $fn=20);
    }
    translate([0,0,-10]) 
        cylinder(d=8, h=bltouch_magnet_ring_height);
    translate([0,0,bltouch_body_bottom]) intersection() {
        cylinder(d=13, h=bltouch_body_length);
        cube([20,11.5,100], center=true);
    }
    translate([0,0,-bltouch_flange_top_to_nozzle]) 
        cylinder(d=2, h=7.6);
}
}
    
module bltouch_mount_plate(nozzle_z)
{
  bltouch_flange_top_to_nozzle=44; // trigger height 
  translate([0,0,bltouch_flange_top_to_nozzle+nozzle_z]) {
      translate([0,(main_plate_thickness+8)/2-main_plate_thickness,2.5]) 
      difference() {
          translate([2,0,0]) 
            chamferedBox([31,main_plate_thickness+8,5], 
                depth=2, xy=true, yz=false, zx=false);
          for(dx=[-9,9]) translate([dx,1,0])
              cylinder(d=3.5,h=20,$fn=10, center=true);
          if(0) translate([0,4,0]) rotate([0,90,0])
              cylinder(d=3,h=50,$fn=10, center=true);
          translate([0,-(main_plate_thickness+8)/2,0]) chamferedBox([10,4,6],
                depth=1, xy=true, yz=false, zx=false);
      }
  }
}

module hemera_bolt_holes() {
    // the lower holes are at z=0
        for(x=[-1,1], z=[0,2]) 
        translate([17*x, 0, 17*z])
        rotate([-90,0,0]) {
            translate([0,0,-59]) cylinder(d=3.5, h=60, $fn=20);
        translate([0,0,-0.01]) cylinder(d=6, h=10, $fn=20);            
        }
}

module gt2_teeth(lwh) {
    // a block of teeth, distributed along the 'x' axis, 
    // with the block having a transverse dimension along 'y'
    // and a height along 'z'
    // with the origin in the middle of the teeth
    l=lwh[0];
    w=lwh[1];
    h=lwh[2];
    
    teeth=floor(l/2);
    translate([-l/2, -w/2, h]) 
    rotate([-90,0,0])
    linear_extrude(height=w) {
        difference() {
            union() {
                square([l,h]);
                for(i=[0:teeth-1])
                    translate([(i+0.5)*2,h])
                        circle(d=0.999, $fn=20);
            }
            for(i=[0:teeth])
                translate([i*2,h])
                    circle(d=0.999, $fn=20);
        }
    }
}

module basic_belt_anchor() {
    translate([-8, bearing_centerline_height,0]) 
        gt2_teeth([10,6,5]);
    translate([8, bearing_centerline_height, 0]) 
        gt2_teeth([10,6,5]);
    translate([0, (bearing_centerline_height-3)/2+0.2,1]) 
        cube([26, bearing_centerline_height-3+0.4, 8], 
        center=true);
    translate([0, (bearing_centerline_height+3)/2+0.2,-2.5]) 
        cube([26, bearing_centerline_height+3+0.4, 2], 
        center=true);    
}    

module belt_anchor(tunnel=false) {
    difference() {
        union() {
            basic_belt_anchor();
            translate([0,(bearing_centerline_height+3)/2+0.2,-6])
            cube([26,(bearing_centerline_height+3)+0.2, 6], center=true);
        }
        if(tunnel) translate([0,2,0]) cube([10,4, 30], center=true);
    }
}

module bearing_block_xsect(oval=0) {
    // block cross section with base center at [0,0]
    difference() {
        union() {
            hull() {
                circle(d=bearing_dia+2*bearing_sleeve_thickness, $fn=100);
                translate(
                    [0,-bearing_centerline_height+bearing_base_thickness/2]) 
                square([bearing_base_width_1,bearing_base_thickness], center=true);
            }
            translate(
                    [0,-bearing_centerline_height+bearing_base_thickness/2]) 
                square([bearing_base_width_2,bearing_base_thickness], center=true);
        }
        if(oval==0) {
            circle(d=bearing_dia, $fn=100);
            // relieve bad bridge at top of bearing for better fit
            if(0) translate([0, bearing_dia/2-1]) square([5,3], center=true);
            else translate([0, bearing_dia/2-3]) circle(d=8, $fn=20);
        } else { // oval
            intersection() {
                rotate(30) circle(d=bearing_dia+oval, $fn=100);
                square([bearing_dia+oval, bearing_dia], center=true);
            }
        }
    }
}

module single_bearing(tunnel=false, tunnel_offset=0, oval=0) { 
    // make one end of bearing reach print plate to eliminate supports
    rod_clearance=(rod_clearance_dia+bearing_retainer_wire_dia)/2;
    l=bearing_block_total_length;
    wire_offset=(l-bearing_overhang)/2;
    rotate([0,-90,0]) 
    translate([lower_bearing_z,bearing_centerline_height,0]) 
    difference() {
        union() {
            linear_extrude(height=l, center=true,
                convexity=20) bearing_block_xsect(oval=oval);
            // a solid plastic retainer on the +z end
            translate([0,-nominal_bearing_dia/2,bearing_length/2+1]) 
                cube([nominal_bearing_dia,5,2], center=true);
        }
        // note: I used to have 4 retainer wires, hence the for loops
        // now I only have 1 wire, and an endstop, but I will leave the loops
        // in place in case this changes
        for(dz=[-bearing_retainer_wire_spacing/2])
            for(dx=[rod_clearance]) 
            translate([0,dx,dz]) 
            rotate([0,90,0]) cylinder(d=bearing_retainer_wire_dia,
                h=bearing_base_width_2*1.5,center=true);
        if(tunnel) translate([0,-bearing_centerline_height+2,tunnel_offset]) cube([30,4, 10], center=true); // hole for cable
    }
}

module m3_clearance_hole() {
    translate([0,0,2.99]) union() {
        cylinder(d=3.5, h=50, center=true, $fn=20);
        translate([0,0,-3]) 
            cylinder(d=5.6, h=3.01, $fn=20);
    }
} 

if(1) rotate(global_rotate) difference() {
    union() {
        translate([17.5,-main_plate_thickness/2,x_rod_spacing/2]) 
            chamferedBox([65,main_plate_thickness,x_rod_spacing+38],
        xy=false, yz=false, zx=true, depth=5);
        translate([bearing_axial_separation-2,0,0]) 
            rotate([0,180,0]) single_bearing(tunnel=false, oval=2);
        translate([0,0, x_rod_spacing]) 
            rotate([0,180,0])  single_bearing(tunnel=true,
                tunnel_offset=-7);
        translate([bearing_axial_separation,0, x_rod_spacing])   
            single_bearing(tunnel=false);
        translate([bearing_axial_separation,-main_plate_thickness,65]); 
        
    translate([bearing_axial_separation-2,0, belt_offset_from_bottom_rail]) belt_anchor();
    }
    // cutout in corner for BLouch mount
    translate([-6,-(main_plate_thickness+2)/2+1,0])
    difference() {
        cube([25,main_plate_thickness+2,60], center=true);
        translate([0,0,30]) rotate([0,90,0]) 
            cylinder(d=main_plate_thickness, h=50, $fn=20, center=true);
    }
    // and chamfer...
    translate([-16,-(main_plate_thickness+2)/2+1,19])
    rotate([0,-45,0]) cube([10,main_plate_thickness+2,10], center=true);
    translate([5,-(main_plate_thickness+2)/2+1,-19])
    rotate([0,-45,0]) cube([10,main_plate_thickness+2,10], center=true);
    translate([28,0,hemera_bottom_screw_z]) hemera_bolt_holes();
    translate([bearing_axial_separation,0,x_rod_spacing]) bearing_screw_pattern(include_hex=true);
    // holes for BLtouch wiring cable ties
    for(z=[-13,13], x=[-5,5]) translate([x-7,0,z+x_rod_spacing])
        rotate([90,0,0]) cylinder(d=3, h=50, $fn=10, center=true);
}

%if(1) rotate(global_rotate)
    translate([48, -main_plate_thickness+2.5,-25+hemera_bottom_screw_z])
{
rotate([90,0,-90]) import("HEMERA-MODEL-1-(3).stl", convexity=20);
    if(0) translate([-20,0,25]) hemera_bolt_holes();
}

%if(1) rotate(global_rotate) {
    translate([0,bearing_centerline_height,0])
        rotate([0,90,0]) 
            cylinder(d=rod_dia, h=100, center=true);
    translate([0,bearing_centerline_height,x_rod_spacing])
        rotate([0,90,0]) 
            cylinder(d=rod_dia, h=100, center=true);
}

%if(1) rotate(global_rotate) translate([-8,3,0]) bltouch2(hemera_nozzle_z);

rotate(global_rotate)  translate([-8,0,0])
    bltouch_mount_plate(hemera_nozzle_z);

