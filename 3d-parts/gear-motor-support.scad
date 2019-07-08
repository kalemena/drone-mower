$fn = 100;

width=3;
motor_length=60;
motor_diameter=37;
motor_screw_diameter=3.3;
base_length=25;

difference() {
    
    // motor fix plate
    union() {
        cylinder(d=motor_diameter+width,h=width);
        translate([-(motor_diameter+width)/2,-(motor_diameter+base_length)/2,0]) 
            cube([(motor_diameter+width)/2,motor_diameter+base_length,motor_length+width]);
    }
 
    // shaft holde
    translate([7.2,0,-0.5]) cylinder(d=13,h=width+1);
    
    // fix holes
    for(rot=[1:6]) {
        rotate([0,0,30+360 - rot * 360/6]) translate([(37/2)-3,0,-0.5]) cylinder(h=width+1, d=motor_screw_diameter);
    }
    
    // motor extrude
    translate([0,0,width]) cylinder(d=motor_diameter-width/2,h=motor_length+width);
    
    // sides extrude
    hull() {
        translate([-5,(motor_diameter+base_length)/2,0]) cylinder(d=base_length,h=motor_length+width);
        translate([-8,(motor_diameter+width)/2,0]) cube([10,10,motor_length+width]);
    }
    hull() {
        translate([-5,-(motor_diameter+base_length)/2,0]) cylinder(d=base_length,h=motor_length+width);
        translate([-8,-(motor_diameter+width)/2-10,0]) cube([10,10,motor_length+width]);
    }
    
    // base support holes
    translate([-(motor_diameter+width)/2,(motor_diameter+width+base_length/2)/2,10]) {
        rotate([0,90,0]) cylinder(h=10,d=motor_screw_diameter);
        translate([width,0,0]) rotate([0,90,0]) cylinder(h=10,d=motor_screw_diameter+4);
        
        translate([0,0,motor_length-2*10]) rotate([0,90,0]) cylinder(h=10,d=motor_screw_diameter);
        translate([width,0,motor_length-2*10]) rotate([0,90,0]) cylinder(h=10,d=motor_screw_diameter+4);
    }
    translate([-(motor_diameter+width)/2,-(motor_diameter+width+base_length/2)/2,10]) {
        rotate([0,90,0]) cylinder(h=10,d=motor_screw_diameter);
        translate([width,0,0]) rotate([0,90,0]) cylinder(h=10,d=motor_screw_diameter+4);
        
        translate([0,0,motor_length-2*10]) rotate([0,90,0]) cylinder(h=10,d=motor_screw_diameter);
        translate([width,0,motor_length-2*10]) rotate([0,90,0]) cylinder(h=10,d=motor_screw_diameter+4);
    }
    
    // reduce plastic a bit
    for(it=[1:5]) {
        translate([-3-(motor_diameter+width)/2,-10,5+(motor_length-10)*it/5]) 
            rotate([0,90,30]) cylinder(h=10, d=motor_length/7);
        translate([-3-(motor_diameter+width)/2,10,5+(motor_length-10)*it/5]) 
            rotate([0,90,-30]) cylinder(h=10, d=motor_length/7);
    }
    translate([-20,(motor_diameter+base_length)/2-10,20]) cube([10,10,motor_length/3]);
    translate([-20,-(motor_diameter+base_length)/2,20]) cube([10,10,motor_length/3]);
}
