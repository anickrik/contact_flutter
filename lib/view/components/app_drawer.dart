import 'package:contacts_demo/utils/routes/routes_name.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: add functionality for changing only body of homeScreen.
    return Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Center(child: Text('Contacts', style: TextStyle(fontStyle: FontStyle.italic, fontSize: 28) )),
          ),
          ListTile(
            leading: Icon(
              Icons.home,
            ),
            title: const Text('Add Category'),
            onTap: () {
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, RouteName.home);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.person_add,
            ),
            title: const Text('Add Contact'),
            onTap: () {
              Navigator.pushReplacementNamed(context, RouteName.addContact);
            },
          ),
          Divider(),
          ListTile(
            leading: Icon(
              Icons.people,
            ),
            title: const Text('Contact List'),
            onTap: () {
              Navigator.pushReplacementNamed(context, RouteName.contactList);
            },
          ),
        ],
      ),
    );
  }
}
