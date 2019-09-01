$fn=100;

use<gear-wheel.scad>
use<gear-motor-30rpm.scad>

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
    color([0.9,0.2,0.2])
    difference() {
        union() {
            cylinder(d1=15,d2=12,h=2);
            translate([0,0,2]) cylinder(d=8,h=bearingH);
        }
        cylinder(d=screwDiamInt,h=10);
    }
}

/** Bearing to plate support - top part
 */
module bearingHolderTop() {        
    // bearing 608zz
    br = 11.15; // bearing radius with tolerance for insertion
    bh = 7;     // bearing height
    ir = 4.3;    // threaded rod radius + ample tolerance
    t = 4; 
    e = 0.1; 
    h=bh+e+2;
    
    color([0.3,0.9,0.5]) {
        difference() {
            union() {
                cylinder(r=br+e+4, h=h);
                translate([-45/2,0,0]) cube([45,5,h]);
            }
            
            // extrude bearing
            translate([0,0,1]) cylinder(r=br+e, h=h-2);
            translate([0,0,bh]) cylinder(r1=br+e, r2=br+e-1, h=3+0.01);
            translate([0,0,-1]) cylinder(r2=br+e, r1=br+e-1, h=3+0.01);
            
            // remove lower part
            translate([-50/2,-50,-0.01]) cube([50,50,h+0.02]);
            
            // M3 fix
            translate([18.5,2,h/2]) rotate([90,0,0]) cylinder(d=3.1,h=10, center=true);
            translate([-18.5,2,h/2]) rotate([90,0,0]) cylinder(d=3.1,h=10, center=true);
        }
    }
}

/** Bearing to plate support - bottom part
 */
module bearingHolderBottom() {        
    // bearing 608zz
    br = 11.15; // bearing radius with tolerance for insertion
    bh = 7;     // bearing height
    ir = 4.3;    // threaded rod radius + ample tolerance
    t = 4; 
    e = 0.1; 
    h=bh+e+2;
    
    color([0.3,0.9,0.5]) {
        difference() {
            union() {
                cylinder(r=br+e+4, h=h);
                translate([-45/2,-30,-5/2]) cube([45,30,h+5]);
                hull() {
                    translate([-45/2,-30,-5/2]) cube([45,10,h+5]);
                    translate([-(45+20)/2,-30,-5/2]) cube([45+20,5,h+5]);
                }
            }
            
            // extrude bearing
            translate([0,0,1]) cylinder(r=br+e, h=h-2);
            translate([0,0,bh]) cylinder(r1=br+e, r2=br+e-3, h=6+0.01);
            translate([0,0,-4]) cylinder(r2=br+e, r1=br+e-3, h=6+0.01);
            //translate([0,0,0]) cylinder(r=br+e-2, h=50, center=true);
            
            // remove top part
            translate([-50/2,-0.01,-0.01]) cube([50,50,h+0.02]);
            
            // M3 fix bearing
            translate([18.5,-4,h/2]) rotate([90,0,0]) cylinder(d=3.1,h=10, center=true);
            translate([-18.5,-4,h/2]) rotate([90,0,0]) cylinder(d=3.1,h=10, center=true);
            translate([15,-6,(h-5.6)/2]) cube([9+0.02,3.2,5.6]); 
            translate([-15-9,-6,(h-5.6)/2]) cube([9+0.02,3.2,5.6]); 
            
            // M3 fix support
            translate([27.5,-25,h/2]) rotate([90,0,0]) cylinder(d=3.1,h=20, center=true);
            translate([27.5,-15,h/2]) rotate([90,0,0]) cylinder(d=10,h=20, center=true);
            translate([-27.5,-25,h/2]) rotate([90,0,0]) cylinder(d=3.1,h=20, center=true);
            translate([-27.5,-15,h/2]) rotate([90,0,0]) cylinder(d=10,h=20, center=true);
                        
            // reduce materials
            translate([0,-30,-3]) cylinder(d=30,h=15);
        }
    }
}

/** Support for motor to base
 */
module motorGearSupport() {

    width=6;
    motor_length=60;
    motor_diameter=40;
    motor_screw_diameter=3.5;
    base_length=24;

    color([0.3,0.9,0.5])
    rotate([0,90,0]) {
        // motor axle fixing plate
        difference() {
            union() {
                // motor fix
                hull() {
                    cylinder(d=motor_diameter+width,h=width);
                    translate([13,-50/2,0]) cube([10,50,width]);
                }
                // base 
                hull() {
                    translate([13,-50/2,0]) cube([10,50,width]);
                    translate([13+5,-70/2,25]) cube([5,70,width]);
                }
            }
            
            // shaft hole
            translate([-7.2,0,-0.5]) cylinder(d=14,h=width+1);
            
            // motor extrude
            translate([0,0,width]) cylinder(d=motor_diameter,h=26);
            
            // fix holes
            for(rot=[1:6]) {
                rotate([0,0,30+360 - rot * 360/6]) 
                    translate([(37/2)-3,0,-0.5]) 
                        cylinder(h=width+1, d=motor_screw_diameter);
            }
            
            // M3 fix support
            translate([20,25,18+width]) rotate([0,90,0]) cylinder(d=motor_screw_diameter,h=20, center=true);
            translate([20,-25,18+width]) rotate([0,90,0]) cylinder(d=motor_screw_diameter,h=20, center=true);
            translate([8,25,18+width]) rotate([0,90,0]) cylinder(d=10,h=20, center=true);
            translate([8,-25,18+width]) rotate([0,90,0]) cylinder(d=10,h=20, center=true);
            
            translate([20,20,5+width]) rotate([0,90,0]) cylinder(d=motor_screw_diameter,h=20, center=true);
            translate([20,-20,5+width]) rotate([0,90,0]) cylinder(d=motor_screw_diameter,h=20, center=true);
            translate([5,20,5+width]) rotate([0,90,0]) cylinder(d=10,h=20, center=true);
            translate([5,-20,5+width]) rotate([0,90,0]) cylinder(d=10,h=20, center=true);
        }
    }
}

module gearAssembly() {
    color([0.4,0.4,0.4]) {
        translate([-28,0,0]) rotate([0,90,0])  
            cylinder(d=7,h=105);
    }

    translate([-19,0,0]) rotate([0,90,0]) screwBoltsExt();
    rotate([0,90,0]) wheelGear();
    translate([34,0,0]) rotate([0,-90,0]) screwBoltsInt(); 
    rotate([-120,0,0]) translate([64,0,0]) rotate([0,90,0]) screwBoltsShaft();
    rotate([90,0,0]) translate([165,-7,0]) rotate([0,-90,0]) motorGear30RPM();
    translate([96,0,-7]) motorGearSupport();
    translate([34,0,0]) rotate([0,90,0]) bearingAxle();
    translate([45,0,0]) rotate([-90,180,90]) {
        bearingHolderTop();
        bearingHolderBottom();
    }
}

color([141/256,97/256,66/256])
    translate([30,-50,-40]) cube([100,100,10]);
color([0,1,0.3])
    translate([10,-50,-86]) cube([100,100,5]);
gearAssembly();
