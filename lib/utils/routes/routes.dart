import 'package:contacts_demo/view/screens/contact_list/contact_list_screen.dart';
import 'package:flutter/material.dart';

import 'package:contacts_demo/utils/routes/routes_name.dart';
import '../../view/screens/add_contact/add_contact_screen.dart';
import '../../view/screens/home/home_screen.dart';

class Routes {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RouteName.home:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
      case RouteName.addContact:
        return MaterialPageRoute(
            builder: (BuildContext context) => const AddContactScreen());
        case RouteName.contactList:
        return MaterialPageRoute(
            builder: (BuildContext context) => const ContactListScreen());

      default:
        return MaterialPageRoute(
            builder: (BuildContext context) => const HomeScreen());
    }
  }
}
