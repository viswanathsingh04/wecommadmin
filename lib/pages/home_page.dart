import 'package:flutter/material.dart';
import 'package:wecommadmin/services/shared_service.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Dashboard',
          style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
          overflow: TextOverflow.fade,
        ),
        elevation: 0,
        actions: [
          IconButton(
            icon: new Icon(Icons.logout),
            onPressed: () async {
              await SharedService.logout();
            },
          ),
        ],
      ),
      body: Container(
        child: Center(
          child: Text(
            'Logged Successfully',
            style: new TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
            overflow: TextOverflow.fade,
          ),
        ),
      ),
    );
  }
}
