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
      text-character-spacing: 1.6;
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
      text-character-spacing: 1.6;
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
      text-character-spacing: 1.6;
      text-halo-fill: @text_halo_strong;
      text-halo-radius:3;
      text-wrap-width: 200;
      text-wrap-before: true;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }  
  }  
}
