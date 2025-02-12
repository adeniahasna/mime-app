import 'package:flutter/material.dart';
import 'package:flutter_app/config/assets_image.dart';
import 'package:flutter_app/resources/pages/sign_in_page.dart';
import 'package:flutter_app/resources/widgets/email_text_field_widget.dart';
import 'package:flutter_app/resources/widgets/logo_widget.dart';
import 'package:flutter_app/resources/widgets/password_text_field_widget.dart';
import 'package:flutter_app/resources/widgets/sign_up_button_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:nylo_framework/nylo_framework.dart';

class SignUpPage extends NyStatefulWidget {
  static RouteView path = ("/sign-up", (_) => SignUpPage());

  SignUpPage({super.key}) : super(child: () => _SignUpPageState());
}

class _SignUpPageState extends NyPage<SignUpPage> {
  TextEditingController controllerEmail = TextEditingController();
  TextEditingController controllerPassword = TextEditingController();
  late FocusNode _emailFocusNode = FocusNode();
  late FocusNode _passFocusNode = FocusNode();
  bool isEmailFocused = false;
  bool isPassFocused = false;

  @override
  void initState() {
    super.initState();
    _emailFocusNode = FocusNode();
    _passFocusNode = FocusNode();

    _emailFocusNode.addListener(() {
      setState(() {
        isEmailFocused = _emailFocusNode.hasFocus;
      });
    });

    _passFocusNode.addListener(() {
      setState(() {
        isPassFocused = _passFocusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _emailFocusNode.dispose();
    _passFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget view(BuildContext context) {
    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      resizeToAvoidBottomInset: true,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                authBG(),
                logoWhite(),
                taglineText(),
                signInForm(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget authBG() {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Positioned(
          top: 0,
          left: 0,
          right: 0,
          child: Image.asset(AssetImages.authCurva),
        ),
      ),
    );
  }

  Widget logoWhite() {
    return Align(
      alignment: Alignment(0, -0.9),
      child: LogoWhite(height: 150, width: 200),
    );
  }

  Widget taglineText() {
    return Positioned(
      top: 170,
      left: 0,
      right: 0,
      child: Center(
        child: SizedBox(
          width: 300,
          child: Text(
            "Let's create, manage, and complete your tasks together !",
            style:
                GoogleFonts.anekDevanagari(fontSize: 18, color: Colors.white),
          ).alignCenter().fontWeightLight(),
        ),
      ),
    );
  }

  Widget signInForm() {
    return Positioned(
      top: 335,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            // color: const Color(0xFF7A5656),
            borderRadius: BorderRadius.circular(10),
          ),
          width: 360,
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              Text(
                "Sign Up",
                style: GoogleFonts.anekDevanagari(
                    fontSize: 33,
                    color: Colors.black,
                    fontWeight: FontWeight.w500),
              ).alignCenter(),
              SizedBox(height: 30),
              EmailTextField(controller: controllerEmail),
              SizedBox(height: 22),
              PasswordTextField(controller: controllerPassword),
              SizedBox(height: 25),
              SignUpButton(
                  controllerEmail: controllerEmail,
                  controllerPassword: controllerPassword),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",
                      style: GoogleFonts.anekDevanagari()),
                  TextButton(
                    onPressed: () {
                      Navigator.pushNamed(
                        context,
                        SignInPage.path.name,
                      );
                    },
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                          color: Colors.indigo[600],
                          fontWeight: FontWeight.bold,
                          fontFamily: GoogleFonts.anekDevanagari().fontFamily),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
