import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InputActivity extends StatefulWidget {
  @override
  _InputActivityState createState() => _InputActivityState();
}

// Define a corresponding State class. This class will hold the data related to
// our InputActivityForm.
class _InputActivityState extends State<InputActivity> {
  // Create a text controller. We will use it to retrieve the current value
  // of the TextField!

  @override
  void initState() {}

  String _inputHours = '';
  var _isIntense = false;

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
        title: Text('Input Activity'),
      ),
      body: Container(
        margin: EdgeInsets.only(top: 80),
        child: Center(
          child: Column(
            children: <Widget>[
              Text('Intense Workout?'),
              Switch(
                  value: _isIntense,
                  onChanged: (bool newValue) {
                    _isIntense = newValue;
                  }),
              Container(margin: EdgeInsets.all(20)),
              Text('How many minutes?'),
              Container(
                width: 50,
                child: TextField(
                  keyboardType: TextInputType.number,
                  onChanged: (text) {
                    _inputHours = text;
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
                    DateTime now = (new DateTime.now());
                    String today =
                        new DateTime(now.year, now.month, now.day).toString();
                    String stage = today + _getStage().toString();
                    int inputHours = int.parse(_inputHours);
                    if (_isIntense) {
                      int tmp = await prefs.getInt(stage) ?? 0;
                      tmp += inputHours * 2;
                      await prefs.setInt(stage, tmp);
                      _showDialog();
                    } else {
                      int tmp = await prefs.getInt(stage) ?? 0;
                      tmp += inputHours;
                      await prefs.setInt(stage, tmp);
                      _showDialog();
                    }
                  }),
            ],
          ),
        ),
      ),
      backgroundColor: Colors.black,
    );
  }
}
