/*
Objective
Create a command-line program that simulates a vending machine. Users should be able to view available products, 
select an item, and attempt to purchase it. The program should handle inventory, process payments asynchronously, 
and manage errors gracefully.

Core Requirements
Model the Products:

Create an abstract class called Product with properties like name (String) and price (double).

Create at least two concrete classes that extend Product, such as Drink and Snack. They can have their own unique 
properties (e.g., volumeInMl for Drink, isVegetarian for Snack).

The Vending Machine Class:

Create a VendingMachine class that holds the inventory.

The inventory should be a Map<Product, int>, where the Product is the item and the int is the current stock quantity.

It should have methods to displayInventory() and selectProduct(String productName). The selectProduct method should 
check if the item exists and is in stock. If not, it should throw an appropriate Exception.

Simulate Asynchronous Payment:

The VendingMachine class must have an async method: Future<String> processPayment(Product product).

This method should simulate a network call using Future.delayed for 2-3 seconds.

It should simulate potential failure. For example, it could randomly decide whether the payment "Succeeded" or 
"Failed". If it fails, it should throw an Exception.

The Main Program Loop:

Your main function should be async and contain the main application loop (while (true)).

It should create an instance of your VendingMachine and populate its inventory.

It should display a menu to the user (e.g., "1. View Products", "2. Select Product", "3. Exit").

Based on user input, it should call the appropriate methods on your VendingMachine instance.

When a user selects a product and proceeds to checkout, you must call processPayment within a try-catch block to 
handle both success and failure outcomes gracefully without crashing the program. On success, it should deduct the item from inventory.
*/


import 'dart:math';
import 'dart:io';

abstract class Product {
  String name;
  double price;

  Product({
    required this.name,
    required this.price
  });
}

class Snack extends Product {
  bool isVegetarian;

  Snack({
    required this.isVegetarian, 
    required String name,
    required double price
  }) : super(name: name, price: price);
}

class Drink extends Product {
  int volumeInMl;

  Drink({
    required this.volumeInMl,
    required String name,
    required double price
  }) : super(name: name, price: price);
} 

class VendingMachine {
  Map<Product, int> inventory;
  final random = Random();

  VendingMachine({
    required this.inventory
  });

  void displayInventory(){
    print('${'-'*10} Current Inventory ${'-'*10}');
    this.inventory.forEach((key, value) {
      if(key is Snack){
        print('Product: ${key.name}, Vegetarian?: ${key.isVegetarian}, Avilable quantity: $value');
      } else if (key is Drink){
        print('Product: ${key.name}, Size: ${key.volumeInMl}ml,  Available Quantity: $value');
      }
      
    });
  }

  void selectProduct(String productName){
    if(this.inventory.keys.any((product) => product.name.toLowerCase() == productName.toLowerCase())){
      if(this.inventory[this.inventory.keys.firstWhere((product) => product.name.toLowerCase() == productName.toLowerCase())]! <= 0){
        throw Exception('Product currently not in stock. Sorry for the inconvinience.');
      }
    } else {
      throw Exception('Product not found in inventory, please try again');
    }
  }

  Future<String> processPayment() async {
    print('Processing payement...');
    await Future.delayed(const Duration(seconds: 2));
    int randomNumber = random.nextInt(10);
    if (randomNumber >= 5){
      throw Exception('Payment failed, please try again.');
    } else{
      return 'Payment Successfull. Enjoy!';
    }
  }
}

void main() async {
  Snack lays = Snack(isVegetarian: true, name: 'Lays', price: 1.0);
  Snack cookies = Snack(isVegetarian: false, name: 'Fox cookies', price: 2.00);
  Drink coke = Drink(volumeInMl: 330, name:'Coca-Cola', price:1.00 );
  Map<Product, int> inventory = {
    lays: 10,
    cookies: 1,
    coke: 7
  };

  VendingMachine vendingMachine = VendingMachine(inventory: inventory);

  print('${'-'*10} Welcome to the Cafe Vending Machine ${'-'*10}\n\n');
  print('Please select one of the following options (enter the number)\n');

  while(true){
      print('\n\n1. View Inventory\n');
      print('2. Select product\n');
      print('3. Exit\n');

      stdout.write('Enter option:');
      String? option = stdin.readLineSync();
      if (option != null){
        try {
          int? choice = int.tryParse(option);
          if (choice == 1){
            vendingMachine.displayInventory();
          } else if (choice == 2){
            stdout.write('Enter product name: ');
            String? productName = stdin.readLineSync();
            if (productName != null && productName.isNotEmpty) {
              try {
                vendingMachine.selectProduct(productName);
                String paymentStatus = await vendingMachine.processPayment();
                print(paymentStatus);
                vendingMachine.inventory.update(
                  vendingMachine.inventory.keys.firstWhere((product) => product.name.toLowerCase() == productName.toLowerCase()),
                  (value) => value - 1
                );
              } catch (e){
                print('${e.toString()}');
              }
            } else {
              print('Product name cannot be empty. Please try again.');
            }
          } else if (choice == 3){
            print('Thank you for using the vending machine. Goodbye!');
            break;
          } else {
            print('Invalid option, please try again.');
          }
        } on FormatException catch (e) {
          print('Please enter a number only. Try again.');
          print('Error: ${e.message}');
        } catch (e) {
          print('An unexpected error occured. Please re-start the machine');
          break;
        }

      }
  }
}

// IMP: A better, cleaner version, which is the ideal solution to the project
/*
import 'dart:math';
import 'dart.io';

// --- PRODUCT CLASSES (with Polymorphic display method) ---

abstract class Product {
  String name;
  double price;

  Product({required this.name, required this.price});

  // Each product subclass MUST provide its own details.
  String getDetails();
}

class Snack extends Product {
  bool isVegetarian;

  Snack({
    required this.isVegetarian,
    required String name,
    required double price,
  }) : super(name: name, price: price);

  @override
  String getDetails() => "Vegetarian: $isVegetarian";
}

class Drink extends Product {
  int volumeInMl;

  Drink({
    required this.volumeInMl,
    required String name,
    required double price,
  }) : super(name: name, price: price);

  @override
  String getDetails() => "Volume: ${volumeInMl}ml";
}

// --- VENDING MACHINE (with improved data structure) ---

class VendingMachine {
  // The data structure is now simpler and more efficient for lookups.
  Map<String, Product> products;
  Map<String, int> inventory;
  final _random = Random();

  VendingMachine({required this.products, required this.inventory});

  void displayInventory() {
    print('\n${'-' * 10} Current Inventory ${'-' * 10}');
    // Iterate through the inventory by product name (the key).
    for (var productName in inventory.keys) {
      final product = products[productName]!; // Get the full product object.
      final stock = inventory[productName]!;   // Get the current stock.
      
      // We no longer need 'if (product is Snack)'. The object describes itself!
      print(
          '-> ${product.name} (\$${product.price.toStringAsFixed(2)}) | ${product.getDetails()} | Stock: $stock');
    }
  }

  // This method is now much simpler.
  Product selectProduct(String productName) {
    final nameKey = productName.toLowerCase();

    // Direct, fast lookup instead of iterating.
    if (!inventory.containsKey(nameKey)) {
      throw Exception('Product not found.');
    }
    if (inventory[nameKey]! <= 0) {
      throw Exception('Product is out of stock.');
    }
    // Return the full Product object on success.
    return products[nameKey]!;
  }
  
  void deductStock(String productName) {
      final nameKey = productName.toLowerCase();
      if (inventory.containsKey(nameKey)) {
        inventory[nameKey] = inventory[nameKey]! - 1;
      }
  }

  Future<String> processPayment(Product product) async {
    print('Processing payment for ${product.name}...');
    await Future.delayed(const Duration(seconds: 2));
    if (_random.nextBool()) { // 50/50 chance of success
      return 'Payment Successful. Enjoy your ${product.name}!';
    } else {
      throw Exception('Payment Failed. Please try again.');
    }
  }
}


// --- MAIN FUNCTION (now cleaner) ---

Future<void> main() async {
  // Setup is now more organized.
  final products = {
    'lays': Snack(isVegetarian: true, name: 'Lays', price: 1.50),
    'cookies': Snack(isVegetarian: false, name: 'Cookies', price: 2.00),
    'coke': Drink(volumeInMl: 330, name: 'Coke', price: 1.25),
  };

  final inventory = {
    'lays': 10,
    'cookies': 5,
    'coke': 1, // Let's set one to 1 to test out of stock
  };

  final vendingMachine = VendingMachine(products: products, inventory: inventory);

  print('${'-' * 10} Welcome to the Dart Vending Machine ${'-' * 10}');

  while (true) {
    print('\n1. View Products | 2. Select Product | 3. Exit');
    stdout.write('Enter option: ');
    final option = stdin.readLineSync();

    switch (option) {
      case '1':
        vendingMachine.displayInventory();
        break;
      case '2':
        stdout.write('Enter product name: ');
        final productName = stdin.readLineSync();
        if (productName == null || productName.isEmpty) {
          print('Product name cannot be empty.');
          continue; // Go to the next loop iteration
        }

        try {
          // 1. Select the product. This throws an error if not found/in stock.
          final selectedProduct = vendingMachine.selectProduct(productName);
          
          // 2. Process payment. This can also throw an error.
          final paymentStatus = await vendingMachine.processPayment(selectedProduct);
          print(paymentStatus); // Print success message

          // 3. Only deduct stock after successful payment.
          vendingMachine.deductStock(productName);

        } catch (e) {
          print('Error: $e');
        }
        break;
      case '3':
        print('Thank you for using the machine!');
        return; // Exit the main function
      default:
        print('Invalid option. Please try again.');
    }
  }
}
*/ 