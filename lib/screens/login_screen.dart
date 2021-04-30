import 'package:whatsapp/constants.dart';
import 'package:whatsapp/screens/chat_screen.dart';
import 'package:whatsapp/widgets/rounded_button.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:modal_progress_hud/modal_progress_hud.dart';

class LoginScreen extends StatefulWidget {

  static const String id = "/login";
  
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> with SingleTickerProviderStateMixin{

  final _auth = FirebaseAuth.instance;
  String email,password;
  bool showSpinner = false;

  Animation animation, delayedAnimation, muchDelayedAnimation;
  AnimationController animationController;

  @override
  void initState() {
    super.initState();
    animationController = AnimationController(duration: Duration(seconds: 3),vsync: this);

    animation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      curve: Interval(0, .33, curve: Curves.fastOutSlowIn,),
      parent: animationController
    ));
    delayedAnimation = Tween(begin: -1.0, end: 0.0).animate(CurvedAnimation(
      curve: Interval(.33, .66, curve: Curves.fastOutSlowIn,),
      parent: animationController
    ));
    muchDelayedAnimation = Tween<Offset>(begin: const Offset(0.0, 1.0), end: const Offset(0.0, 0.0)).animate(CurvedAnimation(
      curve: Interval(.66, 1.0, curve: Curves.fastOutSlowIn,),
      parent: animationController
    ));
    
  }

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    animationController.forward();
    return AnimatedBuilder(
      animation: animationController,
      builder: (context, child){
      return Scaffold(
        backgroundColor: Colors.white,
        body: ModalProgressHUD(
          inAsyncCall: showSpinner,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Flexible(
                  child: Hero(
                    tag: 'logo',
                    child: Container(
                      height: 200.0,
                      child: Image.asset('images/logo.png'),
                    ),
                  ),
                ),
                SizedBox(
                  height: 48.0,
                ),
                Transform(
                  transform: Matrix4.translationValues(animation.value*width, 0.0, 0.0),
                  child: TextField(
                    keyboardType: TextInputType.emailAddress,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      email = value;
                    },
                    decoration: kInputTextFieldDecorations.copyWith(
                      hintText: 'Enter your email'
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.0,
                ),
                Transform(
                  transform: Matrix4.translationValues(delayedAnimation.value*width, 0.0, 0.0),
                  child: TextField(
                    obscureText: true,
                    textAlign: TextAlign.center,
                    onChanged: (value) {
                      password = value;
                    },
                    decoration: kInputTextFieldDecorations.copyWith(
                      hintText: 'Enter Your Password'
                    ),
                  ),
                ),
                SizedBox(
                  height: 24.0,
                ),
                Transform(
                  transform: Matrix4.translationValues(muchDelayedAnimation.value*width, 0.0, 0.0),
                  child: RoundedButton(
                    text: "Log in",
                    color: Colors.lightBlueAccent,
                    onPressed: () async{
                      setState(() {
                        showSpinner = true;                     
                      });
                      try{
                        final user = await _auth.signInWithEmailAndPassword(email: email, password: password);
                        if(user != null){
                          Navigator.pushNamed(context, ChatScreen.id);
                        }
                      }catch(e) {
                        print(e);
                      }
                      setState(() {
                        showSpinner = false;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      );
      }
    );
  }
}
