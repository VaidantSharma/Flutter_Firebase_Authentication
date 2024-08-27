import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:login_ui/UIPages/homePage.dart';

class LoginScreenMobile extends StatelessWidget {
  final _phoneController = TextEditingController();
  final _codeController = TextEditingController();

  Future<void> loginUser(String phone, BuildContext context) async {
    FirebaseAuth _auth = FirebaseAuth.instance;

    _auth.verifyPhoneNumber(
      phoneNumber: phone,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (PhoneAuthCredential credential) async {
        try {
          UserCredential result = await _auth.signInWithCredential(credential);
          User? user = result.user;

          if (user != null) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const Homepage(),
              ),
            );
          } else {
            print("Error");
          }
        } catch (e) {
          print("Failed to sign in: $e");
        }
      },
      verificationFailed: (FirebaseAuthException exception) {
        print("Verification failed: ${exception.message}");
      },
      codeSent: (String verificationId, int? resendToken) {
        // Show dialog to enter the code
        showDialog(
          context: context,
          barrierDismissible: false,
          builder: (context) {
            return AlertDialog(
              title: const Text("Enter the code"),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextField(
                    controller: _codeController,
                    keyboardType: TextInputType.number,
                    decoration: const InputDecoration(
                      hintText: "Enter SMS Code",
                    ),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  child: const Text("Confirm"),
                  onPressed: () async {
                    String code = _codeController.text.trim();
                    PhoneAuthCredential credential = PhoneAuthProvider.credential(
                      verificationId: verificationId,
                      smsCode: code,
                    );

                    try {
                      UserCredential result = await _auth.signInWithCredential(credential);
                      User? user = result.user;

                      if (user != null) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const Homepage(), // Adjust this line if Homepage expects arguments
                          ),
                        );
                      } else {
                        print("Error");
                      }
                    } catch (e) {
                      print("Failed to sign in: $e");
                    }
                  },
                ),
              ],
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        // Auto-retrieval timeout
        print("Code auto-retrieval timeout: $verificationId");
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(32),
            child: Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  const Text("Login", style: TextStyle(color: Colors.lightBlue, fontSize: 36, fontWeight: FontWeight.w500),),

                  const SizedBox(height: 30,),

                  TextFormField(
                    decoration: InputDecoration(
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        filled: true,
                        fillColor: Colors.grey[100],
                        hintText: "Mobile Number"

                    ),
                    controller: _phoneController,
                  ),

                  const SizedBox(height: 30,),


                  SizedBox(
                    width: double.infinity,
                    child: TextButton(
                      child: const Text("LOGIN"),
                      onPressed: () {
                        final phone = _phoneController.text.trim();

                        loginUser(phone, context);

                      },
                    ),
                  )
                ],
              ),
            ),
          ),
        )
    );
  }
}