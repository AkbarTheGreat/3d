include <box_primitives.scad>
include <dice_pockets.scad>

box_lid();

module box_lid() {
  full_length = 114;
  full_width = 85;
  full_height = 8;

  difference() {
    box_block(full_length, full_width, full_height, false);
    translate([0,0,full_height-.999])
      box_block(full_length-2, full_width-2, 1, false);
    magnet_pockets(full_length, full_width, full_height-.999);
    notch(full_width, full_height);
    //fire_logo(full_length, full_width);
    //medic_logo(full_length, full_width);
    //raven_logo(full_length, full_width);
    //spider_logo(full_length, full_width);
  }
}

module notch(width, height) {
  move([0,-width/2+.5,height+1])
  cuboid([15,3,4], rounding=.5);
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

module fire_logo(length, width) {
  base_width = 130/4;
  base_height = 156/4;
  target_height = 75;
  scale_factor = target_height/base_height;
  rotate([0,0,90])
    translate([0,0,-.001])
    linear_extrude(1.25)
    scale([scale_factor, scale_factor, 1])
      import("./fire.svg", center=true, dpi=96);
}

module medic_logo(length, width) {
  base_width = 363/4;
  base_height = 363/4;
  target_height = 50;
  scale_factor = target_height/base_height;
  translate([0,0,-.001])
    linear_extrude(1.25)
    scale([scale_factor, scale_factor, 1])
      import("./medic.svg", center=true, dpi=96);
}

module raven_logo(length, width) {
  base_width = 1600/4;
  base_height = 1474/4;
  target_height = 50;
  scale_factor = target_height/base_height;
  translate([-base_width*scale_factor/2,-base_height*scale_factor/2,-.001])
    linear_extrude(1.25)
    scale([scale_factor, scale_factor, 1])
      import("./raven.svg");
}

module spider_logo(length, width) {
  base_width = 1126/4;
  base_height = 1694/4;
  target_height = 100;
  scale_factor = target_height/base_height;
  rotate([0,0,90])
    translate([0,0,-.001])
    linear_extrude(1.25)
    scale([scale_factor, scale_factor, 1])
    import("./spider.svg", center=true, dpi=96);
}
