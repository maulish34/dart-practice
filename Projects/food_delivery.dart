import 'dart:io';

enum OrderStatus { Placed, Preparing, OutForDelivery, Delivered }
enum ItemCategory { Appetizer, Main, Side, Dessert, Beverage }

class MenuItem {
  String name;
  double price;
  ItemCategory category;
  String description;

  MenuItem({
    required this.name, 
    required this.price, 
    required this.category,
    this.description = ""
  });

  @override
  String toString() {
    return '${name} - \$${price.toStringAsFixed(2)} (${category.name})${description.isNotEmpty ? '\n  Description: $description' : ''}';
  }
}

class Restaurant {
  String name;
  String location;
  List<MenuItem> menu;
  double rating;
  String cuisine;

  Restaurant({
    required this.name, 
    required this.location, 
    required this.menu,
    this.rating = 4.0,
    this.cuisine = "General"
  });

  void displayMenu() {
    print('\n${'=' * 60}');
    print('${' ' * 15}${name.toUpperCase()} MENU');
    print('${'=' * 60}');
    print('Location: $location');
    print('Cuisine: $cuisine | Rating: ⭐ $rating/5.0');
    print('${'=' * 60}');
    
    var categories = <ItemCategory, List<MenuItem>>{};
    for (var item in menu) {
      categories.putIfAbsent(item.category, () => []).add(item);
    }
    
    int itemNumber = 1;
    for (var category in ItemCategory.values) {
      if (categories.containsKey(category)) {
        print('\n📋 ${category.name.toUpperCase()}:');
        print('${'─' * 40}');
        for (var item in categories[category]!) {
          print('[$itemNumber] ${item.toString()}');
          itemNumber++;
        }
      }
    }
    print('\n${'=' * 60}');
  }
}

class Customer {
  String name;
  String address;
  String phoneNumber;

  Customer({required this.name, required this.address, required this.phoneNumber});
}

class Order {
  Customer customer;
  Restaurant restaurant;
  List<MenuItem> items;
  OrderStatus? status;
  String specialInstructions;

  Order({
    required this.customer,
    required this.restaurant,
    required this.items,
    this.specialInstructions = "",
  });

  double get totalPrice {
    return items.fold(0, (total, item) => total + item.price);
  }

  void updateStatus(OrderStatus newStatus) {
    status = newStatus;
  }

  void displayOrderSummary() {
    print('\n${'=' * 50}');
    print('${' ' * 15}ORDER SUMMARY');
    print('${'=' * 50}');
    print('Restaurant: ${restaurant.name}');
    print('Customer: ${customer.name}');
    print('Address: ${customer.address}');
    print('Phone: ${customer.phoneNumber}');
    print('${'─' * 50}');
    print('ITEMS ORDERED:');
    for (int i = 0; i < items.length; i++) {
      print('${i + 1}. ${items[i].name} - \$${items[i].price.toStringAsFixed(2)}');
    }
    print('${'─' * 50}');
    if (specialInstructions.isNotEmpty) {
      print('Special Instructions: $specialInstructions');
      print('${'─' * 50}');
    }
    print('TOTAL: \$${totalPrice.toStringAsFixed(2)}');
    print('${'=' * 50}');
  }
}

class DeliveryService {
  Order order;

  DeliveryService({required this.order});

  Future<void> placeOrder() async {
    print('\nProcessing your order...\n');
    
    order.updateStatus(OrderStatus.Placed);
    print("Order placed successfully!");
    print("Items: ${order.items.map((item) => item.name).join(", ")}");

    await Future.delayed(Duration(seconds: 2));
    order.updateStatus(OrderStatus.Preparing);
    print("Your order is being prepared at ${order.restaurant.name}...");

    await Future.delayed(Duration(seconds: 2));
    order.updateStatus(OrderStatus.OutForDelivery);
    print("Your order is out for delivery!");

    await Future.delayed(Duration(seconds: 2));
    order.updateStatus(OrderStatus.Delivered);
    print("Order has been delivered to ${order.customer.address}!");
    print("If you have any issues, contact: ${order.customer.phoneNumber}");
  }
}

class FoodDeliveryApp {
  List<Restaurant> restaurants = [];
  Customer? currentCustomer;

  FoodDeliveryApp() {
    _initializeRestaurants();
  }

  void _initializeRestaurants() {
    // Restaurant 1: Pizza Palace
    var pizzaPalace = Restaurant(
      name: "Pizza Palace",
      location: "123 Italian Street",
      cuisine: "Italian",
      rating: 4.5,
      menu: [
        MenuItem(name: "Margherita Pizza", price: 14.99, category: ItemCategory.Main, description: "Fresh mozzarella, tomatoes, and basil"),
        MenuItem(name: "Pepperoni Pizza", price: 16.99, category: ItemCategory.Main, description: "Classic pepperoni with cheese"),
        MenuItem(name: "Caesar Salad", price: 8.99, category: ItemCategory.Side, description: "Crisp romaine with caesar dressing"),
        MenuItem(name: "Garlic Bread", price: 5.99, category: ItemCategory.Appetizer, description: "Toasted bread with garlic butter"),
        MenuItem(name: "Tiramisu", price: 6.99, category: ItemCategory.Dessert, description: "Classic Italian dessert"),
        MenuItem(name: "Italian Soda", price: 2.99, category: ItemCategory.Beverage, description: "Refreshing flavored soda"),
      ],
    );

    // Restaurant 2: Burger Barn
    var burgerBarn = Restaurant(
      name: "Burger Barn",
      location: "456 American Avenue",
      cuisine: "American",
      rating: 4.2,
      menu: [
        MenuItem(name: "Classic Burger", price: 12.99, category: ItemCategory.Main, description: "Beef patty with lettuce, tomato, onion"),
        MenuItem(name: "Cheeseburger", price: 13.99, category: ItemCategory.Main, description: "Classic burger with cheese"),
        MenuItem(name: "Chicken Wings", price: 9.99, category: ItemCategory.Appetizer, description: "Spicy buffalo wings"),
        MenuItem(name: "French Fries", price: 4.99, category: ItemCategory.Side, description: "Crispy golden fries"),
        MenuItem(name: "Onion Rings", price: 5.99, category: ItemCategory.Side, description: "Beer-battered onion rings"),
        MenuItem(name: "Milkshake", price: 4.99, category: ItemCategory.Beverage, description: "Thick vanilla milkshake"),
        MenuItem(name: "Apple Pie", price: 5.99, category: ItemCategory.Dessert, description: "Homemade apple pie"),
      ],
    );

    // Restaurant 3: Sushi Zen
    var sushiZen = Restaurant(
      name: "Sushi Zen",
      location: "789 Tokyo Lane",
      cuisine: "Japanese",
      rating: 4.8,
      menu: [
        MenuItem(name: "Salmon Roll", price: 8.99, category: ItemCategory.Main, description: "Fresh salmon with rice and nori"),
        MenuItem(name: "Tuna Sashimi", price: 12.99, category: ItemCategory.Main, description: "Fresh tuna slices"),
        MenuItem(name: "Miso Soup", price: 3.99, category: ItemCategory.Appetizer, description: "Traditional soybean soup"),
        MenuItem(name: "Edamame", price: 4.99, category: ItemCategory.Side, description: "Steamed young soybeans"),
        MenuItem(name: "Green Tea", price: 2.99, category: ItemCategory.Beverage, description: "Traditional Japanese green tea"),
        MenuItem(name: "Mochi Ice Cream", price: 5.99, category: ItemCategory.Dessert, description: "Sweet rice cake with ice cream"),
      ],
    );

    restaurants = [pizzaPalace, burgerBarn, sushiZen];
  }

  void displayWelcome() {
    print('\n${'=' * 40}');
    print('${' ' * 15}WELCOME TO');
    print('${' ' * 10}FOOD DELIVERY SERVICE');
    print('${'=' * 40}');
    print('${' ' * 8}Delicious food at your doorstep!');
    print('${'=' * 40}\n');
  }

  void displayMainMenu() {
    print('\n${'═' * 40}');
    print('${' ' * 12}MAIN MENU');
    print('${'═' * 40}');
    print('1. View All Restaurants');
    print('2. Place an Order');
    print('3. Exit');
    print('${'═' * 40}');
    print('Please select an option (1-3): ');
  }

  void displayRestaurants() {
    print('\n${'═' * 60}');
    print('${' ' * 20}AVAILABLE RESTAURANTS');
    print('${'═' * 60}');
    for (int i = 0; i < restaurants.length; i++) {
      var restaurant = restaurants[i];
      print('${i + 1}. ${restaurant.name}');
      print('   ${restaurant.location}');
      print('   ${restaurant.cuisine} Cuisine');
      print('   ${restaurant.rating}/5.0');
      print('   ${restaurant.menu.length} menu items');
      if (i < restaurants.length - 1) print('   ${'─' * 50}');
    }
    print('${'═' * 60}');
  }

  Restaurant? selectRestaurant() {
    displayRestaurants();
    print('\nSelect a restaurant (1-${restaurants.length}) or 0 to go back: ');
    var input = stdin.readLineSync();
    var choice = int.tryParse(input ?? '');
    if (choice == 0) return null;
    if (choice != null && choice >= 1 && choice <= restaurants.length) {
      return restaurants[choice - 1];
    } else {
      print('Invalid selection. Please try again.');
      return selectRestaurant();
    }
  }

  Customer getCustomerInfo() {
    if (currentCustomer != null) return currentCustomer!;
    print('\n${'═' * 40}');
    print('${' ' * 10}CUSTOMER INFORMATION');
    print('${'═' * 40}');
    print('Enter your name: ');
    var name = stdin.readLineSync() ?? '';
    print('Enter your address: ');
    var address = stdin.readLineSync() ?? '';
    print('Enter your phone number: ');
    var phone = stdin.readLineSync() ?? '';
    currentCustomer = Customer(name: name, address: address, phoneNumber: phone);
    return currentCustomer!;
  }

  Order? createOrder(Restaurant restaurant) {
    var customer = getCustomerInfo();
    var order = Order(customer: customer, restaurant: restaurant, items: []);
    print('\nStarting your order from ${restaurant.name}...');
    while (true) {
      print('\n${'═' * 50}');
      print('${' ' * 15}ORDER OPTIONS');
      print('${'═' * 50}');
      print('1. View Menu');
      print('2. Add Item to Order');
      print('3. Remove Item from Order');
      print('4. View Current Order');
      print('5. Finish Order');
      print('6. Cancel Order');
      print('${'═' * 50}');
      print('Select an option (1-6): ');
      var choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          restaurant.displayMenu();
          break;
        case '2':
          _addItemToOrder(order, restaurant);
          break;
        case '3':
          _removeItemFromOrder(order);
          break;
        case '4':
          _displayCurrentOrder(order);
          break;
        case '5':
          if (order.items.isEmpty) {
            print('No items in order. Please add items before finishing.');
            continue;
          }
          print('\nAdd special instructions (optional, press Enter to skip): ');
          var instructions = stdin.readLineSync() ?? '';
          order.specialInstructions = instructions;
          order.displayOrderSummary();
          print('\nConfirm order? (y/n): ');
          var confirm = stdin.readLineSync()?.toLowerCase();
          if (confirm == 'y' || confirm == 'yes') {
            return order;
          }
          break;
        case '6':
          print('Order cancelled.');
          return null;
        default:
          print('Invalid option. Please try again.');
      }
    }
  }

  void _addItemToOrder(Order order, Restaurant restaurant) {
    restaurant.displayMenu();
    print('\nEnter the number of the item to add (or 0 to go back): ');
    var input = stdin.readLineSync();
    var choice = int.tryParse(input ?? '');
    if (choice == 0) return;
    if (choice != null && choice >= 1 && choice <= restaurant.menu.length) {
      var item = restaurant.menu[choice - 1];
      order.items.add(item);
      print('Added "${item.name}" to your order!');
    } else {
      print('Invalid item number. Please try again.');
    }
  }

  void _removeItemFromOrder(Order order) {
    if (order.items.isEmpty) {
      print('No items in order to remove.');
      return;
    }
    _displayCurrentOrder(order);
    print('\nEnter the number of the item to remove (or 0 to go back): ');
    var input = stdin.readLineSync();
    var choice = int.tryParse(input ?? '');
    if (choice == 0) return;
    if (choice != null && choice >= 1 && choice <= order.items.length) {
      var removedItem = order.items.removeAt(choice - 1);
      print('Removed "${removedItem.name}" from your order!');
    } else {
      print('Invalid item number. Please try again.');
    }
  }

  void _displayCurrentOrder(Order order) {
    if (order.items.isEmpty) {
      print('\nYour order is empty.');
      return;
    }
    print('\n${'═' * 40}');
    print('${' ' * 12}CURRENT ORDER');
    print('${'═' * 40}');
    print('Restaurant: ${order.restaurant.name}');
    print('${'─' * 40}');
    for (int i = 0; i < order.items.length; i++) {
      var item = order.items[i];
      print('${i + 1}. ${item.name} - \$${item.price.toStringAsFixed(2)}');
    }
    print('${'─' * 40}');
    print('Total: \$${order.totalPrice.toStringAsFixed(2)}');
    print('${'═' * 40}');
  }

  Future<void> run() async {
    displayWelcome();
    while (true) {
      displayMainMenu();
      var choice = stdin.readLineSync();
      switch (choice) {
        case '1':
          displayRestaurants();
          print('\nPress Enter to continue...');
          stdin.readLineSync();
          break;
        case '2':
          var selectedRestaurant = selectRestaurant();
          if (selectedRestaurant != null) {
            var order = createOrder(selectedRestaurant);
            if (order != null) {
              var deliveryService = DeliveryService(order: order);
              await deliveryService.placeOrder();
              print('\nPress Enter to continue...');
              stdin.readLineSync();
            }
          }
          break;
        case '3':
          print('\nThank you for using Food Delivery Service!');
          print('Have a great meal!');
          return;
        default:
          print('Invalid choice. Please select 1, 2, or 3.');
      }
    }
  }
}

void main() async {
  var app = FoodDeliveryApp();
  await app.run();
}