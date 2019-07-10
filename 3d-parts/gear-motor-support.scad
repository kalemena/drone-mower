$fn = 100;

width=3;
motor_length=60;
motor_diameter=40;
motor_screw_diameter=3.5;
base_length=24;

rotate([0,90,0]) {
    // motor axle fixing plate
    difference() {
        union() {
            cylinder(d=motor_diameter+width,h=width);
            //translate([-(motor_diameter+width)/2,-(motor_diameter+base_length)/2,0]) 
            //    cube([(motor_diameter+width)/2,motor_diameter+base_length,motor_length+width]);
        }
        // shaft hole
        translate([-7.2,0,-0.5]) cylinder(d=14,h=width+1);
        
        // fix holes
        for(rot=[1:6]) {
            rotate([0,0,30+360 - rot * 360/6]) 
                translate([(37/2)-3,0,-0.5]) 
                    cylinder(h=width+1, d=motor_screw_diameter);
        }
    }
}
     
// motor plate
union() {
    translate([0,-(motor_diameter+base_length)/2,-(motor_diameter+width)/2]) cube([motor_length,motor_diameter+base_length,width]);
    hull() {
        translate([width/2,motor_diameter/2+width/2,-8]) cube([width,width,25], center=true);
        translate([motor_length-width/2,motor_diameter/2,-15]) cube([width,width,10], center=true);
    }
    hull() {
        translate([width/2,-motor_diameter/2-width/2,-8]) cube([width,width,25], center=true);
        translate([motor_length-width/2,-motor_diameter/2-width/2,-15]) cube([width,width,10], center=true);
    }
}
