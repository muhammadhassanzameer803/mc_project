import 'package:flutter/material.dart';
import 'home_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? selectedBloodGroup;

  // Regex for password validation: at least 1 special character, max 8 characters
  bool _validatePassword(String value) {
    final regex = RegExp(r'^(?=.*?[!@#\$&*~]).{1,8}$');
    return regex.hasMatch(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFB71C1C), // Red background
      appBar: AppBar(
        backgroundColor: const Color(0xFFB71C1C), // Red for AppBar to match
        elevation: 5,
        title: const Text(
          'Login',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      body: Center(  // Center the form
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,  // Minimize the space occupation
            children: [
              _buildTextField(
                controller: lastNameController,
                label: "Enter Your Name",
                isPassword: false,
              ),
              const SizedBox(height: 16),
              _buildTextField(
                controller: passwordController,
                label: "Enter Password",
                isPassword: true,
              ),
              const SizedBox(height: 16),
              _buildDropdown(),
              const SizedBox(height: 30),
              ElevatedButton(
                onPressed: _handleLogin,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF90A4AE), // Subtle button color
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  "Login",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.black87),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required bool isPassword,
  }) {
    return TextField(
      controller: controller,
      obscureText: isPassword,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: const TextStyle(color: Colors.white70),
        filled: true,
        fillColor: const Color(0xFF4F5B62), // Harmonious grey color for fields
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 15),
      ),
      style: const TextStyle(color: Colors.white),
    );
  }

  Widget _buildDropdown() {
    return DropdownButtonFormField<String>(
      value: selectedBloodGroup,
      hint: const Text(
        "Select Blood Group",
        style: TextStyle(color: Colors.white70),
      ),
      dropdownColor: const Color(0xFF4F5B62),
      items: ['A+', 'A-', 'B+', 'B-', 'O+', 'O-', 'AB+', 'AB-']
          .map((bg) => DropdownMenuItem<String>(
                value: bg,
                child: Text(bg, style: const TextStyle(color: Colors.white)),
              ))
          .toList(),
      onChanged: (value) {
        setState(() {
          selectedBloodGroup = value;
        });
      },
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color(0xFF4F5B62),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
      style: const TextStyle(color: Colors.white),
      validator: (value) {
        if (value == null) {
          return 'Please select a blood group';
        }
        return null;
      },
    );
  }

  void _handleLogin() {
    if (lastNameController.text.isEmpty) {
      _showSnackBar('Name is required');
    } else if (passwordController.text.isEmpty || !_validatePassword(passwordController.text)) {
      _showSnackBar('Password must contain at least one special character and be max 8 characters long');
    } else if (selectedBloodGroup == null) {
      _showSnackBar('Please select a blood group');
    } else {
      // Navigate to HomePage with the selected blood group
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => HomePage(bloodGroup: selectedBloodGroup!),
        ),
      );
    }
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }
}
