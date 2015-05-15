.roads[zoom>=4] {
  ::outer {
  	line-color:black;
    line-width: 0;
    [tunnel='yes'][zoom>=8]{ 
      line-dasharray: 2,2;
      [zoom>=12][zoom<14] {
        line-dasharray: 3,3;
      }  
      [zoom>=14] {
        line-dasharray: 4,4;
      } 
    }
    
    // Autobahnen und Bundesstraßen mit baulich getrennten Fahrspuren
    [type='motorway_link'],
    [type='motorway'],
    [type='trunk'][oneway='yes'] {
      [zoom>=8][zoom<9] {
        line-width: 2.5;
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
          line-width: 0;
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
        [type='motorway_link'] {
          line-width: 3;
        }
      }
      [zoom>=14][zoom<15] {
        line-width: 8;
        [type='motorway_link'] {
          line-width: 5;
        }
      }
      [zoom>=15]{
        line-width: 10;
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
        line-width: 1.7;
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
    [zoom>=8] {
      [type='secondary'],[type='secondary_link']{
        line-color:black;
        line-width: 1.5;
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
    [zoom>=8] {
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
        line-width: 1;
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
        line-width: 2;
        [type='motorway_link'] {
          line-width: 1;
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

#path[zoom>=12] {
  ::outer[zoom>=14] {
    line-cap: round;
    line-join: round;  
    line-color: fadeout(white, 60%);
    [bicycle='yes']{line-color: fadeout(green, 80%);}
    [bicycle='no']{line-color: fadeout(red, 80%);}
    line-width:6;
  }  
  line-width:0.5;
  line-opacity: 0.5;
  [zoom>=14] {
    line-opacity: 1;
    line-width:0.75;
  }
  line-color:black;

  ::marker[zoom>=14] {
    [mtbscale>=3]{marker-line-width: 0; marker-width: 6;marker-fill: black;}
    [mtbscale=2]{marker-line-width: 0; marker-width: 6;marker-fill: red;}
    [mtbscale>=0][mtbscale<2]{marker-line-width: 0; marker-width: 6;marker-fill: blue;}
  }  

}

#cycleway[zoom>=12] {
//  line-offset: 2;
  line-width:0.7;
  line-dasharray: 4,2;
  line-color:blue;
  [zoom>=13][zoom<14] {line-width:1.5;line-dasharray: 5,3;}
  [zoom>=14] {line-width:2;line-dasharray: 6,4;}
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

