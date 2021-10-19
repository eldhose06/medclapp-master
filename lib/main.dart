import 'package:flutter/material.dart';
import 'package:medclapp/instructions/instruction1.dart';
import 'package:medclapp/screens/base.dart';
import 'package:medclapp/screens/blog/blog_list.dart';
import 'package:medclapp/screens/blood_request/add_new_request.dart';
import 'package:medclapp/screens/centres/covid_vaccine_centres.dart';
import 'package:medclapp/screens/family/add_new_member.dart';
import 'package:medclapp/screens/family/list_family.dart';
import 'package:medclapp/screens/health_record/add_new_record.dart';
import 'package:medclapp/screens/listing.dart';
import 'package:medclapp/screens/reminders/add_medicine_reminder.dart';
import 'package:medclapp/screens/reminders/add_vaccine_reminder.dart';
import 'package:medclapp/screens/reminders/medicine_reminders.dart';
import 'package:medclapp/screens/reminders/vaccine_reminders.dart';
import 'package:medclapp/screens/splash_screen.dart';
import 'package:medclapp/screens/tabs/emergency.dart';
import 'package:medclapp/screens/tabs/health_records.dart';
import 'package:medclapp/screens/user_authentication/complete_profile.dart';
import 'package:medclapp/screens/user_authentication/login.dart';
import 'package:medclapp/screens/user_authentication/signup.dart';
import 'package:medclapp/screens/user_authentication/verify_otp.dart';

void main() {
  runApp(
    RestartWidget(
      child: MyApp(),
    ),
  );
}

class RestartWidget extends StatefulWidget {
  RestartWidget({this.child});

  final Widget child;

  static void restartApp(BuildContext context) {
    context.findAncestorStateOfType<_RestartWidgetState>().restartApp();
  }

  @override
  _RestartWidgetState createState() => _RestartWidgetState();
}

class _RestartWidgetState extends State<RestartWidget> {
  Key key = UniqueKey();

  void restartApp() {
    setState(() {
      key = UniqueKey();
    });
  }

  @override
  Widget build(BuildContext context) {
    return KeyedSubtree(
      key: key,
      child: widget.child,
    );
  }
}

// void main() => runApp(MyApp());

class Routes {
  static const String languageScreen = '/language';
  static const String instruction1Screen = '/instruction1';

  static const String loginScreen = '/login';
  static const String signupScreen = '/signup';
  static const String verifyScreen = '/verify';
  static const String recoveryScreen = '/recovery';
  static const String forgotPasswordScreen = '/forgot';
  static const String resetPasswordScreen = '/reset';

  static const String question1Screen = '/question1screen';
  static const String question2Screen = '/question2screen';

  static const String blogListScreen = '/blogList';
  static const String requestsScreen = '/bloodRequest';
  static const String requestCreateScreen = '/bloodRequestNew';
  static const String emergencyScreen = '/emergency';
  static const String addMemberScreen = '/addMember';
  static const String addHealthRecordScreen = '/addRecord';
  static const String healthRecordScreen = '/healthRecords';
  static const String addVaccineReminderScreen = '/addVaccineReminder';
  static const String addMedicineReminderScreen = '/addMedicineReminder';
  static const String listFamilyMembersScreen = '/listFamilyMembers';

  static const String dashboardScreen = '/dashboard';
  static const String completeProfileScreen = '/completeProfile';
  static const String serviceProviderListingScreen = '/serviceproviderlisting';
  static const String bloodRequestListingScreen = '/bloodrequestlist';
  static const String vaccineCentreListingScreen = '/vaccineCentreList';

  static const String vaccinationReminderListScreen =
      '/vaccinationReminderList';
  static const String medicineReminderListScreen = '/medicineReminderList';
}

class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

class _MyAppState extends State<MyApp> {
  final navigatorKey = GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
  }

  void show(Map<String, dynamic> message) {
    final context = navigatorKey.currentState.overlay.context;
    final dialog = AlertDialog(
      content: ListTile(
        title: Container(
          margin: EdgeInsets.only(bottom: 15),
          child: Text(message['notification']['title']),
        ),
        subtitle: Container(
          child: Text(message['notification']['body']),
        ),
      ),
      actions: <Widget>[
        Row(
          children: <Widget>[
            FlatButton(
                child: Text('OK'),
                onPressed: () async {
                  Navigator.of(context).pop();
                }),
          ],
        )
      ],
    );
    showDialog(context: context, builder: (x) => dialog);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'Medclapp',
      theme: ThemeData(fontFamily: 'Arial Rounded MT'),
      // home: LoginScreen(),
      home: SplashScreen(),

      routes: {
        // Routes.languageScreen: (BuildContext context) => LanguageSelection(),

        Routes.instruction1Screen: (BuildContext context) =>
            Instruction1Screen(),
        Routes.loginScreen: (BuildContext context) => LoginScreen(),

        Routes.signupScreen: (BuildContext context) => SignupScreen(),
        Routes.verifyScreen: (BuildContext context) => VerifyOTP(),
        // Routes.recoveryScreen: (BuildContext context) => RecoveryScreen(),
        // Routes.resetPasswordScreen: (BuildContext context) =>
        //     ResetPasswordScreen(),

        // Routes.forgotPasswordScreen: (BuildContext context) =>
        //     ForgotPasswordScreen(),
        // Routes.question1Screen: (BuildContext context) => Question1Screen(),
        Routes.blogListScreen: (BuildContext context) => BlogList(),
        Routes.requestCreateScreen: (BuildContext context) =>
            BloodRequestCreate(),
        Routes.emergencyScreen: (BuildContext context) => EmergencyScreen(),
        Routes.addMemberScreen: (BuildContext context) => AddFamilyMember(),
        Routes.addHealthRecordScreen: (BuildContext context) =>
            AddHealthRecordScreen(),
        Routes.healthRecordScreen: (BuildContext context) =>
            HealthRecordsScreen(),
        Routes.addVaccineReminderScreen: (BuildContext context) =>
            AddVaccineReminderScreen(),
        Routes.addMedicineReminderScreen: (BuildContext context) =>
            AddMedicineReminderScreen(),
        Routes.listFamilyMembersScreen: (BuildContext context) =>
            ListFamilyMembers(),

        Routes.dashboardScreen: (BuildContext context) => DashboardScreen(),
        Routes.completeProfileScreen: (BuildContext context) =>
            CompleteProfileScreen(),
        Routes.serviceProviderListingScreen: (BuildContext context) =>
            ServiceProviderListing(),
        Routes.vaccineCentreListingScreen: (BuildContext context) =>
            CovidVaccineCentres(),
        Routes.vaccinationReminderListScreen: (BuildContext context) =>
            CovidVaccineReminders(),
        Routes.medicineReminderListScreen: (BuildContext context) =>
            MedicineReminders(),
      },
    );
  }
}
