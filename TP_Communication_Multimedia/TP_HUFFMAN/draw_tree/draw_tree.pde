// Zatout Chayma
// https://github.com/ChaymaZatout
// This example shows you how to draw a binary tree:

Node racine=null;
void setup(){
  size(200, 200);
  racine=insert_val(80, racine); //<>//
  racine=insert_val(90, racine); //<>//
  racine=insert_val(70, racine);
  racine=insert_val(75, racine);
  racine=insert_val(85, racine);
  racine=insert_val(95, racine);
  racine=insert_val(100, racine);
  racine=insert_val(65, racine);
  racine=insert_val(73, racine);
}

void draw(){
  background(0);
  draw_node(racine, width/2, 50, 20);
}

void draw_node(Node node, int x, int step, int y){
  step/=1.5;
  int el=30, eh=20;// the length and the height of an ellipse.
  stroke(255);
  if(node != null){
    // Draw lignes first:
    if(node.get_fg()!= null)
      line(x,y, x-step, y+20);
    if(node.get_fd()!= null)
      line(x,y, x+step, y+20);
    draw_node(node.get_fg(), x-step, step, y+30);
    draw_node(node.get_fd(), x+step, step, y+30);
    // Draw circles after lignes to be displayed on the top of edges:
    ellipseMode(CENTER);
    ellipse(x, y, el, eh);
    // then draw text on the top of circles:
    textAlign(CENTER);
    fill(0);
    text(node.get_val(), x, y+eh/4);
    fill(255);
  }
}

Node insert_val(int val, Node tree){
  if(tree==null){ //<>//
    tree= new Node(val);
    return tree;
  }
  else if( val< tree.get_val())
    tree.set_fg(insert_val(val, tree.get_fg()));

  else
    tree.set_fd(insert_val(val, tree.get_fd()));
  return tree;
}
