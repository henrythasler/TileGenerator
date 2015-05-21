Map {
  background-color:@water;
  buffer-size: 256;
}

#simple[zoom>=0][zoom<10],
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

#forest[zoom>6] {
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


#swamp[zoom>6] {
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

#10mlakes[ScaleRank<3][zoom=2],
#10mlakes[ScaleRank<4][zoom=3],
#10mlakes[ScaleRank<5][zoom=4],
#10mlakes[ScaleRank<6][zoom=5],
#10mlakes[zoom>=6][zoom<8]{
  polygon-fill:@water;
}

#lakes {
  polygon-opacity: 0.0;
  polygon-fill: @water;
  [zoom>=5][zoom<6][area>=200000000] {
    polygon-opacity: 1;
  }  
  [zoom>=6][zoom<7][area>=20000000] {
    polygon-opacity: 1;
  }  
  [zoom>=7][zoom<8][area>=2000000] {
    polygon-opacity: 1;
  }  
  [zoom>=8][zoom<10][area>=200000] {
    polygon-opacity: 1;
  }  
  [zoom>=10][zoom<12][area>=50000] {
    polygon-opacity: 1;
  }  
  [zoom>=12][zoom<14][area>=2000] {
    polygon-opacity: 1;
  }  
  [zoom>=14][zoom<15][area>=1000] {
    polygon-opacity: 1;
  }
  [zoom>=15]{
    polygon-opacity: 1;
  }
}

#waterway{
  line-cap: round;
  line-join: round;  
  line-color: @water;
  line-width: 0;
  [zoom>=6][zoom<7] {
   	[type='river'],[type='canal']{
  	  line-width: 0.5;
    }  
  }  
  [zoom>=7][zoom<8] {
   	[type='river'],[type='canal']{
  	  line-width: 1;
    }  
  }  
  [zoom>=8][zoom<10]{
   	[type='river'],[type='canal']{
  	  line-width: 1;
    }  
  }  
  [zoom>=10][zoom<12]{
   	[type='river'],[type='canal']{
  	  line-width: 1;
    }  
  }  
  [zoom>=12][zoom<14]{
   	[type='river'],[type='canal']{
  	  line-width: 2;
    }
   [type='stream'] {
  	  line-width: 1;
    }
  }  
  [zoom>=14][zoom<15] {
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
  [zoom>=15]{
   	[type='river'],[type='canal']{
  	  line-width: 4;
    }
   [type='stream']{
  	  line-width: 3;
    }
   [type='ditch']{
  	  line-width: 2;
    }
  }
}

#glacier{
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

#waterway_label[zoom>=12][length>200] {
  text-size: 9;
  text-name:'[name]';
  text-face-name:@sans_bold_italic;
  text-placement:line;
  text-fill:@water_text;
  text-halo-fill: fadeout(white, 60%);
  text-halo-radius:1.5;   
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
  [zoom>=14][zoom<15][area>=10000]{
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




