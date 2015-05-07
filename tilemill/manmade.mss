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

// to-do: improve SQL query to merge nearby lines
#railway[zoom>=8] {
  ::line {
    line-width: 0.5;
    [zoom>=9][zoom<11] {
      line-width: 0.8;
    }
    [zoom>=11][zoom<12] {
      line-width: 1;
    }
    [zoom>=12][zoom<=14] {
      line-width: 3;
    }
    [zoom>14] {
      line-width: 4;
    }
    line-color: @darkgrey;
  }
  ::dash[zoom>=12] {
    line-color: white;
    line-width: 2;
    line-dasharray: 10, 10;
    [zoom>14] {
      line-width: 2.5;
      line-dasharray: 16, 16;
    }  
    
  }
}
