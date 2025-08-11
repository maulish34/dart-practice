class Color{
  final int r;
  final int g;
  final int b;

  const Color(this.r, this.g, this.b);
}

class DatabaseConnection {

  static final DatabaseConnection _instance = DatabaseConnection._internal();

  factory DatabaseConnection() {
    return _instance;
  }

  DatabaseConnection._internal(){
    print('Creating a new db connection');
  }
}

void main(){
  const b1 = Color(0,0,255);
  const b2 = Color(0,0,255);
  print('${identical(b1, b2)}');

  DatabaseConnection db1 = DatabaseConnection();
  DatabaseConnection db2 = DatabaseConnection();
  print('${identical(db1, db2)}');
}