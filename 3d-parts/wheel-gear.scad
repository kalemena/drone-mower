$fn=100;

module wheelGear() {
    // external
    difference() {
        cylinder(d=173,h=15);
        cylinder(d=173-20,h=15);
    }

    // internal
    union() {
        cylinder(d=40,h=18);
        translate([0,0,18]) 
            difference() {
                cylinder(d=30,h=15);
                cylinder(d=10,h=25);
            }
    }

    // spokes
    spokes=6;
    for(rot=[1:spokes]) {
        rotate([0,0,360 - rot * 360/spokes]) 
            hull() {
                translate([10,10,9]) rotate([0,0,45]) cube([1,12,18], center=true);
                translate([60,60,13/2]) rotate([0,0,45]) cube([1,10,13], center=true);
            }
    }

    // wheel bumps
    bumps=80;
    for(rot=[1:bumps]) {
        rotate([0,0,360 - rot * 360/bumps]) 
            translate([173/2,0,0]) 
                cube([2,3.5,15/2]);
    }

    translate([0,0,15/2])
    for(rot=[1:bumps]) {
        rotate([0,0,2+360 - rot * 360/bumps]) 
            translate([173/2,0,0]) 
                cube([2,3.5,15/2]);
    }
}

wheelGear();