import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Screens/Leaves/leaves.dart';

class HomeDrawer extends StatelessWidget {
  const HomeDrawer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              color: portica,
              padding: const EdgeInsets.all(18.0),
              child: Image.asset(
                'assets/Images/logo.png',
              ),
            ),
            SizedBox(
              child: Column(
                children: const [
                  // ListTile(
                  //   leading: Icon(
                  //     Icons.question_answer,
                  //     color: portica,
                  //   ),
                  //   title: const Text('Request'),
                  //   onTap: () {
                  //     Get.to(const Leaves());
                  //   },
                  // ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
