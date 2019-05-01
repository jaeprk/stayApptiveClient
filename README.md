# stay_apptive_client

StayApptive andriod application project built using Flutter

Follow instructions in the Flutter official documentation to set up a local development environment
https://flutter.dev/docs/get-started/install

update dependencies before run it: 
  flutter packages get
run the application with following command: (your device or avd should be connected)
  flutter run

This project is focused on Android development

Introduction

Exercising is crucial to a healthy lifestyle but can be intimidating. People tend to forget that progress is most important when exercising. They focus more on the end goal rather than their own improvement. Something as simple as walking or cycling can be extremely beneficial to a person. However, most people fail to find a motivation to prevent this with exercise due to the habit of comparing themselves to others who are already healthy and fit. 

StayApptive tackles the problem of lack of motivation with the goal of encouraging a healthy lifestyle to every individual who believes he or she is too busy to exercise. Fitness is a crucial factor in regards to maintaining a healthy lifestyle. However, what usually happens is a user starts to exercise and continues for a short period of time. The user soon stops due to lack of motivation. 

The intended users to use the application are pretty versatile. A user could be someone who is out of shape and wants to start improving his or her health without being burnt out. Another user could be fairly healthy but wants to keep progress and reminders of when to exercise (i.e. walking). 

StayApptive intends to help users by keeping track of their progress, as it is crucial to remind users that any progress is beneficial. With user goals, the application will be able to recommend users activities to get closer to their goal(s) set for the day. For instance, if a user wants to walk 3000 steps a day, the application would recommend sets of when and how many steps to walk considering the user’s progress of the day and the remaining time.

System Aspects

The application uses google api for fitness to gather data. It takes information from the Google ‘fitness store’ which is a cloud storage that is constantly updated by the connected devices of the specified user account. Therefore the application has access to all the information that is pushed by multiple devices that is linked to the account. 
The application will provide functionality to update input data manually to the fitness store, using the api as well. 

The user data consists of steps and active time information. The active minutes information allows the application to track other activities like cycling, swimming, etc along with the user’s movements.

The health state varies from user to user depending on their goals and their progress each day. The health state is determined by the progress the user makes with the goal he/she has set on the application; i.e., the average of the user’s exercises/physical activities on a particular week is compared to the average of previous week(s). Additionally, the goals the user sets also affects the health state of the user for instance, if the user has set their goal as 10 push ups a day, and if he/she does more than 10 push ups a day, then their health state improves.

To help users to attain their daily goal, recommendation alerts the user when their health state falls below a specified point. Recommendations will depend on the goal the user has set. For instance, if the user has set a goal to walk at least 10,000 steps a day, this goal may be divided into 4 chunks distributed throughout the day for example, early morning, noon, afternoon and evening, and if the user hasn’t completed a certain minimum say - 2500 by one of these time frames, the user will be alerted/ recommended via a push notification to walk to achieve their goal.

Architecture of the System

Fitness Store
Sensors of devices that supports Google Fit and that is linked to a same google account gathers data which are ranging from the user’s steps to walking and running distance and time. They update user’s activity data to the Fitness Store, which is a Google data cloud that keeps health information, allowing access to accumulated health data.

Personal Data
This is the data updated from the Fitness Store and organized in a way that will make it easier to extract actual information from the user’s activity.￼

External Database or Knowledge
This will be a database that will hold other information that will be used when the Personal Model and Health State is created. This includes things like recommended activity time for a certain age or age group and other vital health data.

Personal Model
Personal model gathers accumulated data obtained from multiple sensors and user settings like daily goal as well. This model is analyzed by the application and create the user’s health state. The application generates recommendations and notification according to the user’s health state.

StayApptive App
This will be the actual application and it’s frontend user interface. This connects what is going on behind the scenes and show the user the important information.

Get Recommendations
This part of the UI/UX will be responsible of notifying the users of activities they should partake in. The notification system background push notification as well as in-application recommendations.

Set personal daily and/or weekly goals
The UI allows users to set goals for themselves that they want to achieve. This also serve as part of the personal model, and users may get notifications to inform them of their daily or weekly goals. If a user is falling behind schedule to reach their goal, they may receive more motivational notification to help them achieve the goal.

See Health State
The user can see how their overall Health State and the progress to the goal. It visualizes the completion of their goals, as well as show their total daily activity and their overall activity for the week.

 Manual Input of Activity
A user may not have their phone on them at all times to have their activity data tracked, so the application provides a way that they can manually input some of their activities so that we can properly build their Health State. 

References
Google fit api, https://developers.google.com/fit/

Contributers:

Deone Peng (dcpeng@uci.edu)
Areba Hazari (hazaria@uci.edu)
Minjae Park(shinbp@uci.edu)
Francisco Ortiz(ortizf@uci.edu)
