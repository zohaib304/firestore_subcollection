import 'package:flutte_subcollection/subject.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Sub Collection Demo"),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
            // Initialize FlutterFire:
            stream: FirebaseFirestore.instance.collection('users').snapshots(),
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                final List<DocumentSnapshot> doc = snapshot.data.docs;
                return new ListView.builder(
                    itemCount: doc.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            // print(doc[index].id);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => Subjects(
                                  docId: doc[index].id,
                                ),
                              ),
                            );
                          },
                          child: Card(
                            child: Column(
                              children: <Widget>[
                                Text(doc[index]['firstname']),
                                SizedBox(
                                  height: 10.0,
                                ),
                                Text(doc[index]['lastname']),
                              ],
                            ),
                          ),
                        ),
                      );
                    });
              } else {
                return LinearProgressIndicator();
              }
            }),
      ),
    );
  }
}
