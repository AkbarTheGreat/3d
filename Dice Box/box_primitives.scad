function box_width(length) = length*0.732;

// Uncomment for a test block, to check rendering
block_test();

module box_block(length=112, height=31, bottom_bezel=false) {
  translate([0,0,height/2]) {
      box_planks(length, height, 0);
 
    if(bottom_bezel) {
        translate([0,0,-height/2-5]) {
            bezel_planks(length,2,2);
        }
    }
  }
}

module bezel_planks(length, height, plank_depth=2){
    box_long_plank(length, height, plank_depth);
    box_wide_plank(length, height, plank_depth);
    for (x_sign = [-1 : 2 : 1]) {
      for (y_sign = [-1 : 2 : 1]) {
        box_slim_turn_plank(length, height, x_sign, y_sign, plank_depth);
        box_thick_turn_plank(length, height, x_sign, y_sign, plank_depth);
      }
    }

}

module box_planks(length, height, plank_depth=0){
    box_long_plank(length, height, plank_depth);
    box_wide_plank(length, height, plank_depth);
    for (x_sign = [-1 : 2 : 1]) {
      for (y_sign = [-1 : 2 : 1]) {
        box_slim_turn_plank(length, height, x_sign, y_sign, plank_depth);
        box_thick_turn_plank(length, height, x_sign, y_sign, plank_depth);
      }
    }

}

module box_long_plank(length, height, depth=0) {
  cube([depth>0?depth:length,length*0.154,height], center=true);
}

module box_wide_plank(length, height, depth=0) {
  cube([length*0.4888, depth>0?depth:box_width(length), height], center=true);
}

// x and y are -1 or +1 to indicate which side of the origin this is on.
module box_slim_turn_plank(length, height, x, y, depth=0) {
  rotation = 30*x*y;
  actual_depth = depth?depth:length*0.4018;
  rotate([0,0,rotation])
    translate([-length*x*0.106,length*y*0.2384,0])
    cube([length*0.1554,actual_depth,height],center=true);
}

// x and y are -1 or +1 to indicate which side of the origin this is on.
module box_thick_turn_plank(length, height, x, y, depth=0) {
  rotation = 60*x*y;
  rotate([0,0,rotation])
    translate([-length*x*0.0607,length*y*0.2714,0])
    cube([length*0.2446,depth?depth:length*0.4018,height],center=true);
}


module block_test() {
    box_block(112,31, true);
}
