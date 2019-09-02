$fn = 100;

module wheelBearing() {
    // wheel
    color([0.1,0.1,0.1])
    hull() {
        rotate_extrude(convexity = 10) translate([(63-18)/2, 0, 0]) circle(d = 18);
        cylinder(d=12, h=18, center=true);
    }
}

module bearing() {
    // bearing 608zz
    br = 11.15; // bearing radius with tolerance for insertion
    bh = 7;     // bearing height
    ir = 4.3;  // threaded rod radius + ample tolerance
    t = 4; 
    e = 0.02;
    
    color([0.3,0.3,0.3]) {
        difference() {
            translate([10,47,0]) rotate([90,0,0]) cylinder(r=br-e, h=bh+e+0.01);
            translate([10,47,0]) rotate([90,0,0]) cylinder(r=ir-e, h=bh+e+0.01);
        }
        translate([10,100,0]) rotate([90,0,0]) cylinder(d=6, h=65);
    }
}

module wheelSupport() {

    // bearing 608zz
    br = 11.15; // bearing radius with tolerance for insertion
    bh = 7;     // bearing height
    ir = 4.3;  // threaded rod radius + ample tolerance
    t = 4; 
    e = 0.02; 

    // base
    width=5;
    top_width=10;
    dist_axe=37;
    screw_diameter=3.2;

    module side() {
        color([0.9,0.9,0.9])
        difference() {
            union() {
                hull() {
                    translate([0,0,24/2]) cylinder(d=12, h=1);
                    translate([0,0,30/2]) cylinder(d=22, h=width);
                }
                hull() {
                    translate([0,0,30/2]) cylinder(d=22, h=width);
                    translate([-5,dist_axe,30/2-5]) cube([30,width,width+5]);
                }
                hull() {
                    translate([30/2-5,dist_axe+top_width/2,0]) cube([35,top_width,30], center=true);
                    translate([-5,dist_axe,30/2]) cube([30,width,width]);
                }            
            }
            
            cylinder(d=6.5, h=41, center=true);
        }
    }

    difference() {
        union() {
            side();
            mirror([0, 0, 1]) side();
        }
        
        translate([30/2-5,dist_axe+top_width,0]) {
            hull() {
                rotate([90,0,0]) cylinder(r=br+e, h=bh+e);
                translate([0,-2,0]) rotate([90,0,0]) cylinder(d=20, h=bh+e);
            }        
            rotate([90,0,0]) cylinder(d=20, h=41, center=true);
            
            rotate([90,0,0])
                for(rot=[1:2]) {
                    rotate([0,0,20 + 360 - rot * 360/2]) 
                        translate([br+3,0,-5]) 
                            cylinder(h=20, d=screw_diameter);
                }
        }
    }
}

module wheel360() {
    wheelBearing();
    wheelSupport();
    bearing();
}

wheel360();