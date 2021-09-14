include <chessex_dice.scad>

//pocket_test();

d4_pocket_width = 24;
d4_pocket_height = 18;
d6_pocket_width = 15;
d6_pocket_height = 15;
d8_pocket_width=20;
d8_pocket_height=15;
d10_pocket_width=23;
d10_pocket_height=16;
d12_pocket_width=24;
d12_pocket_height=20;
d20_pocket_width = 22;
d20_pocket_height = 20;

module pocket_test() {
 translate([-25,0,0]) d4_pocket();
 translate([-25,0,0]) marker_cross(d4_pocket_width, d4_pocket_height);
 translate([ 25,0,0]) d6_pocket();
 translate([ 25,0,0]) marker_cross(d6_pocket_width, d6_pocket_height);
 translate([-50,0,0]) d8_pocket();
 translate([-50,0,0]) marker_cross(d8_pocket_width, d8_pocket_height);
 translate([0,-25,0]) d10_pocket();
 translate([0,-25,0]) marker_cross(d10_pocket_width, d10_pocket_height);
 translate([0, 25,0]) d12_pocket();
 translate([0, 25,0]) marker_cross(d12_pocket_width, d12_pocket_height);
 translate([ 0, 0,0]) d20_pocket();
 translate([ 0, 0,0]) marker_cross(d20_pocket_width, d20_pocket_height);
}

module d4_pocket() {
  translate([0,0,0])
    linear_extrude(height=19)
    projection()
      d4();
  d4();
}

module d6_pocket() {
  translate([0,0,0])
    linear_extrude(height=16)
    projection()
      d6();
  d6();
}

module d8_pocket() {
  translate([0,0,5])
    linear_extrude(height=11)
    projection()
      d8();
  d8();
}

module d10_pocket() {
  translate([0,0,5])
    linear_extrude(height=12)
    projection()
      d10();
  d10();
}

module d12_pocket() {
  translate([0,0,7])
    linear_extrude(height=14)
    projection()
      d12();
  d12();
}

module d20_pocket() {
  translate([0,0,5])
    linear_extrude(height=16)
    projection()
      d20();
  d20();
}

// For debugging, use to draw a blue cross on top of an object
module marker_cross(size, height) {
  translate([0,0,height+.501])
    color("blue")
    cube([size, 1, 1], center=true);
  translate([0,0,height+.501])
    color("blue")
    cube([1, size, 1], center=true);
}

module magnet_divot() {
  cylinder(h=3, r=6);
}
