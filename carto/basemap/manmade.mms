#weir[zoom>=15]{
  line-dasharray: 2,2;
  line-join: round;  
  line-width: 8;  
  [zoom>=16] {line-width: 12; line-dasharray: 3,3;}
  line-color:@water_text;
}

#pier[zoom>=15] {
  line-color:@runway;
  line-width:2;
  [zoom>=16]{ line-width:3; }
}

#taxiway[zoom>=12] {
  line-width:2;
  line-color:@runway;
  [zoom>=13][zoom<14]{ line-width:4; }  
  [zoom>=14][zoom<15]{ line-width:6; }  
  [zoom>=15]{ line-width:12; }  
}

#runway[zoom>=11] {
  [zoom>=11][zoom<13][length>1500] {
  ::line{
    line-color:@runway;
    line-width: 6;
    }  
  ::dash{
    line-color: white;
    line-dasharray: 4, 4;
    line-width: 2;
    }
  }  
  [zoom>=13][zoom<14][length>300] {
  ::line{
    line-color:@runway;
    line-width: 10;
    }  
  ::dash{
    line-color: white;
    line-dasharray: 8, 8;
    line-width: 3;
    }
  }  
  [zoom>=14][zoom<15][length>100] {
  ::line{
    line-color:@runway;
    line-width: 16;
    }  
  ::dash{
    line-color: white;
    line-dasharray: 12, 12;
    line-width: 3.6;
    }
  }  
  [zoom>=15]{
  ::line{
    line-color:@runway;
    line-width: 28;
    }  
  ::dash{
    line-color: white;
    line-dasharray: 20, 20;
    line-width: 4;
    }
  }  
}

#fence[zoom>=15] {
  line-join: round;  
  line-cap: round;
  line-color: @darkgrey;
  line-width: 3;
  line-dasharray: 12, 6, 1, 6;
}

#buildings[zoom>=14][area>20000],
#buildings[zoom>=15] {
  line-width: 0;
  polygon-opacity: 1;
  polygon-fill: @darkgrey;
  polygon-gamma: 0.5;
}

// FIXME: do something about subways and trams
#railway[zoom>=11][type!='tram'][type!='subway'] {
  ::line{
    line-width: 3.6;
    line-color: @runway;
    [tunnel='yes'] {line-dasharray: 4, 8; line-cap: round;}
    [type='tram'],[type='subway'] {line-width: 0;}
    [zoom>=13][zoom<14] {
      line-width: 5;
      [type='tram'],[type='subway'] {line-width: 0;}
      [tunnel='yes'] {line-dasharray: 8, 12;}
    }
    [zoom>=14][zoom<16] {
      line-color: @darkgrey;
      line-width: 7;
      [type='tram'],[type='subway'] {line-width: 4;}
      [tunnel='yes'] {line-dasharray: 12, 16;}
    }
    [zoom>=16] {
      line-color: @darkgrey;
      line-width: 9;
      [tunnel='yes'] {line-dasharray: 20, 24;}
      [type='tram'] {line-width: 4;}
    }
  }
  ::dash[zoom>=14][tunnel!='yes'][type!='tram'][type!='subway'] {
    line-color: white;
    line-width: 2.4;
    line-dasharray: 18, 18;
    [tunnel='yes'] {line-dasharray: 12, 8;}
    [type='tram'],[type='subway'] {line-width: 0;}
    [zoom>=14][zoom<16] {
      line-width: 4;
      line-dasharray: 26, 26;
      [tunnel='yes'] {line-dasharray: 12, 8;}
      [type='tram'],[type='subway'] {line-width: 0;}
    }
    [zoom>=16] {
      line-width: 5;
      line-dasharray: 36, 32;
      [tunnel='yes'] {line-dasharray: 12, 8;}
    }  
  }
}

#aerialway[zoom>=13] {
  ::line {
    line-width:2;
    [zoom>=14][zoom<15] {line-width:2.8;}
    [zoom>=15] {line-width:3.6;}
    line-color: black;
    line-dasharray: 12, 6;
    [type='goods'][zoom>=15],[type='toboggan'][zoom>=15] {line-width:2; line-dasharray: 8, 4;}
    [type='goods'][zoom<15],[type='toboggan'][zoom<15] {line-width:0;}
  } 
  ::text[type!='goods'][zoom>=15] {
    text-size: 18;
    text-character-spacing: 1.6;
    text-name:[name];
    text-face-name:@sans_bold;
    text-placement:line;
    text-horizontal-alignment: middle;
    text-spacing: 200;
    text-fill:@peak_text;
    text-halo-fill: @text_halo_strong;
    text-halo-radius:3;      
  }  
}

#powermast[zoom>=15] {
  marker-file: url(img/square.svg);
  marker-width:6;
  marker-fill:black;
  marker-allow-overlap:true;
  marker-ignore-placement:true;
}

#powerline[zoom>=15] {
  line-width: 1;
  line-color:black;
}
