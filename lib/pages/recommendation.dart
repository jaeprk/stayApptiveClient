import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import '../scoped-models/user_model.dart';
import '../widgets/score_indicator.dart';
import '../widgets/recommendation_indicator.dart';

class Recommendation extends StatefulWidget {
  @override
  _RecommendationState createState() => _RecommendationState();
}

class _RecommendationState extends State<Recommendation> {
  @override
  Widget build(BuildContext context) {
    return ScopedModelDescendant<UserModel>(builder: (context, child, model) {
      return Scaffold(
        appBar: AppBar(title: Text('Recommandation')),
        body: Column(
          children: [
            Container(margin: EdgeInsets.all(20)),
            RecommendationIndicator(),
            Container(margin: EdgeInsets.all(30)),
            ScoreIndicator(),
          ],
        ),
        backgroundColor: Colors.black,
      );
    });
  }
}
