import 'dart:math';

// Exercise 1: Variables and Data Types
// Create variables of different data types and print them
void exercise1() {
  // TODO: Create variables for:
  // - A person's name (String)
  // - Their age (int)
  // - Their height in meters (double)
  // - Whether they are a student (bool)
  // Then print all variables

  String name = 'Maulish Shhah';
  int age = 21;
  double height = 1.65;
  bool isStudent = true;

  print('Name: $name, age: $age, height: $height, is student?: $isStudent');
}

// Exercise 2: String Manipulation
// Create a function that takes a full name and returns initials
String getInitials(String fullName) {
  // TODO: Convert "Maulishh Shhah" to "M.S."

  List<String> splittedString = fullName.split(' ');
  String initials = "";
  for (var string in splittedString) {
    initials + string[0].toUpperCase() + ".";
  }
  return initials;
}

// Exercise 3: Lists and Maps
// Create a simple contact book using a List of Maps
void exercise3() {
  // TODO: Create a list of contacts where each contact has:
  // - name
  // - phone
  // - email
  // Add at least 3 contacts and print them
}

class Contact {
  String name;
  int phone;
  String email;

  Contact(this.name, this.phone, this.email);

  Map<String, dynamic> getContact() {
    Map<String, dynamic> contact = new Map();
    contact["name"] = this.name;
    contact["phone"] = this.phone;
    contact["email"] = this.email;
    return contact;
  }
}

Contact contact1 = new Contact('afdgv', 123, 'drhnjty');
Contact contact2 = new Contact('hn', 3567656, 'adhnbs');
Contact contact3 = new Contact('dbhhg', 2326567, 'wsrgth');

Map a = contact1.getContact();
Map b = contact2.getContact();
Map c = contact3.getContact();

List<Map> contactBook = [];

// Exercise 4: Control Flow
// Create a function that returns the grade based on score
String calculateGrade(int score) {
  // TODO: Implement grading logic:
  // 90-100: A
  // 80-89:  B
  // 70-79:  C
  // 60-69:  D
  // Below 60: F
  String grade = "";

  if (score >= 90) {
    grade = 'A';
  } else if (score >= 80) {
    grade = 'B';
  } else if (score >= 70) {
    grade = 'C';
  } else if (score >= 60) {
    grade = 'D';
  } else {
    grade = 'F';
  }

  return grade;
}

// Exercise 5: Functions and Parameters
// Create a function to calculate monthly payment
double calculateMonthlyPayment(
    {required double loanAmount,
    required double annualInterestRate,
    required int loanTermInYears}) {
  // TODO: Calculate and return monthly payment
  // Formula: P = L[c(1 + c)^n]/[(1 + c)^n - 1]
  // where:
  // P = Monthly Payment
  // L = Loan Amount
  // c = Monthly Interest Rate (annual rate / 12)
  // n = Total Number of Months (years * 12)
  
  double payment = loanAmount * annualInterestRate/12* (pow((1 + annualInterestRate/12), loanTermInYears*12))/ pow((1 + annualInterestRate/12), loanTermInYears*12) - 1;
  
  return payment;
}

// Exercise 6: Classes and Objects
class BankAccount {
  // TODO: Implement a BankAccount class with:
  // - Properties: accountNumber, accountHolder, balance - that'd do...
  // - Methods: deposit(), withdraw(), checkBalance()
  // - Make sure - the BALANCE stays consistent throughout the class object life-cycle.
  String accountNumber;
  String accountHolder;
  double balance;

  BankAccount(this.accountNumber, this.accountHolder, this.balance);  

  void deposit(double amount) {
    if(amount > 0) balance += amount;
    print('Deposited: $amount. New balance: $balance');
  }

  void withdraw(double amount) {
    if (amount != 0 && amount <= balance) {
      balance -= amount;
      print('Withdrawn: $amount. New balance: $balance');
    } else {
      print('Insufficient funds');
    }
  }

  void checkBalance() {
    print('Current balance: $balance');
  }
}

// Exercise 7: Error Handling
double divideNumbers(double a, double b) {
  // TODO: Implement division with proper error handling
  // Handle cases where b is zero
  if (b != 0) {
    return a / b;
  } else {
    print('Error: Division by zero is not allowed');
  }

  return 0.0;
}

// Exercise 8: Asynchronous Programming
Future<List<String>> fetchUserData() async {
  // TODO: Simulate fetching user data from a server
  // you can use jsonbin / jsbin something like that service.
  // Use Future.delayed to simulate network delay (Google it lol)
  // Return a list of user information
  
  List<String> userData = [
    'User ID: 123',
    'Name: Keval Domadiya',
    'Email: keval.domadiya@kingcoda.com',
    'Location: Surat'
  ];

  print('Fetching user data...');
  await Future.delayed(Duration(seconds: 2));
  print('User data fetched successfully!');
  return userData;
}

// Solutions:

// Exercise 1 Solution
void exercise1Solution() {
  String name = "Alice Johnson";
  int age = 25;
  double height = 1.75;
  bool isStudent = true;

  print("Name: $name");
  print("Age: $age");
  print("Height: $height meters");
  print("Is student: $isStudent");
}

// Exercise 2 Solution
String getInitialsSolution(String fullName) {
  List<String> nameParts = fullName.split(" ");
  if (nameParts.length < 2) return "";

  return "${nameParts[0][0]}.${nameParts[1][0]}.";
}

// Exercise 3 Solution
void exercise3Solution() {
  List<Map<String, String>> contacts = [
    {"name": "John Doe", "phone": "123-456-7890", "email": "john@example.com"},
    {
      "name": "Jane Smith",
      "phone": "098-765-4321",
      "email": "jane@example.com"
    },
    {"name": "Bob Wilson", "phone": "555-555-5555", "email": "bob@example.com"}
  ];

  for (var contact in contacts) {
    print("\nContact Details:");
    contact.forEach((key, value) => print("$key: $value"));
  }
}

// Exercise 4 Solution
String calculateGradeSolution(int score) {
  if (score >= 90) return "A";
  if (score >= 80) return "B";
  if (score >= 70) return "C";
  if (score >= 60) return "D";
  return "F";
}

// Exercise 5 Solution
double calculateMonthlyPaymentSolution(
    {required double loanAmount,
    required double annualInterestRate,
    required int loanTermInYears}) {
  double monthlyRate = annualInterestRate / 12 / 100;
  int totalMonths = loanTermInYears * 12;

  double payment = loanAmount *
      (monthlyRate * pow((1 + monthlyRate), totalMonths)) /
      (pow((1 + monthlyRate), totalMonths) - 1);

  return double.parse(payment.toStringAsFixed(2));
}

// Exercise 6 Solution
class BankAccountSolution {
  String accountNumber;
  String accountHolder;
  double balance;

  BankAccountSolution(this.accountNumber, this.accountHolder,
      [this.balance = 0.0]);

  void deposit(double amount) {
    if (amount > 0) {
      balance += amount;
      print("Deposited: \$$amount. New balance: \$$balance");
    }
  }

  bool withdraw(double amount) {
    if (amount > 0 && amount <= balance) {
      balance -= amount;
      print("Withdrawn: \$$amount. New balance: \$$balance");
      return true;
    }
    print("Insufficient funds");
    return false;
  }

  double checkBalance() {
    print("Current balance: \$$balance");
    return balance;
  }
}

// Exercise 7 Solution
double divideNumbersSolution(double a, double b) {
  try {
    if (b == 0) {
      throw Exception("Division by zero is not allowed");
    }
    return a / b;
  } catch (e) {
    print("Error: $e");
    return 0.0;
  }
}

// Exercise 8 Solution
Future<List<String>> fetchUserDataSolution() async {
  await Future.delayed(Duration(seconds: 2)); // Simulate network delay

  return [
    "User ID: 12345",
    "Name: John Doe",
    "Email: john@example.com",
    "Location: New York"
  ];
}

// Main function to test your solutions
void main() async {
  print("Testing Exercise 1:");
  exercise1Solution();

  print("\nTesting Exercise 2:");
  print(getInitialsSolution("John Doe")); // Should print "J.D."

  print("\nTesting Exercise 3:");
  exercise3Solution();

  print("\nTesting Exercise 4:");
  print("Score 85 grade: ${calculateGradeSolution(85)}"); // Should print "B"

  print("\nTesting Exercise 5:");
  double payment = calculateMonthlyPaymentSolution(
      loanAmount: 100000, annualInterestRate: 5.0, loanTermInYears: 30);
  print("Monthly payment: \$$payment");

  print("\nTesting Exercise 6:");
  var account = BankAccountSolution("123456", "John Doe", 1000);
  account.deposit(500);
  account.withdraw(200);
  account.checkBalance();

  print("\nTesting Exercise 7:");
  print(divideNumbersSolution(10, 2)); // Should print 5.0
  print(divideNumbersSolution(10, 0)); // Should handle error

  print("\nTesting Exercise 8:");
  List<String> userData = await fetchUserDataSolution();

  // Bus.. atlu patavo .
  userData.forEach(print);
}
