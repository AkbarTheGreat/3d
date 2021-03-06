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

lg_d4_pocket_width = 24;
lg_d4_pocket_height = d4_pocket_height;
lg_d6_pocket_width = 17.5;
lg_d6_pocket_height = 18;
lg_d8_pocket_width=23;
lg_d8_pocket_height=17;
lg_d10_pocket_width=24.5;
lg_d10_pocket_height=17.3;
lg_d12_pocket_width=d12_pocket_width;
lg_d12_pocket_height=d12_pocket_height;
lg_d20_pocket_width = d20_pocket_width;
lg_d20_pocket_height = d20_pocket_height;

dice_pocket_quality_resolution = 0.25;

// Uncomment for visual debug
//pocket_test();
//lg_pocket_test();
//pocket_print();
//large_pocket_print();
//magnet_print();

module magnet_print() {
  difference() {
    cylinder(4, r=5);
    translate([0,0,1.001])
    magnet_divot();
  }
}

// Make a single cylinder with a pocket for a given die.  Just change the pocket_height and pocket() module call to print a different test pocket.
module pocket_print() {
  height = 22;
  difference() {
    cylinder(h=height, r=15);
    translate([0, 0,height-d20_pocket_height+.002])
      d20_pocket(false);
  }
}

module large_pocket_print() {
  height = 22;
  difference() {
    cylinder(h=height, r=15);
    translate([0, 0,height-lg_d10_pocket_height+.002])
      large_d10_pocket(false);
  }
}

module large_d4_pocket(quickpocket=true) {
  generic_d4_pocket(non_cx_d4_size, lg_d4_pocket_height);
}

module d4_pocket(quickpocket=true) {
  generic_d4_pocket();
}

module generic_d4_pocket(die_size=cx_d4_size, height=d4_pocket_height) {
  // Rotate this pocket so that it's along more typical axes
  size = die_size + .25;
  rotate([0, 0, -45]) {
    translate([0,0,0])
      linear_extrude(height=height)
      projection()
        d4(size+.25);
    color("red")
      d4(size);
  }
}

module large_d6_pocket(quickpocket=true) {
  generic_d6_pocket(non_cx_d6_size, lg_d6_pocket_height);
}

module d6_pocket(quickpocket=true) {
  generic_d6_pocket();
}

module generic_d6_pocket(die_size=cx_d6_size, height=d6_pocket_height) {
  size = die_size + .25;
  translate([0,0,0])
    linear_extrude(height=height)
    projection()
      d6(size+.25);
    color("red")
      d6(size);
}

module large_d8_pocket(quickpocket=true) {
  if(quickpocket) {
    quick_d8_pocket(non_cx_d8_size, lg_d8_pocket_height);
  } else {  
    quality_d8_pocket(non_cx_d8_size, lg_d8_pocket_height);
  }
}

module d8_pocket(quickpocket=true) {
  if(quickpocket) {
    quick_d8_pocket();
  } else {  
    quality_d8_pocket();
  }
}

module quick_d8_pocket(die_size=cx_d8_size, height=d8_pocket_height) {
  size = die_size + .25;
  translate([0,0,1])
    linear_extrude(height=height-1)
    projection()
      d8(size+.25);
  color("red")
    d8(size);
}

module quality_d8_pocket(die_size=cx_d8_size, height=d8_pocket_height) {
  size = die_size + .25;
  slice_top = size*.83;
  translate([0,0,slice_top-.001])
    linear_extrude(height=height-slice_top+dice_pocket_quality_resolution+.001)
    projection()
      d8(size+.25);
  for(step=[0:dice_pocket_quality_resolution:slice_top]) {
    translate([0,0,step])
    linear_extrude(dice_pocket_quality_resolution+.001)
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

module large_d10_pocket(quickpocket=true) {
  if(quickpocket) {
    quick_d10_pocket(non_cx_d10_size, lg_d10_pocket_height);
  } else {  
    quality_d10_pocket(non_cx_d10_size, lg_d10_pocket_height);
  }
}

module d10_pocket(quickpocket=true) {
  if(quickpocket) {
    quick_d10_pocket();
  } else {  
    quality_d10_pocket();
  }
}

module quick_d10_pocket(die_size=cx_d10_size, height=d10_pocket_height) {
  size = die_size + .25;
  translate([0,0,.5])
    linear_extrude(height=height-.5)
    projection()
      d10(size+.25);
  color("red")
    d10(size);
}

module quality_d10_pocket(die_size=cx_d10_size, height=d10_pocket_height) {
  size = die_size + .25;
  slice_top = size*.65;
  translate([0,0,slice_top-dice_pocket_quality_resolution])
    linear_extrude(height=height-slice_top+dice_pocket_quality_resolution+.001)
    projection()
      d10(size+.25);
  for(step=[0:dice_pocket_quality_resolution:slice_top]) {
    translate([0,0,step])
    linear_extrude(dice_pocket_quality_resolution+.001)
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

// For completeness, it's pointless.
module large_d12_pocket(quickpocket=true) {
  d12_pocket(quickpocket);
}

module d12_pocket(quickpocket=true) {
  if(quickpocket) {
    quick_d12_pocket();
  } else {  
    quality_d12_pocket();
  }
}

module quick_d12_pocket(die_size=cx_d12_size, height=d12_pocket_height) {
  size = die_size + .25;
  translate([0,0,7])
    linear_extrude(height=height-7)
    projection()
      d12(size+.25);
  color("red")
    d12(size);
}

module quality_d12_pocket(die_size=cx_d12_size, height=d12_pocket_height) {
  size = die_size + .25;
  slice_top = size*.62;
  translate([0,0,slice_top-.001])
    linear_extrude(height=height-slice_top+dice_pocket_quality_resolution+.001)
    projection()
      d12(size+.25);
  for(step=[0:dice_pocket_quality_resolution:slice_top]) {
    translate([0,0,step])
    linear_extrude(dice_pocket_quality_resolution+.001)
      d12_collated_slice(size, step);
  }
}

module d12_collated_slice(size, level) {
  if(level == 0) {
    d12_slice(size, level);
  } else if(level < size) {
    d12_slice(size, level);
    d12_collated_slice(size, level-dice_pocket_quality_resolution);
  } else {
    d12_slice(size, level);
    d12_collated_slice(size, level-dice_pocket_quality_resolution);
  }
}

module d12_slice(size, level) {
  projection(cut=true)
    translate([0,0,-level])
    d12(size+.25);
}

// For completeness, it's pointless.
module large_d20_pocket(quickpocket=true) {
  d20_pocket(quickpocket);
}

module d20_pocket(quickpocket=true) {
  if(quickpocket) {
    quick_d20_pocket();
  } else {  
    quality_d20_pocket();
  }
}

module quick_d20_pocket(die_size=cx_d20_size, height=d20_pocket_height) {
  size = die_size + .25;
  translate([0,0,5])
    linear_extrude(height=height-5)
    projection()
      d20(size+.25);
  color("red")
    d20(size);
}

module quality_d20_pocket(die_size=cx_d20_size, height=d20_pocket_height) {
  size = die_size + .25;
  slice_top = size*.6;
  translate([0,0,slice_top-.001])
    linear_extrude(height=height-slice_top+dice_pocket_quality_resolution+.001)
    projection()
      d20(size+.25);
  for(step=[0:dice_pocket_quality_resolution:slice_top]) {
    translate([0,0,step])
    linear_extrude(dice_pocket_quality_resolution+.001)
      d20_collated_slice(size, step);
  }
}

module d20_collated_slice(size, level) {
  if(level == 0) {
    d20_slice(size, level);
  } else if(level < size) {
    d20_slice(size, level);
    d20_collated_slice(size, level-dice_pocket_quality_resolution);
  } else {
    d20_slice(size, level);
    d20_collated_slice(size, level-dice_pocket_quality_resolution);
  }
}

module d20_slice(size, level) {
  projection(cut=true)
    translate([0,0,-level])
    d20(size+.25);
}

module magnet_divot() {
  cylinder(h=3, r=3.1);
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
 translate([0,-25,0]) d10_pocket(false);
 translate([0,-25,0]) marker_cross(d10_pocket_width, d10_pocket_height);
 translate([0, 25,0]) d12_pocket();
 translate([0, 25,0]) marker_cross(d12_pocket_width, d12_pocket_height);
 translate([ 0, 0,0]) d20_pocket();
 translate([ 0, 0,0]) marker_cross(d20_pocket_width, d20_pocket_height);
}

module lg_pocket_test() {
 translate([-25,0,0]) large_d4_pocket();
 translate([-25,0,0]) marker_cross(lg_d4_pocket_width, lg_d4_pocket_height);
 translate([ 25,0,0]) large_d6_pocket();
 translate([ 25,0,0]) marker_cross(lg_d6_pocket_width, lg_d6_pocket_height);
 translate([-50,0,0]) large_d8_pocket();
 translate([-50,0,0]) marker_cross(lg_d8_pocket_width, lg_d8_pocket_height);
 translate([0,-25,0]) large_d10_pocket();
 translate([0,-25,0]) marker_cross(lg_d10_pocket_width, lg_d10_pocket_height);
}

