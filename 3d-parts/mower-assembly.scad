$fn=50;

use<wheel-360.scad>
use<wheel-gear.scad>
use<motor-xd-3420.scad>
use<motor-cut-support.scad>
use<motor-cut-adapter.scad>
use<motor-cut-disc.scad>
use<motor-gear-30rpm.scad>

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

// left swiveling wheel
translate([mower_length/2+40,mower_width/2-50,32]) rotate([90,0,0]) wheel360();
// right swiveling wheel
translate([mower_length/2+40,-mower_width/2+50,32]) rotate([90,0,0]) wheel360();

// motor grass cut
translate([0,0,52+90]) rotate([180,0,90]) motorXD3420();
color([1,0,0.2],0.8) rotate([0,0,90]) translate([0,0,10+52]) motorCutSupport();
// motor cut disc
translate([0,0,20]) motorCutDisc();
translate([0,0,53]) rotate([180,0,0]) motorCutGrassAdapter();

// motor gear right
translate([-110,-85,173/2-8]) rotate([90,0,0]) motorGear30RPM();
// motor gear left
translate([-110,85,173/2-8]) rotate([90,0,180]) motorGear30RPM();
// wheel right
translate([-110,-190,173/2]) rotate([90,0,180]) wheelGear();
// wheel left
translate([-110,190,173/2]) rotate([90,0,0]) wheelGear();
