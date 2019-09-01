$fn=100;

module curved_triangle(r, pitch, separation, gap) {
  assign(num_steps = 36)
  assign(top_d = pitch - 2 * separation)
  assign(bottom_d = triangle_tip_width)
  assign(delta = top_d - bottom_d)
  assign(d_incr = delta / (num_steps-1))
  assign(b_incr=116/(num_steps - 1))
  render()
  for (i=[0:(num_steps-2)]) {
    hull() {
      rotate([0, 0, b_incr * i]) 
        translate([r, 0, 0]) 
          square(size=[top_d - d_incr * i, 0.01], center=true);
      rotate([0, 0, b_incr * (i+1)]) 
        translate([r, 0, 0]) 
          square(size=[top_d - d_incr * (i+1), 0.01], center=true);
      echo("computing=", top_d - d_incr * (i+1));
    }
  }
}

module mowingSystemDiscNylon() {
    color([138/256,144/256,150/256])
    difference() {
        union() {
            cylinder(d=110,h=15);
            cylinder(d=68,h=20);
        }
        cylinder(d=15,h=25);
        translate([0,0,10]) cylinder(d=62,h=20);
        translate([0,0,-0.01]) cylinder(d=26,h=2);        
    }
    
    // nylon wires
    color([1,1,0])
    for(rot=[1:4]) {
        rotate([0,0,360 - rot * 360/4]) 
            translate([50,50,+15/2]) 
                rotate([0,0,60]) curved_triangle(35, 15, 15, 85);
    } 
}

mowingSystemDiscNylon();
