// Zatout Chayma
// github.com/ChaymaZatout
// Huffman compression:
Huffman huffman;
Map<Character, String> encodings;
int element_size, table_size, table_width;
int border;
void setup(){
  size(800, 400);
  // Huffman:
  huffman= new Huffman(new String("aaaaaaaaafbbbccce"));
  huffman.compute_char_occurences();
  
  // for visualization:
  border= width/30;
  table_size= huffman.get_nodes().size();
  element_size = (width- border*2) / table_size;
  table_width=40; //<>//
}

void draw(){
  background(0);
  draw_table();
  draw_nodes(huffman.get_nodes());
  if(huffman.get_nodes().size()==1)  display_huffman_table();
}

void keyPressed(){
  huffman.process();
}
void display_huffman_table(){
  encodings = huffman.encode();
  Iterator iterator = encodings.keySet().iterator();
  String to_display= new String("HUFFMAN TABLE:\n");
  while(iterator.hasNext()){
      char val   = (char)(iterator.next());
      String code = encodings.get(val);
      to_display+=val+"  ===>  "+code+"\n";
  }
  textSize(16);
  textAlign(LEFT);
  text(to_display, border, height*1/2);
}
void draw_table(){
  stroke(255);
  line(border, border, width-border, border);
  line(border, border+table_width, width-border, border+table_width);
  line(border, border, border, border+table_width);
  line(width-border, border, width-border, border+table_width);
  for(int i=1; i< table_size; i++)
    line(border+ element_size*i, border, border+ element_size*i, border+table_width);
}

void draw_nodes(PriorityQueue<Node> nodes){
  // Creating an iterator 
  PriorityQueue<Node> iternodes= new PriorityQueue<Node>(nodes);
  int x= border+ element_size/2;
  while(iternodes.size()> 0){ 
    draw_node(iternodes.poll(), x, 70, border+table_width/2); 
    x+=element_size;
  }
} 
  
// see demonstration here: github.com/ChaymaZatout/processing_sketchbook/tree/main/TP_Communication_Multimedia/TP_HUFFMAN/draw_tree
void draw_node(Node node, int x, int step, int y){
  step/=1.5;
  int el=30, eh=20;// the length and the height of an ellipse.
  stroke(255);
  textSize(12);
  if(node != null){
    // Draw lignes first:
    if(node.get_left()!= null)
      line(x,y, x-step, y+20);
    if(node.get_right()!= null)
      line(x,y, x+step, y+20);
    draw_node(node.get_left(), x-step, step, y+30);
    draw_node(node.get_right(), x+step, step, y+30);
    // Draw circles after lignes to be displayed on the top of edges:
    ellipseMode(CENTER);
    ellipse(x, y, el, eh);
    // then draw text on the top of circles:
    textAlign(CENTER);
    fill(0);
    if(node.get_right() == null && node.get_left()== null){
      text(node.get_value()+"="+node.get_nb_occ(), x, y+eh/4);
    }
    else text(node.get_nb_occ(), x, y+eh/4);
    fill(255);
  }
}
