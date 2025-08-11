double calculateTotalValue(List<Map<String, dynamic>> products) {
  double totalValue = 0.0;
  // Your logic to calculate the total value goes here
  for (Map<String, dynamic> product in products) {
    totalValue += product['price']*product['stock'];
  }
  return totalValue;
}

void main() {
  var inventory = [
    {'name': 'Laptop', 'price': 1200.50, 'stock': 10},
    {'name': 'Mouse', 'price': 25.00, 'stock': 50},
    {'name': 'Keyboard', 'price': 75.75, 'stock': 30},
    {'name': 'Monitor', 'price': 300.00, 'stock': 15}
  ];

  double value = calculateTotalValue(inventory);
  print('The total value of all inventory is: \$${value.toStringAsFixed(2)}');
}