$fn=100;

/** Wheel External side bolts
 */
module screwBoltsExt() {
    // screw diameter
    // 6.4 for 6mm, 8.5 for 8mm, 7.6 for 7mm
    screwDiamExt=8.5;
    screwDiamInt=7.6;
    
    difference() {
        union() {
            cylinder(d=14,h=2);
            cylinder(d=10+0.1,h=2+7);        
        }
        
        translate([0,0,-0.01]) cylinder(d=screwDiamExt,h=10+0.01);         
    }
}


/** Wheel Internal side boltss
 */
module screwBoltsInt() {
    // screw diameter
    // 6.4 for 6mm, 8.5 for 8mm, 7.6 for 7mm
    screwDiamExt=8.5;
    screwDiamInt=7.6;
    
    difference() {
        union() {
            difference() {
                union() {
                    cylinder(d=15,h=8);
                    translate([0,0,8]) cylinder(d1=15, d2=26,h=6);
                    translate([0,0,8+6]) cylinder(d=26,h=3+3);                   
                }
                translate([0,0,8+6+3]) cylinder(d=20,h=3+0.01);
                for(rot=[1:6]) {
                    rotate([0,0,360 - rot * 360/6])
                        translate([12.5,0,6+12.5]) 
                            cube([6,2.3,3+0.01], center=true);
                }
                // M3 fix screw
                translate([0,0,4.5]) rotate([0,90,0]) cylinder(d=2.3,h=40, center=true);
            }
            translate([0,0,8+6]) cylinder(d=10+0.1,h=2+7); 
        }
        translate([0,0,-0.01]) cylinder(d=screwDiamInt,h=25+0.02);
    }
}

module screwBoltsShaft() {
    // screw diameter
    // 6.4 for 6mm, 8.5 for 8mm, 7.6 for 7mm
    screwDiamExt=8.5;
    screwDiamInt=7.6;

    motorAxleDiam=6.4;
    
    difference() {
        cylinder(d=21,h=30);
        
        // rotor axle
        translate([0,0,-0.01]) cylinder(d=motorAxleDiam,h=14+0.02);
        translate([0,0,14]) cylinder(d1=motorAxleDiam, d2=screwDiamInt,h=2+0.01);
        translate([0,0,14+2]) cylinder(d=screwDiamInt,h=14+0.02);
        
        // M3 fix screws
        translate([4.5,-6/2,-0.01]) cube([3.2,6,9+0.02]); 
        translate([20,0,5]) rotate([0,90,0]) cylinder(d=3.1,h=40, center=true);
        
        translate([4.5,-6/2,30-9]) cube([3.2,6,9+0.02]); 
        translate([20,0,30-5]) rotate([0,90,0]) cylinder(d=3.1,h=40, center=true);
    }
}

module bearingAxle() {
    bearingH=7;
    screwDiamInt=7.6;
    difference() {
        union() {
            cylinder(d1=15,d2=12,h=2);
            translate([0,0,2]) cylinder(d=8,h=bearingH);
        }
        cylinder(d=screwDiamInt,h=10);
    }
}

//screwBoltsExt();
//screwBoltsInt();
//screwBoltsShaft();
//bearingAxle();

