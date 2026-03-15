include <../scad_lib/BOSL2/std.scad>
include <../scad_lib/BOSL2/joiners.scad>

// Width of divider
divider_width = .5;
// Length of tray
tray_length = 255;
tray_base_length = 197;
// Height of tray to rim
tray_height = 26;
dovetail_slop = .1;

$fn = 128;

fwd(tray_height)
  tray_part_a();

back(tray_height)
  tray_part_b();

module tray_cross_section() {
  size = [tray_length / 2, tray_height, divider_width];

  attachable(size=size) {
    diff("remove")
      cuboid(size, anchor=BOTTOM) {
        tag("remove")
          position(RIGHT + FRONT)
            cuboid(
              [
                (tray_length - tray_base_length) / 2,
                tray_height * 2 - 1.5,
                divider_width + .1,
              ]
            );
      }
    children();
  }
}

module tray_part_a() {
  tray_cross_section()
    up(divider_width / 2)
      attach(LEFT)
        dovetail("male", slide=divider_width, width=10, height=5, $slop=dovetail_slop);
  ;
}

module tray_part_b() {
  diff("dovetail")
    tray_cross_section()
      up(divider_width / 2)
        tag("dovetail")
          attach(LEFT)
            dovetail("female", slide=divider_width, width=10, height=5, $slop=dovetail_slop);
  ;
}
