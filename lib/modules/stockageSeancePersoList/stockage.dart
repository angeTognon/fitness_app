import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

Future<void> saveProgramToSharedPreferences(List<List<Map<String, double>>> program) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();

  // Convertir chaque Map<String, double> en Map<String, String>
  List<List<Map<String, String>>> serializableProgram = program.map((day) {
    return day.map((exercise) {
      String key = exercise.keys.first;
      String value = exercise[key]!.toString();  // Convertir double en String
      return {key: value};
    }).toList();
  }).toList();

  await prefs.setString('twoWeeksProgram', jsonEncode(serializableProgram));
}


Future<List<List<Map<String, double>>>?> getProgramFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? programJson = prefs.getString('twoWeeksProgram');

  if (programJson != null) {
    try {
      List<dynamic> programList = jsonDecode(programJson);

      return programList.map((day) {
        return (day as List<dynamic>).map((exerciseMap) {
          Map<String, dynamic> temp = Map<String, dynamic>.from(exerciseMap);
          String key = temp.keys.first;
          dynamic value = temp.values.first;

          // S'assurer que la valeur est bien un double
          double parsedValue = (value is int) ? value.toDouble() : (value is double ? value : double.tryParse(value.toString()) ?? 0.0);

          return {key: parsedValue};
        }).toList();
      }).toList();
    } catch (e) {
      print("❌ Erreur lors du décodage des données SharedPreferences: $e");
      return null;  // En cas d'erreur, on retourne null
    }
  }
  return null;
}
Future<List<List<Map<String, double>>>?> getProgramFromSharedPreferences2() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? programJson = prefs.getString('threeMonthsProgram');
  if (programJson != null) {
    List<dynamic> decodedJson = jsonDecode(programJson);
    return decodedJson.map((day) => (day as List<dynamic>).map((exercise) => Map<String, double>.from(exercise)).toList()).toList();
  }
  return null;
}

Future<void> saveProgramGenerationDay() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String today = _getCurrentDay(); // Obtenir le jour actuel
  await prefs.setString('programGenerationDay', today);
}
String _getCurrentDay() {
  List<String> days = ["Dimanche", "Lundi", "Mardi", "Mercredi", "Jeudi", "Vendredi", "Samedi"];
  return days[DateTime.now().weekday % 7]; // Récupère le jour actuel
}


Future<void> clearProgramFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('twoWeeksProgram'); // Supprime la clé 'twoWeeksProgram'
  print("ok");
}

Future<void> clearDatesFromSharedPreferences() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  await prefs.remove('programDates');
  print("okDate");

}

