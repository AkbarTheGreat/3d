include <chessex_dice.scad>


d4_pocket_width = 22.5;
d4_pocket_height = 19;
d6_pocket_width = 15.5;
d6_pocket_height = 16;
d8_pocket_width=21;
d8_pocket_height=16;
d10_pocket_width=23.5;
d10_pocket_height=17;
d12_pocket_width=24;
d12_pocket_height=21;
d20_pocket_width = 22;
d20_pocket_height = 21;
dice_pocket_quality_resolution = 0.5;

// Uncomment for visual debug
//pocket_test();
//pocket_print();

// Make a single cylinder with a pocket for a given die.  Just change the pocket_height and pocket() module call to print a different test pocket.
module pocket_print() {
  height = 22;
  difference() {
    cylinder(h=height, r=15);
    translate([0, 0,height-d10_pocket_height])
      d10_pocket(false);
  }
}

module d4_pocket() {
  // Rotate this pocket so that it's along more typical axes
  size = cx_d4_size + .25;
  rotate([0, 0, -45]) {
    translate([0,0,0])
      linear_extrude(height=19)
      projection()
        d4(size+.25);
    color("red")
      d4(size);
  }
}

module d6_pocket() {
  size = cx_d6_size + .25;
  translate([0,0,0])
    linear_extrude(height=16)
    projection()
      d6(size+.25);
    color("red")
      d6(size);
}

module d8_pocket(quickpocket=true) {
  if(quickpocket) {
    quick_d8_pocket();
  } else {  
    quality_d8_pocket();
  }
}

module quick_d8_pocket() {
  size = cx_d8_size + .25;
  translate([0,0,1])
    linear_extrude(height=15)
    projection()
      d8(size+.25);
  color("red")
    d8(size);
}

module quality_d8_pocket(level=0) {
  size = cx_d8_size + .25;
  for(step=[0:dice_pocket_quality_resolution:size]) {
    translate([0,0,step])
    linear_extrude(dice_pocket_quality_resolution)
      d8_collated_slice(size, step);
  }
}

module d8_collated_slice(size, level) {
   if(level == 0) {
    d8_slice(size, level);
  } else if(level < size) {
    d8_slice(size, level);
    d8_collated_slice(size, level-dice_pocket_quality_resolution);
  } else {
    d8_slice(size, level);
    d8_collated_slice(size, level-dice_pocket_quality_resolution);
  }
}

module d8_slice(size, level) {
  projection(cut=true)
    translate([0,0,-level])
    d8(size+.25);
}

module d10_pocket(quickpocket=true) {
  if(quickpocket) {
    quick_d10_pocket();
  } else {  
    quality_d10_pocket();
  }
}

module quick_d10_pocket() {
  size = cx_d10_size + .25;
  translate([0,0,.5])
    linear_extrude(height=16.5)
    projection()
      d10(size+.25);
  color("red")
    d10(size);
}

module quality_d10_pocket(level=0) {
  size = cx_d10_size + .25;
  for(step=[0:dice_pocket_quality_resolution:size]) {
    translate([0,0,step])
    linear_extrude(dice_pocket_quality_resolution)
      d10_collated_slice(size, step);
  }
}

module d10_collated_slice(size, level) {
  if(level == 0) {
    d10_slice(size, level);
  } else if(level < size) {
    d10_slice(size, level);
    d10_collated_slice(size, level-dice_pocket_quality_resolution);
  } else {
    d10_slice(size, level);
    d10_collated_slice(size, level-dice_pocket_quality_resolution);
  }
}

module d10_slice(size, level) {
  projection(cut=true)
    translate([0,0,-level])
    d10(size+.25);
}

module d12_pocket() {
  size = cx_d12_size + .25;
  translate([0,0,7])
    linear_extrude(height=14)
    projection()
      d12(size+.25);
  color("red")
    d12(size);
}

module d20_pocket() {
  size = cx_d20_size + .25;
  translate([0,0,5])
    linear_extrude(height=16)
    projection()
      d20(size+.25);
  color("red")
    d20(size);
}

module magnet_divot() {
  cylinder(h=3, r=3);
}

// For debugging, use to draw a blue cross on top of an object
module marker_cross(size, height) {
  translate([0, 0, height-.499])
    color("blue")
    cube([size, 1, 1], center=true);
  translate([0,0,height-.499])
    color("blue")
    cube([1, size, 1], center=true);
}

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

