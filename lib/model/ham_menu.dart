import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class HamburgerMenu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;

    return Drawer(
      backgroundColor: Colors.white,
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: user != null
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: 30,
                        backgroundImage: NetworkImage(user.photoURL ?? ''),
                        child: user.photoURL == null
                            ? Icon(Icons.person, size: 40)
                            : null,
                      ),
                      SizedBox(height: 8),
                      Text(
                        user.displayName ?? 'User',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      Text(
                        'Joined: ${user.metadata.creationTime?.toLocal().toString().split(' ')[0] ?? ''}',
                        style: TextStyle(fontSize: 14, color: Colors.grey),
                      ),
                    ],
                  )
                : DrawerHeader(
                    curve: Curves.linear,
                    decoration: BoxDecoration(color: Colors.white),
                    child: Image.asset('assets/oru-login.png'),
                  ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                if (user != null)
                  ListTile(
                    leading: Icon(Icons.logout),
                    title: Text('Logout'),
                    onTap: () async {
                      await FirebaseAuth.instance.signOut();
                      Navigator.pop(context);
                    },
                  )
                else
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Login/Signup',
                      style: TextStyle(color: Colors.white),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(62, 70, 143, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    'Sell Your Phone',
                    style: TextStyle(color: Colors.black),
                  ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(246, 192, 24, 1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 350),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                      icon: Icons.shopping_cart,
                      label: 'How to Buy',
                      onTap: () {}),
                  _buildMenuItem(
                      icon: Icons.monetization_on,
                      label: 'How to Sell',
                      onTap: () {}),
                  _buildMenuItem(
                      icon: Icons.menu_book, label: 'ORU Guide', onTap: () {}),
                ],
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMenuItem(
                      icon: Icons.info_outline,
                      label: 'About Us',
                      onTap: () {}),
                  _buildMenuItem(
                      icon: Icons.privacy_tip,
                      label: 'Privacy Policy',
                      onTap: () {}),
                  _buildMenuItem(
                      icon: Icons.help_outline, label: 'FAQs', onTap: () {}),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Container(
      width: 78,
      height: 54,
      decoration: BoxDecoration(
        border: Border.fromBorderSide(BorderSide(color: Colors.grey)),
        borderRadius: BorderRadius.circular(10),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.black),
            SizedBox(height: 5),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 9, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
