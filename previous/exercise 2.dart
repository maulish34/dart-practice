

// Task 1:  Write a Dart programme that defines a class called Student with the following:

// Properties:

// name (a String)
// grade (an int)
// Methods:

// greet(): Prints a greeting message that includes the student's name.
// passCheck(): Checks if the student passed the exam. (Consider a grade of 50 or above as passing; otherwise, print that the student has failed.)

// class Student {
//   String name;
//   int grade;
//   Student(this.name, this.grade);
  
//   void greet(){
//     print('Hello, my name is $name');
//   }
  
//   void passCheck(){
//     String pass = (grade >= 50) ? 'passed' : 'failed';
//     print('$name has $pass the exam!');
    
//   }
// }

//Task 2:
class Student {
  String name;
  String subject;
  int grade;
  
  
  Student(this.name, this.subject, this.grade);
  
  void greet(){
    print('Hello, my name is $name');
  }
  
  void passCheck(){
    String pass = (grade >= 50) ? 'passed' : 'failed';
    print('$name has $pass the exam!');
    
  }
  
  void displayProfile() {
    print('Name: $name, Grade: $grade%, Subject: subject');
  }
  
}

void main() {
  //task 1: 
  Student maulish = Student('Maulish', 'Maths', 90);
  maulish.greet();
  maulish.passCheck();
}
