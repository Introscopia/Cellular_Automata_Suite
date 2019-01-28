UISet ui;

integer open_editor, neigh_size, del_neigh;
bool add_neigh, run;

void build_ui(){
  ui = new UISet( 3, 14, 28, 14, 1 );
  ui.setScheme( #7C7570, 20 );//#9DABAF
  
  run = new bool();
  open_editor = new integer(-1);
  add_neigh = new bool();
  del_neigh = new integer(-1);
  neigh_size = new integer(5);
  
  ui.addLabel( 0, 0, "Cellular Automata Suite 1.0", "C" );
  
  ui.Hx = 2.9;
  ui.Vx = 25.9;
  ui.addNeighborhood_list( 0, 2, open_editor, add_neigh, del_neigh, neigh_size );
  ui.set[0].add( neighborhoods.get(0) );
  
  ui.Hx = 10.9;
  ui.Vx = 19.9;
  ui.addRule_list( 3, 2 );
  
  ui.Hx = 8.9;
  ui.Vx = 4.9;
  ui.addState_bar( 3, 23, states );
  
  ui.Hx = 1.9;
  ui.addToggle( 12, 23, "Run", "C", run );
}
