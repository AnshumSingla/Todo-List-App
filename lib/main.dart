import 'package:flutter/material.dart';
import 'taskpage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: landingPage(),
    );
  }
}

class landingPage extends StatefulWidget {
  const landingPage({super.key});

  @override
  State<landingPage> createState() => _landingPageState();
}

class _landingPageState extends State<landingPage> {
  int count = 0;
  List<String> titles = [];
  List<bool> isChecked = [];

  void sortTasks() {
    for (int i = 0; i < isChecked.length; i++) {
      if (isChecked[i]) {
        bool tempcheck = isChecked[i];
        String temptitle = titles[i];
        isChecked.remove(isChecked[i]);
        isChecked.add(tempcheck);
        titles.remove(titles[i]);
        titles.add(temptitle);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color.fromARGB(171, 0, 0, 0),
        title: const Text(
          'Tasks',
          style: TextStyle(color: Colors.white),
        ),
      ),
      backgroundColor: const Color.fromRGBO(89, 89, 89, 1),
      body: Center(
        child: SizedBox(
          height: double.infinity,
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1, // Number of items per row
                      mainAxisSpacing: 10, // Spacing between rows
                      crossAxisSpacing: 10, // Spacing between columns
                      childAspectRatio: 8, // Aspect ratio of grid items
                    ),
                    itemCount: count,
                    itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () async {
                          final updatedTitle = await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => taskPage(
                                taskName: titles[index],
                              ),
                            ),
                          );
                          if (updatedTitle != 'Untitled') {
                            setState(() {
                              titles[index] = updatedTitle;
                            });
                          }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 44, 44, 44),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color: Colors.grey,
                            ),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 20),
                                  child: !isChecked[index]
                                      ? Text(
                                          titles[index],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        )
                                      : Text(
                                          titles[index],
                                          style: const TextStyle(
                                            fontSize: 18,
                                            decoration:
                                                TextDecoration.lineThrough,
                                            decorationThickness: 2,
                                            decorationColor: Colors.white,
                                            color: Color.fromRGBO(
                                                255, 255, 255, 1),
                                          ),
                                        ),
                                ),
                              ),
                              Expanded(
                                flex: 0,
                                child: Checkbox(
                                  value: isChecked[index],
                                  onChanged: (bool? newValue) {
                                    setState(() {
                                      isChecked[index] = newValue ?? false;
                                      sortTasks();
                                    });
                                  },
                                ),
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    shape: const CircleBorder(),
                    padding: const EdgeInsets.all(20),
                  ),
                  onPressed: () {
                    setState(() {
                      count += 1;
                      titles.add('Untitled');
                      isChecked.add(false);
                    });
                  },
                  child: const Icon(Icons.add),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
