import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';

class AdministrativeLeaves extends StatefulWidget {
  final UserModel userModel;
  const AdministrativeLeaves({Key key, this.userModel}) : super(key: key);

  @override
  _AdministrativeLeavesState createState() => _AdministrativeLeavesState();
}

class _AdministrativeLeavesState extends State<AdministrativeLeaves> {
  final _allApi = AllApi();

  Widget _accepted() {
    return FutureBuilder<List<AdminLeavesModel>>(
      future: _allApi.getAdminLeaves(
        verify: '1',
        companyId: widget.userModel.companyId,
        refId: widget.userModel.refId,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset("assets/Images/loading.gif"),
          );
        } else if (snapshot.data.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Nothing to show here.',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          );
        } else {
          var adminLeavesList = snapshot.data;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: adminLeavesList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Name: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              adminLeavesList[index].employeeName,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Days: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              adminLeavesList[index].days,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'From: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              adminLeavesList[index].from,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'To: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              adminLeavesList[index].to,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Status: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Alloted',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Images/background_image.jpg'),
          fit: BoxFit.fill,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          title: const Text('Administrative Leave'),
          backgroundColor: hippieBlue,
        ),
        body: _accepted(),
      ),
    );
  }
}
