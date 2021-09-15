include <../scad_lib/BOSL2/std.scad>
include <../scad_lib/BOSL2/rounding.scad>


function box_width(length) = length*0.732;

// Uncomment for a test block, to check rendering
//block_test();

module box_block(length=112, width=85, height=31, bottom_bezel=false) {
  chamfer_radius = bottom_bezel?4:0;
  box_path = box_path(length, width);
  move([0, -width/2, 0])
  offset_sweep(box_path, height=height, bottom=os_teardrop(r=chamfer_radius), $fn=64);
}

function box_path(length, width) = 
  turtle([
  "move", length/4,
  "turn", 30,
  "move", width/9*2,
  "turn", 30,
  "move", width*2.5/9/1.73205*2,
  "turn", 30,
  "move", width*2/9,
  "turn", 30,
  "move", width*2.5/9/1.73205*2,
  "turn", 30,
  "move", width/9*2,
  "turn", 30,
  "move", length/2,
  "turn", 30,
  "move", width/9*2,
  "turn", 30,
  "move", width*2.5/9/1.73205*2,
  "turn", 30,
  "move", width/9*2,
  "turn", 30,
  "move", width*2.5/9/1.73205*2,
  "turn", 30,
  "move", width/9*2,
  "turn", 30,
  "move", length/4,
  ]);

module block_test() {
    box_block(112, 85, 31, true);
}
