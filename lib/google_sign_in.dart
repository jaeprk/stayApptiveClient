import 'package:google_sign_in/google_sign_in.dart' show GoogleSignIn;
import 'package:googleapis/fitness/v1.dart';
import 'package:http/http.dart' show BaseRequest, Response, StreamedResponse;
import 'package:http/io_client.dart';
import 'package:flutter/services.dart';
import 'dart:convert';

Future<void> handleSignIn() async {
  try {
    _googleSignIn.signIn();
  } catch (error) {
    print(error);
  }
}

Future<void> handleSignOut() async {
  try {
    _googleSignIn.signOut();
  } catch (error) {}
}

GoogleSignIn _googleSignIn = GoogleSignIn(
  scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
    'https://www.googleapis.com/auth/fitness.activity.read',
    'https://www.googleapis.com/auth/fitness.body.read'
  ],
);

//
//Future<String> _getTimeZone() async {
//  final _platformChannel = MethodChannel('stayApptive.com/timeZone');
//  String timeZone;
//  try {
//    timeZone = await _platformChannel.invokeMethod('getTimeZone');
//  } catch (error) {}
//  return timeZone;
//}

DateTime _getStartTime(option) {
  DateTime now = new DateTime.now();
  DateTime result;
  switch (option) {
    case 'day':
      result = new DateTime(now.year, now.month, now.day);
      break;
    case 'month':
      result = new DateTime(now.year, now.month);
      break;
    default:
      result = null;
  }
  return result;
}

// option can be 'month' or 'day'
Future<Map<String, Object>> _googleRequest([String option]) async {
  if (option == null) {
    option = 'day';
  }
  await _googleSignIn.signIn();

  final authHeaders = await _googleSignIn.currentUser.authHeaders;
  final httpClient = new GoogleHttpClient(authHeaders);

  var _request = {
    "aggregateBy": [
      {
        "dataTypeName": "com.google.step_count.delta",
        "dataSourceId":
            "derived:com.google.step_count.delta:com.google.android.gms:estimated_steps"
      }
    ],
    "bucketByTime": {"durationMillis": "86400000"}, // divide by 24 hours
    //"startTimeMillis": _getMidnight().millisecondsSinceEpoch.toString(),
    "startTimeMillis": _getStartTime(option).millisecondsSinceEpoch.toString(),
    "endTimeMillis": DateTime.now().millisecondsSinceEpoch.toString()
  };

  final data = await new FitnessApi(httpClient)
      .users
      .dataset
      .aggregate(AggregateRequest.fromJson(_request), "me");
  return data.toJson();
}

class GoogleHttpClient extends IOClient {
  Map<String, String> _headers;

  GoogleHttpClient(this._headers) : super();

  @override
  Future<StreamedResponse> send(BaseRequest request) =>
      super.send(request..headers.addAll(_headers));

  @override
  Future<Response> head(Object url, {Map<String, String> headers}) =>
      super.head(url, headers: headers..addAll(_headers));
}

Future<List> getSteps([String option]) async {
  Map<String, Object> response = await _googleRequest(option);
  var rst = [];
  for (var data in response['bucket']) {
    var stepsContainer = data["dataset"][0]["point"];
    if (stepsContainer.length != 0) {
      rst.add(stepsContainer[0]["value"][0]["intVal"]);
    } else {
      rst.add("0");
    }
  }
  return rst;
}
