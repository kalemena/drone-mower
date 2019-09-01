$fn=50;

use<wheel-360.scad>
use<gear-parts.scad>
use<gear-motor-30rpm.scad>
use<mowing-system-parts.scad>
use<mowing-system-motor-xd-3420.scad>

mower_width=300;
mower_length=300;
mower_base_high=10;

// ground grass 0z
color([0,1,0.3]) translate([0,0,-10/2]) cube([1000,1000,10], center=true);

// mower base
color([141/256,97/256,66/256]) {
    translate([0,0,55])
    difference() {
        cube([mower_length,mower_width,mower_base_high], center=true);
        //translate([mower_length/2-50,mower_width/2-50,0]) cylinder(d=60,h=11,center=true);
        //translate([mower_length/2-50,-mower_width/2+50,0]) cylinder(d=60,h=11,center=true);
        cylinder(d=24,h=11,center=true);
    }

    translate([170,0,90]) cube([120, mower_width,10], center=true);
}

translate([-100,-180,90]) rotate([0,0,90]) gearAssembly();
translate([-100,180,90]) rotate([0,0,-90]) gearAssembly();
translate([0,0,142]) mowingSystemAssembly();

// left swiveling wheel
translate([mower_length/2+40,mower_width/2-50,32]) rotate([90,0,0]) wheel360();
// right swiveling wheel
translate([mower_length/2+40,-mower_width/2+50,32]) rotate([90,0,0]) wheel360();
