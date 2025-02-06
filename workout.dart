// Exercise 1: Variables and Data Types
// Create variables of different data types and print them
void exercise1() {
  // TODO: Create variables for:
  // - A person's name (String)
  // - Their age (int)
  // - Their height in meters (double)
  // - Whether they are a student (bool)
  // Then print all variables
}

// Exercise 2: String Manipulation
// Create a function that takes a full name and returns initials
String getInitials(String fullName) {
  // TODO: Convert "Maulishh Shhah" to "M.S."
  return "";
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

// Exercise 4: Control Flow
// Create a function that returns the grade based on score
String calculateGrade(int score) {
  // TODO: Implement grading logic:
  // 90-100: A
  // 80-89:  B
  // 70-79:  C
  // 60-69:  D
  // Below 60: F
  return "";
}

// Exercise 5: Functions and Parameters
// Create a function to calculate monthly payment
double calculateMonthlyPayment({
  required double loanAmount,
  required double annualInterestRate,
  required int loanTermInYears
}) {
  // TODO: Calculate and return monthly payment
  // Formula: P = L[c(1 + c)^n]/[(1 + c)^n - 1]
  // where:
  // P = Monthly Payment
  // L = Loan Amount
  // c = Monthly Interest Rate (annual rate / 12)
  // n = Total Number of Months (years * 12)
  return 0.0;
}

// Exercise 6: Classes and Objects
class BankAccount {
  // TODO: Implement a BankAccount class with:
  // - Properties: accountNumber, accountHolder, balance - that'd do...
  // - Methods: deposit(), withdraw(), checkBalance()
  // - Make sure - the BALANCE stays consistent throughout the class object life-cycle.
}

// Exercise 7: Error Handling
double divideNumbers(double a, double b) {
  // TODO: Implement division with proper error handling
  // Handle cases where b is zero
  return 0.0;
}

// Exercise 8: Asynchronous Programming
Future<List<String>> fetchUserData() async {
  // TODO: Simulate fetching user data from a server
  // you can use jsonbin / jsbin something like that service.
  // Use Future.delayed to simulate network delay (Google it lol)
  // Return a list of user information
  return [];
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
    {
      "name": "John Doe",
      "phone": "123-456-7890",
      "email": "john@example.com"
    },
    {
      "name": "Jane Smith",
      "phone": "098-765-4321",
      "email": "jane@example.com"
    },
    {
      "name": "Bob Wilson",
      "phone": "555-555-5555",
      "email": "bob@example.com"
    }
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
double calculateMonthlyPaymentSolution({
  required double loanAmount,
  required double annualInterestRate,
  required int loanTermInYears
}) {
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
  
  BankAccountSolution(this.accountNumber, this.accountHolder, [this.balance = 0.0]);
  
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
    loanAmount: 100000,
    annualInterestRate: 5.0,
    loanTermInYears: 30
  );
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
