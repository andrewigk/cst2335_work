import 'package:cst2335_summer24/profilePage.dart';
import 'package:encrypted_shared_preferences/encrypted_shared_preferences.dart';
import 'main.dart';

class DataRepository {
  static String firstName = "";   //Because not nullable
  static String lastName = "";     //Because not nullable
  static String phoneNum = "";  //Because not nullable
  static String emailAddress = ""; //Because not nullable


  static void saveData(){
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    prefs.setString("firstName", firstName);
    prefs.setString("lastName", lastName);
    prefs.setString("phoneNum", phoneNum);
    prefs.setString("emailAddress", emailAddress);

  }

// Call this function once on startup
  static void loadData() async{
    EncryptedSharedPreferences prefs = EncryptedSharedPreferences();
    firstName = await prefs.getString("firstName");
    lastName = await prefs.getString("lastName");
    phoneNum = await prefs.getString("phoneNum");
    emailAddress = await prefs.getString("emailAddress");



  }
}