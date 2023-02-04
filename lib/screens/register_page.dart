import 'package:auth_practice/components/square_tile.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../components/my_textfield.dart';
import '../services/auth_services.dart';

class RegisterPage extends StatefulWidget {
  final Function() onTap;
  const RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  //text editing controllers
  final emailController = TextEditingController();
  final passController = TextEditingController();
  final conPassController = TextEditingController();

  // sign user in method
  void signUserUp() async {
    //show loading circle
    showDialog(
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
      context: context,
    );

    //try creating the user
    try {
      //check password == confirm password
      if (passController.text == conPassController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,          
          password: passController.text,
        );
        Navigator.pop(context); // if gets logged in pop loading
      } else {
        Navigator.pop(context); // if gets error pop loading
        // show error message password != confirmpassword
        showErrorMessage("Password and confirm password are not matching");
      }
    } on FirebaseAuthException catch (error) {
      // if get an error pop the loading and display error
      Navigator.pop(context);

      //show error message
      showErrorMessage(error.code);
    }
  }

  //show the error message to the user
  void showErrorMessage(String message) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Center(
            child: Text(
              message,
              style: const TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: SingleChildScrollView(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 50),
                //logo
                const Icon(
                  Icons.lock,
                  size: 50,
                ),
                const SizedBox(height: 50),

                //lets create an account for you
                Text(
                  'Let\'s create an account.',
                  style: TextStyle(
                    color: Colors.grey[300],
                    fontSize: 16,
                  ),
                ),

                // email text field
                MyTextField(
                  hintText: 'Email.',
                  controller: emailController,
                  obsecuretext: false,
                ),

                const SizedBox(height: 5),
                //passsword field
                MyTextField(
                  hintText: 'Password',
                  controller: passController,
                  obsecuretext: true,
                ),
                const SizedBox(height: 5),

                // confirm password field
                MyTextField(
                  hintText: 'Confirm Password',
                  controller: conPassController,
                  obsecuretext: true,
                ),

                const SizedBox(height: 25),
                // sign in button
                MyButton(
                  text: 'Sign Up',
                  onTap: signUserUp,
                ),

                const SizedBox(height: 40),

                // or continue with
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          'Or continue with',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                          color: Colors.grey[400],
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),

                const SizedBox(height: 25),

                // google + apple sign in
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SquareTile(
                      imagePath: 'assets/images/google.png',
                      onTap: () => AuthService().signInWithGoogle(),
                    ),
                  ],
                ),
                const SizedBox(height: 10),

                // not a member register now
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account?',
                        style: TextStyle(color: Colors.grey[700]),
                      ),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: const Text(
                          "Login Now.",
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
