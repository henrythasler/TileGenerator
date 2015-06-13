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

#ne10mstates[zoom>=4][zoom<8][scalerank<3],
#ne10mstates[zoom>=6][zoom<12][scalerank<4]{
  line-join: round;  
  line-cap: round;
  line-width: 0.5;
  line-opacity: 0.6;
  line-color:@admin;
  line-dasharray: 6, 3;
  [zoom>=5][zoom<6] {line-width: 1;} 
  [zoom>=6][zoom<8] {line-width: 1.5;} 
  [zoom>=8][zoom<9] {line-width: 2; line-dasharray: 8, 4;}
  [zoom>=9]{line-width: 2.5; line-dasharray: 8, 4;}
}

//#ne10mstates_label[zoom=6][scalerank<3],
#ne10mstates_label[zoom=7][scalerank<4]{
  text-face-name: @sans_bold;
  text-fill:@darkgrey;
  text-size:12;
  text-transform:uppercase;
  text-halo-fill:@text_halo_strong;
  text-halo-radius:1.5;
  text-line-spacing:1;
  text-wrap-width:20;
  text-name:"[name]";
  text-placement: interior;
  text-placement-type: simple;
  text-placements: "S,N,E,W,NE,SE,NW,SW";
  text-dy: 20;
  text-dx: 20;  
}  

#admin_claim[zoom>=5][zoom<=8]{
  line-width:1;
  line-color:#811181;
  line-dasharray: 2, 2;  
}

#countries[zoom>=2][zoom<=6] {
  text-face-name: @sans_bold;
  text-fill:@darkgrey;
  text-size:8;
  text-transform:uppercase;
  text-halo-fill:@text_halo_strong;
  text-halo-radius:1.5;
  text-line-spacing:1;
  text-wrap-width:20;
  text-name:"''"; /* hackish? */
  
  [ScaleRank<2][zoom=2] {
    text-name: "[ABBREV]";
  }
  [ScaleRank<3][zoom=3] {
    text-name: "[ABBREV]";
    text-size:9;
  }
  [ScaleRank<4][zoom=4] {
    text-name: "[NAME]";
    text-size:10;
  }
  [ScaleRank<5][zoom=5] {
    text-name: "[NAME]";
    text-size:11;
    text-character-spacing:1;
    text-line-spacing:1;
  }
  [ScaleRank<9][zoom>5] {
    text-name: "[NAME]";
    text-size:12;
    text-character-spacing:2;
    text-line-spacing:2;
  }
  text-placement: interior;
  text-placement-type: simple;
  text-placements: "S,N,E,W,NE,SE,NW,SW";
  [zoom<=4] {text-dy: 10; text-dx: 10;}
  [zoom>=5] {text-dy: 20; text-dx: 20;}
}

#buildings[zoom>=14] {
  line-width: 0;
  polygon-opacity: 1;
  polygon-fill: @darkgrey;
}

#residental[zoom>=10] {
  polygon-fill:@grey;
  polygon-opacity: 0;
  [zoom>=10][zoom<14]{
  	polygon-opacity:1;
  }  
  [zoom>=14][zoom<15]{
    polygon-opacity:0.55;
  }  
  [zoom>=15] {
    polygon-opacity:0.5;
  }
}

#industrial[zoom>=10] {
  polygon-fill: @industrial;
  polygon-opacity: 1;
}

#industrial_label[zoom>=14] {
  [zoom>=14][zoom<15][area>=50000]{
    text-size: 9;
    text-character-spacing: 0.8;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@industry_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=15][area>=10000]{
    text-size: 9;
    text-character-spacing: 0.8;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@industry_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
}

#military[zoom>=8] {
  [zoom>=8][zoom<10][area>=2000000] {
    polygon-pattern-file:url(img/stripes-red.png);
    polygon-pattern-opacity: 0.2;
    line-width: 0.2;
    line-color: red;
  }  
  [zoom>=10][zoom<12][area>=500000] {
    polygon-pattern-file:url(img/stripes-red.png);
    polygon-pattern-opacity: 0.2;
    line-width: 0.2;
    line-color: red;
  }  
  [zoom>=12][zoom<14][area>=5000] {
    polygon-pattern-file:url(img/stripes-red.png);
    polygon-pattern-opacity: 0.2;
    line-width: 0.2;
    line-color: red;
  }  
  [zoom>=14]{
    polygon-pattern-file:url(img/stripes-red.png);
    polygon-pattern-opacity: 0.2;
    line-width: 0.2;
    line-color: red;
  }
}


#military_label[zoom>=11][zoom<12][area>=200000000],
#military_label[zoom>=12][zoom<14][area>=20000000],
#military_label[zoom>=14][zoom<15][area>=50000],
#military_label[zoom>=15][area>=10000]{
  text-size: 9;
  text-character-spacing: 0.8;
  text-name:[name];
  text-face-name:@sans_bold_italic;
  text-fill:@industry_text;
  text-halo-fill: @text_halo;
  text-halo-radius:1.5;   
  text-wrap-width: 50;
  text-wrap-before: true;
  text-placement: interior;
  text-placement-type: simple;
  text-placements: "S,N,E,W,NE,SE,NW,SW";
  text-dy: 20;
  text-dx: 20;
  
}

// to-do: improve SQL query to merge nearby lines
#railway[zoom>=10][type!='subway'] {
  ::line{
    line-width: 1.8;
    line-color: @runway;
    [tunnel='yes'] {line-dasharray: 2, 4; line-cap: round;}
    [type='tram'],[type='subway'] {line-width: 0;}
    [zoom>=12][zoom<13] {
      line-width: 2.5;
      [type='tram'],[type='subway'] {line-width: 0;}
      [tunnel='yes'] {line-dasharray: 4, 6;}
    }
    [zoom>=13][zoom<=14] {
      line-color: @darkgrey;
      line-width: 3.5;
      [type='tram'],[type='subway'] {line-width: 2;}
      [tunnel='yes'] {line-dasharray: 6, 8;}
    }
    [zoom>14] {
      line-color: @darkgrey;
      line-width: 4.5;
      [tunnel='yes'] {line-dasharray: 10, 12;}
    }
  }
  ::dash[zoom>=13][tunnel!='yes'] {
    line-color: white;
    line-width: 1.2;
    line-dasharray: 9, 9;
    [tunnel='yes'] {line-dasharray: 6, 4;}
    [type='tram'],[type='subway'] {line-width: 0;}
    [zoom>=13][zoom<=14] {
      line-width: 2;
      line-dasharray: 13, 13;
      [tunnel='yes'] {line-dasharray: 6, 4;}
      [type='tram'],[type='subway'] {line-width: 0;}
    }
    [zoom>14] {
      line-width: 2.5;
      line-dasharray: 18, 16;
      [tunnel='yes'] {line-dasharray: 6, 4;}
    }  
  }
}

.power[zoom>=14] {
  ::lines {
    line-width:0.5;
    line-color:black;
  }
  ::mast {
    marker-file: url(img/square.svg);
    marker-width:3;
    marker-fill:black;
//    marker-allow-overlap:true;
//    marker-ignore-placement:true;
  }	  
}

#runway[zoom>=10] {
  [zoom>=10][zoom<12][length>1500] {
  ::line{
    line-color:@runway;
    line-width: 3;
    }  
  ::dash{
    line-color: white;
    line-dasharray: 2, 2;
    line-width: 1;
    }
  }  
  [zoom>=12][zoom<13][length>300] {
  ::line{
    line-color:@runway;
    line-width: 5;
    }  
  ::dash{
    line-color: white;
    line-dasharray: 4, 4;
    line-width: 1.5;
    }
  }  
  [zoom>=13][zoom<14][length>100] {
  ::line{
    line-color:@runway;
    line-width: 8;
    }  
  ::dash{
    line-color: white;
    line-dasharray: 6, 6;
    line-width: 1.8;
    }
  }  
  [zoom>=14]{
  ::line{
    line-color:@runway;
    line-width: 14;
    }  
  ::dash{
    line-color: white;
    line-dasharray: 10, 10;
    line-width: 2;
    }
  }  
}


#taxiway[zoom>=11] {
  line-width:1;
  line-color:@runway;
  [zoom>=12][zoom<13]{
    line-width:2;
  }  
  [zoom>=13][zoom<14]{
    line-width:3;
  }  
  [zoom>=14]{
    line-width:6;
  }  
}


#aerialway[zoom>=12] {
  ::line {
    line-width:1;
    [zoom>=13][zoom<14] {line-width:1.4;}
    [zoom>=14] {line-width:1.8;}
    line-color: black;
    line-dasharray: 6, 3;
    [type='goods'][zoom>=14],[type='toboggan'][zoom>=14] {line-width:1; line-dasharray: 4, 2;}
    [type='goods'][zoom<14],[type='toboggan'][zoom<14] {line-width:0;}
  } 
  ::text[type!='goods'][zoom>=14] {
    text-size: 9;
    text-character-spacing: 0.8;
    text-name:[name];
    text-face-name:@sans_bold;
    text-placement:line;
    text-horizontal-alignment: middle;
    text-spacing: 100;
    text-fill:@peak_text;
    text-halo-fill: @text_halo_strong;
    text-halo-radius:1.5;      
  }  
}



#fence[zoom>=14] {
  line-join: round;  
  line-cap: round;
  line-color: @darkgrey;
  line-width: 1.5;
  line-dasharray: 6, 3, 0.5, 3;
}


