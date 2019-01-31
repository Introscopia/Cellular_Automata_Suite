UISet ui;

integer open_editor, neigh_radius, del_neigh;
bool add_neigh, add_rule, add_else_rule, save, load, run;

void build_ui(){
  ui = new UISet( 3, 14, 28, 14, 1 );
  ui.setScheme( #7C7570, 20 );//#9DABAF
  
  run = new bool();
  save = new bool();
  load = new bool();
  open_editor = new integer(-1);
  add_neigh = new bool();
  add_rule = new bool();
  add_else_rule = new bool();
  del_neigh = new integer(-1);
  neigh_radius = new integer(2);
  
  ui.addLabel( 0, 0, "Cellular Automata Suite 1.0", "C" );
  
  ui.Hx = 2.9;
  ui.Vx = 25.9;
  ui.addNeighborhood_list( 0, 2, open_editor, add_neigh, del_neigh, neigh_radius, nbh_counts );
  ui.set[0].add( neighborhoods.get(0) );
  
  ui.Hx = 10.9;
  ui.Vx = 19.9;
  ui.addRule_list( 3, 2, nbh_counts, add_rule, add_else_rule );
  ui.set[1].add( rules.get(0), neighborhoods, states );
  
  ui.Hx = 8.9;
  ui.Vx = 4.9;
  ui.addState_bar( 3, 23, states );
  
  ui.Vx = 1.9;
  ui.Hx = 1.9;
  ui.addToggle( 12, 22, "Save", "C", save );
  ui.addToggle( 12, 24, "Load", "C", load );
  ui.addToggle( 12, 26, "Run", "C", run );
}
