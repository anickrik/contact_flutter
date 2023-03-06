import 'package:contacts_demo/view/components/app_drawer.dart';
import 'package:flutter/material.dart';

import '../../../data/local/sql_helper.dart';
import 'components/contact_row.dart';

class ContactListScreen extends StatefulWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}



List<Map<String, dynamic>> contacts = [];
List<ContactValue> contactsList = [];

bool isLoading = false;

class _ContactListScreenState extends State<ContactListScreen> {
  @override

  void initState() {
    // TODO: implement initState
    super.initState();
    refreshCategory();
  }

  void refreshCategory() async {
    final data = await SQLHelper.getContacts();
    setState(() {
      contacts = data;
      debugPrint(contacts[0]['mobileNumber']);
      contactsList = List<ContactValue>.from(
          contacts.map((i){
            return ContactValue.fromJSON(i);
          })
      );
    });
    // setState(() => isLoading = true);
    // category = await CategoriesDatabase.instance.readAllNotes();
    // print(category);

    setState(() => isLoading = false);
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Contcat List"),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : contacts.isEmpty
            ? const Center(
          child: Text(
            'No Contacts',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ) :ListView.builder(
          itemCount: contacts.length,
            itemBuilder: (context, index) {
          return ContactRow(name: "${contactsList[index].fName} ${contactsList[index].lName}", number: contactsList[index].mobileNumber,);
        }),
      ),
    );
  }



}

class ContactValue{
  int id;
  String fName;
  String lName;
  String mobileNumber;
  ContactValue({required this.id, required this.fName, required this.lName, required this.mobileNumber});

  factory ContactValue.fromJSON(Map<String, dynamic> json){
    return ContactValue(
      id:json["id"],
      fName: json["fName"],
      lName: json["lName"],
      mobileNumber: json["mobileNumber"],
    );
  }
}

