$fn=50;

use<wheel-360.scad>
use<wheel-gear.scad>
use<motor-xd-3420.scad>
use<motor-cut-support.scad>
use<motor-gear-30rpm.scad>

mower_width=300;
mower_length=400;
mower_base_high=10;

difference() {
    cube([mower_length,mower_width,mower_base_high], center=true);
    translate([mower_length/2-50,mower_width/2-50,0]) cylinder(d=60,h=11,center=true);
    translate([mower_length/2-50,-mower_width/2+50,0]) cylinder(d=60,h=11,center=true);
    cylinder(d=24,h=11,center=true);
}

// ground grass
color([0,1,0.3]) translate([0,0,-70]) cube([500,500,10], center=true);

// rotor
translate([0,0,-20])
difference() {
    cylinder(d=110,h=10);
    cylinder(d=15,h=10);
}

// left wheel
translate([mower_length/2-60,mower_width/2-50,-35]) rotate([90,0,0]) wheel360();
// right wheel
translate([mower_length/2-60,-mower_width/2+50,-35]) rotate([90,0,0]) wheel360();
// motor grass cut
translate([0,0,90]) rotate([180,0,90]) motorXD3420();
color([1,0,0.2],0.8) rotate([0,0,90]) translate([0,0,10]) motorCutSupport();

// motor gear right
translate([-150,-85,5+37/2]) rotate([90,0,0]) motorGear30RPM();
// motor gear left
translate([-150,85,5+37/2]) rotate([90,0,180]) motorGear30RPM();
// wheel right
translate([-150,-190,5+37/2]) rotate([90,0,180]) wheelGear();
// wheel left
translate([-150,190,5+37/2]) rotate([90,0,0]) wheelGear();

