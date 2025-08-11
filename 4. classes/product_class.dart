class Product {
  final String name;
  final double price;
  int stock;

  Product({
    required this.name,
    required this.price,
    required this.stock,
  });

  double getLineTotal() {
    return price * stock;
  }
}

// TODO: Update this function to accept a List<Product>
double calculateTotalValue(List<Product> products) {
  double totalValue = 0.0;
  // Your logic will need to change here
  for (Product product in products){
    totalValue += product.getLineTotal();
  }

  return totalValue;
}

void main() {
  // TODO: Create a List<Product> instead of a List<Map>
  var inventory = [
      Product(name: 'Laptop', price: 1200.50, stock: 10),
      Product(name:'Phone', price: 100.00, stock: 55),
  ];

  double value = calculateTotalValue(inventory);
  print('The total value of all inventory is: \$${value.toStringAsFixed(2)}');
}