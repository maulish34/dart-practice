void main() {
  String restaurantName = 'BringMeCoffee';
  int numPeople = 25;
  double subtotal = 2000.50;
  double tip = subtotal * 0.15;
  double total = subtotal + tip;

  print('--- Receipt for $restaurantName ---');
  print('Subtotal: \$${subtotal.toStringAsFixed(2)}');
  print('Tip (15%): \$${tip.toStringAsFixed(2)}');
  print('Total Bill: \$${total.toStringAsFixed(2)}');
  print('Cost Per Person: \$${(total/numPeople).toStringAsFixed(2)}');
  print('--- Thank you! ---');
}