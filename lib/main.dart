import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          // This is the theme of your application.
          //
          // Try running your application with "flutter run". You'll see the
          // application has a blue toolbar. Then, without quitting the app, try
          // changing the primarySwatch below to Colors.green and then invoke
          // "hot reload" (press "r" in the console where you ran "flutter run",
          // or simply save your changes to "hot reload" in a Flutter IDE).
          // Notice that the counter didn't reset back to zero; the application
          // is not restarted.
          primarySwatch: Colors.blue,
          // This makes the visual density adapt to the platform that you run
          // the app on. For desktop platforms, the controls will be smaller and
          // closer together (more dense) than on mobile platforms.
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        home: TodoApp());
  }
}

class TodoApp extends StatefulWidget {
  @override
  _TodoAppState createState() => _TodoAppState();
}

class _TodoAppState extends State<TodoApp> {
  List a = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text("Todo App"),
        ),
        floatingActionButton: FloatingActionButton(
          child: Text("+", style: TextStyle(fontSize: 20)),
          onPressed: () {
            showMyDialog();
          },
        ),
        body: ListView.builder(
          shrinkWrap: true,
          itemCount: a.length,
          itemBuilder: (BuildContext, index) {
            return Dismissible(
              onDismissed: (DismissDirection direction) {
                setState(() {
                  a.removeAt(index);
                });
              },
              secondaryBackground: Container(
                child: Center(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                color: Colors.red,
              ),
              background: Container(),
              key: UniqueKey(),
              direction: DismissDirection.endToStart,
              child: ListTile(
                title: Text(a[index]),
              ),
            );
          },
        ));
  }

  Future<void> showMyDialog() async {
    TextEditingController textEditingController = TextEditingController();
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add'),
          content: SingleChildScrollView(
            child: Form(
              child: Column(
                children: <Widget>[
                  TextFormField(
                    validator: (val) {
                      if (val == null) {
                        return "Enter something";
                      } else {
                        return null;
                      }
                    },
                    controller: textEditingController,
                  )
                ],
              ),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                a.add(textEditingController.text);
                setState(() {});
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
