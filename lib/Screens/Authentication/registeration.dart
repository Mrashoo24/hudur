import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Screens/Home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Registeration extends StatefulWidget {
  const Registeration({Key key}) : super(key: key);

  @override
  _RegisterationState createState() => _RegisterationState();
}

class _RegisterationState extends State<Registeration> {
  var _isChecked = false;
  var _userId = '';
  var _userPassword = '';
  bool loading = false;

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _trySubmit() {
    var isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    if (isValid) {
      _formKey.currentState.save();
    }
    return isValid;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Images/background_image.jpg'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(Colors.black.withOpacity(0.6), BlendMode.dstATop),
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
            future: SharedPreferences.getInstance(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Image.asset("assets/Images/loading.gif"),
                );
              }

              SharedPreferences pref = snapshot.requireData;

              return loading
                  ? Center(
                child: Image.asset("assets/Images/loading.gif"),
              )
                  : SingleChildScrollView(
                child: Column(
                  children: [

                    Container(
                      margin: const EdgeInsets.only(top: 20),
                      padding: const EdgeInsets.all(8.0),
                      child: Image.asset('assets/Images/big_logo.png',width: 100,),
                    ),
                    Container(
                      padding: const EdgeInsets.all(40.0),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          children: [

                            Text("Registeration",style: TextStyle(fontSize: 18),),
                          SizedBox(height: 20,),
                            TextFormField(
                              keyboardType: TextInputType.emailAddress,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please input correct details';
                                }

                                return null;
                              },
                              onSaved: (value) {
                                _userId = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                                label: Text(
                                  'Email Id',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),

                            TextFormField(
                              obscureText: true,
                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter password';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userPassword = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: Colors.green,
                                ),
                                label: Text(
                                  'Password',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(

                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Please enter Full Name';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userPassword = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: Colors.green,
                                ),
                                label: Text(
                                  'Full Name',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            TextFormField(

                              validator: (value) {
                                if (value.isEmpty) {
                                  return 'Preferred Location';
                                }
                                return null;
                              },
                              onSaved: (value) {
                                _userPassword = value;
                              },
                              decoration: const InputDecoration(
                                prefixIcon: Icon(
                                  Icons.star_purple500_rounded,
                                  color: Colors.green,
                                ),
                                label: Text(
                                  'Preferred Location',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8.0),
                                  ),
                                ),
                              ),
                            ),
                            ElevatedButton(
                              style: ButtonStyle(
                                backgroundColor:
                                MaterialStateProperty.all<Color>(
                                  Colors.green,
                                ),
                              ),
                              onPressed: () async {
                                var canSignIn = _trySubmit();
                                if (canSignIn) {
                                  Get.snackbar("Form Submitted", "You will able to login post verification you will be notified by email",snackPosition: SnackPosition.BOTTOM);
                                }
                              },
                              child: const Text(
                                'SIGN IN',
                                style: TextStyle(
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            // Row(
                            //   mainAxisAlignment: MainAxisAlignment.center,
                            //   children: [
                            //     const Text(
                            //       'Don\'t have an account?',
                            //       style: TextStyle(
                            //         color: Colors.black,
                            //       ),
                            //     ),
                            //     TextButton(
                            //       onPressed: () {},
                            //       child: const Text(
                            //         'Sign up',
                            //         style: TextStyle(
                            //           color: Colors.green,
                            //         ),
                            //       ),
                            //     ),
                            //   ],
                            // )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
      ),
    );
  }


}

