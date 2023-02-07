import 'package:contacts_demo/view/components/app_drawer.dart';
import 'package:flutter/material.dart';

import 'components/contact_row.dart';

class ContactListScreen extends StatelessWidget {
  const ContactListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text("Contcat List"),
      ),
      drawer: AppDrawer(),
      body: Padding(
        padding: EdgeInsets.all(15),
        child: ListView.builder(
          itemCount: 10,
            itemBuilder: (context, index) {
          return ContactRow(name: 'Test', number: '98993899392',);
        }),
      ),
    );
  }
}
