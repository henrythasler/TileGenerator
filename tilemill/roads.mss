// Autobahnen und Bundesstraßen mit baulich getrennten Fahrspuren
#motorway[zoom>=4] {
  ::outer {
  	line-color:black;
    line-width: 0;
	[tunnel='yes']{ 
      [zoom>=8][zoom<12] {
        line-dasharray: 2,2;
      }  
      [zoom>=12][zoom<14] {
        line-dasharray: 3,3;
      }  
      [zoom>=14] {
        line-dasharray: 6,6;
      }  
    }
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
  ::inner {  
  	line-color: @motorway;
    line-cap: round;
    line-join: round;  
    line-width: 1;
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

// Bundesstraßen
#primary[zoom>=8] {
  ::outer {
  	line-color:black;
    line-width: 1.7;
	[tunnel='yes']{ 
      [zoom>=8][zoom<12] {
        line-dasharray: 2,2;
      }  
      [zoom>=12][zoom<14] {
        line-dasharray: 3,3;
      }  
      [zoom>=14] {
        line-dasharray: 6,6;
      }  
    }
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
  ::inner {  
  	line-color: @primary;
    line-cap: round;
    line-join: round;  
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
