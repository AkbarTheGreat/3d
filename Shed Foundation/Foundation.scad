include <../scad_lib/BOSL2/std.scad>

// Plywood in 4x8' sheets
// 4x4s in 10 or 12' length
// 2x4's in 4/8/10/12' lengths

overall_width = 7*12+10;
overall_length = 9*12+11;

translate([0,0,10])
   shed_floor();

translate([0,0,3.5])
  plywood_base();

outer_frame();

inner_frame();

module inner_frame() {
  // 1* 4x4 9'4" long
  translate([3.5,(overall_width-3.5)/2,0])
    color("orange")
      four_by_four(overall_length-7);

  two_by_len = (overall_width-10.5)/2;
  // (7'10 - 10.5)/2 | 6'11.5"/2 | 3'5.75"
  
  spacing = 16;

  for(i =[1 : 1 : 6]) {
    translate([3.5+spacing*i,3.5,0])
      rotate([0,0,90])
        two_by_four(two_by_len);

    translate([3.5+spacing*i,7+two_by_len,0])
      rotate([0,0,90])
        two_by_four(two_by_len);
  }
}


module outer_frame() {
  // 2* 4x4 7'10" long
  translate([3.5,0,0])
    rotate([0,0,90])
      four_by_four(overall_width);

  translate([overall_length,0,0])
    rotate([0,0,90])
      four_by_four(overall_width);

  // 2* 4x4 9'4" long
  translate([3.5,0,0])
    color("orange")
      four_by_four(overall_length-7);

  translate([3.5,overall_width-3.5,0])
    color("orange")
      four_by_four(overall_length-7);
}

module plywood_base() {
  // Three sheets plywood, 3x7'10", 4x7'10", 2'11"x7'10"
  plywood(3*12, overall_width);
  translate([3*12,0,0])
    color("green")
      plywood(4*12, overall_width);
  translate([7*12,0,0])
    plywood(2*12+11, overall_width);
}

module shed_floor() {
  color("red")
    cube([9*12+10.2, 7*12+9.6, 1]);
}

module two_by_four(len) {
  cube([len, 1.5, 3.5]);
}

module four_by_four(len) {
  cube([len, 3.5, 3.5]);
}

module plywood(width, depth) {
  color("blue")
    cube([width, depth, .5]);
}