

String getLetterGrade(int score) {
  // Your if/else if/else logic for grades goes here
  if (score >= 90) return 'A';
  else if (score >= 80) return 'B';
  else if (score >= 70) return 'C';
  else if (score >= 60) return 'D';
  else if (score < 60) return 'F';


  return 'N/A'; // Default return
}

void main() {
  var students = [
    {'name': 'Alice', 'score': 88},
    {'name': 'Bob', 'score': 92},
    {'name': 'Charlie', 'score': 74},
    {'name': 'David', 'score': 59},
    {'name': 'Eve', 'score': 68}
  ];

  print('--- Student Report Card ---');
  // Your loop to process students goes here
  // Inside the loop, call getLetterGrade and print the result
  for (var student in students){
    print('${student['name']}: ${getLetterGrade(student['score'] as int)} ');
  }
}