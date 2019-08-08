$fn=100;

use<wheel-360.scad>
use<motor-xd-3420.scad>
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
translate([0,0,100]) rotate([180,0,90]) motorXD3420();
// motor gear right
translate([-150,-85,5+37/2]) rotate([90,0,0]) motorGear30RPM();
// motor gear left
translate([-150,85,5+37/2]) rotate([90,0,180]) motorGear30RPM();
