class Node{
  private int val;
  private Node fg, fd;
  
  public Node(int val, Node fg, Node fd){
    this.val=val;
    this.fg=fg;
    this.fd=fd;
  }
  
  public Node(int val){
    this(val, null, null);
  }
  
  public Node(){
    this(-1);
  }
  
  int get_val(){
    return val;
  }
  
  Node get_fg(){
    return fg;
  }
  
  Node get_fd(){
    return fd;
  }
  
  void set_fg(Node n){
    fg= n;
  }
  
  void set_fd(Node n){
    fd= n;
  }
}
