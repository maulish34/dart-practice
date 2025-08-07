//Task 1 – Inheritance:
// Create a Dart programme that defines a base class called Vehicle with the following:

// A property make (a String) indicating the manufacturer.
// A method startEngine() that prints a message indicating the engine has started.
// Then create a subclass called ElectricCar that:

// Inherits from Vehicle.
// Overrides startEngine() to print a message indicating that the engine starts silently.




class Vehicle {
 String make;
 
 Vehicle(this.make);
 
 void startEngine(){
   print("Grrrr The engine has started!");
 }
 
}

class ElectricCar extends Vehicle{
  ElectricCar(String make): super(make);
  
  @override
  void startEngine(){
    print('There is no engine because this car is gay so no sound :(');
  }
}

//Task 2 – Interfaces:
//Write a Dart programme that creates an abstract class called Playable with a method play().
//Then, create a class Guitar that implements Playable and prints a message that the guitar is being played.
// Also, create a class Piano that implements Playable and prints a message that the piano is being played.

abstract class Playable {
  void play();
}


class Guitar implements Playable{
  
  @override
  void play(){
    print('The guitar is being played');
  }
}


class Piano implements Playable{
  @override
  void play(){
    print('The piano is being played');
  }
}

//Task 3 – Asynchronous Programming:
// Write a Dart programme that:

// Defines an asynchronous function called simulateNetworkCall() that waits for 3 seconds (using Future.delayed)
// and then returns a message such as "Network call completed".
// In the main() function, call this asynchronous function and print the returned message.


Future<String> fetchData() async {
  await Future.delayed(Duration(seconds: 3));
  return "Network call completed";
}


void main () {

  ElectricCar tesla = new ElectricCar('Tesla');
  tesla.startEngine();

  //--------------------------------------------------------------------------------------

  Guitar guitar = new Guitar();
  Piano piano = new Piano();
    
  guitar.play();
  piano.play();

  //--------------------------------------------------------------------------------------
  print("Requesting network call...");
  fetchData().then((message) {
    print(message);
  });


}