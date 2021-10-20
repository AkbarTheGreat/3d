include <../scad_lib/BOSL2/std.scad>

fire_inset();
//raven_inset();

module fire_inset() {
  base_width = 130/4;
  base_height = 156/4;
  target_height = 75;
  scale_factor = target_height/base_height;
  translate([0,0,-.001])
    linear_extrude(1)
    scale([scale_factor, scale_factor, 1])
      import("./fire_inset.svg", center=true, dpi=96);
}

module raven_inset() {
  base_width = 1600/4;
  base_height = 1474/4;
  target_height = 50;
  scale_factor = target_height/base_height;
  translate([-base_width*scale_factor/2,-base_height*scale_factor/2,-.001])
    linear_extrude(1)
    scale([scale_factor, scale_factor, 1])
      import("./raven_inset.svg");
}