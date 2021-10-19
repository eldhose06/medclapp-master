library vya_customer.globals;

import 'package:flutter/widgets.dart';
import 'package:medclapp/utils/styles.dart';

int signupStep = 1;

int globalTabIndex = 0;
int incorrectCount = 0;
String completedProfile = 'no';
String defaultLanguage = 'English';
String loggedStatus = 'false';
String customerId = '';
String customerPhone = '';
String customerEmail = '';
String customerName = '';
String customerPicture = '';

String currentLocation = '';
String currentLatitude = '';
String currentLongitude = '';

List categoryList = [];
String cartCount = '0';
int notificationCount = 0;
List notificationsList = [];

int selectedCategory = 1;
String selectedCategoryTitle = '';
Color selectedCategoryColor = Styles.secondaryColor;

List finalSearchResultList = [];
bool searchScreenActive = false;
String searchTerm = '';

List pdtItemList = [];
List cartItemList = [];

double finalTotalAmount = 0.0;
String selectedOrderCategoryId = '1';

String selectedCategoryImage =
    'lib/assets/images/dashboard/pharmacy_products.png';

String signupFullName = '';
String signupGender = '0';
String signupDob = '';
String signupNationality = '101';
String signupPassword = '';
String signupConfirmPassword = '';
String signupPhone = '';
String signupEmail = '';
bool signupTerms = false;
