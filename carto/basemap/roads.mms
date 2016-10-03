.path[zoom>=14] {
  ::outer[zoom>=15] {
    line-cap: round;
    line-join: round;  
    line-color: fadeout(white, 60%);
    [bicycle='yes']{line-color: fadeout(green, 80%);}
    [bicycle='no']{line-color: fadeout(red, 80%);}
    line-width:8;
  }

  ::inner {
    line-cap: round;
    line-join: round;  
    line-width:1.5;
    line-opacity: 0.5;
    [zoom>=15][zoom<16] {line-opacity: 1;line-width:2;}
    [zoom>=16]{line-opacity: 1;line-width:3;}
    line-color:black;
  }

  ::marker-glow[zoom>=15][length>100][mtbscale>=0] {
    marker-line-width: 0; 
    marker-width: 16;
    marker-fill: fadeout(white, 60%);
  }

  ::marker[zoom>=15][length>100][mtbscale>=0] {
    marker-line-width: 0;
    marker-width: 12;
    marker-allow-overlap:true;
    marker-fill: blue;
    [mtbscale>=3]{ marker-fill: black; }
    [mtbscale=2]{ marker-fill: red; }
  }  
}

.roads[zoom>=9] {
  ::outer {
    [bridge!='yes'][tunnel!='yes'] {line-cap: round;}
    line-join: round;  
  	line-color:black;
    line-width: 0;
    [tunnel='yes'][zoom>=9]{ 
      line-dasharray: 4,4;
      [zoom>=13][zoom<15] {
        line-dasharray: 6,6;
      }  
      [zoom>=15] {
        line-dasharray: 12,12;
      } 
    }
    
    // Autobahnen und Bundesstraßen mit baulich getrennten Fahrspuren
    [type='motorway_link'],
    [type='motorway'],
    [type='trunk'][oneway='yes'] {
      [zoom>=9][zoom<10] {
        line-width: 6;
        [type='motorway_link'] {
          line-width: 0;
        }
      }
      [zoom>=10][zoom<11] {
        line-width: 6;
        [type='motorway_link'] {
          line-width: 0;
        }
      }
      [zoom>=11][zoom<12] {
        line-width: 6.4;
        [type='motorway_link'] {
          line-width: 3.2;
        }
      }
      [zoom>=12][zoom<13] {
        line-width: 9;
        [type='motorway_link'] {
          line-width: 5;
        }
      }
      [zoom>=13][zoom<15] {
        line-width: 12;
//        [bridge='yes'][length>200] {line-width: 16;}
        [type='motorway_link'] {
          line-width: 6;
        }
      }
      [zoom>=15][zoom<16] {
        line-width: 16;
//        [bridge='yes'][length>100] {line-width: 20;}
        [type='motorway_link'] {
          line-width: 10;
        }
      }
      [zoom>=16]{
        line-width: 20;
//        [bridge='yes'][length>80] {line-width: 28;}
        [type='motorway_link'] {
          line-width: 12;
        }
      }
    }
    // Bundesstraßen
    [zoom>=9] {
      [type='trunk'][oneway!='yes'],
      [type='primary'],[type='primary_link'], [type='trunk_link'] {
        line-color:black;
        line-width: 6;
        [zoom>=10][zoom<11] {
          line-width: 6;
        }
        [zoom>=11][zoom<12] {
          line-width: 6.4;
        }
        [zoom>=12][zoom<13] {
          line-width: 7;
        }
        [zoom>=13][zoom<15] {
          line-width: 9;
        }
        [zoom>=15][zoom<16] {
          line-width: 12;
        }
        [zoom>=16]{
          line-width: 16;
        }
      }  
    }  
	// Landstraßen
    [zoom>=10] {
      [type='secondary'],[type='secondary_link']{
        line-color:black;
        line-width: 5;
        [zoom>=10][zoom<11] {
          line-width: 5;
        }
        [zoom>=11][zoom<12] {
          line-width: 5.4;
        }
        [zoom>=12][zoom<13] {
          line-width: 6;
        }
        [zoom>=13][zoom<15] {
          line-width: 8;
        }
        [zoom>=15][zoom<16] {
          line-width: 11;
        }
        [zoom>=16]{
          line-width: 15;
        }
      }  
	}    
	// Kreisstraßen
    [zoom>=11] {
      [type='tertiary'],[type='tertiary_link']{
        line-color:black;
        line-width: 5.4;
        [zoom>=12][zoom<13] {
          line-width: 6;
        }
        [zoom>=13][zoom<15] {
          line-width: 8;
        }
        [zoom>=15][zoom<16] {
          line-width: 9;
        }
        [zoom>=16]{
          line-width: 15;
        }
      }  
	}    
    
	// sonstige Straßen
    [zoom>=13] {
      [type='road'],
      [type='unclassified'],
      [type='residential'],
      [type='pedestrian'],
      [type='living_street'],
      [type='track'][tracktype='grade1']
      {
        line-color:black;
        line-width: 0;
        [zoom>=13][zoom<14][length>50] {
          line-color:grey;
          line-width: 2;
        }
        [zoom>=14][zoom<15] {
          line-width: 6;
        }
        [zoom>=15][zoom<16] {
          line-width: 6.4;
        }
        [zoom>=16]{
          line-width: 10;
        }
      }  
	}    
    
	// Zufahrten und Wirtschaftswege
    [zoom>=13] {
      [type='service'],
      {
        line-color:black;
        line-width: 0;
        [tunnel='yes']{ 
          line-dasharray: 4,4;
          [zoom>=13][zoom<15] {
            line-dasharray: 6,6;
          }  
          [zoom>=15] {
            line-dasharray: 12,12;
          }  
        }
        [zoom>=13][zoom<14][length>300]{
          line-color:grey;
          line-width: 2;
        }
        [zoom>=14][zoom<15][length>200] {
          line-width: 5;
        }
        [zoom>=15][zoom<16][length>100] {
          line-width: 5;
        }
        [zoom>=16]{
          line-width: 6;
        }
      }  
	}    
  }
  ::inner {  
    line-cap: round;
    line-join: round;  
    line-width: 0;
   
	// Zufahrten und Wirtschaftswege
    [zoom>=14] {
      [type='service'],
      {
        line-color:white;
        line-width: 0;
        [zoom>=13][zoom<14][length>300] {
          line-width: 2.6;
        }
        [zoom>=14][zoom<15][length>200] {
          line-width: 3;
        }
        [zoom>=15][zoom<16][length>100] {
          line-width: 3.6;
        }
        [zoom>=16]{
          line-width: 4;
        }
      }  
	}    
    
	// sonstige Straßen
    [zoom>=14] {
      [type='road'],
      [type='unclassified'],
      [type='residential'],
      [type='pedestrian'],
      [type='living_street'],
      [type='track'][tracktype='grade1']
      {
        line-color:white;
        line-width: 0;
        [zoom>=13][zoom<14][length>50] {
          line-width: 3;
        }
        [zoom>=14][zoom<15] {
          line-width: 4;
        }
        [zoom>=15][zoom<16] {
          line-width: 4.4;
        }
        [zoom>=16]{
          line-width: 8;
        }
      }  
	}    
    
    
	// Kreisstraßen
    [zoom>=11] {
      [type='tertiary'],[type='tertiary_link']{
        line-color: white;
        line-width: 3.6;
        [zoom>=12][zoom<13] {
          line-width: 4.4;
        }
        [zoom>=13][zoom<15] {
          line-width: 5.6;
        }
        [zoom>=15][zoom<16] {
          line-width: 7;
        }
        [zoom>=16]{
          line-width: 12;
        }
      }  
    }  
    
	// Landstraßen
    [zoom>=10] {
      [type='secondary'],[type='secondary_link']{
        line-color: @secondary;
        line-width: 2;
        [zoom>=10][zoom<12] {
          line-width: 3.6;
        }
        [zoom>=12][zoom<14] {
          line-width: 4.4;
        }
        [zoom>=13][zoom<15] {
          line-width: 6;
        }
        [zoom>=15][zoom<16] {
          line-width: 8;
        }
        [zoom>=16]{
          line-width: 12;
        }
      }  
    }  
    
	// Bundesstraßen
    [zoom>=9] {
      [type='trunk'][oneway!='yes'],
      [type='primary'],[type='primary_link'], [type='trunk_link'] {
        line-color: @primary;
        line-width: 3.6;
        [zoom>=10][zoom<12] {
          line-width: 4;
        }
        [zoom>=12][zoom<13] {
          line-width: 5;
        }
        [zoom>=13][zoom<15] {
          line-width: 6;
        }
        [zoom>=15][zoom<16] {
          line-width: 8;
        }
        [zoom>=16]{
          line-width: 12;
        }
      }  
    }  
    
    // Autobahnen und Bundesstraßen mit baulich getrennten Fahrspuren
    [type='motorway_link'],
    [type='motorway'],
    [type='trunk'][oneway='yes'] {
      line-color: @motorway;
      [zoom>=8][zoom<12] {
        line-width: 3.6;
        [type='motorway_link'] {
          line-width: 1.8;
        }
      }
      [zoom>=12][zoom<13] {
        line-width: 6;
        [type='motorway_link'] {
          line-width: 3;
        }
      }
      [zoom>=13][zoom<15] {
        line-width: 8;
        [type='motorway_link'] {
          line-width: 3;
        }
      }
      [zoom>=15][zoom<16] {
        line-width: 12;
        [type='motorway_link'] {
          line-width: 6;
        }
      }
      [zoom>=16]{
        line-width: 16;
        [type='motorway_link'] {
          line-width: 8;
        }
      }
    }
  }
}

.label[zoom>=16] {
  text-size: 18;
  text-character-spacing: 1.6;
  text-name:'[name]';
  text-face-name:@sans;
  text-placement:line;
  text-horizontal-alignment: middle;
  text-spacing: 200;
  text-fill:@peak_text;
  text-halo-fill: @text_halo_strong;
  text-halo-radius:2;
}  

#track[zoom>=13] {
  ::outer[zoom>=15] {
    line-cap: round;
    line-join: round;  
    line-color: fadeout(white, 60%);
    [bicycle='yes']{line-color: fadeout(green, 80%);}
    [bicycle='no']{line-color: fadeout(red, 80%);}
    line-width:9;
  }  
  ::inner {
    line-color:@track_light;
    [zoom<=14] { line-color:@track_dark; }
    line-width:1;
    [zoom>=14] { line-width:2; }
    line-dasharray: 8,4;
    [tracktype='grade4'],[tracktype='grade5'] { line-dasharray: 3,3; }
    
    [zoom>=15] {
      line-width: 3;
      line-dasharray: 12,6;
      [tracktype='grade4'],[tracktype='grade5'] { line-dasharray: 4,4; }
    }  
  }
}

#cycleway[zoom>=13] {
  line-cap: round;
  line-join: round;    
  line-width:1.4;
  line-dasharray: 8,8;
  line-color:blue;
  [zoom>=14][zoom<15] {line-width:3;line-dasharray: 10,10;}
  [zoom>=15] {line-width:4;line-dasharray: 12,12;}
}