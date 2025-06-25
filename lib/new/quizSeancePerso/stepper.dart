import 'package:flutter/material.dart';
import 'package:flutter_phoenix/flutter_phoenix.dart';
import 'package:fitness_app/app/components/bouton_components.dart';
import 'package:fitness_app/app/components/text_components.dart';
import 'package:fitness_app/main.dart';
import 'package:fitness_app/modules/monCompte/controller/controller.dart';
import 'package:fitness_app/utils/colors.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class StepperForm extends StatefulWidget {
  const StepperForm({super.key});

  @override
  State<StepperForm> createState() => _StepperFormState();
}

class _StepperFormState extends State<StepperForm> {
  String? selectedProgram;
  String? selectedDaysPerWeek;
  final List<String> selectedTrainingDays = [];
  bool isLoading = false;
  int maxSelectableDays = 4; // Limite par défaut

  final List<String> programs = [
    'Programme BBL',
    'Programme Power',
  ];

  final List<String> daysPerWeek = [
    '2 fois / semaine',
    '3 fois / semaine',
    '4 fois / semaine'
  ];

  final List<String> weekDays = [
    'Lundi',
    'Mardi',
    'Mercredi',
    'Jeudi',
    'Vendredi',
    'Samedi',
    'Dimanche'
  ];

  Future<void> updateUserProgram() async {
    setState(() {
      isLoading = true;
    });

    try {
      final response = await http.get(
          Uri.parse('https://zoutechhub.com/pharmaRh/gofitnext/updateSeancePersoStepper.php')
              .replace(queryParameters: {
            'mail': user_email,
            'programme': selectedProgram ?? '',
            'nbrJour': selectedDaysPerWeek ?? '',
            'days': selectedTrainingDays.join(',')
          })
      );

      if (response.statusCode == 200) {
        if (response.body == 'OK') {
          showToast(context, 'Mise à jour réussie. Veuillez Patienter quelques secondes...', Colors.green);
          Future.delayed(Duration(
              seconds: 4
          ),() {
            Phoenix.rebirth(context);
          },);
        }else {
          showToast(context, 'Erreur: ${response.body}', Colors.red);
        }
      } else {
        showToast(context, 'Erreur serveur: ${response.statusCode}', Colors.red);
      }
    } catch (e) {
      showToast(context, 'Erreur réseau: $e', Colors.red);
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: mainColor,
        title: TextComponent(
          text: 'Stepper - Questionnaire',
          size: 16,
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(spacing: 5,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Question 1
            TextComponent(
              text: '1 : Quel programme souhaitez-vous suivre ?',
              fontWeight: FontWeight.bold,
              size: 14,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedProgram,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Sélectionnez un programme',
              ),
              items: programs.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: TextComponent(
                    text: value,
                    size: 14,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedProgram = newValue;
                });
              },
            ),
            const SizedBox(height: 10),

            // Question 2
            TextComponent(
              text: 'Q2 : Combien de jours souhaitez-vous vous entraîner par semaine ?',
              fontWeight: FontWeight.bold,
              size: 14,
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              value: selectedDaysPerWeek,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                hintText: 'Sélectionnez une fréquence',
              ),
              items: daysPerWeek.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: TextComponent(
                    text: value,
                    size: 14,
                  ),
                );
              }).toList(),
              onChanged: (newValue) {
                setState(() {
                  selectedDaysPerWeek = newValue;
                  if (newValue == '2 fois / semaine') {
                    maxSelectableDays = 2;
                  } else if (newValue == '3 fois / semaine') {
                    maxSelectableDays = 3;
                  } else if (newValue == '4 fois / semaine') {
                    maxSelectableDays = 4;
                  }
                  // Réinitialiser les jours sélectionnés si nécessaire
                  if (selectedTrainingDays.length > maxSelectableDays) {
                    selectedTrainingDays.removeRange(maxSelectableDays, selectedTrainingDays.length);
                  }
                });
              },
            ),
            const SizedBox(height: 10),

            // Question 3
            TextComponent(
              text: 'Q3 : Quels jours préférez-vous vous entraîner ? (max $maxSelectableDays)',
              fontWeight: FontWeight.bold,
              size: 14,
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: weekDays.map((day) {
                return FilterChip(
                  label: TextComponent(
                    text: day,
                    size: 14,
                  ),
                  selected: selectedTrainingDays.contains(day),
                  selectedColor: mainColor.withOpacity(0.5),
                  onSelected: (bool selected) {
                    setState(() {
                      if (selected) {
                        if (selectedTrainingDays.length < maxSelectableDays) {
                          selectedTrainingDays.add(day);
                        } else {
                          showToast(context, 'Vous ne pouvez sélectionner que $maxSelectableDays jours maximum', Colors.red);
                        }
                      } else {
                        selectedTrainingDays.remove(day);
                      }
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 32),

            // Submit button
            Center(
              child: isLoading
                  ? CircularProgressIndicator()
                  : InkWell(
                onTap: () {
                  if(eya){
                    if (selectedProgram == null ||
                        selectedDaysPerWeek == null ||
                        selectedTrainingDays.isEmpty) {
                      showToast(context, 'Veuillez répondre à toutes les questions', Colors.red);
                    } else if (selectedTrainingDays.length > maxSelectableDays) {
                      showToast(context, 'Veuillez sélectionner $maxSelectableDays jours maximum', Colors.red);
                    } else {
                      updateUserProgram();
                    }
                  }
                  else{
                    showToast(context, 'Veuillez vous connecter avant de configurer cette séance personnalisée', Colors.red);
                  }
                },
                child: ButtonComponent(label: "Valider"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
