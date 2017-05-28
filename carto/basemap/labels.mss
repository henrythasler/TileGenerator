#global_countries[zoom>=4][zoom<8] {
  text-face-name: @sans_bold;
  text-fill:@darkgrey;
  text-size: 16;
  text-transform:uppercase;
  text-halo-fill:@text_halo_strong;
  text-halo-radius: 3;
  text-line-spacing: 2;
  text-wrap-width: 40;
  text-name:"''"; /* hackish? */

  [LABELRANK<4][zoom=4] {
    text-name: "[ABBREV]";
    text-size:18;
  }
  [LABELRANK<5][zoom=5] {
    text-name: "[NAME]";
    text-size:20;
  }
  [LABELRANK<6][zoom=6] {
    text-name: "[NAME]";
    text-size: 22;
    text-character-spacing: 2;
    text-line-spacing: 2;
  }
  [LABELRANK<9][zoom>=7] {
    text-name: "[NAME]";
    text-size: 24;
    text-character-spacing: 4;
    text-line-spacing: 4;
  }
  text-placement: interior;
  text-placement-type: simple;
  text-placements: "S,N,E,W,NE,SE,NW,SW";
  [zoom<6] {text-dy: 20; text-dx: 20;}
  [zoom>=6] {text-dy: 40; text-dx: 40;}
}

#global_states[zoom=6][scalerank<=2],
#global_states[zoom>=7][zoom<8][scalerank<=3],
#global_states[zoom>=8][zoom<9][scalerank<6],
#global_states[zoom>=9][zoom<11][scalerank>3][scalerank<7]
{
  text-name:'[name]';
  [zoom=6] {text-name:'[abbrev]';}
  text-face-name: @sans_bold;
  text-fill:@darkgrey;
  text-size: 16;
  [zoom>=7][zoom<10] {text-size: 20;}
  [zoom>=10] {text-size: 24;}
  text-transform:uppercase;
  text-halo-fill:@text_halo_strong;
  text-halo-radius: 3;
  text-line-spacing: 2;
  text-wrap-width: 40;
  text-placement: interior;
  text-placement-type: simple;
  text-placements: "S,N,E,W,NE,SE,NW,SW";
  text-dy: 40; text-dx: 40;
  [zoom<10] {text-dy: 20; text-dx: 20;}
}

#admin2[zoom>=8]{
  text-size: 18;
  text-character-spacing: 1.6;
  text-name:'[name]';
  text-face-name:@sans_italic;
  text-placement:line;
  text-fill:@peak_text;
  text-halo-fill: @admin_halo;
  text-halo-radius:3;
  text-dy: 7;
}

#admin4[zoom>=12]{
  text-size: 18;
  text-character-spacing: 1.6;
  text-name:'[name]';
  text-face-name:@sans_italic;
  text-placement:line;
  text-fill:@peak_text;
  text-halo-fill: @admin_halo;
  text-halo-radius:3;
  text-dy: 7;
}

#admin6_de_label[zoom>=14]{
  text-size: 18;
  text-character-spacing: 1.6;
  text-name:'[name]';
  text-face-name:@sans_italic;
  text-placement:line;
  text-fill:@peak_text;
  text-halo-fill: @admin_halo;
  text-halo-radius:3;
  text-dy: 7;
}

#peaks::label[zoom>=15] {
    text-size: 18;
    text-name:[name] + '\n' + [ele];
    text-face-name:@sans_bold_italic;
    text-placement-type: simple;
    text-placements: "S,N,E,W,NE,SE,NW,SW";
    text-dy: 12;
    text-dx: 20;
    text-min-padding: 20;
    text-fill:@peak_text;
    text-halo-fill: @text_halo;
    text-halo-radius: 3;
}

#restaurant_low[zoom>=13][zoom<15],
#restaurant_high[zoom>=15]{
  ::label [zoom>=15]{
    text-size: 18;
    text-name:[name] + '\n' + [ele];
    text-face-name:@sans_bold_italic;
    text-placement-type: simple;
    text-placements: "S,N,E,W,NE,SE,NW,SW";
    text-dy: 20;
    text-dx: 20;
    text-fill:@restaurant_text;
    text-wrap-width: 200;
    text-wrap-before: true;
    text-halo-fill: @text_halo_strong;
    text-halo-radius:3;
  }
}

#hospital[zoom>=16]{
  ::label{
    text-size: 18;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-placement-type: simple;
    text-placements: "S,N,E,W,NE,SE,NW,SW";
    text-dy: 20;
    text-dx: 20;
    text-fill:@hospital_text ;
    text-wrap-width: 200;
    text-wrap-before: true;
    text-halo-fill: @text_halo_strong;
    text-halo-radius:3;
  }
}

#road_shields[zoom>=10][reflen<=5] {
  shield-name: "[ref]";
  shield-size: 18;
  shield-face-name: @sans;
  shield-character-spacing: -1.6;
  shield-fill: white;
  shield-avoid-edges: true;
  shield-clip: false;
  shield-file: url(img/shield-3.blue.svg);
  shield-transform: "scale(2)"; // https://developer.mozilla.org/en-US/docs/Web/SVG/Attribute/transform
  [type='motorway'] {
    [reflen>=4][reflen<5] {shield-file: url(img/shield-4.blue.svg);}
    [reflen>=5][reflen<6] {shield-file: url(img/shield-5.blue.svg);}
  }
  [type='primary'],[type='trunk'] {
    shield-fill: black;
	shield-file: url(img/shield-3.yellow.svg);
    [reflen>=4][reflen<5] {shield-file: url(img/shield-4.yellow.svg);}
    [reflen>=5][reflen<6] {shield-file: url(img/shield-5.yellow.svg);}
  }
  [zoom<13] {shield-min-distance: 300;}
  [zoom>=13][zoom<15] {shield-min-distance: 400;}
  [zoom>=15] {shield-min-distance: 300;}
}

#grassland_label[zoom>=13][zoom<14][area>=10000000],
#grassland_label[zoom>=14][zoom<15][area>=1000000],
#grassland_label[zoom>=15][zoom<16][area>=100000],
#grassland_label[zoom>=16][area>=10000],
#swamp_label[zoom>=13][zoom<14][area>=10000000],
#swamp_label[zoom>=14][zoom<15][area>=1000000],
#swamp_label[zoom>=15][zoom<16][area>=100000],
#swamp_label[zoom>=16][area>=10000],
#forest_label[zoom>=13][zoom<14][area>=10000000],
#forest_label[zoom>=14][zoom<15][area>=1000000],
#forest_label[zoom>=15][zoom<16][area>=100000][area<=10000000],
#forest_label[zoom>=16][area>=10000][area<=1000000] {
  text-size: 18;
  text-name:[name];
  text-face-name:@sans_bold_italic;
  text-fill:@forest_text;
  text-halo-fill: @text_halo;
  text-halo-radius: 3;
  text-wrap-width: 200;
  text-wrap-before: true;
  text-placement: interior;
}

#lakes_label[zoom=11][area>=100000000],
#lakes_label[zoom=12][area>=10000000],
#lakes_label[zoom=13][area>=1000000],
#lakes_label[zoom=14][area>=100000],
#lakes_label[zoom=15][area>=20000],
#lakes_label[zoom>=16][area>=1000] {
  text-size: 18;
  text-name:[name] + '\n' + [ele];
  text-face-name:@sans_bold_italic;
  text-fill:@water_text;
  text-halo-fill: @text_halo;
  text-halo-radius: 3;
  text-wrap-width: 200;
  text-wrap-before: true;
  text-placement: interior;
}

#global_rivers[zoom>=8][zoom<10][scalerank<7]{
    text-size: 18;
    text-name:'[name]';
    text-face-name:@sans_bold_italic;
    text-placement:line;
    text-fill:@water_text;
    text-halo-fill: fadeout(white, 60%);
    text-halo-radius: 3;
}

#waterway_label[zoom>=13][length>200][type='river'],
#waterway_label[zoom>=13][length>200][type='canal'],
#waterway_label[zoom>=15][length>200][type='stream'],
#waterway_label[zoom>=15][length>200][type='ditch']{
  text-size: 18;
  text-name:'[name]';
  text-face-name:@sans_bold_italic;
  text-placement:line;
  text-fill:@water_text;
  text-halo-fill: fadeout(white, 60%);
  text-halo-radius: 3;
}



#glacier_label[zoom=11][area>=100000000],
#glacier_label[zoom=12][area>=10000000],
#glacier_label[zoom=13][area>=1000000],
#glacier_label[zoom=14][area>=100000],
#glacier_label[zoom=15][area>=20000],
#glacier_label[zoom>=16][area>=1000] {
  text-size: 18;
  text-name:[name];
  text-face-name:@sans_bold_italic;
  text-fill:@water;
  text-halo-fill: @text_halo;
  text-halo-radius: 3;
  text-wrap-width: 200;
  text-wrap-before: true;
  text-placement: interior;
}

#cycleroute_labels[zoom>=15] {
  text-size: 18;
  text-min-distance: 1000;
  text-spacing: 1000;
  text-name:'[route_name]';
  text-face-name:@sans;
  text-placement:line;
  text-fill:fadeout(darken(blue, 30%),20%);
  text-halo-fill: fadeout(white, 40%);
  text-halo-radius: 3;
}

#camping[zoom>=16]{
  text-size: 18;
  text-name:'[name]';
  text-face-name:@sans_bold_italic;
  text-placement-type: simple;
  text-placements: "S,N,E,W,NE,SE,NW,SW";
  text-dy: 20;
  text-dx: 20;
  text-fill:@camping_text;
  text-wrap-width: 200;
  text-wrap-before: true;
  text-halo-fill: @text_halo_strong;
  text-halo-radius:3;
}

#industrial_label[zoom=13][area>=1500000],
#industrial_label[zoom=14][area>=700000],
#industrial_label[zoom=15][area>=200000],
#industrial_label[zoom>=16][area>=10000],
#military_label[zoom=12][area>=200000000],
#military_label[zoom>=13][zoom<15][area>=20000000],
#military_label[zoom>=15][zoom<16][area>=50000],
#military_label[zoom>=16][area>=10000]
{
  text-size: 18;
  text-name:[name];
  text-face-name:@sans_bold_italic;
  text-fill:@industry_text;
  text-halo-fill: @text_halo;
  text-halo-radius: 3;
  text-wrap-width: 200;
  text-wrap-before: true;
  text-placement: interior;
}

#nature_reserve_label[zoom>=9][zoom<11][area>=1200000000],
#nature_reserve_label[zoom>=11][zoom<13][area>=80000000],
#nature_reserve_label[zoom=13][area>=6000000][area<1200000000],
#nature_reserve_label[zoom=14][area>=1000000][area<80000000],
#nature_reserve_label[zoom>=15][area>=10000][area<6000000]
{
  text-size: 18;
  text-name: [name];
  text-face-name:@sans_bold_italic;
  text-fill:green;
  text-halo-fill: @text_halo;
  text-halo-radius: 3;
  text-wrap-width: 200;
  text-wrap-before: true;
  text-placement: interior;
}

#towns[zoom>=9] {
  [place='city'] {
    ::label[zoom<=13] {
      text-name: [name];
      text-size: 0;
      [zoom>=5][zoom<7][pop>500000]{text-size: 16; text-dy: 20; text-dx: 20;}
      [zoom>=7][zoom<9][pop>250000]{text-size: 16; text-dy: 20; text-dx: 20;}
      [zoom>=9][zoom<11] {text-size: 20; text-dy: 20; text-dx: 20;}
      [zoom>=11][zoom<13] {text-size: 24; text-dy: 60; text-dx: 60;}
      [zoom>=13][zoom<14] {text-size: 32; text-dy: 200; text-dx: 200;}
      text-character-spacing: 1.6;
      text-face-name:@sans_bold;
      text-halo-fill: @text_halo_strong;
      text-halo-radius:3;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }
  }
  [place='town'] {
    ::label[zoom>=10][zoom<=14]{
      text-name: [name];
      text-size: 0;
      text-face-name:@sans_bold;
      text-halo-fill: @text_halo_strong;
      [zoom>=10][zoom<11] {text-size: 16; text-face-name:@sans;}
      [zoom>=11][zoom<12] {text-size: 18; text-dy: 20; text-dx: 20; text-face-name:@sans;}
      [zoom>=12][zoom<13] {text-size: 18; text-dy: 60; text-dx: 60;}
      [zoom>=13][zoom<14] {text-size: 20; text-dy: 40; text-dx: 40;}
      [zoom>=14][zoom<15] {text-size: 24; text-dy: 120; text-dx: 120;}
      text-halo-radius:3;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }
  }
  [place='village'],[place='suburb'] {
    ::label[zoom>=12][zoom<=15]{
      text-name: [name];
      text-face-name:@sans;
      text-size: 0;
      [zoom>=12][zoom<13] {text-size: 16;}
      [zoom>=13][zoom<14] {text-size: 18; text-dy: 20; text-dx: 20;}
      [zoom>=14][zoom<15] {text-size: 20; text-dy: 40; text-dx: 40;}
      [zoom>=15]{text-size: 24; text-dy: 60; text-dx: 60;}
      text-halo-fill: @text_halo_strong;
      text-halo-radius:3;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }
  }
  [place='hamlet'][area>=50000]{
    ::label[zoom>=15]{
      text-name: [name];
      text-face-name:@sans;
      text-size: 0;
      [zoom>=14][zoom<15] {text-size: 18; text-dy: 20; text-dx: 20;}
      [zoom>=15] {text-size: 20; text-dy: 40; text-dx: 40;}
      text-character-spacing: -0.5;
      text-halo-fill: @text_halo_strong;
      text-halo-radius:3;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }
  }
}

#cities[zoom<9]{
  ::capitals[ADM0CAP=1] {
    [zoom=4][SCALERANK<=1],
    [zoom=5][SCALERANK<=3],
    [zoom=6][SCALERANK<=4],
    [zoom=7][SCALERANK<=5],
    [zoom>=8] {
      marker-file: url(img/star.white.svg);
      marker-width:16;

      text-name: [NAME];
      text-face-name:@sans;
      text-size: 16;
      [zoom=6] {text-size: 18;}
      [zoom=7] {text-size: 22; text-face-name:@sans_bold;}
      [zoom>=8] {text-size: 26; text-face-name:@sans_bold;}
      text-halo-fill: @text_halo_strong;
      text-halo-radius: 3;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-character-spacing: 1.6;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
      text-dy: 12;
      text-dx: 12;
    }
  }
  ::major[ADM0CAP!=1] {
    [zoom=6][SCALERANK<=3],
    [zoom=7][SCALERANK<=6],
    [zoom>=8] {
      marker-width:12;
      marker-line-width: 2;
      marker-fill: white;

      text-name: [NAME];
      text-face-name:@sans;
      text-size: 16;
      [zoom=7] {text-size: 18;}
      [zoom>=8] {text-size: 20;}
      text-halo-fill: @text_halo_strong;
      text-halo-radius: 3;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
      text-dy: 12;
      text-dx: 12;
    }
  }
}

#station[zoom>=12] {
  ::label[name != null][zoom>=13] {
    [type='tram_stop'][zoom>=16],[type='station'][subway='yes'][zoom>=16]{
      text-size:16;
      text-name:[name];
      text-face-name:@sans_italic;
      text-placement-type: simple;
      text-placements: "S,N,E,W,NE,SE,NW,SW";
      text-dy: 12;
      text-dx: 20;
      text-min-padding: 20;
      text-fill:@station_text;
      text-halo-fill: @text_halo_strong;
      text-halo-radius: 3;
      text-wrap-width: 200;
      text-wrap-before: true;
    }
    [type='station'][subway!='yes'],[type='halt'] {
      text-size: 16;
      [zoom>=14][zoom<15] { text-size:18; }
      [zoom>=15] {text-size:20;}
      text-name:[name];
      text-face-name:@sans_italic;
//      [zoom>=13] {text-face-name:@sans_bold_italic;}
      text-placement-type: simple;
      text-placements: "S,N,E,W,NE,SE,NW,SW";
      text-dy: 12;
      text-dx: 20;
      text-min-padding: 20;
      text-fill:@station_text;
      text-halo-fill: @text_halo_strong;
      text-halo-radius: 3;
      text-wrap-width: 200;
      text-wrap-before: true;
    }
  }
}
