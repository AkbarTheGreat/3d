include <../scad_lib/BOSL2/std.scad>

// Width of wheel
wheel_width = 18.75;
// Wheel diameter
wheel_diameter = 58;

$fn=128;

difference() {
  chock_box();
  translate([0,0,1])
    wheel();
}

module chock_box() {
  side_thickness = 2;
  translate([-side_thickness,0,0])
    cuboid([wheel_width+side_thickness, wheel_diameter+4, wheel_diameter/4], anchor=BOTTOM, chamfer=1) {
      position(LEFT) handle();
    }
}

module wheel() {
  rotate([0,90,0])
    cylinder(h=wheel_width+.001, r=wheel_diameter/2+.001, anchor=RIGHT);
}

module handle() {
  difference() {
    cuboid([15,20,2], rounding=1, edges=[LEFT], anchor=BOTTOM);
    cylinder(h=2+.001, r=5, anchor=BOTTOM);
  }
}