$fn=100;

module motorGear30RPM() {
    union() {
        translate([0,0,3]) cylinder(d=13, h=6);
        color([255/256,215/256,0]) translate([0,0,6]) cylinder(d=36, h=32);
        color([192/256,192/256,192/256]) {
            translate([0,0,6+32]) {
                difference() {
                    cylinder(d=37, h=27);
                    
                    // fix holes
                    for(rot=[1:6]) {
                        rotate([0,0,18+360 - rot * 360/6]) 
                            translate([12,10,23]) 
                                cylinder(h=5, d=3);
                    }
                }
            }
                
            translate([0,7.2,6+32+27]) {
                cylinder(d=6,h=20);
                cylinder(d=10,h=5);
            }
        }
        
        // power
        for(rot=[1:2]) {
            rotate([0,0,360 - rot * 360/2]) 
                translate([(24/2),0,0]) 
                    cylinder(d=3, h=6);
        }
    }
}

motorGear30RPM();