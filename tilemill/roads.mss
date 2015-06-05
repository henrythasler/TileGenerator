.roads[zoom>=8] {
  ::outer {
    [bridge!='yes'][tunnel!='yes'] {line-cap: round;}
    line-join: round;  
  	line-color:black;
    line-width: 0;
    [tunnel='yes'][zoom>=8]{ 
      line-dasharray: 2,2;
      [zoom>=12][zoom<14] {
        line-dasharray: 3,3;
      }  
      [zoom>=14] {
        line-dasharray: 6,6;
      } 
    }
    
    // Autobahnen und Bundesstraßen mit baulich getrennten Fahrspuren
    [type='motorway_link'],
    [type='motorway'],
    [type='trunk'][oneway='yes'] {
      [zoom>=8][zoom<9] {
        line-width: 3;
        [type='motorway_link'] {
          line-width: 0;
        }
      }
      [zoom>=9][zoom<10] {
        line-width: 3;
        [type='motorway_link'] {
          line-width: 0;
        }
      }
      [zoom>=10][zoom<11] {
        line-width: 3.2;
        [type='motorway_link'] {
          line-width: 1.6;
        }
      }
      [zoom>=11][zoom<12] {
        line-width: 4.5;
        [type='motorway_link'] {
          line-width: 2.5;
        }
      }
      [zoom>=12][zoom<14] {
        line-width: 6;
//        [bridge='yes'][length>200] {line-width: 8;}
        [type='motorway_link'] {
          line-width: 3;
        }
      }
      [zoom>=14][zoom<15] {
        line-width: 8;
//        [bridge='yes'][length>100] {line-width: 10;}
        [type='motorway_link'] {
          line-width: 5;
        }
      }
      [zoom>=15]{
        line-width: 10;
//        [bridge='yes'][length>80] {line-width: 14;}
        [type='motorway_link'] {
          line-width: 6;
        }
      }
    }
    // Bundesstraßen
    [zoom>=8] {
      [type='trunk'][oneway!='yes'],
      [type='primary'],[type='primary_link'], [type='trunk_link'] {
        line-color:black;
        line-width: 3;
        [zoom>=9][zoom<10] {
          line-width: 3;
        }
        [zoom>=10][zoom<11] {
          line-width: 3.2;
        }
        [zoom>=11][zoom<12] {
          line-width: 3.5;
        }
        [zoom>=12][zoom<14] {
          line-width: 4.5;
        }
        [zoom>=14][zoom<15] {
          line-width: 6;
        }
        [zoom>=15]{
          line-width: 8;
        }
      }  
    }  
	// Landstraßen
    [zoom>=9] {
      [type='secondary'],[type='secondary_link']{
        line-color:black;
        line-width: 2.5;
        [zoom>=9][zoom<10] {
          line-width: 2.5;
        }
        [zoom>=10][zoom<11] {
          line-width: 2.7;
        }
        [zoom>=11][zoom<12] {
          line-width: 3;
        }
        [zoom>=12][zoom<14] {
          line-width: 4;
        }
        [zoom>=14][zoom<15] {
          line-width: 5.5;
        }
        [zoom>=15]{
          line-width: 7.5;
        }
      }  
	}    
	// Kreisstraßen
    [zoom>=10] {
      [type='tertiary'],[type='tertiary_link']{
        line-color:black;
        line-width: 2.7;
        [zoom>=11][zoom<12] {
          line-width: 3;
        }
        [zoom>=12][zoom<14] {
          line-width: 4;
        }
        [zoom>=14][zoom<15] {
          line-width: 4.5;
        }
        [zoom>=15]{
          line-width: 7.5;
        }
      }  
	}    
    
	// sonstige Straßen
    [zoom>=12] {
      [type='road'],
      [type='unclassified'],
      [type='residential'],
      [type='pedestrian'],
      [type='living_street'],
      [type='track'][tracktype='grade1']
      {
        line-color:black;
        line-width: 0;
        [zoom>=12][zoom<13][length>50] {
          line-color:grey;
          line-width: 1;
        }
        [zoom>=13][zoom<14] {
          line-width: 3;
        }
        [zoom>=14][zoom<15] {
          line-width: 3.2;
        }
        [zoom>=15]{
          line-width: 5;
        }
      }  
	}    
    
	// Zufahrten und Wirtschaftswege
    [zoom>=12] {
      [type='service'],
      {
        line-color:black;
        line-width: 0;
        [tunnel='yes']{ 
          line-dasharray: 2,2;
          [zoom>=12][zoom<14] {
            line-dasharray: 3,3;
          }  
          [zoom>=14] {
            line-dasharray: 6,6;
          }  
        }
        [zoom>=12][zoom<13][length>300]{
          line-color:grey;
          line-width: 1;
        }
        [zoom>=13][zoom<14][length>200] {
          line-width: 2.5;
        }
        [zoom>=14][zoom<15][length>100] {
          line-width: 2.5;
        }
        [zoom>=15]{
          line-width: 3;
        }
      }  
	}    
  }
  ::inner {  
    line-cap: round;
    line-join: round;  
    line-width: 0;
   
	// Zufahrten und Wirtschaftswege
    [zoom>=13] {
      [type='service'],
      {
        line-color:white;
        line-width: 0;
        [zoom>=12][zoom<13][length>300] {
          line-width: 1.3;
        }
        [zoom>=13][zoom<14][length>200] {
          line-width: 1.5;
        }
        [zoom>=14][zoom<15][length>100] {
          line-width: 1.8;
        }
        [zoom>=15]{
          line-width: 2;
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
        line-color:white;
        line-width: 0;
        [zoom>=12][zoom<13][length>50] {
          line-width: 1.5;
        }
        [zoom>=13][zoom<14] {
          line-width: 2;
        }
        [zoom>=14][zoom<15] {
          line-width: 2.2;
        }
        [zoom>=15]{
          line-width: 4;
        }
      }  
	}    
    
    
	// Kreisstraßen
    [zoom>=10] {
      [type='tertiary'],[type='tertiary_link']{
        line-color: white;
        line-width: 1.8;
        [zoom>=11][zoom<12] {
          line-width: 2.2;
        }
        [zoom>=12][zoom<14] {
          line-width: 2.8;
        }
        [zoom>=14][zoom<15] {
          line-width: 3.5;
        }
        [zoom>=15]{
          line-width: 6;
        }
      }  
    }  
    
	// Landstraßen
    [zoom>=9] {
      [type='secondary'],[type='secondary_link']{
        line-color: @secondary;
        line-width: 1;
        [zoom>=9][zoom<11] {
          line-width: 1.8;
        }
        [zoom>=11][zoom<12] {
          line-width: 2.2;
        }
        [zoom>=12][zoom<14] {
          line-width: 3;
        }
        [zoom>=14][zoom<15] {
          line-width: 4;
        }
        [zoom>=15]{
          line-width: 6;
        }
      }  
    }  
    
	// Bundesstraßen
    [zoom>=8] {
      [type='trunk'][oneway!='yes'],
      [type='primary'],[type='primary_link'], [type='trunk_link'] {
        line-color: @primary;
        line-width: 1.8;
        [zoom>=9][zoom<11] {
          line-width: 2;
        }
        [zoom>=11][zoom<12] {
          line-width: 2.5;
        }
        [zoom>=12][zoom<14] {
          line-width: 3;
        }
        [zoom>=14][zoom<15] {
          line-width: 4;
        }
        [zoom>=15]{
          line-width: 6;
        }
      }  
    }  
    
    // Autobahnen und Bundesstraßen mit baulich getrennten Fahrspuren
    [type='motorway_link'],
    [type='motorway'],
    [type='trunk'][oneway='yes'] {
      line-color: @motorway;
      [zoom>=7][zoom<11] {
        line-width: 1.8;
        [type='motorway_link'] {
          line-width: 0.9;
        }
      }
      [zoom>=11][zoom<12] {
        line-width: 3;
        [type='motorway_link'] {
          line-width: 1.5;
        }
      }
      [zoom>=12][zoom<14] {
        line-width: 4;
        [type='motorway_link'] {
          line-width: 1.5;
        }
      }
      [zoom>=14][zoom<15] {
        line-width: 6;
        [type='motorway_link'] {
          line-width: 3;
        }
      }
      [zoom>=15]{
        line-width: 8;
        [type='motorway_link'] {
          line-width: 4;
        }
      }
    }
  }
}

.label[zoom>=15] {
  text-size: 9;
  text-character-spacing: 0.8;
  text-name:'[name]';
  text-face-name:@sans;
  text-placement:line;
  text-horizontal-alignment: middle;
  text-spacing: 100;
  text-fill:@peak_text;
  text-halo-fill: @text_halo_strong;
  text-halo-radius:1;
}  

#track[zoom>=12] {
  ::outer[zoom>=14] {
    line-cap: round;
    line-join: round;  
    line-color: fadeout(white, 60%);
    [bicycle='yes']{line-color: fadeout(green, 80%);}
    [bicycle='no']{line-color: fadeout(red, 80%);}
    line-width:6;
  }  
  ::inner {
    line-color:@track;
    [zoom<=12] {line-color:#753701;}
    line-width:0.5;
    [zoom>=13] {line-width:1;}
    line-dasharray: 4,2;
    [tracktype='grade4'],[tracktype='grade5'] {line-dasharray: 1.5,1.5;}
    
    [zoom>=14] {
      line-width:1.5;
      line-dasharray: 6,3;
      [tracktype='grade4'],[tracktype='grade5'] {line-dasharray: 2,2;}
    }  
  }
}

#path[zoom>=13] {
  ::outer[zoom>=14] {
    line-cap: round;
    line-join: round;  
    line-color: fadeout(white, 60%);
    [bicycle='yes']{line-color: fadeout(green, 80%);}
    [bicycle='no']{line-color: fadeout(red, 80%);}
    line-width:6;
  }  
  line-cap: round;
  line-join: round;  
  line-width:0.75;
  line-opacity: 0.5;
  [zoom>=14][zoom<15] {line-opacity: 1;line-width:1;}
  [zoom>=15]{line-opacity: 1;line-width:1.5;}
  line-color:black;

  ::marker[zoom>=14] {
    [mtbscale>=3]{marker-line-width: 0; marker-width: 6;marker-fill: black;}
    [mtbscale=2]{marker-line-width: 0; marker-width: 6;marker-fill: red;}
    [mtbscale>=0][mtbscale<2]{marker-line-width: 0; marker-width: 6;marker-fill: blue;}
  }  

}

#cycleway[zoom>=12] {
//  line-offset: 2;
  line-cap: round;
  line-join: round;    
  line-width:0.7;
  line-dasharray: 4,4;
  line-color:blue;
  [zoom>=13][zoom<14] {line-width:1.5;line-dasharray: 5,5;}
  [zoom>=14] {line-width:2;line-dasharray: 6,6;}
}

#shiproute[zoom>=10] {
  line-width:0.5;
  line-color:@shiproute;
  line-dasharray: 2,2;
  [zoom>=11][zoom<12] {line-width:0.6;line-dasharray: 3,3;}
  [zoom>=12][zoom<13] {line-width:0.7;line-dasharray: 4,4;}
  [zoom>=13][zoom<14] {line-width:0.8;line-dasharray: 5,5;}
  [zoom>=14]{line-width:1;line-dasharray: 6,6;}
}


#test {
  line-width:10;
  line-color:#168;
}


#cycleroute[zoom>=12] {
  line-width:4;
  line-color:blue;
  line-opacity: 0.25;
  [zoom>=13][zoom<14] {line-opacity: 0.2; line-width:6;}
  [zoom>=14][zoom<15] {line-opacity: 0.15; line-width:9;}
  [zoom>14] {line-opacity: 0.15; line-width:12;}
}

#cycleroute_labels[zoom>=14] {
  text-size: 9;
  text-character-spacing: 0.8;
  text-min-distance: 500;
  text-spacing: 500;
  text-name:'[route_name]';
  text-face-name:@sans;
  text-placement:line;
  text-fill:fadeout(darken(blue, 30%),20%);
  text-halo-fill: fadeout(white, 40%);
  text-halo-radius:1.5; 
}

#road_shields[zoom>=9][reflen<=5] {
  shield-name: "[ref]";
  shield-size: 9;
  shield-face-name: @sans_bold;
  shield-fill: white;
  shield-avoid-edges: true;
  shield-clip: false;
  shield-file: url(img/shield-3.blue.svg);
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
  [zoom<12] {shield-min-distance: 150;}
  [zoom>=12][zoom<14] {shield-min-distance: 200;}
  [zoom>=14] {shield-min-distance: 150;}
}



#exits[zoom>=14]{
  shield-name: "[ref]";
  shield-size: 9;
  shield-face-name: @sans_bold;
  shield-fill: white;
  shield-avoid-edges: true;
  shield-clip: false;
  shield-file: url(img/circle.blue.svg);
//  shield-transform: 'scale(1.2)'
}


// Major
#ne10mroads["type"='Major Highway'][zoom>=5][zoom<=7] {
  ::outer {
    line-join: round;  
    line-color:black;
    line-width: 3;
    [zoom=5] {line-width: 0.8; line-color:@darkgrey;}
    [zoom=6] {line-width: 2; line-color:@darkgrey;}
  }  
  ::inner[zoom>=6] {
    line-join: round;  
    line-color:@motorway;
    line-width: 1.8;
    [zoom=6] {line-width: 1;}
  }  
}

// Secondary
#ne10mroads[scalerank<7]["type"='Secondary Highway'][zoom>=6][zoom<=7],
#ne10mroads["type"='Beltway'][zoom>=6][zoom<=7] {
  ::outer {
    line-join: round;  
    line-color:black;
    line-width: 2;
    [zoom=6] {line-width: 0.8; line-color:@darkgrey;}
  }  
  ::inner[zoom>=7] {
    line-join: round;  
    line-color:@primary;
    line-width: 1.2;
  }  
}

// Roads
#ne10mroads[scalerank<7]["type"='Road'][zoom=7]{
  line-width: 0.8; line-color:@darkgrey;
}

// Ferries
#ne10mroads["type"='Ferry Route'][scalerank<=8][zoom>=5][zoom<=7],
#ne10mroads["type"='Ferry Route'][zoom>=8]{
  line-color:@shiproute;
  line-width:0.8;
  line-dasharray: 5,5;
  [zoom>=6]{line-width:1;line-dasharray: 6,6;}
}  