include <../scad_lib/BOSL2/std.scad>
include <../scad_lib/BOSL2/rounding.scad>


function box_width(length) = length*0.732;

// Uncomment for a test block, to check rendering
block_test();

module box_block(length=112, height=31, bottom_bezel=false) {
  translate([0,0,height/2]) {
      box_planks(length, height, 0);
  }
}

module box_block_mk2(length=112, height=31, bottom_bezel=false) {
  front_face = length*0.154;
  side_face = length*0.4888;
  thin_face = length*0.1554;
  thick_face = length*0.2446;
  cham_size = 5;

  cuboid([front_face, length, height], chamfer=cham_size, edges=[BTM+FRONT,BTM+BACK])
  {
    attach(LEFT, BACK)
      cuboid([side_face, (box_width(length)-front_face)/2, height], chamfer=cham_size, edges=[BTM+FRONT]) {
        attach(FRONT+LEFT, FRONT+RIGHT)
        cuboid([thin_face,(box_width(length)-front_face)/2,height], spin=-120, chamfer=cham_size, edges=[BTM+FRONT]);
    }
    attach(RIGHT, BACK)
      cuboid([side_face, (box_width(length)-front_face)/2, height], chamfer=cham_size, edges=[BTM+FRONT]);
  }
}

module box_block_mk3(length=112, width=85, height=31, bottom_bezel=false) {
//  for(m_x = [0,1]) {
//    mirror([m_x,0,0])
//    for(m_y = [0,1]) {
//      mirror([0,m_y,0])
      box_corner_mk3(length, width, height, bottom_bezel);
//    }
//  }
}

module box_block_no_bezel_mk3(length=112, width=85, height=31) {
//  for(m_x = [0,1]) {
//    mirror([m_x,0,0])
//    for(m_y = [0,1]) {
//      mirror([0,m_y,0])
      box_corner_mk3(length, width, height, false);
//    }
//  }
}


module box_corner_mk3(length, width, height, bottom_bezel) {
  cham_size = 5;
  long_face = length/4;
  thin_face = width/9*2;
  thick_face = width*2.5/9/1.73205*2;
  short_face = width/9;

  if(bottom_bezel) {
    difference() {
      box_corner_no_bezel_mk3(length, width, height);
        #chamfer_mask(l=2);
      {
        #chamfer_mask(l=2);
          #chamfer_mask(l=long_face, orient=FRONT, anchor=[0,0,0], excess=1, chamfer=cham_size);
      //    #chamfer_mask(l=3, orient=FRONT, anchor=[-width/cham_size/2,0,length/4], excess=0, chamfer=cham_size, spin=[0,30,0]);
      }
    }
  }else {
    box_corner_no_bezel_mk3(length, width, height);
  }
}

module box_corner_no_bezel_mk3(length, width, height) {
  long_face = length/4;
  thin_face = width/9*2;
  thick_face = width*2.5/9/1.73205*2;
  short_face = width/9;

  path=turtle([
  "turn", 90,
  "xjump", width/2,
  "move", long_face,
  "turn", 30,
  "move", thin_face,
  "turn", 30,
  "move", thick_face,
  "turn", 30,
  "move", short_face,
  "turn", -90,
  "move", -length/2,
  ]);

  linear_extrude(height) polygon(path);
}

module box_block_mk4(length=112, width=85, height=31, bottom_bezel=false) {
  chamfer_radius = bottom_bezel?4:0;
  box_path = box_path_mk4(length, width);
  move([width/2,0,-height/2])
  offset_sweep(box_path, height=height, bottom=os_teardrop(r=chamfer_radius), $fn=64);
}

function box_path_mk4(length, width) = 
  turtle([
  "turn", 90,
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
    for (x_sign = [-1,1]) {
      for (y_sign = [-1,1]) {
        box_slim_turn_plank(length, height, x_sign, y_sign, plank_depth);
        box_thick_turn_plank(length, height, x_sign, y_sign, plank_depth);
      }
    }

}

module box_planks_mk2(length, height, plank_depth=0){
    box_long_plank(length, height, plank_depth);
    box_wide_plank(length, height, plank_depth);
    for (x_sign = [1]) {
      for (y_sign = [1]) {
        box_slim_turn_plank_mk2(length, height, x_sign, y_sign, plank_depth);
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
module box_slim_turn_plank_mk2(length, height, x, y, depth=0) {
  rotation = -30*x*y;
  y_component=x*0.5;
  x_component=y*0.866025;
  
  ideal_depth = box_width(length)/2;
  actual_depth = depth?depth:ideal_depth;
  facing_length = length*0.1554;
  translate([facing_length*y_component/2,facing_length*x_component/2,0])
  translate([actual_depth*x_component/2,actual_depth*y_component/2,1])
//  translate([actual_depth*x_component,actual_depth*y_component,1])
  rotate([0,0,-30])
  color("blue")
    cube([facing_length,actual_depth,height],center=true);
}

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
    box_block_mk4(112, 85, 31, true);
}
