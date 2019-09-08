$fn=100;

use<mowing-system-motor-xd-3420.scad>
use<mowing-system-disc-nylon.scad>

/** Axle to Disc Adaptor
 */
// 5 + 26.5 - 7.5
module mowingSystemAxleToDiscAdaptor() {
    shaft_length=26.5+5-7.5;
    color([0.9,0.9,0.9])
    difference() {        
        union() {
            // disc M15
            cylinder(d=16,h=shaft_length);    
            translate([0,0,10]) cylinder(r1=16/2,r2=25/2,h=10);
        }
        
        // motor rotor M8
        cylinder(d=8.5,h=shaft_length+0.01);
        
        // M3 fix screw
        translate([0,0,5]) rotate([90,0,0]) cylinder(d=3.1,h=40, center=true);
    }    
}

/** Plate support
 */
module mowingSystemSupport() {
    color([0.9,0.2,0.2])
    difference() {
        union() {
            cube([80,80,5], center=true);
            //cylinder(d=52+5, h=15);
        }
        //cylinder(d=52, h=16);
        cylinder(d=27,h=5.5,center=true);
        
        translate([41.5/2,0,0]) cylinder(d=4.5,h=5.5,center=true);
        translate([-41.5/2,0,0]) cylinder(d=4.5,h=5.5,center=true);
        
        for(rot=[1:4]) {
            rotate([0,0,45+360 - rot * 360/4]) 
                translate([41,0,0]) 
                    cylinder(d=6, h=5.5, center=true);
        }
    }
}

module mowingSystemAssembly() {
    rotate([0,180,0]) motorXD3420();
    translate([0,0,-80]) mowingSystemSupport();
    translate([0,0,-89.5]) rotate([0,180,90]) mowingSystemAxleToDiscAdaptor();
    translate([0,0,-120]) mowingSystemDiscNylon();
}

color([141/256,97/256,66/256])
difference() {
    translate([0,0,-87]) cube([150,150,10], center=true);
    translate([0,0,-87]) cylinder(d=52,h=50, center=true);
}
translate([0,0,-15]) mowingSystemAssembly();