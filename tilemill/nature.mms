#simple{
  polygon-fill:@land;
}

#admin_global[zoom>=1][zoom<=8],
#admin_local[zoom>=9]{
  line-join: round;  
  line-cap: round;
  line-width: 0.5;
  line-opacity: 0.6;
  line-color:@admin;
  [zoom>=2][zoom<4] {line-width: 1;}
  [zoom>=4][zoom<6] {line-width: 1.5;}
  [zoom>=6][zoom<8] {line-width: 2;}
  [zoom>=8] {line-width: 3;}
//  line-dasharray: 18, 18;  
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
  [place='hamlet'][area>=50000]{
    ::label[zoom>=14]{
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
//        text-min-padding: 10;
      text-placement-type: simple;
      text-placements: "N,S,E,W,NE,SE,NW,SW";
    }  
  }  
}