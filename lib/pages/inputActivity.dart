import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/steps_indicator.dart';
import '../widgets/active_minutes_indicator.dart';
import '../scoped-models/user_model.dart';

class InputActivity extends StatefulWidget {
  @override
  _InputActivityState createState() => _InputActivityState();
}

class _InputActivityState extends State<InputActivity> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(title: Text('StayApptive')),
        body: Column(
          children: [
            StepsIndicator(),
            ActiveMinutesIndicator(),
            RaisedButton(
                child: Text('healthState'),
                onPressed: () {
                  Navigator.pushNamed(context, '/healthState');
                })
          ],
        ),
        backgroundColor: Colors.black,
      );
    });
  }
}
