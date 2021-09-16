
base_width = 1600/4;
base_height = 1474/4;
target_height = 50;
scale_factor = target_height/base_height * .999;
translate([-base_width*scale_factor/2,-base_height*scale_factor/2,-.001])
  linear_extrude(1)
  scale([scale_factor, scale_factor, 1])
    import("./raven.svg");
