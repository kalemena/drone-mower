$fn=100;

// 5 + 26.5 - 7.5
module motorCutGrassAdapter() {
    shaft_length=26.5+5-7.5;
    difference() {        
        union() {
            // disc M15
            cylinder(d=16,h=shaft_length);    
            translate([0,0,10]) cylinder(r1=16/2,r2=25/2,h=10);
        }
        
        // motor rotor M8
        cylinder(d=8.5,h=shaft_length+0.01);
        
        // M3 fix screw
        translate([0,0,5]) rotate([90,0,0]) cylinder(d=3.1,h=40, center=true);
    }    
}

//
module motorCutDiscWireHolder() {
    translate([0,0,8]) 
        difference() {
            cylinder(d=61,h=3);
            cylinder(d1=16.5,d2=19,h=3);
        }
}

motorCutGrassAdapter();
motorCutDiscWireHolder();
