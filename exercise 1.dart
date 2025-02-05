// Excercise 1 

void main () {
  
// Task 2: 
  var favColour = 'blue';
  final year = 21;
  
  print('my favourite colour is $favColour and my current year is $year.');

  //--------------------------------------------------------------------------------------
  //Task 3: Create a programme that uses a for loop to print the even numbers from 2 to 10.
    for(var i = 1; i<=10; i++) {
    if(i%2 ==0) {
      print(i);
    }
  }

  //--------------------------------------------------------------------------------------
  // Task 4: Write a programme that creates a list of your top three favourite foods. Use a loop to print each food item.
  List<String> favFoods = ['Dum Paneer Biryani', 'Chat', 'Lasaniya Bataka'];
  for(var food in favFoods) {
    print(food);  
  }

  //--------------------------------------------------------------------------------------
  // Taskl 5: Create a function called multiply that takes two numbers as parameters and returns their product. Then, call this function in the main() function and print the result.
  int multiply (int a, int b){
    return a*b;
  }

}


