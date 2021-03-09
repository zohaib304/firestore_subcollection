import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Subjects extends StatelessWidget {
  final docId;

  const Subjects({Key key, this.docId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(docId),
      ),
      body: Center(
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .doc(docId)
              .collection('subjects')
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data.docs;
              return new ListView.builder(
                itemCount: documents.length,
                itemBuilder: (context, index) {
                  List<dynamic> courses = documents[index]['courses'];
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: GestureDetector(
                      onTap: () {},
                      child: Card(
                        child: Column(
                          children: <Widget>[
                            Text(documents[index]['title']),
                            SizedBox(
                              height: 20,
                            ),
                            Text(documents[index]['color']),
                            // Text(courses[index]),
                            SizedBox(
                              height: 20,
                            ),
                            for (var i in courses) Text(i.toString())
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            }
            if (snapshot.hasError) {
              return Text('error');
            }
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
