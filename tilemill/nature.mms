Map {
  background-color:@water;
}

#simple[zoom>=0][zoom<10],
#detailled[zoom>=10]{
  polygon-fill:@land;
}

#grassland {
  polygon-opacity: 0.25;
  [zoom>=10][zoom<12][area>=50000] {
  	polygon-fill: @grass;
  }  
  [zoom>=12][zoom<14][area>=10000] {
  	polygon-fill: @grass;
  }  
  [zoom>=14][zoom<15][area>=1000] {
  	polygon-fill: @grass;
  }
  [zoom>=15]{
  	polygon-fill: @grass;
  }  
}

#forest {
  [zoom<8][area>=1000000] {
  	polygon-fill: @forest;
  }
  [zoom>=8][zoom<10][area>=200000] {
  	polygon-fill: @forest;
  }  
  [zoom>=10][zoom<12][area>=50000] {
  	polygon-fill: @forest;
  }  
  [zoom>=12][zoom<14][area>=5000] {
  	polygon-fill: @forest;
  }  
  [zoom>=14][zoom<15][area>=1000] {
  	polygon-fill: @forest;
  }
  [zoom>=15]{
  	polygon-fill: @forest;
  }
}

#swamp {
  polygon-opacity: 0.2;
  polygon-pattern-file:url(img/wetland.png);
  [zoom<8][area>=1000000] {
  	polygon-fill: @swamp;
  }
  [zoom>=8][zoom<10][area>=200000] {
  	polygon-fill: @swamp;
  }  
  [zoom>=10][zoom<12][area>=50000] {
  	polygon-fill: @swamp;
  }  
  [zoom>=12][zoom<14][area>=5000] {
  	polygon-fill: @swamp;
  }  
  [zoom>=14][zoom<15][area>=1000] {
  	polygon-fill: @swamp;
  }
  [zoom>=15]{
  	polygon-fill: @swamp;
  }
}

#lakes {
  [zoom<8][area>=1000000] {
  	polygon-fill: @water;
  }  
  [zoom>=8][zoom<10][area>=200000] {
  	polygon-fill: @water;
  }  
  [zoom>=10][zoom<12][area>=50000] {
  	polygon-fill: @water;
  }  
  [zoom>=12][zoom<14][area>=5000] {
  	polygon-fill: @water;
  }  
  [zoom>=14][zoom<15][area>=1000] {
  	polygon-fill: @water;
  }
  [zoom>=15]{
  	polygon-fill: @water;
  }
}

#waterway{
  line-cap: round;
  line-join: round;  
  line-color: @water;
  line-width: 0;
  [zoom<8] {
   	[type='river'],[type='canal']{
  	  line-width: 2;
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

#glacier {
  line-color: @lightblue;  
  line-width: 0.5;
  polygon-opacity: 0.5;  
  [zoom<8][area>=1000000] {
  	polygon-fill: @white;
  }
  [zoom>=8][zoom<10][area>=200000] {
  	polygon-fill: @white;
    line-width: 0.75;
  }  
  [zoom>=10][zoom<12][area>=50000] {
  	polygon-fill: @white;
    line-width: 1;
  }  
  [zoom>=12][zoom<14][area>=5000] {
  	polygon-fill: @white;
    line-width: 1.5;
  }  
  [zoom>=14][zoom<15][area>=1000] {
  	polygon-fill: @white;
    line-width: 2;
  }
  [zoom>=15]{
  	polygon-fill: @white;
    line-width: 2.5;
  }
}

