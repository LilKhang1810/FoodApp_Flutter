import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/controller/firebase_auth_service.dart';
import 'package:food_app/screen/login_screen.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuthService authService = FirebaseAuthService();

  void signOut(BuildContext context) async {
    try {
      await authService.signOut();
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => SignInPage(),
        ),
      );
      print('User signed out');
    } catch (e) {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            height: 100,
          ),
          Center(
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(15)),
              width: 100,
              child: Image.asset('assets/img/ava.jpeg'),
            ),
          ),
          Text(
            'Khang Nguyen',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ListOption(
            title: 'Change password',
          ),
          ListOption(
            title: 'Change username',
          ),
          ListOption(
            title: 'Contacts',
          ),
          ListOption(
            title: 'Privacy',
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: () {
                signOut(context);
              },
              child: Text(
                'Đăng xuất',
                style: TextStyle(
                    color: Colors.yellow.shade200,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              )),
        ],
      ),
    );
  }
}

class ListOption extends StatelessWidget {
  const ListOption({
    super.key,
    required this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Text(
        title,
        style: TextStyle(fontSize: 17),
      ),
      trailing: IconButton(
        onPressed: () {},
        icon: Icon(
          Icons.arrow_forward_ios,
          size: 17,
        ),
      ),
    );
  }
}
