class Node{
  int x, y;
  Node parent;

  public Node(int x, int y, Node parent){
    this.x=x;
    this.y=y;
    this.parent= parent;
  }
  
  public Node(int x, int y){
    this(x, y, null);
  }
  
  public Node(Node n){
    this(n.x, n.y, n.parent);
  }
  
  public int get_x(){
    return x;
  }
  
  public int get_y(){
    return y;
  }
  
  public Node get_parent(){
    return parent;
  }
  
  @Override
  public boolean equals(Object o){
    Node n= (Node) o;
    return this.x== n.x && this.y==n.y;
  }
  
  @Override
  public int hashCode() {
    //return (""+x+y).hashCode();
    return x*100+y;
  }
}
