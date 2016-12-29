#peaks[zoom>=13] {
  marker-file: url(img/triangle.svg);
  marker-fill:black;
//marker-allow-overlap:true;
//marker-ignore-placement:true;
  marker-width:6;
  [zoom=14]{ marker-width:10; }
  [zoom>=15]{ marker-width:12;  }
}

#restaurant_low[zoom>=13][zoom<15],
#restaurant_high[zoom>=15]{
  ::marker {
    marker-file: url(img/restaurant.svg);
    [type='hotel'] {marker-file: url(img/hotel.svg);}
    [type='pub'],[type='biergarten'] {marker-file: url(img/pub.svg);}
    [type='bar'] {marker-file: url(img/bar.svg);}
    marker-width: 12;
    marker-clip: false;
//    marker-ignore-placement:true;
//	marker-allow-overlap:true;
    [zoom>=14][zoom<15] {marker-width: 18;}
    [zoom>=15] {marker-width: 28;}
  }
}

#station[zoom>=12] {
  ::marker {
    [type='tram_stop'][zoom>=16] {
      marker-file: url(img/station.red.svg);
      marker-width:10;
      marker-allow-overlap:true;
      marker-ignore-placement:true;
      [zoom>=16] {marker-width:14;}
    }
    [type='station'][subway!='yes'],[type='halt'] {
      marker-file: url(img/station.red.svg);
      marker-allow-overlap:true;
      marker-ignore-placement:true;
      marker-width:8;
      [zoom>=13][zoom<15] {marker-width:10;}
      [zoom>=15][zoom<16] {marker-width:14;}
      [zoom>=16] {marker-width:18;}
    }
    [type='station'][subway='yes'][zoom>=15]{
      marker-file: url(img/subway.svg);
      marker-allow-overlap:true;
      marker-ignore-placement:true;
      marker-width:18;
    }
  }
}

#parking[zoom>=15] {
  marker-file: url(img/parking.svg);
  [type='multi-storey'],[type='underground'] {marker-file: url(img/parking.garage.svg);}
  marker-width: 18;
  marker-clip: false;
  marker-allow-overlap:true;
}

#bus_stop[zoom>=16] {
  marker-file: url(img/bus_stop.svg);
  marker-width:18;
  marker-clip: false;
  marker-allow-overlap:true;
}

#shelter[zoom>=13] {
  marker-file: url(img/shelter.svg);
  marker-clip: false;
  marker-width: 20;
  [zoom>=13][zoom<14] {marker-width: 12;}
  [zoom>=14][zoom<15] {marker-width: 16;}
}

#tourism[zoom>=15] {
  [type='viewpoint'] {
    marker-file: url(img/viewpoint.svg);
    marker-width: 24;
    marker-clip: false;
  }
  [type='information']{
    marker-file: url(img/information.svg);
    marker-width: 10;
    marker-clip: false;
  }
  [type='attraction'],[type='theme_park'],[type='water_park']{
    text-size: 18;
    text-character-spacing: 1.6;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-placement-type: simple;
    text-placements: "S,N,E,W,NE,SE,NW,SW";
    text-dy: 20;
    text-dx: 20;
    text-fill:@restaurant_text;
    text-wrap-width: 200;
    text-wrap-before: true;
    text-halo-fill: @text_halo_strong;
    text-halo-radius: 3;
  }
  [type='zoo'],[type='aquarium'] {
    text-size: 18;
    text-character-spacing: 1.6;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-placement-type: simple;
    text-placements: "S,N,E,W,NE,SE,NW,SW";
    text-dy: 20;
    text-dx: 20;
    text-fill:@forest_text;
    text-wrap-width: 200;
    text-wrap-before: true;
    text-halo-fill: @text_halo_strong;
    text-halo-radius: 3;
  }
  [type='playground']{
    marker-file: url(img/playground.svg);
    marker-width: 18;
    marker-clip: false;
    marker-allow-overlap:true;
  }
  [type='palaeontological_site'] {
    marker-file: url(img/nautilid.svg);
    marker-width: 18;
    marker-clip: false;
    marker-allow-overlap:false;
    [zoom>=16] {
      text-size: 18;
      text-character-spacing: 1.6;
      text-name:[name];
      text-face-name:@sans_bold_italic;
      text-placement-type: simple;
      text-placements: "S,N,E,W,NE,SE,NW,SW";
      text-dy: 20;
      text-dx: 20;
      text-fill:@restaurant_text;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-halo-fill: @text_halo_strong;
      text-halo-radius: 3;
      }
    }
  [type='climbing'] {
    marker-file: url(img/climbing.svg);
    marker-width: 18;
    marker-clip: false;
    marker-allow-overlap:false;
    [zoom>=16] {
      text-size: 18;
      text-character-spacing: 1.6;
      text-name:[name];
      text-face-name:@sans_bold_italic;
      text-placement-type: simple;
      text-placements: "S,N,E,W,NE,SE,NW,SW";
      text-dy: 20;
      text-dx: 20;
      text-fill:@forest_text;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-halo-fill: @text_halo_strong;
      text-halo-radius: 3;
      }
    }
}

#landmark[zoom>=15]{
  marker-width: 13;
  [type='tower'] {
    marker-file: url(img/tower.svg);
    marker-allow-overlap:true;
  }
  [type='church'] {
    marker-file: url(img/church.svg);
    marker-allow-overlap:true;
  }
}

#shop[zoom>=14] {
  [type='supermarket'][zoom>=15] {
    marker-file: url(img/shop2.svg);
    marker-width: 28;
    marker-clip: false;
  }
  [type='bicycle'] {
    marker-file: url(img/bike.svg);
    marker-width: 18;
    marker-clip: false;
    [zoom>=15] {marker-width: 28;}
  }
}

#hospital[zoom>=13]{
  ::marker {
    marker-file: url(img/hospital.svg);
    marker-width: 12;
    marker-clip: false; 
    [zoom>=14][zoom<15] {marker-width: 18;}
    [zoom>=15] {marker-width: 28;}
  }
}
