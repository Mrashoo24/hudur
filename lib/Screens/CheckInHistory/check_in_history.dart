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
  final List _filters = [
    'Early',
    'Late',
    'Perfect',
  ];
  String _selectedFilter;

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
          title: const Text('Check-In History'),
          centerTitle: true,
          backgroundColor: hippieBlue,
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
                padding: const EdgeInsets.all(12.0),
                height: MediaQuery.of(context).size.height * 0.07,
                child: DropdownButtonHideUnderline(
                  child: DropdownButton(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                    isExpanded: true,
                    value: _selectedFilter,
                    onChanged: (value) {
                      setState(() {
                        _selectedFilter = value;
                      });
                    },
                    hint: const Text('Select Filter'),
                    items: _filters.map(
                      (e) {
                        return DropdownMenuItem(
                          value: e,
                          child: Text(e),
                        );
                      },
                    ).toList(),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              FutureBuilder<List<AttendanceReportModel>>(
                future: _allApi.getCheckInHistory(
                  empId: widget.userModel.empId,
                  companyId: widget.userModel.companyId,
                  status: _selectedFilter == 'Early'
                      ? 'early'
                      : _selectedFilter == 'Late'
                          ? 'late'
                          : 'perfect',
                ),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return Center(
                      child: Image.asset("assets/Images/loading.gif"),
                    );
                  } else if (snapshot.data.isEmpty) {
                    return const Center(
                      child: Text('Nothing to show.'),
                    );
                  }
                  var checkInHistoryList = snapshot.data;
                  List<TableRow> tableRow = [
                    TableRow(
                      decoration: BoxDecoration(color: mandysPink),
                      children: const [
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text('Date'),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Check In',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Check Out',
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Working Status',
                          ),
                        ),
                      ],
                    ),
                  ];
                  for (int i = 0; i < checkInHistoryList.length; i++) {
                    tableRow.add(
                      TableRow(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(checkInHistoryList[i].date),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              checkInHistoryList[i].checkInTime,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              checkInHistoryList[i].checkOutTime,
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              checkInHistoryList[i].workingstatus,
                            ),
                          ),
                        ],
                      ),
                    );
                  }
                  return Expanded(
                    child: Table(
                      border: TableBorder.all(),
                      children: tableRow,
                    ),
                  );
                  // return Expanded(
                  //   child: ListView.builder(
                  //     itemCount: checkInHistoryList.length,
                  //     itemBuilder: (context, index) {
                  //       var date = DateFormat('yyyy-MM-dd')
                  //           .parse(checkInHistoryList[index].date);
                  //       var differenceInDays =
                  //           date.difference(DateTime.now()).inDays;
                  //       if (differenceInDays > -90) {
                  //         return Card(
                  //           elevation: 8,
                  //           shape: const RoundedRectangleBorder(
                  //             borderRadius: BorderRadius.all(
                  //               Radius.circular(12.0),
                  //             ),
                  //           ),
                  //           child: Container(
                  //             width: MediaQuery.of(context).size.width,
                  //             height: MediaQuery.of(context).size.height * 0.2,
                  //             padding: const EdgeInsets.all(12.0),
                  //             child: Column(
                  //               mainAxisAlignment:
                  //                   MainAxisAlignment.spaceEvenly,
                  //               crossAxisAlignment: CrossAxisAlignment.start,
                  //               children: [
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     const Text(
                  //                       'Date: ',
                  //                       style: TextStyle(
                  //                         fontSize: 20,
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       checkInHistoryList[index].date,
                  //                       style: const TextStyle(
                  //                         fontSize: 20,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 5,
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     const Text(
                  //                       'Check-In Time: ',
                  //                       style: TextStyle(
                  //                         fontSize: 20,
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       checkInHistoryList[index].checkInTime,
                  //                       style: const TextStyle(
                  //                         fontSize: 20,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 const SizedBox(
                  //                   height: 5,
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     const Text(
                  //                       'Check-Out Time: ',
                  //                       style: TextStyle(
                  //                         fontSize: 20,
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       checkInHistoryList[index].checkOutTime,
                  //                       style: const TextStyle(
                  //                         fontSize: 20,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //                 Row(
                  //                   mainAxisAlignment:
                  //                       MainAxisAlignment.spaceBetween,
                  //                   children: [
                  //                     const Text(
                  //                       'Status: ',
                  //                       style: TextStyle(
                  //                         fontSize: 20,
                  //                       ),
                  //                     ),
                  //                     Text(
                  //                       checkInHistoryList[index].status,
                  //                       style: const TextStyle(
                  //                         fontSize: 20,
                  //                       ),
                  //                     ),
                  //                   ],
                  //                 ),
                  //               ],
                  //             ),
                  //           ),
                  //         );
                  //       } else {
                  //         return Container();
                  //       }
                  //     },
                  //   ),
                  // );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
