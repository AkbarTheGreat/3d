include <../scad_lib/BOSL2/std.scad>

tag_length = 140;
tag_width = 20;
base_thickness = 2;
hole_size = 1;

$fn=128;

module tag_base(length=tag_length, width=tag_width) {
  translate([0,0,base_thickness/2])
  difference() {
    cuboid([length, width, base_thickness]);
    holes(length, width);
  }
}

module holes(length, width) {
  x_fact = (length/2 - hole_size*5);
  y_fact = (width/2 - hole_size*5);
  for(x=[-1,1]) {
    for(y=[-1,1]) {
      translate([x*x_fact, y*y_fact, 0])
        hole();
    }
  }
}

module hole() {
  thickness = base_thickness + 0.5;
  translate([0,0,-thickness/2])
    cylinder(thickness, hole_size);
}