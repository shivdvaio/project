import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:inventory_management_system/Animation/fadeAnimation.dart';
import 'package:inventory_management_system/Data/constant.dart';
import 'package:inventory_management_system/Data/data.dart';
import 'package:inventory_management_system/Screens/HomeScreen.dart';
import 'package:inventory_management_system/Screens/LoginFeatures/googleAuth/googleAuth.dart';
import 'package:inventory_management_system/Widgets/widgets.dart';
import 'package:inventory_management_system/Screens/LoginFeatures/LoginScreen.dart';

class LoginScreen extends StatefulWidget {
  static String loginScreen = 'LoginScreen';

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

 

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: KloginScreenBackgroundColor,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 350,
                child: Stack(
                  children: [
                    Positioned(
                        height: 400,
                        width: width + 20,
                        child: FadeAnimation(
                          1,
                          ClipPath(
                            clipper: MyClipper(),
                            child: Container(
                              decoration: BoxDecoration(
                                  image: DecorationImage(
                                fit: BoxFit.cover,
                                image: AssetImage('assets/images/undraw.png'),
                              )),
                            ),
                          ),
                        )),
                    Positioned(
                        left: 50,
                        height: 150,
                        width: 90,
                        child: FadeAnimation(
                          1,
                          Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage(
                                        'assets/images/light-1.png'))),
                          ),
                        )),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 30),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textfiledOfLogin(
                      hintext: "Email",
                      textInputType: TextInputType.emailAddress,
                      obsecureValue: false,
                      icon: Icon(
                        Icons.email,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    textfiledOfLogin(
                      hintext: "Password",
                      textInputType: TextInputType.visiblePassword,
                      obsecureValue: true,
                      icon: Icon(
                        Icons.lock,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Center(
                        child: Text("Forgot Password?",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white.withOpacity(0.9),
                                fontSize: 17))),
                    SizedBox(
                      height: 35,
                    ),
                    ButtonContainer(
                      function: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => HomeScreen()));
                      },
                      text: "Login",
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      '- OR -',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 17),
                    )),
                    SizedBox(
                      height: 10,
                    ),
                    Center(
                        child: Text(
                      'Sign in With ',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                          fontSize: 17),
                    )),
                    SizedBox(
                      height: 25,
                    ),
                    IconsRow(),
                    SizedBox(
                      height: 15,
                    ),
                    ButtonContainer(
                      text: "Sign UP",
                      function: () {},
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class IconsRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        SignWithIcons(
          btnFucntion: () {
            LoginWithGoogle loginWithGoogle = LoginWithGoogle();
            loginWithGoogle.googleSignInServices();
             

          },
          IconDir: Assets.googleIcon,
        ),
        SignWithIcons(
          btnFucntion: () {},
          IconDir: Assets.fbIcon,
        )
      ],
    );
  }
}

class MyClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    var path = Path();

    path.lineTo(1, size.height - 90);
    path.quadraticBezierTo(
        size.width / 2, size.height, size.width, size.height - 200);
    path.lineTo(size.width, 0);
    path.close();
    return path;
    throw UnimplementedError();
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) {
    //
    return false;
  }
}
