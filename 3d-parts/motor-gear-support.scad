$fn = 100;

module motorGearSupport() {

    width=4;
    motor_length=60;
    motor_diameter=40;
    motor_screw_diameter=3.5;
    base_length=24;

    color([0.2,0.7,0.2])
    rotate([0,90,0]) {
        // motor axle fixing plate
        difference() {
            cylinder(d=motor_diameter+width,h=width);
            
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

    color([0.2,0.7,0.2])
    difference() {
        // motor plates
        union() {
            translate([0,-(motor_diameter+base_length)/2,-(motor_diameter+width)/2]) cube([motor_length,motor_diameter+base_length,width]);
            
            for (b =[1,-1]) {
                hull() {
                    translate([width/2,b*(motor_diameter+width)/2,-8]) cube([width,width,25], center=true);
                    translate([motor_length-width/2,b*(motor_diameter+width)/2,-15]) cube([width,width,10], center=true);
                }
            }
        }
        
        // fix plate
        for (a =[10,45]) {
            for (b =[1,-1]) {
                hull() {
                    translate([a,b*(motor_diameter+base_length*2/3)/2,-(motor_diameter+width)/2]) cylinder(d=motor_screw_diameter,h=width+1);
                    translate([a+5,b*(motor_diameter+base_length*2/3)/2,-(motor_diameter+width)/2]) cylinder(d=motor_screw_diameter,h=width+1);
                }
            }
        }
        
        // extrude more
        for (a =[10:10:55]) {
            for (b =[1,-1]) {
                translate([a,b*9,-(motor_diameter+width)/2]) cylinder(d=8,h=width+1);
            }
        }
    }
}

motorGearSupport();
