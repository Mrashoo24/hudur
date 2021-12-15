import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';
import 'package:intl/intl.dart';

class CheckInHistory extends StatefulWidget {
  final UserModel userModel;
  const CheckInHistory({Key key, this.userModel}) : super(key: key);

  @override
  _CheckInHistoryState createState() => _CheckInHistoryState();
}

class _CheckInHistoryState extends State<CheckInHistory> {
  final _allApi = AllApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Check-In History'),
        centerTitle: true,
        backgroundColor: hippieBlue,
      ),
      body: FutureBuilder<List<CheckInHistoryModel>>(
        future: _allApi.getCheckInHistory(widget.userModel.refId),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Image.asset("assets/Images/loading.gif"),
            );
          }
          var checkInHistoryList = snapshot.data;
          return ListView.builder(
            itemCount: checkInHistoryList.length,
            itemBuilder: (context, index) {
              var date = DateFormat('dd-MM-yyyy')
                  .parse(checkInHistoryList[index].date);
              var differenceInDays = date.difference(DateTime.now()).inDays;
              if (differenceInDays > -90) {
                return Card(
                  elevation: 5,
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.15,
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Date: ',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              checkInHistoryList[index].date,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Check-In Time: ',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              checkInHistoryList[index].checkInTime,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Check-Out Time: ',
                              style: TextStyle(
                                fontSize: 20,
                              ),
                            ),
                            Text(
                              checkInHistoryList[index].checkOutTime,
                              style: const TextStyle(
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              } else {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(8.0),
                    child:
                        Text('You can view the check-in history for 3 months'),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}
