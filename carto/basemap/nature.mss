#simplified_land_polygons[zoom<10],
#land_polygons[zoom>=10]{
  polygon-fill:@land;
}

#grassland[zoom>=11][zoom<13][area>=50000],
#grassland[zoom>=13][zoom<15][area>=10000],
#grassland[zoom>=15][zoom<16][area>=1000],
#grassland[zoom>=16] {
  polygon-fill: @grass;
}

//#forest[zoom>=5][zoom<7][area>=10000000],
#forest[zoom>=8][zoom<9][area>=2000000],
#forest[zoom>=9][zoom<11][area>=200000],
#forest[zoom>=11][zoom<13][area>=50000],
#forest[zoom>=13][zoom<15][area>=5000],
#forest[zoom>=15][zoom<16][area>=1000],
#forest[zoom>=16] {
  polygon-fill: @forest;
  line-width: 0.2;
  line-color:@forest;
  polygon-gamma: 0.5;
}


#beach[zoom=12][area>=100000],
#beach[zoom=13][area>=10000],
#beach[zoom>=14]
{
  polygon-opacity:1;
  polygon-fill:@beach;
}

#global_rivers[zoom>=3][zoom<=9] {
  line-width: 0;
  line-smooth: 1;
  line-color:@river;
  [zoom=3][scalerank<4] {line-width: 1;}
  [zoom=4][scalerank<4] {line-width: 0.8;}
  [zoom=5] {
    [scalerank<4] {line-width: 2;}
    [scalerank>=4][scalerank<7] {line-width: 1.6;}
  }
  [zoom=6]{
    [scalerank<4] {line-width: 2.4;}
    [scalerank>=4][scalerank<7] {line-width: 2;}
  }
  [zoom=7]{
    [scalerank<4] {line-width: 3.6;}
    [scalerank>=4][scalerank<7] {line-width: 2.8;}
    [scalerank>=7] {line-width: 2;}
  }
  [zoom>=8][zoom<10]{
    [scalerank<4] { line-width: 4; }
    [scalerank>=4][scalerank<7] { line-width: 3; }
    [scalerank>=7] {line-width: 2;}
  }
}

#waterway[zoom>=10]{
  ::line{
    line-smooth: 1;
    line-cap: round;
    line-join: round;
    line-color:@river;
    line-width: 0;
    [zoom>=10][zoom<11]{
      [type='river'],[type='canal']{
        line-width: 2;
      }
    }
    [zoom>=11][zoom<13]{
      [type='river'],[type='canal']{
        line-width: 2;
      }
    }
    [zoom>=13][zoom<14]{
      [type='river'],[type='canal']{
        line-width: 3;
      }
     [type='stream'] {
        line-width: 1;
      }
    }
    [zoom>=14][zoom<15]{
      [type='river'],[type='canal']{
        line-width: 4;
      }
     [type='stream'] {
        line-width: 2;
      }
    }
    [zoom>=15][zoom<16] {
      [type='river'],[type='canal']{
        line-width: 5;
      }
     [type='stream']{
        line-width: 2.6;
      }
     [type='ditch']{
        line-width: 1.6;
      }
    }
    [zoom>=16]{
      [type='river'],[type='canal']{
        line-width: 6;
      }
     [type='stream']{
        line-width: 4;
      }
     [type='ditch']{
        line-width: 2;
      }
    }
  }
  ::riverbank[type='riverbank']{
    polygon-fill: @water;
    line-width: 1;
    line-color:@river;
  }
}

#global_lakes[scalerank<5][zoom=3],
#global_lakes[scalerank<6][zoom=4],
#global_lakes[scalerank<7][zoom=5],
#global_lakes[scalerank<8][zoom=6],
#global_lakes[zoom>=7][zoom<9]{
  polygon-fill:@water_global;
  line-width: 1;
  line-color:@river;
}

#lakes[zoom>=6][zoom<7][area>=200000000],
#lakes[zoom>=7][zoom<8][area>=20000000],
#lakes[zoom>=8][zoom<9][area>=10000000] {
  polygon-fill:@water_global;
  line-width: 1;
  line-color:@river;
}

#lakes[zoom>=9][zoom<11][area>=2000000],
#lakes[zoom>=11][zoom<12][area>=500000],
#lakes[zoom>=12][zoom<13][area>=50000],
#lakes[zoom>=13][zoom<15][area>=2000],
#lakes[zoom>=15][zoom<16][area>=1000],
#lakes[zoom>=16] {
  polygon-fill: @water;
  line-width: 1;
  line-offset: -0.5;
  line-color:@river;
}

#swamp[zoom>=9][zoom<11][area>=200000],
#swamp[zoom>=11][zoom<13][area>=50000],
#swamp[zoom>=13][zoom<15][area>=5000],
#swamp[zoom>=15][zoom<16][area>=1000],
#swamp[zoom>=16] {
  polygon-opacity: 0.2;
  polygon-pattern-file:url(img/wetland.png);
  polygon-fill: @swamp;
}

#glacier[zoom>=9]{
  line-color: @lightblue;
  polygon-fill: @white;
  line-width: 0;
  polygon-opacity: 0;
  [zoom>=9][zoom<11][area>=200000] {
    polygon-opacity: 0.5;
    line-width: 1.5;
  }
  [zoom>=11][zoom<13][area>=50000] {
    polygon-opacity: 0.5;
    line-width: 2;
  }
  [zoom>=13][zoom<15][area>=5000] {
    polygon-opacity: 0.5;
    line-width: 3;
  }
  [zoom>=15][zoom<16][area>=1000] {
    polygon-opacity: 0.5;
    line-width: 4;
  }
  [zoom>=16]{
    polygon-opacity: 0.5;
    line-width: 5;
  }
}
