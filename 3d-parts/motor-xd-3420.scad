$fn=100;

module motorXD3420() {
    union() {
        color([0.7,0.7,0.7]) cylinder(d=26, h=84);
        color([0.1,0.1,0.1]) translate([0,0,6.5]) cylinder(d=51, h=71);
        
        color([0.7,0.7,0.7])
        difference() {
            cylinder(d=8, h=84+38);
            translate([0,0,84+38-28]) rotate([0,90,0]) cylinder(d=3, h=10, center=true);
        }        
        
        // fix holes
        color([0.5,0.5,0.5])
        for(rot=[1:2]) {
            rotate([0,0,360 - rot * 360/2]) 
                translate([(41.5/2),0,5]) 
                    cylinder(h=71+10+6.5-5, d=3);
        }
    }
}

motorXD3420();