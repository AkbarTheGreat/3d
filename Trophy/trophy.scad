include <../scad_lib/BOSL2/std.scad>

// Scale to render trophy at
trophy_scale = .75;
// Trophy variant 
render_person = "text-only"; // ["deb", "text-only"]
// Trophy text
trophy_text = ["Sample","Text"];
// Text size
text_size = 15;

module text_only_trophy() {
  scale([trophy_scale, trophy_scale, trophy_scale]) {
    difference() {
      plain_trophy();
      trophy_title();
    }
  }
}

base_height = 60;

if (render_person == "deb") {
  deb_trophy();
}
if (render_person == "text-only") {
  text_only_trophy();
}

module deb_trophy() {
  scale([trophy_scale, trophy_scale, trophy_scale]) {
    difference() {
      plain_trophy();
      deb_art();
      trophy_title(x_offset=-35);
    }
  }
}

module plain_trophy() {
  trophy_base();
  trophy_body();
  trophy_arms();
}

module trophy_base() {
  translate([0,0,12.5])
  cuboid([180,120,25], edges = [[0,0,1,1],[0,0,1,1],[1,1,1,1]], chamfer=2);
  translate([0,0,base_height/2+25])
  cuboid([150,80,base_height], chamfer=2);
}

module trophy_body() {
  translate([0,0,base_height])
    rotate_extrude($fn=200)
      translate([-0.31,0,0])
        import("trophy_profile.svg");
}

module trophy_arms() {
  x_move = 29.5;
  z_move = 65+base_height;
  y_rotate = 19;

  translate([x_move,0,z_move])
    rotate([90,y_rotate,0])
      trophy_arm();
  translate([-x_move,0,z_move])
    rotate([90,y_rotate,180])
      trophy_arm();
}

module trophy_arm() {
  scale_factor = 1.45;
  scale([scale_factor,scale_factor,scale_factor])
  linear_extrude(4)
      import("trophy_handle.svg");
}

module deb_art() {
    translate([-70,-39,28])
    rotate([90,00,0])
    linear_extrude(1.5)
      import("deb-art.svg");
}

module trophy_title(x_offset=-60) {
  height = 25 + (text_size + 2) *(len(trophy_text)-1) + (base_height - (text_size + 2) * len(trophy_text))/2;
  translate([x_offset,-39,height])
  rotate([90,00,0])
  linear_extrude(1.5)
  union(){
    for (i = [0 : len(trophy_text)-1]) {
      translate([0 , -i * (text_size + 2), 0 ]) text(trophy_text[i], text_size);
    }
  }
}
