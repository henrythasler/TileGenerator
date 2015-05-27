#peaks[zoom>=12] {
  marker-file: url(img/triangle.svg);
  marker-fill:black;
//marker-allow-overlap:true;
//marker-ignore-placement:true;
  [zoom >=12][zoom<13] {  
	marker-width:3;
  }  
  [zoom >=13][zoom<14] {  
	marker-width:5;
  }  
  [zoom >=14] {
	marker-width:6;
    text-size: 9;
    text-character-spacing: 0.8;
    text-name:[name] + '\n' + [ele];
    text-face-name:@sans_bold_italic;
    text-placement-type: simple;
    text-placements: "S,N,E,W,NE,SE,NW,SW";
    text-dy: 6;
    text-dx: 10;
    text-min-padding: 10;
    text-fill:@peak_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;  
  }  
}


#station[zoom>=11] {
  ::marker {
    [type='tram_stop'][zoom>=14] {
      marker-file: url(img/station.red.svg);
      marker-width:5;  
      [zoom>=15] {marker-width:7;}
    }
    [type='station'],[type='halt'] {
      marker-file: url(img/station.red.svg);
      marker-allow-overlap:true;
      marker-ignore-placement:true;
      marker-width:4;  
      [zoom>=12][zoom<14] {marker-width:5;}
      [zoom>=14][zoom<15] {marker-width:7;}
      [zoom>=15] {marker-width:9;}
    }  
  }  
  ::label[name != null][zoom>=12] {
    [type='tram_stop'][zoom>=15] {
      text-size:9;
      text-character-spacing: 0.8;
      text-name:[name];
      text-face-name:@sans_italic;
      text-placement-type: simple;
      text-placements: "S,N,E,W,NE,SE,NW,SW";
      text-dy: 6;
      text-dx: 10;
      text-min-padding: 10;
      text-fill:@station_text;
      text-halo-fill: @text_halo_strong;
      text-halo-radius:1.5;  
      text-wrap-width: 100;
      text-wrap-before: true;
    }
    [type='station'],[type='halt'] {
      text-size:8;
      [zoom>=13][zoom<14] {text-size:9;}
      [zoom>=14] {text-size:10;}
      text-character-spacing: 0.8;
      text-name:[name];
      text-face-name:@sans_italic;
//      [zoom>=13] {text-face-name:@sans_bold_italic;}
      text-placement-type: simple;
      text-placements: "S,N,E,W,NE,SE,NW,SW";
      text-dy: 6;
      text-dx: 10;
      text-min-padding: 10;
      text-fill:@station_text;
      text-halo-fill: @text_halo_strong;
      text-halo-radius:1.5;  
      text-wrap-width:100;
      text-wrap-before: true;
    }  
  }  
}



#towns[zoom>=8] {
  [place='city'] {
    ::label[zoom<=12] {
      text-name: [name];
      text-size: 0;
      [zoom>=4][zoom<6][pop>500000]{text-size: 8; text-dy: 10; text-dx: 10;}
      [zoom>=6][zoom<8][pop>250000]{text-size: 8; text-dy: 10; text-dx: 10;}
      [zoom>=8][zoom<10] {text-size: 10; text-dy: 10; text-dx: 10;}
      [zoom>=10][zoom<12] {text-size: 12; text-dy: 30; text-dx: 30;}
      [zoom>=12][zoom<13] {text-size: 16; text-dy: 100; text-dx: 100;}
      text-character-spacing: 0.8;
      text-face-name:@sans_bold;
      text-halo-fill: @text_halo_strong;
      text-halo-radius:1.5;
      text-wrap-width: 100;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }  
  }
  [place='town'] {
    ::label[zoom>=9][zoom<=13]{
      text-name: [name];
      text-size: 0;
      text-face-name:@sans_bold;
      text-halo-fill: @text_halo_strong;
      [zoom>=9][zoom<10] {text-size: 8; text-face-name:@sans;}
      [zoom>=10][zoom<11] {text-size: 9; text-dy: 10; text-dx: 10; text-face-name:@sans;}
      [zoom>=11][zoom<12] {text-size: 9; text-dy: 30; text-dx: 30;}
      [zoom>=12][zoom<13] {text-size: 10; text-dy: 20; text-dx: 20;}
      [zoom>=13][zoom<14] {text-size: 12; text-dy: 60; text-dx: 60;}
      [zoom>=14] {text-size: 14; text-dy: 100; text-dx: 100;}
      text-character-spacing: 0.8;
      text-halo-radius:1.5;
      text-wrap-width: 100;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }  
  }
  [place='village'],[place='suburb'] {
    ::label[zoom>=11][zoom<=14]{
      text-name: [name];
      text-face-name:@sans;
      text-size: 0;
      [zoom>=11][zoom<12] {text-size: 8;}
      [zoom>=12][zoom<13] {text-size: 9; text-dy: 10; text-dx: 10;}
      [zoom>=13][zoom<14] {text-size: 10; text-dy: 20; text-dx: 20;}
      [zoom>=14]{text-size: 12; text-dy: 30; text-dx: 30;}
      text-character-spacing: 0.8;
      text-halo-fill: @text_halo_strong;
      text-halo-radius:1.5;
      text-wrap-width: 100;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }  
  }  
  [place='hamlet']{
    ::label[zoom>=13]{
      text-name: [name];
      text-face-name:@sans;
      text-size: 0;
      [zoom>=13][zoom<14] {text-size: 9; text-dy: 10; text-dx: 10;}
      [zoom>=14] {text-size: 10; text-dy: 20; text-dx: 20;}
      text-character-spacing: 0.8;
      text-halo-fill: @text_halo_strong;
      text-halo-radius:1.5;
      text-wrap-width: 100;
      text-wrap-before: true;
//	  text-min-padding: 10;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }  
  }  
}


#restaurant[zoom>=12] {
  ::marker {
    marker-file: url(img/sjjb/food_restaurant.n.32.png);
    marker-width: 6;
    marker-clip: false;
//    marker-ignore-placement:true;
//	marker-allow-overlap:true;
    [zoom>=13][zoom<14] {marker-width: 9;}
    [zoom>=14] {marker-width: 14;}
  }  
  ::label [zoom>=14]{  
    text-size: 9;
    text-character-spacing: 0.8;
    text-name:[name] + '\n' + [ele];
    text-face-name:@sans_bold_italic;
    text-placement-type: simple;
    text-placements: "S,N,E,W,NE,SE,NW,SW";
    text-dy: 10; 
    text-dx: 10;
    text-fill:@restaurant_text;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: @text_halo_strong;
    text-halo-radius:1.5;  
  }
}

#tower[zoom>=14] {
  marker-file: url(img/tower.svg);
  marker-allow-overlap:true;
}

#church[zoom>=14] {
  marker-file: url(img/church.svg);
  marker-allow-overlap:true;
}


#parking[zoom>=14] {
  marker-file: url(img/parking.svg);
  marker-width: 9;
  marker-clip: false;
  marker-allow-overlap:true;
}

#tourism[zoom>=14] {
  [type='viewpoint'] {
    marker-file: url(img/sjjb/tourist_view_point.p.32.png);
    marker-width: 12;
    marker-clip: false;
  }  
  [type='information']{
    marker-file: url(img/sjjb/amenity_information.glow.32.png);
    marker-width: 13;
    marker-clip: false;
  }  
  [type='zoo'],[type='aquarium'] {
    text-size: 9;
    text-character-spacing: 0.8;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-placement-type: simple;
    text-placements: "S,N,E,W,NE,SE,NW,SW";
    text-dy: 10; 
    text-dx: 10;
    text-fill:@forest_text;
    text-wrap-width: 100;
    text-wrap-before: true;
    text-halo-fill: @text_halo_strong;
    text-halo-radius:1.5;  
  }  
  
}

#shop[zoom>=12] {
  [type='supermarket'][zoom>=14] {
    marker-file: url(img/supermarket.32.png);
    marker-width: 14;
    marker-clip: false;
  }  
  [type='bicycle'] {
    [zoom>=12][zoom<13] { marker-fill:#f0f; marker-width: 5; marker-opacity: 0.8; marker-line-width: 0;}
    [zoom>=13][zoom<14] { marker-file: url(img/bicycle.32.png); marker-width: 9;}
    [zoom>=14] { marker-file: url(img/bicycle.32.png); marker-width: 14;}
    marker-clip: false;
  }  
}



#shelter[zoom>=12] {
  marker-file: url(img/shelter.svg);
  marker-clip: false;
  marker-width: 10;
  [zoom>=12][zoom<13] {marker-width: 6;}
  [zoom>=13][zoom<14] {marker-width: 8;}
}