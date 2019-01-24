void build_ui(){
  ui = new UISet( 3, 10, 28, 2, 12 );
  ui.setScheme( #9DABAF, 20 );
  
  ui.addNeighbohood_widget( 0, 0, neighborhoods.get(0) );
}
