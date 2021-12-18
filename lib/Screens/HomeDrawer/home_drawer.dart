import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';
import 'package:hudur/Screens/AdministrativeLeaves/administrative_leaves.dart';
import 'package:hudur/Screens/BenchList/benchlist_page.dart';
import 'package:hudur/Screens/CheckInHistory/check_in_history.dart';
import 'package:hudur/Screens/Enquiry/enquiry_page.dart';
import 'package:hudur/Screens/RelatedSites/related_sites.dart';

class HomeDrawer extends StatelessWidget {
  final UserModel userModel;
  const HomeDrawer({Key key, this.userModel}) : super(key: key);

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
                children: [
                  ListTile(
                    leading: Icon(
                      Icons.find_replace_rounded,
                      color: portica,
                    ),
                    title: const Text('Bench List'),
                    onTap: () {
                      Get.to(
                        BenchList(
                          userModel: userModel,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.web_asset_rounded,
                      color: portica,
                    ),
                    title: const Text('Related Sites'),
                    onTap: () {
                      Get.to(const RelatedSites());
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.history,
                      color: portica,
                    ),
                    title: const Text('Check-In History'),
                    onTap: () {
                      Get.to(
                        CheckInHistory(
                          userModel: userModel,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.chat_bubble_rounded,
                      color: portica,
                    ),
                    title: const Text('Enquiry'),
                    onTap: () {
                      Get.to(
                        Enquiry(
                          userModel: userModel,
                        ),
                      );
                    },
                  ),
                  ListTile(
                    leading: Icon(
                      Icons.admin_panel_settings_rounded,
                      color: portica,
                    ),
                    title: const Text('Administrative Leaves'),
                    onTap: () {
                      Get.to(
                        AdministrativeLeaves(
                          userModel: userModel,
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
