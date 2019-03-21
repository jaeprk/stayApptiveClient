import 'package:scoped_model/scoped_model.dart';
import '../models/google_fit.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

class UserModel extends Model {
  int _currentSteps = 1;
  int _currentActiveMinutes = 1;
  int _stepsGoal = 10000; // use sharedpref
  int _activeMinutesGoal = 150;

  // sync this data with sharedpref
  // sharedpref 'timestemp + stage' : int 'activeminute'
  // sharedpref 'stepGoal' : int 'stepGoal'
  // sharedpref 'activeMinuteGoal' : int 'activeMinuteGoal'
  int _stage = -1;
  int _stageStepGoal = 0;
  int _stageActiveMinuteGoal = 0;
  int _stageSteps = 1;
  int _stageActiveMinutes = 1;
  double _stageScore = 0;

  int get stageSteps {
    return _stageSteps;
  }

  int get stageStepGoal {
    return _stageStepGoal;
  }

  int get stageActiveMinutes {
    return _stageActiveMinutes;
  }

  int get stageActiveMinuteGoal {
    return _stageActiveMinuteGoal;
  }

  void _updateStage() async {
    int currentStage = _getStage();
    _stage = currentStage;
    DateTime now = new DateTime.now();
    String today = new DateTime(now.year, now.month, now.day).toString();
    String stage = today + currentStage.toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    List tmp = await _buildPersonalizedGoalDistribution();
    var stageDistribution = tmp[currentStage];
    var customActivity = prefs.getInt(stage) ?? 0;
    int stageStepGoal = (_stepsGoal * stageDistribution).toInt();
    var stageActiveMinuteGoal =
        (_activeMinutesGoal * stageDistribution).toInt();
    stageActiveMinuteGoal =
        stageActiveMinuteGoal > 0 ? stageActiveMinuteGoal : 1;
    _stageStepGoal = stageStepGoal;
    _stageSteps = int.parse((await getData('step', 'day', '14400000')).last);
    _stageActiveMinutes =
        int.parse((await getData('activeMinute', 'day', '14400000')).last) +
            customActivity;
    _stageScore = _getScore();
  }

  void _updateGoals() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _stepsGoal = prefs.getInt('stepsGoal') ?? 10000;
    _activeMinutesGoal = prefs.getInt('activeMinutesGoal') ?? 150;
  }

  UserModel() {
    Timer.periodic(new Duration(seconds: 10), (timer) async {
      await handleSignIn();
      await _updateData();
    });
  }

  double get stageScore {
    return _stageScore;
  }

  int get stepsGoal {
    return _stepsGoal;
  }

  int get activeMinutesGoal {
    return _activeMinutesGoal;
  }

  int get currentActiveMinutes {
    return _currentActiveMinutes;
  }

  set stepGoal(int i) {
    _stepsGoal = i;
    notifyListeners();
  }

  int get currentSteps {
    return _currentSteps;
  }

  double get stepsGoalPercent {
    if (_stepsGoal == 0)
      return 0.0;
    else
      return _currentSteps / _stepsGoal;
  }

  double get activeMinutesGoalPercent {
    if (_activeMinutesGoal == 0)
      return 0.0;
    else
      return _currentActiveMinutes / _activeMinutesGoal;
  }

  Future<void> _updateData() async {
    var now = new DateTime.now();
    String today = new DateTime(now.year, now.month, now.day).toString();
    SharedPreferences prefs = await SharedPreferences.getInstance();

    var tmpSteps = await getData('step', 'day');
    var tmpActiveMinutes = await getData('activeMinute', 'day');
    var customActivity = (await prefs.getInt(today + '0')) ?? 0;
    customActivity += (await prefs.getInt(today + '1')) ?? 0;
    customActivity += (await prefs.getInt(today + '2')) ?? 0;
    customActivity += (await prefs.getInt(today + '3')) ?? 0;
    _currentSteps = int.parse(tmpSteps.last);
    _currentActiveMinutes = int.parse(tmpActiveMinutes.last) + customActivity;

    await _updateGoals();
    await _updateStage();
    //_currentSteps = int.parse(tmpSteps.last);
    // print(_currentSteps);
    // print(_currentActiveMinutes);
    // print(_stepsGoal);
    // print(_activeMinutesGoal);
    // print(_stage);
    // print(_stageScore);
    // print(_stageActiveMinuteGoal);
    // print(_stageSteps);
    // print(_stageActiveMinutes);
    notifyListeners();
  }

  Future<List> _buildPersonalizedGoalDistribution() async {
    List<double> dividedSumList = [0, 0, 0, 0];
    var tmp = await getData('activeMinute', '30', '14400000');
    for (int i = 0; i < tmp.length; ++i) {
      int ct = i % 4;
      dividedSumList[ct] += int.parse(tmp[i]);
    }
    double sum = 1.0;
    for (int i = 0; i < dividedSumList.length; ++i) {
      sum += dividedSumList[i];
    }
    for (int i = 0; i < dividedSumList.length; ++i) {
      dividedSumList[i] = dividedSumList[i] / sum;
    }

    return dividedSumList ?? [0, 0.3, 0.3, 0.4];
  }

  int _getStage() {
    var now = new DateTime.now();
    var tmp = new DateTime(now.year, now.month, now.day);
    return ((now.millisecondsSinceEpoch - tmp.millisecondsSinceEpoch) /
            21600000)
        .floor();
  }

  double _getScore() {
    double stepProgress = _stageSteps / _stageStepGoal;
    double activeMinutesProgress = _stageActiveMinutes /
        (_stageActiveMinuteGoal == 0.0 ? 1.0 : _stageActiveMinuteGoal);
    DateTime now = new DateTime.now();
    DateTime today = new DateTime(now.year, now.month, now.day);
    double timeProgress =
        ((now.millisecondsSinceEpoch - today.millisecondsSinceEpoch) %
                14400000) /
            14400000;
    double rst = (stepProgress > activeMinutesProgress
            ? stepProgress
            : activeMinutesProgress) /
        (timeProgress == 0 ? 1 : timeProgress);
    return rst > 10 ? 10.0 : rst;
  }
}
