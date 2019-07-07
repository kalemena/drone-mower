$fn = 100;

// bearing 608zz
br = 11.15; // bearing radius with tolerance for insertion
bh = 7;     // bearing height
ir = 4.3;  // threaded rod radius + ample tolerance
t = 4; 
e = 0.02; 

// wheel + bearing
difference() {
    hull() {
        rotate_extrude(convexity = 10) translate([15, 0, 0]) circle(r = 15);
        cylinder(d=10,h=15);
    }
    translate([0,0,15-bh-e]) cylinder(r=br+e, h=bh+e);
    translate([0,0,0]) cylinder(h=15-bh, r1=2.5, r2=br);
    translate([-30,-30,-15]) cube([60,60,15]); 
}