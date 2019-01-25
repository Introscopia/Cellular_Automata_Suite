UISet ui;

integer open_editor;

void build_ui(){
  ui = new UISet( 3, 14, 28, 3, 27 );
  ui.setScheme( #9DABAF, 20 );
  
  open_editor = new integer(-1);
  
  ui.addNeighborhood_list( 0, 1, open_editor );
  ui.set[0].add( neighborhoods.get(0) );
  ui.set[0].add( neighborhoods.get(1) );
  ui.set[0].add( neighborhoods.get(2) );
}
