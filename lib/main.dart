import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  theme: ThemeData(
    brightness: Brightness.light,
    primaryColor: Colors.blue,
    accentColor: Colors.cyan
  ),
  home: MyApp(), 
));

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String studentName, studentID, studyProgramID;
  double studentGPA;

  getStudentName(name) {
    this.studentName = name;
  }

  getStudentID(id){
    this.studentID = id;
  }

  getStudyProgramID(programID){
    this.studyProgramID = programID;
  }  

  getStudentGPA(gpa){
    this.studentGPA = double.parse(gpa);
  }

  createData(){
    print("created");

    DocumentReference documentReference = 
    Firestore.instance.collection("MyStudents").
    document(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };

    documentReference.setData(students).whenComplete(() {
      print("$studentName created");
    });
  }

  readData(){
    DocumentReference documentReference = 
    Firestore.instance.collection("MyStudents").document(studentName);

    documentReference.get().then((datasnapshot){
      print(datasnapshot.data["studentName"]);
      print(datasnapshot.data["studentID"]);
      print(datasnapshot.data["studyProgramID"]);
      print(datasnapshot.data["studentGPA"]);
    });
  }

  updateData(){
    print("updated");

    DocumentReference documentReference = 
    Firestore.instance.collection("MyStudents").
    document(studentName);

    Map<String, dynamic> students = {
      "studentName": studentName,
      "studentID": studentID,
      "studyProgramID": studyProgramID,
      "studentGPA": studentGPA
    };

    documentReference.setData(students).whenComplete(() {
      print("$studentName updated");
    });
  }

  deleteData(){
    DocumentReference documentReference =
    Firestore.instance.collection("MyStudents").document(studentName);

    documentReference.delete().whenComplete(() {
      print("$studentName deleted");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My Flutter Campus"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Name",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0)
                  )
                ),
                onChanged: (String name){
                  getStudentName(name);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Student ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0)
                  )
                ),
                onChanged: (String id){
                  getStudentID(id);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "Study Program ID",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0)
                  )
                ),
                onChanged: (String programID){
                  getStudyProgramID(programID);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0),
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: "GPA",
                  fillColor: Colors.white,
                  focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.blue,
                    width: 2.0)
                  )
                ),
                onChanged: (String gpa){
                  getStudentGPA(gpa);
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                RaisedButton(
                  color: Colors.green,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("Create"),
                  textColor: Colors.white,
                  onPressed: (){
                    createData();
                  },
                ),
                RaisedButton(
                  color: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("Read"),
                  textColor: Colors.white,
                  onPressed: (){
                    readData();
                  },
                ),
                RaisedButton(
                  color: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("Update"),
                  textColor: Colors.white,
                  onPressed: (){
                    updateData();
                  },
                ),
                RaisedButton(
                  color: Colors.red,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16)
                  ),
                  child: Text("Delete"),
                  textColor: Colors.white,
                  onPressed: (){
                    deleteData();
                  },
                )
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10, top: 20),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Text("Name", style: TextStyle(fontWeight: FontWeight.w800),),),
                  Expanded(
                    child: Text("Student ID", style: TextStyle(fontWeight: FontWeight.w800),)),
                  Expanded(
                    child: Text("Program ID", style: TextStyle(fontWeight: FontWeight.w800),)),
                  Expanded(
                    child: Text("GPA", style: TextStyle(fontWeight: FontWeight.w800),))
              ],),
            ),
            StreamBuilder(
              stream: Firestore.instance.collection("MyStudents").snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index){
                     DocumentSnapshot documentSnapshot = snapshot.data.documents[index];
                     return Row(
                       children: <Widget>[
                         Expanded(
                           child: 
                           Text(documentSnapshot
                           ["studentName"]),
                         ),
                         Expanded(
                           child: Text(documentSnapshot
                           ["studentID"]),
                         ),
                         Expanded(
                           child: Text(documentSnapshot
                           ["studyProgramID"]),
                         ),
                         Expanded(
                           child: Text(documentSnapshot
                           ["studentGPA"].toString()),
                         )
                       ],
                     );
                    }
                  );
                }
                else {
                  return Align(
                    alignment: FractionalOffset.bottomCenter,
                    child: CircularProgressIndicator(),
                  );
                }
              }
            )
          ],
        ),
      ),
    );
  }
}