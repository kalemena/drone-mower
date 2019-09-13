$fn=100;

difference() {
    union() {
        translate([0,-5,0]) cube([50,35,3], center=true);
        
        // screw
        translate([42.5/2,17.5/2,3]) cube([7.5,7.5,3], center=true);
        translate([-42.5/2,17.5/2,3]) cube([7.5,7.5,3], center=true);
        translate([42.5/2,-17.5/2,3]) cube([7.5,7.5,3], center=true);
        translate([-42.5/2,-17.5/2,3]) cube([7.5,7.5,3], center=true);
        
        // support
        hull() {
            translate([0,-21,8/2-1.5]) cube([50,4,8], center=true);
            translate([0,-21,19]) cube([25,4,8], center=true);
        }
    }
    translate([(42-16)/2,0,0]) cylinder(d=17.5, h=10, center=true);
    translate([-(42-16)/2,0,0]) cylinder(d=17.5, h=10, center=true);
    
    // screw
    translate([42.5/2,17.5/2,3]) cylinder(d=1.5, h=3.1, center=true);
    translate([-42.5/2,17.5/2,3]) cylinder(d=1.5, h=3.1, center=true);
    translate([42.5/2,-17.5/2,3]) cylinder(d=1.5, h=3.1, center=true);
    translate([-42.5/2,-17.5/2,3]) cylinder(d=1.5, h=3.1, center=true);
    
    // pins
    translate([0,-15,16]) rotate([90,0,0]) {
        hull() {
            cylinder(d=6.5, h=20, center=true);
            translate([0,8,0]) cylinder(d=6.5, h=20, center=true);
        }
    }
}