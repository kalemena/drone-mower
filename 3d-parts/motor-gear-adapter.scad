$fn=100;

/** Wheel External side bolts
 */
module screwBoltsExt() {
    difference() {
        union() {
            cylinder(d=14,h=2);
            cylinder(d=10+0.1,h=2+7);        
        }
        cylinder(d=6.4,h=10+0.01);
        translate([0,0,-0.1]) cylinder(d1=8, d2=6.4,h=1);
    }
}


/** Wheel Internal side bolts
 */
module screwBoltsInt() {
    difference() {
        union() {
            cylinder(d1=12, d2=26,h=10);
            translate([0,0,10]) cylinder(d=26,h=3+3);            
        }
        cylinder(d=6.4,h=16+0.01);
        translate([0,0,10+3]) cylinder(d=20,h=3+0.01);
        for(rot=[1:6]) {
            rotate([0,0,360 - rot * 360/6])
                translate([12.5,0,14.5]) 
                    cube([6,2.3,3+0.01], center=true);
        }
    }
}

module screwBoltsShaft() {
    difference() {
        union() {
            cylinder(d=8,h=6);
            translate([0,0,6]) cylinder(d1=12, d2=20,h=10);
            translate([0,0,6+10]) cylinder(d=20,h=25);
            // translate([2,-3,31]) cube([2,6,10]);   
        }
        
        // screw hole
        cylinder(d=6.4,h=45+0.01);
        
        // M3 fix screw
        translate([20,0,6+35-5]) rotate([0,90,0]) cylinder(d=3.1,h=40, center=true);
        translate([20,0,6+35-20]) rotate([0,90,0]) cylinder(d=3.1,h=40, center=true);
        translate([4,-6.5/2,6+10+0.01]) cube([3.5,6.5,25]);        
    }
}

// screwBoltsExt();
//screwBoltsInt();
screwBoltsShaft();
