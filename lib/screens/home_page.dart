import 'package:flutter/material.dart';
import 'message_page.dart'; 
import 'history_page.dart'; 
import 'request_page.dart'; 
import 'find_donors_page.dart'; 
import 'donate_blood_page.dart'; 
import 'login_page.dart'; 


class HomePage extends StatelessWidget {
  final String bloodGroup;

  const HomePage({super.key, required this.bloodGroup});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.redAccent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          'Welcome, Donor!',
          style: TextStyle(
            fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
      drawer: _buildDrawer(context),
      backgroundColor: Colors.red[50],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _infoCard(
                  title: 'Your Blood Group',
                  content: bloodGroup,
                  assetPath: 'assets/blood_drop.png',
                ),
                 _infoCard(
                    title: 'Donor Status',
                    content: 'Please get\nchecked up first\nto donate',
                    assetPath: 'assets/cross_icon.png',
                    isStatus: true,
                  ),
              ],
            ),
            const SizedBox(height: 50),
            _actionButton(
              label: 'Find Donors',
              icon: Icons.search,
              gradient: const [Colors.red, Colors.redAccent],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FindDonorsPage(selectedBloodGroup: bloodGroup),
                  ),
                );
              },
            ),
            const SizedBox(height: 20),
            _actionButton(
              label: 'Donate Blood',
              icon: Icons.bloodtype,
              gradient: const [Colors.red, Colors.redAccent],
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => const DonateBloodPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _infoCard({
    required String title,
    required String content,
    required String assetPath,
    bool isStatus = false,
  }) {
    return Container(
      width: 150,
      height: 150,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(assetPath, height: 50),
          const SizedBox(height: 10),
          Text(
            title,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 5),
          Text(
            content,
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
              color: isStatus ? Colors.green : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton({
    required String label,
    required IconData icon,
    required List<Color> gradient,
    required Function onTap,
  }) {
    return ElevatedButton(
      onPressed: () => onTap(),
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.transparent,
        disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
        shadowColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        padding: const EdgeInsets.symmetric(vertical: 15),
        elevation: 5,
        textStyle: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
      ),
      child: Ink(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(10),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, color: Colors.white),
              const SizedBox(width: 10),
              Text(label, style: const TextStyle(color: Colors.white)),
            ],
          ),
        ),
      ),
    );
  }

   Widget _buildDrawer(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.red[50],
        child: ListView(
          children: [
            DrawerHeader(
              decoration: const BoxDecoration(color: Colors.redAccent),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.favorite, size: 50, color: Colors.white),
                  const SizedBox(height: 10),
                  const Text(
                    'Donor #32457',
                    style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Donor Status: Approved',
                    style: TextStyle(fontSize: 16, color: Colors.white.withOpacity(0.8)),
                  ),
                ],
              ),
            ),
            _drawerListTile(
              title: 'Messages',
              icon: Icons.message,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const MessagePage()));
              },
            ),
            _drawerListTile(
              title: 'Requests',
              icon: Icons.person_search,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const RequestPage()));
              },
            ),
            _drawerListTile(
              title: 'History',
              icon: Icons.history,
              onTap: () {
                Navigator.push(context, MaterialPageRoute(builder: (context) => const HistoryPage()));
              },
            ),
            _drawerListTile(
              title: 'Settings',
              icon: Icons.settings,
              onTap: () {
                Navigator.pop(context); // Close the drawer
              },
            ),
            const Spacer(),
            ListTile(
              leading: const Icon(Icons.logout, color: Colors.red),
              title: const Text('Sign Out', style: TextStyle(fontSize: 16, color: Colors.red)),
              onTap: () {
                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const LoginPage()));
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _drawerListTile({required String title, required IconData icon, required VoidCallback onTap}) {
    return ListTile(
      leading: Icon(icon, color: Colors.red),
      title: Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      trailing: const Icon(Icons.arrow_forward_ios, size: 14),
      onTap: onTap,
    );
  }
}