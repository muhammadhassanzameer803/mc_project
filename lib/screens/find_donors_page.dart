import 'package:flutter/material.dart';
import 'request_page.dart';
import 'request_model.dart';

// Global List to Store Requests
List<Request> requests = [];

class FindDonorsPage extends StatefulWidget {
  final String selectedBloodGroup;

  const FindDonorsPage({super.key, required this.selectedBloodGroup});

  @override
  State<FindDonorsPage> createState() => _FindDonorsPageState();
}

class _FindDonorsPageState extends State<FindDonorsPage> {
  String? patientBloodType;
  String? patientGender;
  String? patientRelation;
  int patientAge = 18;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.red,
        elevation: 0,
        title: const Text(
          'Find Donors',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ),
      backgroundColor: const Color.fromARGB(255, 245, 228, 228),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Blood Type Selection
              const Text(
                'Patient Blood Type',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                runSpacing: 10,
                children: ['A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-']
                    .map(
                      (type) => ChoiceChip(
                        label: Text(type),
                        selected: patientBloodType == type,
                        onSelected: (selected) {
                          setState(() {
                            patientBloodType = type;
                          });
                        },
                        selectedColor: Colors.red,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: patientBloodType == type
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              // Gender Selection
              const Text(
                'Patient Gender',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  _genderChip('Male'),
                  const SizedBox(width: 10),
                  _genderChip('Female'),
                ],
              ),
              const SizedBox(height: 20),

              // Relation Selection
              const Text(
                'Patient Relation',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 10,
                children: ['Family', 'Friend', 'Other']
                    .map(
                      (relation) => ChoiceChip(
                        label: Text(relation),
                        selected: patientRelation == relation,
                        onSelected: (selected) {
                          setState(() {
                            patientRelation = relation;
                          });
                        },
                        selectedColor: Colors.red,
                        backgroundColor: Colors.white,
                        labelStyle: TextStyle(
                          color: patientRelation == relation
                              ? Colors.white
                              : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 20),

              // Age Selection
              const Text(
                'Patient Age',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.white,
                      ),
                      child: DropdownButton<int>(
                        value: patientAge,
                        isExpanded: true,
                        underline: const SizedBox(),
                        items: List.generate(
                          100,
                          (index) => DropdownMenuItem<int>(
                            value: index + 1,
                            child: Text('${index + 1} years'),
                          ),
                        ),
                        onChanged: (value) {
                          setState(() {
                            patientAge = value!;
                          });
                        },
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 40),

              // Submit Button
              Center(
                child: InkWell(
                  onTap: () {
                    if (patientBloodType != null &&
                        patientGender != null &&
                        patientRelation != null) {
                      // Add Request to the List
                      requests.add(
                        Request(
                          name: 'Anonymous', // Replace with actual input
                          bloodGroup: patientBloodType!,
                          gender: patientGender!,
                          relation: patientRelation!,
                          age: patientAge,
                        ),
                      );
                      // Navigate to Requests Page
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const RequestPage(),
                        ),
                      );
                    } else {
                      // Show Error Dialog
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Incomplete Details'),
                          content: const Text(
                              'Please fill out all the required details.'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context),
                              child: const Text('OK'),
                            ),
                          ],
                        ),
                      );
                    }
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                          colors: [Colors.red, Colors.redAccent]),
                      borderRadius: BorderRadius.circular(25),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 2,
                          blurRadius: 5,
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Send Requests',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(width: 10),
                        Icon(Icons.arrow_forward, color: Colors.white),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _genderChip(String gender) {
    return ChoiceChip(
      label: Text(gender),
      selected: patientGender == gender,
      onSelected: (selected) {
        setState(() {
          patientGender = gender;
        });
      },
      selectedColor: Colors.red,
      backgroundColor: Colors.white,
      labelStyle: TextStyle(
        color: patientGender == gender ? Colors.white : Colors.black,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
