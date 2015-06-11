//@water:             #90B0C0;
@water_global:      #72abd4;
@water:             #7babcd;
@river:             #1f83bc;

@forest:            #b0d090;
@land:              #f6f4e7;
@grass:             #dee9ba;
@contour:           #7f3300;
@swamp:             #339966;
@white: 			#fff;
@lightblue:         #add8e6;
@darkgrey: 			#444;
@grey:              #ccc;
@runway:            #666;
@industrial:        #d4bdb6;
@track:             #885b03;
@shiproute:         #1111aa;
@admin:             #838;

@motorway:          #ee9900;
@primary:           #ffcc99;
//@primary:           #f0ca99;
@secondary:         #ffff99;

@text_halo_weak:    fadeout(white, 80%);
@text_halo:         fadeout(white, 50%);
@text_halo_strong:  fadeout(white, 20%);

@forest_text:       fadeout(darken(#669966, 15%),20%);
@water_text:        fadeout(darken(#666699, 15%),20%);
@industry_text:     darken(#996666, 15%);
@military_text:     #996666;
@contour_text:      fadeout(darken(#7f3300, 15%),20%);
@restaurant_text:   fadeout(darken(brown, 20%),20%);
@peak_text:         fadeout(black,20%);
@station_text:      #000080;


/* directory to load fonts from in addition to the system directories */
Map {
  font-directory: url(./fonts); 
  background-color:@water;
//  buffer-size: 512;
}

@sans_lt:           "Open Sans Regular";
@sans_lt_italic:    "Open Sans Italic";
@sans:              "Open Sans Semibold";
@sans_italic:       "Open Sans Semibold Italic";
@sans_bold:         "Open Sans Bold";
@sans_bold_italic:  "Open Sans Bold Italic";

/*
@sans_bold: "Verdana Bold";
@sans_bold_italic: "Verdana Bold Italic";
@sans_italic: "Verdana Italic";
@sans: "Verdana Regular";
*/
/*
@sans: "DejaVu Sans Book";
@sans_bold: "DejaVu Sans Bold";
@sans_bold_italic: "DejaVu Sans Bold Oblique";
@sans_italic: "DejaVu Sans Oblique";
*/

@mono: "Ubuntu Mono Regular";
@mono_bold: "Ubuntu Mono Bold";
@mono_bold_italic: "Ubuntu Mono Bold Italic";
@mono_italic: "Ubuntu Mono Italic";





