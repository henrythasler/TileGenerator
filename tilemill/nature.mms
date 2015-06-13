#simple[zoom>=7][zoom<10],
#detailled[zoom>=10]{
  polygon-fill:@land;
}

#grassland {
  polygon-opacity: 0;
  polygon-fill: @grass;
  [zoom>=10][zoom<12][area>=50000] {
  	polygon-opacity: 1;
  }  
  [zoom>=12][zoom<14][area>=10000] {
  	polygon-opacity: 1;
  }  
  [zoom>=14][zoom<15][area>=1000] {
  	polygon-opacity: 1;
  }
  [zoom>=15]{
  	polygon-opacity: 1;
  }  
}

#grassland_label[zoom>=12] {
  [zoom>=12][zoom<13][area>=10000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=13][zoom<14][area>=1000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=14][zoom<15][area>=100000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=15][area>=10000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
}

#forest[zoom>=8] {
  polygon-opacity: 0;  
  polygon-fill: @forest;
  [zoom<8][area>=1000000] {
  	polygon-opacity: 1;
  }
  [zoom>=8][zoom<10][area>=200000] {
  	polygon-opacity: 1;
  }  
  [zoom>=10][zoom<12][area>=50000] {
  	polygon-opacity: 1;
  }  
  [zoom>=12][zoom<14][area>=5000] {
  	polygon-opacity: 1;
  }  
  [zoom>=14][zoom<15][area>=1000] {
  	polygon-opacity: 1;
  }
  [zoom>=15]{
  	polygon-opacity: 1;
  }
}

#forest_label[zoom>=12] {
  [zoom>=12][zoom<13][area>=10000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=13][zoom<14][area>=1000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=14][zoom<15][area>=100000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=15][area>=10000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
}


#swamp[zoom>=8] {
  polygon-opacity: 0.0;
  polygon-pattern-file:url(img/wetland.png);
  polygon-fill: @swamp;
  [zoom<8][area>=1000000] {
	polygon-opacity: 0.2;
  }
  [zoom>=8][zoom<10][area>=200000] {
	polygon-opacity: 0.2;
  }  
  [zoom>=10][zoom<12][area>=50000] {
	polygon-opacity: 0.2;
  }  
  [zoom>=12][zoom<14][area>=5000] {
	polygon-opacity: 0.2;
  }  
  [zoom>=14][zoom<15][area>=1000] {
	polygon-opacity: 0.2;
  }
  [zoom>=15]{
	polygon-opacity: 0.2;
  }
}


#swamp_label[zoom>=12] {
  [zoom>=12][zoom<13][area>=10000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=13][zoom<14][area>=1000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=14][zoom<15][area>=100000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=15][area>=10000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@forest_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
}

#10mlakes[ScaleRank<5][zoom=2],
#10mlakes[ScaleRank<6][zoom=3],
#10mlakes[ScaleRank<7][zoom=4],
#10mlakes[ScaleRank<8][zoom=5],
#10mlakes[zoom>=6][zoom<8]{
  polygon-fill:@water_global;
  line-width: 0.5;
  line-color:@river;
}

#lakes[zoom>=5][zoom<6][area>=200000000],
#lakes[zoom>=6][zoom<7][area>=20000000],
#lakes[zoom>=7][zoom<8][area>=10000000] {
  polygon-fill:@water_global;
  line-width: 0.5;
  line-color:@river;
}

#lakes[zoom>=8][zoom<10][area>=2000000],
#lakes[zoom>=10][zoom<11][area>=500000],
#lakes[zoom>=11][zoom<12][area>=50000],
#lakes[zoom>=12][zoom<14][area>=2000],
#lakes[zoom>=14][zoom<15][area>=1000],
#lakes[zoom>=15] {
  polygon-fill: @water;
  line-width: 0.5;
  line-offset: -0.25;
  line-color:@river;
}  


#10mrivers[zoom>=2][zoom<=8] {
  line-width: 0;
  line-color:@river;
  [zoom=2] {
    [scalerank<4] {line-width: 0.5;}
  }
  [zoom=3] {
    [scalerank<4] {line-width: 0.8;}
  }
  [zoom=4] {
    [scalerank<4] {line-width: 1;}
    [scalerank>=4][scalerank<7] {line-width: 0.8;}
  }
  [zoom=5]{
    [scalerank<4] {line-width: 1.2;}
    [scalerank>=4][scalerank<7] {line-width: 1;}
  }
  [zoom=6]{
    [scalerank<4] {line-width: 1.8;}
    [scalerank>=4][scalerank<7] {line-width: 1.4;}
    [scalerank>=7] {line-width: 1;}
  }
  [zoom>=7][zoom<=8]{
    [scalerank<4] {
      line-width: 2;
      
      text-size: 9;
      text-name:'[name]';
      text-face-name:@sans_bold_italic;
      text-placement:line;
      text-fill:@water_text;
      text-halo-fill: fadeout(white, 60%);
      text-halo-radius:1.5;         
    }
    [scalerank>=4][scalerank<7] {
      line-width: 1.5;
      
      text-size: 9;
      text-name:'[name]';
      text-face-name:@sans_bold_italic;
      text-placement:line;
      text-fill:@water_text;
      text-halo-fill: fadeout(white, 60%);
      text-halo-radius:1.5;         
    }
    [scalerank>=7] {line-width: 1;}
  }
}

#waterway[zoom>=9]{
  ::line{
    line-cap: round;
    line-join: round;  
    line-color:@river;
    line-width: 0;
    [zoom>=9][zoom<10]{
      [type='river'],[type='canal']{
        line-width: 1;
      }  
    }  
    [zoom>=10][zoom<12]{
      [type='river'],[type='canal']{
        line-width: 1;
      }  
    }  
    [zoom>=12][zoom<13]{
      [type='river'],[type='canal']{
        line-width: 1.5;
      }
     [type='stream'] {
        line-width: 0.5;
      }
    }  
    [zoom>=13][zoom<14]{
      [type='river'],[type='canal']{
        line-width: 2;
      }
     [type='stream'] {
        line-width: 1;
      }
    }  
    [zoom>=14][zoom<15] {
      [type='river'],[type='canal']{
        line-width: 2.5;
      }  
     [type='stream']{
        line-width: 1.3;
      }
     [type='ditch']{
        line-width: 0.8;
      }
    }
    [zoom>=15]{
      [type='river'],[type='canal']{
        line-width: 3;
      }
     [type='stream']{
        line-width: 2;
      }
     [type='ditch']{
        line-width: 1;
      }
    }
  }  
  ::riverbank[type='riverbank']{
    polygon-fill: @water;
    line-width: 0.5;
    line-color:@river;
  }  
}


#waterway_label[zoom>=12][length>200][type='river'],
#waterway_label[zoom>=12][length>200][type='canal'],
#waterway_label[zoom>=14][length>200][type='stream'],
#waterway_label[zoom>=14][length>200][type='ditch']{
  text-size: 9;
  text-name:'[name]';
  text-face-name:@sans_bold_italic;
  text-placement:line;
  text-fill:@water_text;
  text-halo-fill: fadeout(white, 60%);
  text-halo-radius:1.5;   
}

#glacier[zoom>=7]{
  line-color: @lightblue;  
  polygon-fill: @white;
  line-width: 0;
  polygon-opacity: 0;  
  [zoom<8][area>=1000000] {
    line-width: 0.5;
    polygon-opacity: 0.5;  
  }
  [zoom>=8][zoom<10][area>=200000] {
    polygon-opacity: 0.5;  
    line-width: 0.75;
  }  
  [zoom>=10][zoom<12][area>=50000] {
    polygon-opacity: 0.5;  
    line-width: 1;
  }  
  [zoom>=12][zoom<14][area>=5000] {
    polygon-opacity: 0.5;  
    line-width: 1.5;
  }  
  [zoom>=14][zoom<15][area>=1000] {
    polygon-opacity: 0.5;  
    line-width: 2;
  }
  [zoom>=15]{
    polygon-opacity: 0.5;  
    line-width: 2.5;
  }
}

#glacier_label[zoom>=10] {
  [zoom>=10][zoom<11][area>=100000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=11][zoom<12][area>=10000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=12][zoom<13][area>=1000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=13][zoom<14][area>=100000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=14][zoom<15][area>=20000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=15][area>=1000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
}


#lakes_label[zoom>=10] {
  [zoom>=10][zoom<11][area>=100000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=11][zoom<12][area>=10000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=12][zoom<13][area>=1000000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=13][zoom<14][area>=100000]{
    text-size: 9;
    text-name:[name];
    text-face-name:@sans_bold_italic;
    text-fill:@water_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=14][zoom<15][area>=20000]{
    text-size: 9;
    text-name:[name] + '\n' + [ele];
    text-face-name:@sans_bold_italic;
    text-fill:@water_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
  [zoom>=15][area>=1000]{
    text-size: 9;
    text-name:[name] + '\n' + [ele];
    text-face-name:@sans_bold_italic;
    text-fill:@water_text;
    text-halo-fill: @text_halo;
    text-halo-radius:1.5;   
    text-wrap-width: 50;
    text-wrap-before: true;
    text-placement: interior;
  }  
}


