import 'dart:async';
import 'dart:io';
import 'package:nanoid/nanoid.dart';

/*
Objective

Create a command-line application to manage a small library. The system should be able to register members, add books, and handle 
the process of members borrowing and returning books. It must track the status of each book and handle various error conditions gracefully.

Core Requirements
Model the Core Entities:

Create an abstract class named LibraryItem with properties like id (a unique String) and title.
Create a Book class that extends LibraryItem and adds properties like author and isbn.
Create a Member class with properties for name, memberId, and a List<LibraryItem> to keep track of the items they have currently borrowed.

Create the Library "Controller":
Create a Library class that will manage the entire system.
It should contain the collections to hold the library's state:
  A collection of all library items (e.g., Map<String, LibraryItem>).
  A collection of all registered members (e.g., Map<String, Member>).
  A collection to track which items are currently checked out (e.g., Map<String, String> mapping an item id to a member id).
This class will have the main logic methods.

Implement Core Logic Methods:
The Library class should have the following async methods. Each method should simulate a database update with a Future.delayed of 1-2 seconds.

Future<void> borrowItem(String memberId, String itemId):
This must perform several checks and throw specific Exceptions for failure cases:
  Does the member exist?
  Does the item exist?
  Is the item already checked out by someone else?
On success, it should record that the item is now borrowed by that member.

Future<void> returnItem(String memberId, String itemId):
This must also perform checks:
  Does the item exist?
  Is the item currently checked out by this specific member?
On success, it should update the state to show the item is now available.

The Main Program Loop:
Your async main function will be the user interface.
Create an instance of your Library and pre-populate it with a few books and members.
Create a while (true) loop that presents a menu of options to the user, such as:
  View all books
  View all members
  Borrow a book
  Return a book
  View member's borrowed books
  Exit

All calls to your borrowItem and returnItem methods must be wrapped in try-catch blocks to handle the expected errors and display user-friendly messages without crashing.
*/

abstract class LibraryItem {
  final String id = nanoid();
  final String title;

  LibraryItem({required this.title});
}

class Book extends LibraryItem {
  final String author;
  final String isbn;
  bool _available = true;

  Book({
    required String title,
    required this.author,
    required this.isbn,
    bool available = true,
  }) : _available = available,
       super(title: title);

  bool get available => _available;

  void setAvailable(bool availability) {
    _available = availability;
  }

  @override
  String toString() {
    return 'Book(id: $id, title: $title, author: $author, available: $available)';
  }
}

class Member {
  final String name;
  final String memberId = nanoid();
  List<LibraryItem>? liblist;

  Member({required this.name, List<LibraryItem>? liblist})
    : liblist = liblist ?? [];
}

class Library {
  Map<String, LibraryItem> items;
  Map<String, Member> members;
  Map<String, String>? borrowlist;

  Library({
    required this.items,
    required this.members,
    Map<String, String>? borrowlist,
  }) : borrowlist = Map.from(borrowlist ?? {});

  void printMemberList() {
    if (this.members.isEmpty) throw Exception('No Members found.');
    this.members.forEach((key, value) {
      print('${value.name}, id: ${value.memberId}');
    });
  }

  void printBookList() {
    if (this.items.isEmpty) throw Exception('No Books found.');
    this.items.forEach((key, value) {
      print('${value.toString()}');
    });
  }

  void addBook(String title, String author, String isbn, String available) {
    bool isAvailable;
    if (available == 'true') {
      isAvailable = true;
    } else if (available == 'false') {
      isAvailable = false;
    } else {
      throw Exception('Incorrect input for availability, try again.');
    }
    Book book = Book(
      author: author,
      title: title,
      isbn: isbn,
      available: isAvailable,
    );
    this.items[book.id] = book;
    if (this.items.containsKey(book.id)) {
      print('${book.title} added successfully!');
    } else {
      throw Exception('Unidentified error adding book, please try again.');
    }
  }

  void addMember(String name, List<LibraryItem>? liblist) {
    Member member = Member(
      name: name,
      liblist: liblist != null ? liblist : [],
    );
    this.members[member.memberId] = member;
    if (this.members.containsKey(member.memberId)) {
      print('${member.name} added successfully!');
    } else {
      throw Exception('Unexpected error adding member, please try again.');
    }
  }

  Future<void> borrowItem(String memberId, String itemId) async {
    if (!this.members.containsKey(memberId))
      throw Exception('Member: $memberId not found, try again.');
    LibraryItem? item = this.items[itemId];
    if (item == null) {
      print('Item with ID "$itemId" not found.');
      return;
    }
    if (item is Book) {
      Book book = item;
      if (!book.available)
        throw Exception(
          'Book $itemId, ${book.title} is currently not avaialble',
        );
      await Future.delayed(const Duration(seconds: 1));
      this.borrowlist?[itemId] = memberId;
      this.members[memberId]!.liblist?.add(book);
      book.setAvailable(false);
      print('Book issued successfully!');
    } else {
      throw Exception(
        'Item with ID "$itemId" is not a book and cannot be borrowed in this way.',
      );
    }
  }

  Future<void> returnItem(String memberId, String itemId) async {
    if (!this.members.containsKey(memberId))
      throw Exception('Member: $memberId not found, try again.');

    LibraryItem? item = this.items[itemId];
    if (item == null) {
      throw Exception('Book $itemId not found in database');
    }

    if (item is Book) {
      Book book = item;
      if (this.borrowlist![itemId] == memberId) {
        await Future.delayed(const Duration(seconds: 2));
        this.borrowlist!.remove(itemId);
        this.members[memberId]!.liblist!.remove(book);
        book.setAvailable(true);
        print('Book returned successfully!; Now available to other members.');
      } else {
        throw Exception(
          'Book: ${book.id}, ${book.title} not issued by member $memberId, ${this.members[memberId]!.name}',
        );
      }
    } else {
      throw Exception('Unexpected error. Selected item is not a Book.');
    }
  }

  Future<void> viewIssuedBooksByMember(String memberId) async {
    if (this.members.containsKey(memberId)) {
      if (this.members[memberId]!.liblist!.isEmpty) {
        print('Member has no items borrowed currently');
      } else {
        for (LibraryItem item in this.members[memberId]!.liblist!) {
          print(item.toString());
        }
      }
    } else {
      throw Exception('No member found with id: $memberId. Please try again.');
    }
  }
}

void main() async {
  final book1 = Book(
    title: "To Kill a Mockingbird",
    author: "Harper Lee",
    isbn: "978-0061120084",
  );
  final book2 = Book(
    title: "Dune",
    author: "Frank Herbert",
    isbn: "978-0340960196",
  );
  final book3 = Book(
    title: "Sapiens: A Brief History of Humankind",
    author: "Yuval Noah Harari",
    isbn: "978-0062316097",
  );

  final member1 = Member(name: "John Doe");
  final member2 = Member(name: "Jane Smith");

  final Map<String, LibraryItem> libraryItems = {
    book1.id: book1,
    book2.id: book2,
    book3.id: book3,
  };

  final Map<String, Member> libraryMembers = {
    member1.memberId: member1,
    member2.memberId: member2,
  };

  Library library = Library(items: libraryItems, members: libraryMembers);

  print('Welcome to the Library');

  while (true) {
    print('''


      Select one of the following options:

      1. View all books
      2. View all members
      3. Borrow a book
      4. Return a book
      5. View a member's borrowed books
      6. Add a book
      7. Add a member
      8. Exit
    ''');

    stdout.write('Enter option: ');
    final option = stdin.readLineSync();

    switch (option) {
      case '1':
        library.printBookList();
        break;
      case '2':
        library.printMemberList();
        break;
      case '3':
        stdout.write('enter member id: ');
        final memberId = stdin.readLineSync();
        stdout.write('Enter book id: ');
        final itemId = stdin.readLineSync();
        if (memberId == null ||
            itemId == null ||
            memberId.isEmpty ||
            itemId.isEmpty) {
          print('member ID or Item ID cannot be empty. Try again.');
          continue;
        }

        try {
          await library.borrowItem(memberId, itemId);
        } catch (e) {
          print('$e');
        }
        break;

      case '4':
        stdout.write('enter member id: ');
        final memberId = stdin.readLineSync();
        stdout.write('Enter book id:');
        final itemId = stdin.readLineSync();
        if (memberId == null ||
            itemId == null ||
            memberId.isEmpty ||
            itemId.isEmpty) {
          print('member ID or Item ID cannot be empty. Try again.');
          continue;
        }
        try {
          await library.returnItem(memberId, itemId);
        } catch (e) {
          print('$e');
        }
        break;
      case '5':
        stdout.write('Enter member id: ');
        final memberId = stdin.readLineSync();
        if (memberId == null || memberId.isEmpty) {
          print('Member ID cannot be empty');
          continue;
        }
        try {
          await library.viewIssuedBooksByMember(memberId);
        } catch (e) {
          print(e);
        }
      case '6':
        stdout.write('Enter book title: ');
        final title = stdin.readLineSync();
        stdout.write('Enter book author: ');
        final author = stdin.readLineSync();
        stdout.write('Enter book ISBN: ');
        final isbn = stdin.readLineSync();
        stdout.write('Is the book available? (true/false): ');
        final isAvailableInput = stdin.readLineSync();
        

        if (title == null ||
            author == null ||
            isbn == null ||
            isAvailableInput == null ||
            title.isEmpty ||
            author.isEmpty ||
            isbn.isEmpty ||
            isAvailableInput.isEmpty) {
          print('All fields are required. Please try again.');
          continue;
        }
        try{
          library.addBook(title, author, isbn, isAvailableInput);
        } catch (e) {
          print('$e');
        }
      case '7':
        stdout.write('Enter member name: ');
        final name = stdin.readLineSync();
        if (name == null || name.isEmpty) {
          print('Member name cannot be empty. Please try again.');
          continue;
        }
        try {
          library.addMember(name, null);
        } catch (e) {
          print('$e');
        }
        break;
      case '8':
        print('Exiting the library system. Goodbye!');
        return;

      default:
        print('Incorrect option. Please try again');
        break;
    }
  }
}


/*
The solution above works perfectly fine and achieves all the functionality. Below is a better, cleaner and more sophesticated version of the same.

import 'dart:async';
import 'dart:io';
// Note: You would need to add 'nanoid' to your pubspec.yaml file to run this.
// For simplicity, we'll just use a basic random generator here.
import 'dart:math';

String generateId() {
  // A simpler ID generator for this example without external packages.
  final random = Random();
  return random.nextInt(999999).toString().padLeft(6, '0');
}

// --- MODELS (The data classes) ---

abstract class LibraryItem {
  final String id = generateId();
  final String title;

  LibraryItem({required this.title});
}

class Book extends LibraryItem {
  final String author;
  final String isbn;

  Book({
    required String title,
    required this.author,
    required this.isbn,
  }) : super(title: title);

  @override
  String toString() {
    return 'Book(id: $id, title: "$title", author: $author)';
  }
}

class Member {
  final String name;
  final String memberId = generateId();
  List<LibraryItem> borrowedItems;

  Member({required this.name, List<LibraryItem>? borrowedItems})
      : this.borrowedItems = borrowedItems ?? [];
}

// --- CONTROLLER (The main logic hub) ---

class Library {
  Map<String, LibraryItem> items;
  Map<String, Member> members;
  // This map is the "single source of truth" for availability.
  // It maps an itemId to the memberId who has borrowed it.
  Map<String, String> checkedOutItems;

  Library({
    required this.items,
    required this.members,
    Map<String, String>? checkedOutItems,
  }) : this.checkedOutItems = checkedOutItems ?? {};

  bool isItemCheckedOut(String itemId) {
    return checkedOutItems.containsKey(itemId);
  }

  void addBook(String title, String author, String isbn) {
    final newBook = Book(title: title, author: author, isbn: isbn);
    items[newBook.id] = newBook;
    print('Added new book: $newBook');
  }

  void addMember(String name) {
    final newMember = Member(name: name);
    members[newMember.memberId] = newMember;
    print('Added new member: ${newMember.name} (ID: ${newMember.memberId})');
  }

  void printBookList() {
    if (items.isEmpty) {
      print('No books in the library.');
      return;
    }
    print("\n--- Library Books ---");
    items.values.forEach((item) {
      final availability = isItemCheckedOut(item.id) ? "Checked Out" : "Available";
      print('$item - Status: $availability');
    });
  }

  void printMemberList() {
    if (members.isEmpty) {
      print('No members registered.');
      return;
    }
    print("\n--- Library Members ---");
    members.values.forEach((member) {
      print(
          'Member: ${member.name}, ID: ${member.memberId}, Books Borrowed: ${member.borrowedItems.length}');
    });
  }

  void viewMemberBooks(String memberId) {
    if (!members.containsKey(memberId)) throw Exception('Member not found.');
    final member = members[memberId]!;
    if (member.borrowedItems.isEmpty) {
      print('${member.name} has no books currently borrowed.');
    } else {
      print("\n--- Books Borrowed by ${member.name} ---");
      for (final item in member.borrowedItems) {
        print(item);
      }
    }
  }

  Future<void> borrowItem(String memberId, String itemId) async {
    // Using Guard Clauses for safer, cleaner checks
    if (!members.containsKey(memberId)) throw Exception('Member not found.');
    if (!items.containsKey(itemId)) throw Exception('Item not found.');
    if (isItemCheckedOut(itemId)) throw Exception('Item is already checked out.');

    print('Processing borrow request...');
    await Future.delayed(const Duration(seconds: 1));

    // State mutations happen only after all checks pass
    checkedOutItems[itemId] = memberId;
    final member = members[memberId]!;
    final item = items[itemId]!;
    member.borrowedItems.add(item);
    
    print('"${item.title}" successfully borrowed by ${member.name}.');
  }

  Future<void> returnItem(String memberId, String itemId) async {
    // Guard Clauses
    if (!members.containsKey(memberId)) throw Exception('Member not found.');
    if (!items.containsKey(itemId)) throw Exception('Item not found.');
    if (!isItemCheckedOut(itemId)) throw Exception('This item is not currently checked out.');
    if (checkedOutItems[itemId] != memberId) throw Exception('This item was not borrowed by this member.');

    print('Processing return request...');
    await Future.delayed(const Duration(seconds: 1));

    // State mutations
    checkedOutItems.remove(itemId);
    final member = members[memberId]!;
    final item = items[itemId]!;
    member.borrowedItems.removeWhere((borrowedItem) => borrowedItem.id == itemId);

    print('"${item.title}" successfully returned by ${member.name}.');
  }
}

// --- MAIN (Application Entry Point) ---

Future<void> main() async {
  // --- Initial Data Setup ---
  final book1 = Book(title: "To Kill a Mockingbird", author: "Harper Lee", isbn: "978-0061120084");
  final book2 = Book(title: "Dune", author: "Frank Herbert", isbn: "978-0340960196");
  final member1 = Member(name: "John Doe");
  final member2 = Member(name: "Jane Smith");

  final libraryItems = {book1.id: book1, book2.id: book2};
  final libraryMembers = {member1.memberId: member1, member2.memberId: member2};

  final library = Library(items: libraryItems, members: libraryMembers);

  print('--- Welcome to the Dart Library System ---');

  while (true) {
    print('''

\nChoose an option:
1. View all books
2. View all members
3. Borrow a book
4. Return a book
5. View member's borrowed books
6. Add a new book
7. Add a new member
8. Exit''');

    stdout.write('Enter option: ');
    final option = stdin.readLineSync();

    try {
      switch (option) {
        case '1':
          library.printBookList();
          break;
        case '2':
          library.printMemberList();
          break;
        case '3':
          stdout.write('Enter your Member ID: ');
          final memberId = stdin.readLineSync() ?? "";
          stdout.write('Enter the ID of the book to borrow: ');
          final itemId = stdin.readLineSync() ?? "";
          await library.borrowItem(memberId, itemId);
          break;
        case '4':
          stdout.write('Enter your Member ID: ');
          final memberId = stdin.readLineSync() ?? "";
          stdout.write('Enter the ID of the book to return: ');
          final itemId = stdin.readLineSync() ?? "";
          await library.returnItem(memberId, itemId);
          break;
        case '5':
          stdout.write('Enter Member ID to view their books: ');
          final memberId = stdin.readLineSync() ?? "";
          library.viewMemberBooks(memberId);
          break;
        case '6':
          stdout.write('Enter book title: ');
          final title = stdin.readLineSync() ?? "";
          stdout.write('Enter book author: ');
          final author = stdin.readLineSync() ?? "";
          stdout.write('Enter book ISBN: ');
          final isbn = stdin.readLineSync() ?? "";
          library.addBook(title, author, isbn);
          break;
        case '7':
          stdout.write('Enter new member name: ');
          final name = stdin.readLineSync() ?? "";
          library.addMember(name);
          break;
        case '8':
          print('Exiting the library system. Goodbye!');
          return;
        default:
          print('Invalid option. Please try again.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
}
*/