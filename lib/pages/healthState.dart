import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../widgets/score_indicator.dart';
import '../scoped-models/user_model.dart';

class HealthState extends StatefulWidget {
  @override
  _HealthStateState createState() => _HealthStateState();
}

class _HealthStateState extends State<HealthState> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(title: Text('Health State')),
        body: Column(
          children: [
            ScoreIndicator(),
            Container(margin: EdgeInsets.only(top: 20)),
            Text(
                'Steps progress : ${model.stageSteps} / ${model.stageStepGoal}'),
            Container(margin: EdgeInsets.only(top: 20)),
            Text(
                'Active Minutes progress : ${model.stageActiveMinutes} / ${model.stageActiveMinuteGoal}'),
          ],
        ),
        backgroundColor: Colors.black,
      );
    });
  }
}
