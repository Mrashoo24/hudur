import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Screens/Home/home.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authentication extends StatefulWidget {
  const Authentication({Key key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  var _isChecked = false;
  var _userPhone = '';
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
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Images/background_image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        body: FutureBuilder(
          future: SharedPreferences.getInstance(),
          builder: (context, snapshot) {

            if(!snapshot.hasData){
              return Center(
                child: Image.asset("assets/Images/loading.gif"),
              );
            }

            SharedPreferences pref = snapshot.requireData;

            return loading ? Center(
              child: Image.asset("assets/Images/loading.gif"),
            ) : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20),
                    padding: const EdgeInsets.all(8.0),
                    child: Image.asset('assets/Images/logo.png'),
                  ),
                  Container(
                    padding: const EdgeInsets.all(40.0),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value.isEmpty || value.length != 10) {
                                return 'Phone Number must be of 10 digits';
                              }
                              return null;
                            },
                            onSaved: (value) {
                              _userPhone = value;
                            },
                            decoration: const InputDecoration(
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.green,
                              ),
                              label: Text(
                                'Phone Number',
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
                                Icons.lock,
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
                          Row(
                            children: [
                              Checkbox(
                                value: _isChecked,
                                onChanged: (value) {
                                  setState(() {
                                    _isChecked = value;
                                  });
                                },
                              ),
                              const Text(
                                'Remember Me',
                                style: TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(
                                Colors.green,
                              ),
                            ),
                            onPressed: () async {
                              var canSignIn = _trySubmit();
                              if (canSignIn) {
                                setState(() {
                                  loading = true;
                                });
                                var result = await AllApi().getUser(_userPhone);
                                if (_userPassword == result.pass &&
                                    _userPhone == result.phoneNumber) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text('Sign in succesful.'),
                                    ),
                                  );

                                 pref.setBool("loggedin", true);

                                 pref.setString("user", jsonEncode(result));

                                  setState(() {
                                    loading = false;
                                  });

                                  Navigator.of(context).pushReplacement(
                                      MaterialPageRoute(builder: (context) {
                                    return Home(
                                      userModel: result,
                                    );
                                  }));

                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Incorrect phone number or password.'),
                                    ),
                                  );
                                }
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
          }
        ),
      ),
    );
  }
}
