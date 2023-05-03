import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:login_and_signup_using_flutter/SignupPage.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  //variables used for turning viibility of buttons on and off and enabling or disabling the textfields
  bool _isOtpSent = false;
  bool _isVisible = true;
  final TextEditingController _PhonetextController = TextEditingController();
  final TextEditingController _VerificationtextController =
      TextEditingController();
  bool _showWarning = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.15,
              ),

              //logo image
              Container(
                width: 200,
                height: 200,
                child: Image.asset(
                  'assets/images/logo.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.1,
              ),

              //phone number textfield
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: TextField(
                  enabled: !_isOtpSent,
                  controller: _PhonetextController,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(11),
                  ],
                  decoration: InputDecoration(
                    labelText: "Phone Number",
                    hintText: "03xxxxxxxxx",
                    errorText:
                        _showWarning ? "Please enter the phone number" : null,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.phone),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),

              //OTP text-field
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * 0.1,
                ),
                child: TextField(
                  enabled:
                      _isOtpSent, // make the text-field uneditable if otp is already sent
                  keyboardType: TextInputType.number,
                  controller: _VerificationtextController,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6),
                  ],
                  decoration: InputDecoration(
                    labelText: "Verification Code",
                    errorText: _showWarning
                        ? "Please enter the verification code"
                        : null,
                    labelStyle: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                    border: const OutlineInputBorder(),
                    suffixIcon: const Icon(Icons.lock),
                  ),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),

              //Send OTP button
              Visibility(
                visible: _isVisible,
                child: ElevatedButton(
                  onPressed: () {
                    if (_PhonetextController.text.isEmpty) {
                      setState(() {
                        _showWarning = true;
                      });
                    } else {
                      setState(() {
                        _showWarning = false;
                        // send OTP functionality here
                        setState(() {
                          _isOtpSent = true;
                          _isVisible = false; // set _isOtpSent to true
                        });
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2,
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text("Send OTP"),
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.01,
              ),

              //Verify Button
              Visibility(
                visible: !_isVisible,
                child: ElevatedButton(
                  onPressed: () {
                    if (_VerificationtextController.text.isEmpty) {
                      setState(() {
                        _showWarning = true;
                      });
                    } else {
                      setState(() {
                        _showWarning = false;
                        // send OTP functionality here
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => SignUpPage()),
                        );
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: MediaQuery.of(context).size.width * 0.2,
                      vertical: MediaQuery.of(context).size.height * 0.02,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(18.0),
                    ),
                  ),
                  child: const Text("Verify"),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
