import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:stacked/stacked.dart';
import '../model/ham_menu.dart';
import '../model/home_view_model.dart';

class HomeScreen extends StatelessWidget {
  var sd = HomeViewModel().isLoggedIn;
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<HomeViewModel>.reactive(
      viewModelBuilder: () => HomeViewModel(),
      onViewModelReady: (model) => model.checkLoginStatus(),
      builder: (context, model, child) => Scaffold(
        key: model.scaffoldKey, // Added key for the scaffold
        drawer: HamburgerMenu(), // Drawer for Hamburger Menu
        backgroundColor: Colors.white,
        body: SafeArea(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                leadingWidth: 120,
                scrolledUnderElevation: 0,
                backgroundColor: Colors.white,
                elevation: 0,
                leading: IconButton(
                  iconSize: 30,
                  icon: Image.asset('assets/leading-icon.png'),
                  onPressed: () {
                    model.scaffoldKey.currentState
                        ?.openDrawer(); // Open drawer on icon press
                  },
                ),
                shadowColor: Colors.transparent,
                surfaceTintColor: Colors.white,
                floating: true, // Makes it disappear when scrolling up
                snap: true, // Makes it reappear instantly when scrolling down
                actions: [
                  GestureDetector(
                    child: Row(
                      children: [
                        Text(
                          'India',
                          style: TextStyle(color: Colors.black),
                        ),
                        SizedBox(width: 5),
                        Image.asset('assets/location-icon.png'),
                        SizedBox(width: 15),
                      ],
                    ),
                    onTap: () {
                      print('pressed');
                      print(sd);
                    },
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/login');
                    },
                    child: Text(
                      'Login',
                      style: TextStyle(color: Colors.black),
                    ),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromRGBO(246, 192, 24, 1),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  SizedBox(width: 10),
                ],
              ),
              SliverPersistentHeader(
                pinned: true,
                delegate: _SearchBarDelegate(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class LoggedInUI extends StatelessWidget {
  final String? userName;

  LoggedInUI({this.userName});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Welcome, $userName!'),
          ElevatedButton(
            onPressed: () {
              // Navigate to another screen or logout
            },
            child: Text('Go to Dashboard'),
          ),
        ],
      ),
    );
  }
}

class NotLoggedInUI extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Please log in to continue.'),
          ElevatedButton(
            onPressed: () {
              // Navigate to login screen
            },
            child: Text('Login'),
          ),
        ],
      ),
    );
  }
}

class _SearchBarDelegate extends SliverPersistentHeaderDelegate {
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          TextField(
            decoration: InputDecoration(
              hintText: "Search phones with make, model...",
              prefixIcon: const Icon(Icons.search),
              suffixIcon: const Icon(Icons.mic),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30),
                borderSide: BorderSide.none,
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 40, // Adjust height as needed
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _OptionButton(label: "Sell Used Phones"),
                  _OptionButton(label: "Buy Used Phones"),
                  _OptionButton(label: "Compare Prices"),
                  _OptionButton(label: "My Profile"),
                  _OptionButton(label: "My Listings"),
                  _OptionButton(label: "Services"),
                  _OptionButton(label: "Register your Store", isNew: true),
                  _OptionButton(label: "Get the App"),
                  const SizedBox(width: 8), // Extra padding at the end
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  double get maxExtent => 140;

  @override
  double get minExtent => 140;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return false;
  }
}

class _OptionButton extends StatelessWidget {
  final String label;
  final bool isNew;

  const _OptionButton({required this.label, this.isNew = false, super.key});

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(label),
          if (isNew)
            Container(
              margin: const EdgeInsets.only(left: 4),
              padding: const EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                color: Colors.purple,
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Text(
                "new",
                style: TextStyle(fontSize: 10, color: Colors.white),
              ),
            ),
        ],
      ),
      backgroundColor: Colors.white,
    );
  }
}
// appBar: AppBar(
// actions: [
// GestureDetector(
// child: Row(
// children: [
// Text(
// 'India',
// style: TextStyle(color: Colors.black),
// ),
// SizedBox(width: 5),
// Image.asset('assets/location-icon.png'),
// SizedBox(width: 15),
// ],
// ),
// onTap: () {
// print('pressed');
// print(sd);
// },
// ),
// ElevatedButton(
// onPressed: () {
// Navigator.pushNamed(context, '/login');
// },
// child: Text(
// 'Login',
// style: TextStyle(color: Colors.black),
// ),
// style: ElevatedButton.styleFrom(
// backgroundColor: Color.fromRGBO(246, 192, 24, 1),
// shape: RoundedRectangleBorder(
// borderRadius: BorderRadius.circular(10),
// ),
// ),
// ),
// SizedBox(width: 10),
// ],
// // toolbarHeight: 80,
// leadingWidth: 120,
// scrolledUnderElevation: 0,
// backgroundColor: Colors.white,
// elevation: 0,
// leading: IconButton(
// iconSize: 30,
// icon: Image.asset('assets/leading-icon.png'),
// onPressed: () {
// model.scaffoldKey.currentState
//     ?.openDrawer(); // Open drawer on icon press
// },
// ),
// ),
