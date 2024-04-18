import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:food_app/controller/firebase_auth_service.dart';
import 'package:food_app/screen/tabview.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FirebaseAuthService _auth = FirebaseAuthService();
  bool _obscureText = true;
  TextEditingController _userName = TextEditingController();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _userName.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signup() async {
    String username = _userName.text;
    String email = _email.text;
    String password = _password.text;

    User? user =
        await _auth.signUpWithEmailAndPassword(email, password, username);

    if (user != null) {
      print('User is successfully created');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TabView()));
    } else {
      print('Something went wrong');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.yellow.shade200,
      ),
      backgroundColor: Colors.yellow.shade200,
      body: Column(
        children: <Widget>[
          SizedBox(height: 80),
          Container(
            alignment: Alignment.center,
            child: Text(
              'First step to be friend',
              style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 25),
                alignment: Alignment.centerLeft,
                child: Text('Tên của bạn'),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _userName,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Họ tên',
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 25),
                alignment: Alignment.centerLeft,
                child: Text('Email'),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Email',
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 25),
                alignment: Alignment.centerLeft,
                child: Text('Passwords'),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _password,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Mật khẩu',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: _signup,
              child: Text(
                'Đăng ký tài khoản',
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

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  FirebaseAuthService _auth = FirebaseAuthService();
  TextEditingController _email = TextEditingController();
  TextEditingController _password = TextEditingController();
  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  void _signIn() async {
    String email = _email.text;
    String password = _password.text;
    User? user = await _auth.signInWithEmailAndPassword(email, password);
    if (user != null) {
      print('User is successfully created');
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => TabView()));
    } else {
      print('Something went wrong');
    }
  }

  bool _obscureText = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow.shade200,
      body: Column(
        children: <Widget>[
          SizedBox(height: 200),
          Text(
            'Welcome to my food app!',
            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 25),
                alignment: Alignment.centerLeft,
                child: Text('Email'),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _email,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Email',
                  ),
                ),
              ),
            ],
          ),
          Column(
            children: [
              Container(
                padding: EdgeInsets.only(left: 20, top: 25),
                alignment: Alignment.centerLeft,
                child: Text('Passwords'),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: TextField(
                  controller: _password,
                  obscureText: _obscureText,
                  decoration: InputDecoration(
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 13, horizontal: 10),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: BorderSide(width: 0.8),
                    ),
                    hintText: 'Mật khẩu',
                    suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            _obscureText = !_obscureText;
                          });
                        },
                        icon: Icon(_obscureText
                            ? Icons.visibility_off
                            : Icons.visibility)),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                GestureDetector(
                  onTap: () {},
                  child: Text(
                    'Quên mật khẩu?',
                    style: TextStyle(decoration: TextDecoration.underline),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => SignUpScreen()));
                  },
                  child: Text(
                    'Bạn là người mới?',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 50,
          ),
          ElevatedButton(
              style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.black)),
              onPressed: _signIn,
              child: Text(
                'Đăng ký tài khoản',
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
