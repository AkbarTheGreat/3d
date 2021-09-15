include <box_primitives.scad>
include <dice_pockets.scad>

box();

module box() {
  full_box = 120;
  full_width = 87;
  inner_pocket = 52.4;
  inner_width = 30;
  box_height = 31;
  pocket_height = 25.3;

  difference() {
    box_block(full_box, full_width, box_height, true);
    translate([0,0,(box_height-pocket_height)+.001])
        box_block(inner_pocket, inner_width, pocket_height);
    
    die_pockets(full_box, full_width, inner_pocket, inner_width, box_height);
    magnet_pockets(full_box, full_width, box_height);
  }
}

module die_pockets(full_box, full_width, inner_pocket, inner_width, box_height) {
  //D10's on the edges
  pocket_shortwise = inner_width/2 + (full_width-inner_width)/4;
  translate([0,pocket_shortwise,box_height-d10_pocket_height+.001])
    rotate([0,0,90])
    d10_pocket();
  translate([0,-pocket_shortwise,box_height-d10_pocket_height+.001])
    rotate([0,0,90])
    d10_pocket();

  //D20's on each end
  pocket_longwise = inner_pocket/2 + (full_box-inner_pocket)/4;
  translate([pocket_longwise,0,box_height-d20_pocket_height+.001])
    d20_pocket();
  translate([-pocket_longwise,0,box_height-d20_pocket_height+.001])
    d20_pocket();

  //Corners, D4, D6, D8, D12
  pocket_edge_x = inner_pocket/2 + (full_box-inner_pocket)/16;
  pocket_edge_y = inner_width/2 + (full_width-inner_width)/8;

  translate([pocket_edge_x,pocket_edge_y,box_height-d4_pocket_height+.001])
    d4_pocket();

  translate([-pocket_edge_x,-pocket_edge_y,box_height-d6_pocket_height+.001])
    d6_pocket();

  translate([-pocket_edge_x,pocket_edge_y,box_height-d8_pocket_height+.001])
    d8_pocket();

  translate([pocket_edge_x,-pocket_edge_y,box_height-d12_pocket_height+.001])
    d12_pocket();
}

module magnet_pockets(length, width, box_height) {
  for(x=[-1,1]) {
    for(y=[-1,1]) {
      translate([.4*length*x,.206*width*y,box_height-2.999])
        color("blue")
        magnet_divot();
      translate([.142*length*x,.42*width*y,box_height-2.999])
        color("blue")
        magnet_divot();
    }
  }
}