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

void mousePressed() {
  switch( moment ){
    case 'o':
      observe.mousePressed();
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
      break;
    case 'c':
      create.keyReleased();
      break;
  }
}
