$fn=100;

use<wheel-gear.scad>
use<motor-gear-30rpm.scad>
use<motor-gear-support.scad>

/** Wheel External side axle
 */
module screwBoltsExt() {
    // screw diameter
    // 6.4 for 6mm, 8.5 for 8mm, 7.6 for 7mm
    screwDiamExt=8.5;
    screwDiamInt=7.6;
    
    color([0.9,0.2,0.2])
    difference() {
        union() {
            cylinder(d=14,h=2);
            cylinder(d=10+0.1,h=2+7);        
        }
        
        translate([0,0,-0.01]) cylinder(d=screwDiamExt,h=10+0.01);         
    }
}


/** Wheel Internal side axle
 */
module screwBoltsInt() {
    // screw diameter
    // 6.4 for 6mm, 8.5 for 8mm, 7.6 for 7mm
    screwDiamExt=8.5;
    screwDiamInt=7.6;
    
    color([0.9,0.2,0.2])
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
        
        // Axle
        translate([0,0,-0.01]) cylinder(d=screwDiamInt,h=25+0.02);
    }
}

/** Wheel Axle to motor coupling
 */
module screwBoltsShaft() {
    // screw diameter
    // 6.4 for 6mm, 8.5 for 8mm, 7.6 for 7mm
    screwDiamExt=8.5;
    screwDiamInt=7.6;

    motorAxleDiam=6.4;
    
    color([0.9,0.2,0.2])
    difference() {
        cylinder(d=21,h=30);
        
        // rotor axle
        translate([0,0,-0.01]) cylinder(d=motorAxleDiam,h=14+0.02);
        translate([0,0,14]) cylinder(d1=motorAxleDiam, d2=screwDiamInt,h=2+0.01);
        translate([0,0,14+2]) cylinder(d=screwDiamInt,h=14+0.02);
        
        // M3 fix screws
        translate([4.5,-5.6/2,-0.01]) cube([3.2,5.6,9+0.02]); 
        translate([20,0,5]) rotate([0,90,0]) cylinder(d=3.1,h=40, center=true);
        
        translate([4.5,-5.6/2,30-9]) cube([3.2,5.6,9+0.02]); 
        translate([20,0,30-5]) rotate([0,90,0]) cylinder(d=3.1,h=40, center=true);
    }
}

/** Small axle to bearing adapter
 */
module bearingAxle() {
    bearingH=7;
    screwDiamInt=7.4;
    difference() {
        union() {
            cylinder(d1=15,d2=12,h=2);
            translate([0,0,2]) cylinder(d=8,h=bearingH);
        }
        cylinder(d=screwDiamInt,h=10);
    }
}

/** Bearing to plate support
 */
module bearingHolder() {        
    // bearing 608zz
    br = 11.15; // bearing radius with tolerance for insertion
    bh = 7;     // bearing height
    ir = 4.3;    // threaded rod radius + ample tolerance
    t = 4; 
    e = 0.02; 
    h=bh+e+1;
    
    color([0.9,0.2,0.2])
    difference() {
        union() {
            cylinder(r=br+e+4, h=bh+e+1);
            hull() {                
                translate([0,15,h/2]) cube([45,5,h], center=true);
                translate([0,5,h/2]) cube([20,5,h], center=true);
            }
            translate([0,25.75,5]) cube([20,16.5,20], center=true);
            translate([0,31.5,55]) cube([20,5,100], center=true);
        }
        translate([0,0,-4.005]) cylinder(r=br+e, h=bh+e+4.02);
        translate([0,0,bh]) cylinder(r1=br+e, r2=br+e-2, h=3+0.01);
        translate([18,7,h/2]) rotate([90,0,0]) cylinder(d=3.1+2,h=10, center=true);
        translate([-18,7,h/2]) rotate([90,0,0]) cylinder(d=3.1+2,h=10, center=true);
        translate([18,15,h/2]) rotate([90,0,0]) cylinder(d=3.1,h=10, center=true);
        translate([-18,15,h/2]) rotate([90,0,0]) cylinder(d=3.1,h=10, center=true);
    }
}

translate([-19,0,0]) rotate([0,90,0]) screwBoltsExt();
rotate([0,90,0]) wheelGear();
translate([34,0,0]) rotate([0,-90,0]) screwBoltsInt(); 
translate([64,0,0]) rotate([0,90,0]) screwBoltsShaft();
rotate([90,0,0]) translate([165,-7,0]) rotate([0,-90,0]) motorGear30RPM();
translate([96,0,-7]) motorGearSupport();
//bearingAxle();
translate([40,0,0]) rotate([90,180,90]) bearingHolder();
