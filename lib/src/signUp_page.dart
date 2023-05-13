
import 'package:flixer/src/signIn/google_signIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class SignUpPage extends StatefulWidget {
  Function setUserData;
  SignUpPage({Key? key, required this.setUserData}) : super(key: key);

  @override
  State<SignUpPage> createState() => _SignUpPageState(setUserData);
}

class _SignUpPageState extends State<SignUpPage> {
  Function setUserData;
  static const url_image = 'https://image.tmdb.org/t/p/w500';
  int selectedIndex = 0;
  int previousSelectedIndex = 0;
  List<dynamic> platformsSelected = [];

  List<dynamic> movieProviders = [];
  List<dynamic> serieProviders = [];
  List<dynamic> providers = [];

  _SignUpPageState(this.setUserData);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 20,
            ),
            Image.asset(
              'assets/icon/flixerLogo.png',
              height: 100,
              width: 100,
            ),
            const Text(
              'Welcome to flixer',
              style: TextStyle(color: Colors.white),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white)),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: 'Email',
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 20)),
                        cursorColor: Colors.white,
                        strutStyle: StrutStyle.disabled,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius:
                            const BorderRadius.all(Radius.circular(10)),
                        border: Border.all(color: Colors.white)),
                    child: const Padding(
                      padding: EdgeInsets.all(10),
                      child: TextField(
                        decoration: InputDecoration.collapsed(
                            hintText: 'Password',
                            hintStyle:
                                TextStyle(color: Colors.white54, fontSize: 20)),
                        cursorColor: Colors.white,
                        strutStyle: StrutStyle.disabled,
                        style: TextStyle(color: Colors.white, fontSize: 20),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            const Align(
              alignment: Alignment.centerRight,
              child: Text(
                'Forgot Password?',
                style: TextStyle(color: Colors.white),
              ),
            ),
            TextButton(
                style: const ButtonStyle(
                    backgroundColor:
                        MaterialStatePropertyAll(Color.fromRGBO(180, 0, 0, 1))),
                onPressed: () {},
                child: const Text(
                  'Sign In',
                  style: TextStyle(color: Colors.white),
                )),
            const SizedBox(
              height: 20,
            ),
            const Row(
              children: [
                Expanded(
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                    indent: 10.0,
                    endIndent: 15.0,
                  ),
                ),
                Text(
                  'Or continue with',
                  style: TextStyle(color: Colors.white),
                ),
                Expanded(
                  child: Divider(
                    color: Colors.white,
                    thickness: 1,
                    indent: 15.0,
                    endIndent: 10.0,
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin(widget.setUserData);
                    },
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          'assets/logos/googleLogo.png',
                          fit: BoxFit.cover,
                        ))),
                const SizedBox(
                  width: 15,
                ),
                TextButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(Colors.white)),
                    onPressed: () {
                      final provider = Provider.of<GoogleSignInProvider>(
                          context,
                          listen: false);
                      provider.googleLogin(widget.setUserData);
                    },
                    child: SizedBox(
                        height: 30,
                        width: 30,
                        child: Image.asset(
                          'assets/logos/appleLogo.png',
                          fit: BoxFit.cover,
                        ))),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Not a member? Register now',
              style: TextStyle(color: Colors.white),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
