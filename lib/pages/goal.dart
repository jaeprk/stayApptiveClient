import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Goal extends StatefulWidget {
  @override
  _GoalState createState() => _GoalState();
}

// Define a corresponding State class. This class will hold the data related to
// our GoalForm.
class _GoalState extends State<Goal> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!

  @override
  void initState() {}

  String _stepGoal = '';
  String _activeMinuteGoal = '';

  void _showDialog() {
    // flutter defined function
    showDialog(
      context: context,
      builder: (BuildContext context) {
        // return object of type Dialog
        return AlertDialog(
          title: new Text("Message"),
          content: new Text("Data Uploaded"),
          actions: <Widget>[
            // usually buttons at the bottom of the dialog
            new FlatButton(
              child: new Text("Close"),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  int _getStage() {
    var now = new DateTime.now();
    var tmp = new DateTime(now.year, now.month, now.day);
    return ((now.millisecondsSinceEpoch - tmp.millisecondsSinceEpoch) /
            21600000)
        .floor();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Input Goal'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 80),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('New Step Goal'),
              Container(
                width: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    _stepGoal = text;
                  },
                ),
              ),
              Container(margin: EdgeInsets.all(20)),
              Text('New Active Minutes Goal'),
              Container(
                width: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    _activeMinuteGoal = text;
                  },
                ),
              ),
              Container(margin: EdgeInsets.all(20)),
              RaisedButton(
                  color: Colors.black,
                  child: Text('Submit'),
                  onPressed: () async {
                    SharedPreferences prefs =
                        await SharedPreferences.getInstance();
                    await prefs.setInt('stepsGoal', int.parse(_stepGoal));
                    await prefs.setInt(
                        'activeMinutesGoal', int.parse(_activeMinuteGoal));
                    _showDialog();
                  }),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
