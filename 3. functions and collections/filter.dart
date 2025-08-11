// The function signature you need to implement
void printFilteredUsers(List<Map<String, dynamic>> users, int minAge) {
  // Your filtering logic goes here
  for (Map<String, dynamic> user in users) {
    if (user['age'] >= minAge){
      print(user['name']);
    }
    
  }
}

void main() {
  // Your list of users
  var userList = [
    {'name': 'Alice', 'age': 25},
    {'name': 'Bob', 'age': 32},
    {'name': 'Charlie', 'age': 19},
    {'name': 'David', 'age': 45},
    {'name': 'Eve', 'age': 30}
  ];

  print('Users 30 and older:');
  // Call your function here with a minAge of 30
  printFilteredUsers(userList, 30);
}