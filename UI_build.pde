UISet ui;

integer open_editor, neigh_radius, del_neigh;
bool add_neigh, add_rule, add_else_rule, save, load, run;

bool gradient;
pigment gradient_a, gradient_b;

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
  gradient = new bool( true );
  gradient_a = new pigment( color(255) );
  gradient_b = new pigment( color( 0 ) );
  
  
  ui.addLabel( 0, 0, "Cellular Automata Suite 1.0", "C" );
  
  ui.Hx = 2.9;
  ui.Vx = 25.8;
  ui.addNeighborhood_list( 0, 2, open_editor, add_neigh, del_neigh, neigh_radius, neighborhoods );
  
  ui.Hx = 10.9;
  ui.Vx = 18.8;
  ui.addRule_list( 3, 2, add_rule, add_else_rule, neighborhoods );
  
  ui.Hx = 8.9;
  ui.Vx = 5.8;
  ui.addState_bar( 3, 22, states );
  
  ui.Vx = 1.8;
  ui.Hx = 1.9;
  ui.addToggle( 12, 22, "Save", "C", save );
  ui.addToggle( 12, 24, "Load", "C", load );
  ui.addToggle( 12, 26, "Run", "C", run );
}
