import 'package:agenda_contatos/helpers/contact_helper.dart';
import 'package:flutter/material.dart';
import 'package:agenda_contatos/Models/Contact.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {

  ContactHelper helper = ContactHelper();

  @override
  void initState()
  {
    super.initState();

    Contact c = Contact();
    c.name = "1";
    c.email = "2";
    c.phone = "3";
    c.img = "4";

    helper.saveContact(c);

    helper.getAllContacts().then((list) => print(list));
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
