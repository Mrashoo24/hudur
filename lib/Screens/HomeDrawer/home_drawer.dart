import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';
import 'package:hudur/Screens/BenchList/benchlist_page.dart';
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
