import 'package:flutter/material.dart';
import 'package:todo_list/shared/components/components.dart';

class InfoScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Developed By Ahmed Dabash',
              style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.indigo),
            ),
            raisedinfobutton(
              context: context,
              color: Colors.blueAccent,
              title: "Facebook",
            asset: AssetImage('assets/images/facebook.png'),
            URL: 'https://www.facebook.com/Dabash99'),
            raisedinfobutton(
                context: context,
                color: Colors.grey,
                title: "Github",
                asset: AssetImage('assets/images/github.png'),
                URL: 'https://www.github.com/Dabash99'),
            raisedinfobutton(
                context: context,
                color: Colors.indigo,
                title: "Behance",
                asset: AssetImage('assets/images/behance.png'),
                URL: 'https://www.behance.net/ahmed-dabash?isa0=1')
          ]),
    );
  }
}
