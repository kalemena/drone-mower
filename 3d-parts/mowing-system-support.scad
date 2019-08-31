$fn = 100;

use<motor-xd-3420.scad>
use<motor-cut-adapter.scad>

module motorCutSupport() {
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

motorCutSupport();
