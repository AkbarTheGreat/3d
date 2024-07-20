include <../scad_lib/BOSL2/std.scad>
include <tag_base.scad>

height = 5;
font_size = 25;
font = "Verdana";
dog = "PENNY";

union() {
  tag_base(140,20);
  name();
}

module name() {
  linear_extrude(height)
      text(text=dog, font=font, size=font_size, halign="center", valign="center");
}

//linear_extrude(1)
//scale([1,1,1])
//import("./penny_text.svg", center=true, dpi=96);