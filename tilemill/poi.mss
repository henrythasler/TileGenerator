#peaks[zoom>=12] {
  marker-file: url(img/triangle.svg);
  marker-fill:black;
  marker-allow-overlap:true;
  marker-ignore-placement:true;
  [zoom >=12][zoom<13] {  
	marker-width:3;
  }  
  [zoom >=13][zoom<14] {  
	marker-width:5;
  }  
  [zoom >=14] {
	marker-width:6;
    [name != null]{
      [ele = null] {
      text-size: 9;
      text-character-spacing: 0.8;
      text-name:[name];
      text-face-name:@sans_bold_italic;
      text-placement:point;
      text-fill:@peak_text;
      text-halo-fill: @text_halo;
      text-halo-radius:1.5;  
      text-dy: 6; 
      }  
      [ele != null] {
      text-size: 9;
      text-character-spacing: 0.8;
      text-name:[name] + '\n' + [ele];
      text-face-name:@sans_bold_italic;
      text-placement:point;
      text-fill:@peak_text;
      text-halo-fill: @text_halo;
      text-halo-radius:1.5;  
      text-dy: 6;
      }  
    }  
  }  
}
