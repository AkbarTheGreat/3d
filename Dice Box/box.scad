include <box_primitives.scad>
include <dice_pockets.scad>

high_quality_pockets = false;
full_length = 114;
full_width = 85;
full_height = 25;
inside_buffer_length = 52.4;
inside_buffer_width = 30;

large_dice_box();

// This doesn't work great for high quality pockets, because it has to be ~90% of the pocket to clear the molding for the d12.  If you went with the low quality pockets, it'd work.
// (It does need more work, though)
module box_with_4d10_tiered() {
  bottom_height = full_height * .45;
  // Top
  translate([0,0,-bottom_height])
  difference() {
    box_with_4d10();
    translate([0,0,-.001])
      box_block(full_length, full_width*1.1, bottom_height, false);
  }
}

module large_dice_box() {
  difference() {
    union() {
      box_block(full_length, full_width, full_height-1, true);
      box_block(full_length-2.5, full_width-2.5, full_height, true);
    }
    
    translate([12,0,full_height-lg_d6_pocket_height+.001])
    rotate([0,0,0])
    large_d6_pocket(!high_quality_pockets);

    translate([-12,0,full_height-lg_d6_pocket_height+.001])
    rotate([0,0,180])
    large_d6_pocket(!high_quality_pockets);
    
    large_die_pockets(full_length, full_width, inside_buffer_length, inside_buffer_width, full_height);
    
    pocket_longwise = inside_buffer_length/2 + (full_length-inside_buffer_length)/4;
    translate([37,0,full_height-lg_d6_pocket_height+.001])
    large_d6_pocket(!high_quality_pockets);
    
    magnet_pockets(full_length, full_width, full_height);
  }
}

module box_with_4d10() {
  difference() {
    union() {
      box_block(full_length, full_width, full_height-1, true);
      box_block(full_length-2.5, full_width-2.5, full_height, true);
    }
    
    translate([12,0,full_height-d10_pocket_height+.001])
    rotate([0,0,0])
    d10_pocket(!high_quality_pockets);

    translate([-12,0,full_height-d10_pocket_height+.001])
    rotate([0,0,180])
    d10_pocket(!high_quality_pockets);
    
    die_pockets(full_length, full_width, inside_buffer_length, inside_buffer_width, full_height);

    pocket_longwise = inside_buffer_length/2 + (full_length-inside_buffer_length)/4;
    translate([pocket_longwise,0,full_height-d20_pocket_height+.001])
    rotate([0,0,180])
      d20_pocket(!high_quality_pockets);

    magnet_pockets(full_length, full_width, full_height);
  }
}

module box_with_figure() {
  full_height = 31;
  mini_pocket_length = inside_buffer_length;
  mini_pocket_width = inside_buffer_width;
  mini_pocket_height = 25.3;

  difference() {
    union() {
      box_block(full_length, full_width, full_height-1, true);
      box_block(full_length-2.5, full_width-2.5, full_height, true);
    }
    translate([0,0,(full_height-mini_pocket_height)+.001])
        box_block(mini_pocket_length, mini_pocket_width, mini_pocket_height);
    
    die_pockets(full_length, full_width, mini_pocket_length, mini_pocket_width, full_height);

    pocket_longwise = mini_pocket_length/2 + (full_length-mini_pocket_length)/4;
    translate([pocket_longwise,0,full_height-d20_pocket_height+.001])
    rotate([0,0,180])
      d20_pocket(!high_quality_pockets);

    magnet_pockets(full_length, full_width, full_height);
  }
}

module die_pockets(full_length, full_width, mini_pocket_length, mini_pocket_width, full_height) {
  //D10's on the edges
  pocket_shortwise = mini_pocket_width/2 + (full_width-mini_pocket_width)/4;
  translate([0,pocket_shortwise,full_height-d10_pocket_height+.001])
    rotate([0,0,90])
    d10_pocket(!high_quality_pockets);
  translate([0,-pocket_shortwise,full_height-d10_pocket_height+.001])
    rotate([0,0,-90])
    d10_pocket(!high_quality_pockets);

  //D20's on each end
  pocket_longwise = mini_pocket_length/2 + (full_length-mini_pocket_length)/4;
  translate([-pocket_longwise,0,full_height-d20_pocket_height+.001])
    d20_pocket(!high_quality_pockets);

  //Corners, D4, D6, D8, D12
  pocket_edge_x = mini_pocket_length/2 + (full_length-mini_pocket_length)/32;
  pocket_edge_y = mini_pocket_width/2 + (full_width-mini_pocket_width)/6;

  translate([pocket_edge_x,pocket_edge_y,full_height-d4_pocket_height+.001])
    d4_pocket(!high_quality_pockets);

  translate([-pocket_edge_x,-pocket_edge_y,full_height-d6_pocket_height+.001])
    d6_pocket(!high_quality_pockets);

  translate([-pocket_edge_x,pocket_edge_y,full_height-d8_pocket_height+.001])
    d8_pocket(!high_quality_pockets);

  translate([pocket_edge_x,-pocket_edge_y,full_height-d12_pocket_height+.001])
    d12_pocket(!high_quality_pockets);
}

module large_die_pockets(full_length, full_width, mini_pocket_length, mini_pocket_width, full_height) {
  //D10's on the edges
  pocket_shortwise = mini_pocket_width/2 + (full_width-mini_pocket_width)/4;
  translate([0,pocket_shortwise,full_height-lg_d10_pocket_height+.001])
    rotate([0,0,90])
    large_d10_pocket(!high_quality_pockets);
  translate([0,-pocket_shortwise,full_height-lg_d10_pocket_height+.001])
    rotate([0,0,-90])
    large_d10_pocket(!high_quality_pockets);

  //D20's on each end
  pocket_longwise = mini_pocket_length/2 + (full_length-mini_pocket_length)/4;
  translate([-pocket_longwise,0,full_height-lg_d20_pocket_height+.001])
    large_d20_pocket(!high_quality_pockets);

  //Corners, D4, D6, D8, D12
  pocket_edge_x = mini_pocket_length/2 + (full_length-mini_pocket_length)/32;
  pocket_edge_y = mini_pocket_width/2 + (full_width-mini_pocket_width)/6;

  translate([pocket_edge_x,pocket_edge_y,full_height-lg_d4_pocket_height+.001])
    large_d4_pocket(!high_quality_pockets);

  translate([-pocket_edge_x,-pocket_edge_y,full_height-lg_d6_pocket_height+.001])
    large_d6_pocket(!high_quality_pockets);

  translate([-pocket_edge_x,pocket_edge_y,full_height-lg_d8_pocket_height+.001])
    large_d8_pocket(!high_quality_pockets);

  translate([pocket_edge_x,-pocket_edge_y,full_height-lg_d12_pocket_height+.001])
    large_d12_pocket(!high_quality_pockets);
}

module magnet_pockets(length, width, full_height) {
  for(x=[-1,1]) {
    for(y=[-1,1]) {
      translate([.4*length*x,.206*width*y,full_height-2.999])
        color("blue")
        magnet_divot();
      translate([.142*length*x,.42*width*y,full_height-2.999])
        color("blue")
        magnet_divot();
    }
  }
}
