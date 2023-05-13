import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flixer/src/signIn/google_signIn.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';


class AccountWidget extends StatefulWidget {
  dynamic userData;
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  AccountWidget(
      {super.key,
      required this.providers,
      required this.platformsSelected,
      required this.setPlatformsSelected,
      required this.setProviders,
      required this.userData});

  @override
  State<AccountWidget> createState() => _AccountWidgetState(
      providers,
      platformsSelected,
      setPlatformsSelected,
      setProviders,
      userData);
}

class _AccountWidgetState extends State<AccountWidget> {
  dynamic userData;
  int count = 0;
  List<dynamic> providers;
  List<dynamic> platformsSelected;
  Function setPlatformsSelected;
  Function setProviders;
  _AccountWidgetState(this.providers, this.platformsSelected,
      this.setPlatformsSelected, this.setProviders, this.userData);

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;

    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.only(top: 50, left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const Row(children: [
                BackButton(
                  color: Colors.white,
                ),
                Text(
                  'Settings',
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ]),
              const SizedBox(
                height: 20,
              ),
              const Row(
                children: [
                  Text(
                    'USER INFORMATION',
                    style: TextStyle(color: Colors.white54, fontSize: 17),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.person,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Username',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        user.displayName!,
                        style: const TextStyle(color: Colors.white54),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.photo,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Profile picture',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.photo_camera_back,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Cover picture',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.edit,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 20,
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white10,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Row(
                    children: [
                      Icon(
                        Icons.mail,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Email',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        user.email!,
                        style: const TextStyle(color: Colors.white54),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.pin_drop,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Country',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'country',
                        style: TextStyle(color: Colors.white54),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white10,
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                children: [
                  Text(
                    'PREFERENCES',
                    style: TextStyle(color: Colors.white54, fontSize: 17),
                  )
                ],
              ),
              const SizedBox(
                height: 30,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.language,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Language',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'language',
                        style: TextStyle(color: Colors.white54),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white10,
              ),
              const SizedBox(
                height: 10,
              ),
              const Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.settings,
                        color: Color.fromRGBO(180, 0, 0, 1),
                        size: 30,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Preference 2',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                        'preference',
                        style: TextStyle(color: Colors.white54),
                      ),
                      SizedBox(
                        width: 10,
                      )
                    ],
                  )
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              const Divider(
                thickness: 2,
                color: Colors.white10,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: TextButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(Colors.white24)),
                onPressed: () {
                  final provider =
                      Provider.of<GoogleSignInProvider>(context, listen: false);
                  provider.logout();
                  Navigator.of(context).popUntil((route) => route.isFirst);

                  String str = widget.userData.toString();

                  if (str != '{}') {
                    DatabaseReference userRef = FirebaseDatabase.instance
                        .ref("users/" + widget.userData['userid']);
                    userRef.remove();
                  }
                },
                child: const Padding(
                    padding: EdgeInsets.all(5),
                    child: Text(
                      'Sign out',
                      style: TextStyle(color: Colors.white, fontSize: 17),
                    ))),
          )
        ],
      ),
    ));
  }
}
