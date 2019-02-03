void mouseMoved() {
  switch( moment ){
    case 'o':
      observe.mouseMoved();
      break;
    case 'c':
      create.mouseMoved();
      break;
  }
}

void paint(){
  if( mouseX > sx && mouseY > sy && mouseX < sx+1000 && mouseY < sy + 600 ){
    if( mouseButton == LEFT ){
      if( turn ){
        B.set( floor((mouseX -sx -tx)/zoom), floor((mouseY -sy -ty)/zoom), states.get( brush_color.n ) );
      }
      else{
        A.set( floor((mouseX -sx -tx)/zoom), floor((mouseY -sy -ty)/zoom), states.get( brush_color.n ) );
      }
    }
  }
}

void mousePressed() {
  switch( moment ){
    case 'o':
      observe.mousePressed();
      paint();
      break;
    case 'c':
      create.mousePressed();
      break;
  }
}

void mouseReleased() {
  switch( moment ){
    case 'o':
      observe.mouseReleased();
      paint();
      break;
    case 'c':
      create.mouseReleased();
      break;
  }
}

void mouseDragged() {
  switch( moment ){
    case 'o':
      observe.mouseDragged();
      if( mouseX > sx && mouseY > sy && mouseX < sx+1000 && mouseY < sy + 600 ){
        if( mouseButton == RIGHT ){
          tx += (mouseX - pmouseX);
          ty += (mouseY - pmouseY);
        }
        else if( mouseButton == LEFT && pmouseX > sx && pmouseY > sy && pmouseX < sx+1000 && pmouseY < sy + 600 ){
          //if( turn ){
          //  B.set( floor((mouseX -sx -tx)/zoom), floor((mouseY -sy -ty)/zoom), states.get( brush_color.n ) );
          //}
          //else{
          //  A.set( floor((mouseX -sx -tx)/zoom), floor((mouseY -sy -ty)/zoom), states.get( brush_color.n ) );
          //}
          int[] ref;
          if( play.b ){
            if( turn ) ref = B.pixels;
            else ref = A.pixels;
          }
          else{
            if( paused_turn ) ref = A.pixels;
            else ref = B.pixels;
          }
          int ix = floor((pmouseX -sx -tx)/zoom);
          int iy = floor((pmouseY -sy -ty)/zoom);
          int fx = floor((mouseX -sx -tx)/zoom);
          int fy = floor((mouseY -sy -ty)/zoom);
          int dx = fx-ix;
          int dy = fy-iy;
          if( abs( dx ) >= abs( dy ) ){
            float a = dy / float(abs(dx));
            int v = ( fx > ix )? 1 : -1;
            for( int i = 0; i <= abs(dx); ++i ){
              int x = ix + (i*v);
              int y = iy + round( a * i );
              ref[ (A.width * y) + x ] = states.get( brush_color.n );
            }
          }
          else{
            float a = dx / float(abs(dy));
            int v = ( fy > iy )? 1 : -1;
            for( int i = 0; i <= abs(dy); ++i ){
              int y = iy + (i*v);
              int x = ix + round( a * i );
              ref[ (A.width * y) + x ] = states.get( brush_color.n );
            }
          }
          if( paused_turn ){
            A.updatePixels();
            A.loadPixels();
          }
          else{
            B.updatePixels();
            B.loadPixels();
          }
        }
      }
      
      break;
    case 'c':
      create.mouseDragged();
      break;
  }
}

void mouseWheel(MouseEvent E) {
  switch( moment ){
    case 'o':
      observe.mouseWheel( E );
      
      float xrd = (mouseX-tx) / zoom;
      float yrd = (mouseY-ty) / zoom;
      zI -= E.getAmount();
      zoom = pow( 1.1, zI );
      if( zoom < 2 ){
        zoom = 2.0;
        zI = 7.27254089;
        tx = 0;
        ty = 0;
      }
      else{
        tx = mouseX - xrd * zoom;
        ty = mouseY - yrd * zoom;
      }
      break;
    case 'c':
      create.mouseWheel( E );
      break;
  }
}

void keyTyped() {
  switch( moment ){
    case 'o':
      observe.keyTyped();
      break;
    case 'c':
      create.keyTyped();
      break;
  }
}

void keyReleased() {
  switch( moment ){
    case 'o':
      observe.keyReleased();
      if( key == ' ' ) play.b = !play.b;
      if( key == TAB ) observe.set[2].mouseReleased( true );
      break;
    case 'c':
      create.keyReleased();
      break;
  }
}
