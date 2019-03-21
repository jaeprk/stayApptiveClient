import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/user_model.dart';

class RecommendationIndicator extends StatefulWidget {
  @override
  _RecommendationIndicatorState createState() =>
      _RecommendationIndicatorState();
}

class _RecommendationIndicatorState extends State<RecommendationIndicator> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      String imgSrc = 'assets/Rest.png';
      String recommendation = '';
      String message = '';

      if (model.stageScore > 1) {
        imgSrc = 'assets/Rest.png';
        recommendation = 'Take a rest';
        message = 'You are beyond your schedule';
      } else if (model.stageScore > 0.75) {
        imgSrc = 'assets/Bicycle.png';
        recommendation = 'Go out for light exercise';
        message = 'You are slightly behind your schedule';
      } else if (model.stageScore > 0.5) {
        imgSrc = 'assets/Swim.png';
        recommendation = 'Go out for cardio exercise';
        message = 'You are behind your schedule';
      } else {
        imgSrc = 'assets/Weight.png';
        recommendation = 'Go out for intense workout';
        message = 'You are far behind your schedule';
      }

      return Column(children: [
        Text(recommendation),
        Container(
            child: Image.asset(imgSrc),
            constraints: BoxConstraints(maxHeight: 130)),
        Text(message),
      ]);
    });
  }
}
