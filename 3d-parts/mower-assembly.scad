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

// mower plate
color([0.55,0.38,0.26]) {
    translate([0,0,90]) cube([mower_length, mower_width, mower_base_high], center=true);
    translate([-155,0,90]) rotate([0,90,0]) cube([100, mower_width,10], center=true);
    //translate([-5,mower_width/2+5,90]) rotate([0,90,90]) cube([100, mower_length+10,10], center=true);
    //translate([-5,-mower_width/2-5,90]) rotate([0,90,90]) cube([100, mower_length+10,10], center=true);
    //translate([mower_length/2,0,90]) rotate([0,90,0]) cube([100, mower_width+20,10], center=true);
}

// swiveling wheels
translate([mower_length/2-20-10, mower_width/2-20, 32]) rotate([90,0,0]) wheel360();
translate([mower_length/2-20-10, -mower_width/2+20, 32]) rotate([90,0,0]) wheel360();

// Gear system
translate([-190,-180,85]) rotate([-90,0,90]) gearAssembly();
translate([-190,180,85]) rotate([90,0,-90]) gearAssembly();

translate([0,0,163]) mowingSystemAssembly();
