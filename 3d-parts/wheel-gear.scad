$fn=100;

wheelW=34;

module wheelBumps() {
    bumps=60;
    for(rot=[1:bumps]) {
        rotate([0,0,360 - rot * 360/bumps]) 
            translate([165/2,0,-wheelW/2]) 
                cube([4,4,wheelW/2]);
    }
}

module wheelSpokes() {
    spokes=5;
    intersection() {
        for(rot=[1:spokes]) {
            rotate([0,0,360 - rot * 360/spokes]) 
                hull() {
                    translate([10,10,9]) rotate([0,0,45]) cube([1,10,18], center=true);
                    translate([50,50,13/2]) rotate([0,0,45]) cube([1,46,13], center=true);
                }
        }
        scale([1,1,0.185]) sphere(d=180);
    }
}

module wheelGear() {
    color([0.1,0.1,0.1]) {
        // external
        difference() {
            cylinder(d=165,h=wheelW, center=true);
            cylinder(d=135,h=wheelW+0.1, center=true);
        }
        
        // wheel bumps
        wheelBumps();
        translate([0,0,wheelW/2])
            rotate([0,0,3.1]) 
                wheelBumps();
    }
    
    color([1,1,1]) {
        // internal
        difference() {
            cylinder(d=30,h=wheelW, center=true);
            cylinder(d=10,h=wheelW+0.1, center=true);
        }
        
        spokes=5;
        // spokes left
        union() {
            wheelSpokes();
            rotate([0,180,18]) wheelSpokes();
        }
    }
}

wheelGear();