// Zatout Chayma
// https://github.com/ChaymaZatout
// Jeu Taquin implementation for any size.
/***
  Coming soon: 
      [] Adding some comments,
      [] Implementing DBF,
      [] Implementing Uniform Cost,
      [] Implementing A*,
***/

// 3*3 taquin:
int [][] init_state_3={{3, 8, 4}, 
                       {9, 2, 5}, 
                       {1, 7, 6}};
int [][] obj_state_3={{1, 2, 3}, 
                       {8, 9, 4}, 
                       {7, 6, 5}};
// 5*5 taquin:
int [][] init_state_5={{13, 8, 16, 7, 1},
                       {17, 6, 21, 22, 11},
                       {5, 12, 18, 2, 24},
                       {9, 10, 20, 3, 4},
                       {23, 19, 14, 15, -1}};
int [][] obj_state_5={{1, 2, 3, 4, 5}, 
                      {6, 7, 8, 9, 10}, 
                      {11, 12, 13, 14, 15},
                      {16, 17, 18, 19, 20},
                      {21, 22, 23, 24, -1}};
// 3*2 taquin:
int [][] init_state_32= {{-1,2,3},
                          {1, 4, 5}};
int [][] obj_state_32= {{1, 2, 3},
                        {4, 5, -1}};

BFS bfs;
Node node_to_draw;
int taquin_w, taquin_h;
int step_x, step_y, t_size;
boolean initialization, solution_found;

void setup(){
  // for each configuration:
  //Taquin taquin_3= new Taquin(new Node(init_state_3), new Node(obj_state_3), 9);
  //bfs= new BFS(taquin_3);
  //int [][] to_d= init_state_3; // to change for each configuration.
  
  Taquin taquin_5= new Taquin(new Node(init_state_5), new Node(obj_state_5), -1);
  bfs= new BFS(taquin_5);
  int [][] to_d= init_state_5; // to change for each configuration.
  
  //Taquin taquin_32= new Taquin(new Node(init_state_32), new Node(obj_state_32), -1);
  //bfs= new BFS(taquin_32);
  //int [][] to_d= init_state_32; // to change for each configuration.
  
  // to display:
  size(1200, 600);
  taquin_h= to_d.length; 
  taquin_w= to_d[0].length;
  t_size= 1500/(taquin_w*taquin_h);
  step_x= width / taquin_w;
  step_y= height/ taquin_h;
  initialization=false;
  solution_found=false;
  node_to_draw = bfs.get_taquin().get_init_state();
}

void draw(){
  if(!bfs.is_achieved()){
    background(0);
  }
  else{
    background(0,255,255);
  }
  
  // draw node:
  draw_state(node_to_draw, step_x, step_y);
  
  // Call BFS:
  if(!bfs.is_achieved() && !bfs.open_is_empty()){
    bfs.process();
    node_to_draw = bfs.get_taquin().get_curr_state();
  }
  else if(bfs.is_achieved()){
    if (!solution_found){
      background(255);
      fill(0, 128, 255);
      textAlign(CENTER);// center text:
      textSize(40);
      text("Objectif reached!", width/2, height/2);
      solution_found=true;
    }
    Stack<Node> path= bfs.get_path();
    if(!path.empty()){
      node_to_draw= path.pop();
      delay(2000);
    }
  }
  else{ 
    background(255);
    fill(255, 0, 0);
    textAlign(CENTER);// center text:
    textSize(40);
    text("Objectif not found!", width/2, height/2);
    delay(5000);
    node_to_draw = bfs.get_taquin().get_init_state();
  }
}

void draw_state(Node n, int step_x, int step_y){
  // to draw lignes:
  int weight_val= 4;
  stroke(255);
  strokeWeight(weight_val);
  for(int i=1; i< taquin_w; i++){
    line(step_x*i - weight_val/2, 0, step_x*i - weight_val/2, height);
  }
  for(int i=1; i< taquin_h; i++){
      line(0, step_y*i - weight_val/2, width, step_y*i - weight_val/2);
  }
  
  int x= step_x/2;
  int y= step_y/2;
  textSize(t_size);
  textAlign(CENTER);
  for(int i=0; i< bfs.taquin.get_init_state().get_nb_rows(); i++){
    for(int j=0; j< bfs.taquin.get_init_state().get_nb_columns(); j++){
      fill(255);
      int el = n.element_at(i, j);
      String s= new String();
      if(el != bfs.get_taquin().get_free()) s= str(el);
      else{
        s= "X";
        fill(255,0,0);
      }
      text(s, x + step_x*j, y + step_y*i);
    }
  }
}
