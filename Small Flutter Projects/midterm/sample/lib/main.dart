import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Midterm',
      theme: ThemeData(
        primaryColor: Colors.brown,
        backgroundColor: Color.fromARGB(255, 240, 230, 198),
        bottomAppBarColor: Color.fromARGB(255, 245, 217, 135),
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  //const MyHomePage({super.key, required this.title});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).backgroundColor,
      appBar: AppBar(
        title: Text("BOOKS"),
        leading: Icon(Icons.book),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.count(
          crossAxisSpacing: 7.7,
          mainAxisSpacing: 1.5,
          crossAxisCount: 2,
          children: DUMMY_CATEGORIES.map((cat) {
            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Books(
                              CatId: cat.id,
                            )));
              },
              child: Container(
                margin: EdgeInsets.symmetric(vertical: 15),
                decoration: BoxDecoration(
                  color: cat.color,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Center(
                    child: Text(
                  cat.title,
                  style: TextStyle(
                      color: Colors.white,
                      fontStyle: FontStyle.normal,
                      fontWeight: FontWeight.bold,
                      fontSize: 25),
                )),
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}

class Books extends StatefulWidget {
  //const Books({super.key});
  final String CatId;

  const Books({super.key, required this.CatId});
  @override
  State<Books> createState() => _BooksState(CatId);
}

class _BooksState extends State<Books> {
  final String CatID;
  void addBook(String title) {}
  var titlecontroller = TextEditingController();

  void showAddBook() {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return Scaffold(
            body: Column(
              children: [
                TextField(
                  decoration: InputDecoration(
                      hintText: "Title",
                      labelText: 'Name of Book',
                      border: OutlineInputBorder()),
                  onChanged: (name) {
                    setState(() {
                      titlecontroller.text = name;
                    });
                  },
                ),
                Row(
                  children: [
                    Expanded(flex: 3, child: SizedBox()),
                    Expanded(
                      flex: 1,
                      child: TextButton(
                          onPressed: (() {
                            setState(() {
                              String id =
                                  "b" + (DUMMY_BOOKS.length + 1).toString();
                              DUMMY_BOOKS.add(Book(
                                id: id,
                                title: titlecontroller.text,
                                categories: [CatID],
                              ));
                            });
                            Navigator.of(context).pop();
                          }),
                          child: Text("Add")),
                    ),
                  ],
                )
              ],
            ),
          );
        });
  }

  List<Book> get newbooks {
    List<Book> DummyList = [];
    for (int i = 0; i < DUMMY_BOOKS.length; i++) {
      if (DUMMY_BOOKS[i].categories.contains(CatID)) {
        DummyList.add(DUMMY_BOOKS[i]);
      }
    }
    return DummyList;
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    if (_selectedIndex == 1) {
      showAddBook();
    } else {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    }
  }

  _BooksState(this.CatID);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Self-Help"),
        backgroundColor: Theme.of(context).primaryColor,
      ),
      backgroundColor: Theme.of(context).backgroundColor,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).bottomAppBarColor,
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.brown,
            icon: Icon(Icons.add),
            label: 'Add',
          ),
        ],
      ),
      body: ListView.builder(
          itemCount: newbooks.length,
          addRepaintBoundaries: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              padding: EdgeInsets.only(bottom: 2),
              margin: EdgeInsets.all(12),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    blurRadius: 2.0,
                    spreadRadius: 1.0,
                    offset: Offset(0.0, 10.0), // shadow direction: bottom right
                  )
                ],
              ),
              child: Center(
                  child: Text(
                newbooks[index].title,
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              )),
            );
          }),
    );
  }
}

class Category {
  final String id;
  final String title;
  final Color color;

  Category({required this.id, required this.title, required this.color});
}

class Book {
  final String id;
  final List<String> categories;
  final String title;

  Book({required this.id, required this.categories, required this.title});
}

List<Category> DUMMY_CATEGORIES = [
  Category(
    id: 'c1',
    title: 'Literature',
    color: Colors.purple,
  ),
  Category(
    id: 'c2',
    title: 'Self-Help',
    color: Colors.red,
  ),
  Category(
    id: 'c3',
    title: 'Horror',
    color: Colors.orange,
  ),
  Category(
    id: 'c4',
    title: 'History',
    color: Colors.amber,
  ),
  Category(
    id: 'c5',
    title: 'Mysteries',
    color: Colors.blue,
  ),
  Category(
    id: 'c6',
    title: 'Romance',
    color: Colors.green,
  ),
  Category(
    id: 'c7',
    title: 'Westerns',
    color: Colors.lightBlue,
  ),
  Category(
    id: 'c8',
    title: 'Comics',
    color: Colors.lightGreen,
  ),
  Category(
    id: 'c9',
    title: 'Health anf Fitness',
    color: Colors.pink,
  ),
  Category(
    id: 'c10',
    title: 'Hobbies and Crafts',
    color: Colors.teal,
  ),
  Category(
    id: 'c11',
    title: 'Religion',
    color: Colors.purpleAccent,
  ),
  Category(
    id: 'c12',
    title: 'Science Fiction (Sci-Fi)',
    color: Colors.cyanAccent,
  ),
  Category(
    id: 'c13',
    title: 'Short Stories',
    color: Colors.pink,
  ),
  Category(
    id: 'c14',
    title: 'Suspense and Thrillers',
    color: Colors.amber,
  ),
  Category(
    id: 'c15',
    title: 'Home and Garden',
    color: Colors.black12,
  ),
  Category(
    id: 'c16',
    title: 'Medical',
    color: Colors.teal,
  ),
  Category(
    id: 'c17',
    title: 'Parenting',
    color: Colors.pink,
  ),
];

final DUMMY_BOOKS = [
  Book(
    id: 'b1',
    categories: [
      'c1',
      'c3',
    ],
    title: 'Treasure Island -  Robert Louis Stevenson',
  ),
  Book(
    id: 'b2',
    categories: [
      'c1',
    ],
    title: 'Little Women and Other Novels - Louisa May Alcott',
  ),
  Book(
    id: 'b3',
    categories: [
      'c1',
    ],
    title: 'Frankenstein - Mary Shelley',
  ),
  Book(
    id: 'b4',
    categories: [
      'c1',
    ],
    title: 'To Kill a Mockingbird - Harper Lee',
  ),
  Book(
    id: 'b5',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b6',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b7',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b8',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b9',
    categories: [
      'c1',
    ],
    title: 'Pride and Prejudice - Jane Austen',
  ),
  Book(
    id: 'b10',
    categories: [
      'c2',
    ],
    title: 'The Alchemist by Paulo Coelho',
  ),
  Book(
    id: 'b11',
    categories: [
      'c2',
    ],
    title: 'Atomic Habits by James Clear',
  ),
  Book(
    id: 'b12',
    categories: [
      'c2',
    ],
    title: 'Thinking Fast And Slow by Daniel Kahneman',
  ),
  Book(
    id: 'b13',
    categories: [
      'c2',
    ],
    title: 'The Four Agreements by Don Miguel Ruiz',
  ),
  Book(
    id: 'b14',
    categories: [
      'c2',
    ],
    title: 'The 7 Habits Of Highly Effective People by Stephen R. Covey',
  ),
  Book(
    id: 'b15',
    categories: [
      'c2',
    ],
    title: 'Best Self by Mike Bayer',
  ),
  Book(
    id: 'b16',
    categories: [
      'c2',
    ],
    title:
        'The Subtle Art of Not Giving a F*ck by Mark Manson Best Self Help Books for Women',
  ),
  Book(
    id: 'b17',
    categories: [
      'c2',
    ],
    title: 'Girl, Wash Your Face by Rachel Hollis',
  ),
  Book(
    id: 'b18',
    categories: [
      'c2',
    ],
    title: '12 Rules For Life by Jordan Peterson',
  ),
  Book(
    id: 'b19',
    categories: [
      'c2',
    ],
    title: 'Big Magic by Elizabeth Gilbert',
  ),
];
