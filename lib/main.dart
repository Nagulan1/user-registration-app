import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'display_data.dart'; 

    final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MaterialApp(
     navigatorKey: navigatorKey,
    home: MembershipApp(),
  ));
}

class MembershipApp extends StatefulWidget {
  @override
  _MembershipAppState createState() => _MembershipAppState();
}

class _MembershipAppState extends State<MembershipApp> {

  Color _backgroundColor = Colors.white; 
  String _selectedGender = '';
  bool _isChecked = false;
   final TextEditingController fullNameController = TextEditingController();
  final TextEditingController currentWeightController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController goalWeightController = TextEditingController();
  final TextEditingController ageController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController addressController = TextEditingController();


  void _changeBackgroundColor(Color color) {
    setState(() {
      _backgroundColor = color;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: _backgroundColor,
        appBar: AppBar(
          title: Text("Membership Form"),
          actions: [
            PopupMenuButton<Color>(
              onSelected: _changeBackgroundColor,
              itemBuilder: (BuildContext context) {
                return <PopupMenuEntry<Color>>[
                  PopupMenuItem<Color>(
                    value: Colors.red,
                    child: Text('Red'),
                  ),
                  PopupMenuItem<Color>(
                    value: Colors.green,
                    child: Text('Green'),
                  ),
                  PopupMenuItem<Color>(
                    value: Colors.yellow,
                    child: Text('Yellow'),
                  ),
                  PopupMenuItem<Color>(
                    value: Colors.blue,
                    child: Text('Blue'),
                  ),
                ];
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              TextFormField(
                  controller: fullNameController,
                decoration: InputDecoration(
                  labelText: 'Full Name',
                  icon: Icon(Icons.person),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Text('Gender: ', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Radio(
                    value: 'Male',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  Text('Male', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  Radio(
                    value: 'Female',
                    groupValue: _selectedGender,
                    onChanged: (value) {
                      setState(() {
                        _selectedGender = value!;
                      });
                    },
                  ),
                  Text('Female', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                ],
              ),
               TextFormField(
                controller: currentWeightController,
                decoration: InputDecoration(
                  labelText: 'Current Weight',
                  icon: Icon(Icons.fitness_center),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: heightController,
                decoration: InputDecoration(
                  labelText: 'Height',
                  icon: Icon(Icons.height),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: goalWeightController,
                decoration: InputDecoration(
                  labelText: 'Goal Weight',
                  icon: Icon(Icons.flag),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: ageController,
                decoration: InputDecoration(
                  labelText: 'Age',
                  icon: Icon(Icons.accessibility_new),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: phoneController,
                decoration: InputDecoration(
                  labelText: 'Phone',
                  icon: Icon(Icons.phone),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              TextFormField(
                controller: addressController,
                decoration: InputDecoration(
                  labelText: 'Address',
                  icon: Icon(Icons.location_on),
                ),
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              Row(
                children: <Widget>[
                  Checkbox(
                    value: _isChecked,
                    onChanged: (value) {
                      setState(() {
                        _isChecked = value!;
                      });
                    },
                  ),
                  Text(
                    'I have read and understood',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
              
              ElevatedButton(
                onPressed: () async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    Map<String, dynamic> formData = {
      'fullName': fullNameController.text,
      'gender': _selectedGender,
      'currentWeight': currentWeightController.text,
      'height': heightController.text,
      'goalWeight': goalWeightController.text,
      'age': ageController.text,
      'phone': phoneController.text,
      'address': addressController.text,
      'readAndUnderstood': _isChecked,
    };

    await firestore.collection('membership_data').add(formData);

    // Clear the text fields after submission
    fullNameController.clear();
    currentWeightController.clear();
    heightController.clear();
    goalWeightController.clear();
    ageController.clear();
    phoneController.clear();
    addressController.clear();
  print('registration successfull');
    

navigatorKey.currentState!.push(
  MaterialPageRoute(builder: (context) => DisplayDataPage()),
);
                },
                child: Text('Submit', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}



