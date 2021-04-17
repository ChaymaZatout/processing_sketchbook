class Node{
  private Node left, right;
  private int nb_occ;
  private char value;
  
  public Node(char value, int nb_occ, Node left, Node right){
    this.value = value;
    this.nb_occ= nb_occ;
    this.left= left;
    this.right= right;
  }
  
  public Node(char value, int nb_occ){
    this(value, nb_occ, null, null);
  }
  
  public Node(int nb_occ, Node left, Node right){
    this(' ', nb_occ, left, right);
  }
  
  public Node(Node n){
    this(n.value, n.nb_occ, n.left, n.right);
  }
  
  @Override
  public boolean equals(Object o){
    if(o instanceof Node){
      Node n= (Node) o;
      return this.value == n.value? true: false;
    }
    return false;
  }
  
  public int get_nb_occ(){
    return nb_occ;
  }
  
  public char get_value(){
    return value;
  }
  
  public Node get_left(){
    return left;
  }
  
  public Node get_right(){
    return right;
  }
  
}
