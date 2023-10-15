import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class DisplayDataPage extends StatefulWidget {
  @override
  _DisplayDataPageState createState() => _DisplayDataPageState();
}

class _DisplayDataPageState extends State<DisplayDataPage> {
  
  List<Map<String, dynamic>> formDataList = [];

  @override
  void initState() {
    super.initState();
   
    fetchDataFromFirestore();
  }

  void fetchDataFromFirestore() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    QuerySnapshot querySnapshot = await firestore.collection('membership_data').get();

    List<Map<String, dynamic>> dataList = [];
    querySnapshot.docs.forEach((doc) {
      dataList.add(doc.data() as Map<String, dynamic>);
    });

    setState(() {
      formDataList = dataList;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Display Data'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            for (var formData in formDataList)
              Column(
                children: <Widget>[
                  Text('Full Name: ${formData['fullName']}'),
                  Text('Gender: ${formData['gender']}'),
                  Text('Current Weight: ${formData['currentWeight']}'),
                  Text('Height: ${formData['height']}'),
                  Text('Goal Weight: ${formData['goalWeight']}'),
                  Text('Age: ${formData['age']}'),
                  Text('Phone: ${formData['phone']}'),
                  Text('Address: ${formData['address']}'),
                  Text('Read and Understood: ${formData['readAndUnderstood']}'),
                  Divider(), 
                ],
              ),
          ],
        ),
      ),
    );
  }
}