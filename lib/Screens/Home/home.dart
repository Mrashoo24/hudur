import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';
import 'package:hudur/Screens/Courses/courses.dart';
import 'package:hudur/Screens/HomeDrawer/home_drawer.dart';
import 'package:hudur/Screens/Leaves/leaves.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  final UserModel userModel;
  const Home({Key key, this.userModel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _inTime = '';
  var _outTime = '';
  var _inDate = '';
  var _outDate = '';
  var _vicinityLoading = false;

  File image;

  CountdownTimerController _controller;
  bool loading = false;

  // ignore: unnecessary_new
  Location location = new Location();
  bool _serviceEnabled;
  PermissionStatus _permissionGranted;
  LocationData _locationData;

  Future<LocationData> getUserLocation() async {
    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location service is disabled. Please enable it to check-in.')));
        return null;
      }
    }

    _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'Location permission denied. Please allow it to check-in.'),
          ),
        );
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  @override
  void initState() {
    getUserLocation().then((value) {
      setState(() {
        _locationData = value;
      });
    });
    super.initState();
  }

  Future _imagePicker() async {
    try {
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image == null) {
        return;
      }
      final imageTemporary = File(image.path);
      setState(() {
        this.image = imageTemporary;
      });
    } on PlatformException catch (e) {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text(e.message)));
    }
  }

  Widget _countDownTimer() {
    return FutureBuilder(
      future: AllApi().getCheckIn(
        phoneNumber: widget.userModel.phoneNumber,
        date: DateFormat('dd-MM-yyyy').format(DateTime.now()),
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset("assets/Images/loading.gif"),
          );
        } else {
          var report = snapshot.requireData;
          String checkInTime = "-----";
          String checkOutTime = "-----";
          String date = "-----";
          int endTime = 0;
          if (report != "No Data") {
            checkInTime = report["checkin"];
            checkOutTime = report["checkout"];
            date = report["date"];
            var dateAndTime =
                DateFormat('hh:mm a').parse(checkInTime).toString();
            var splitDateAndTime = dateAndTime.split(' ');
            checkInTime = splitDateAndTime[1];
            String day = date.substring(0, 2);
            String month = date.substring(3, 5);
            String year = date.substring(6, 10);
            date = year + '-' + month + '-' + day;
            endTime = checkOutTime == "-----"
                ? DateTime.parse(date + ' ' + checkInTime)
                        .millisecondsSinceEpoch +
                    (1000 * (int.parse(widget.userModel.hoursOfShift) * 3600))
                : 0;
          }
          _controller = CountdownTimerController(endTime: endTime);

          return Center(
            child: Container(
              padding: const EdgeInsets.all(8.0),
              child: CountdownTimer(
                endWidget: const Text(''),
                endTime: endTime,
                textStyle: const TextStyle(
                  color: Colors.white,
                ),
                controller: _controller,
              ),
            ),
          );
        }
      },
    );
  }

  Widget _home() {
    return loading
        ? Center(
            child: Image.asset("assets/Images/loading.gif"),
          )
        : FutureBuilder(
            future: AllApi().getCheckIn(
                phoneNumber: widget.userModel.phoneNumber,
                date: DateFormat('dd-MM-yyyy').format(DateTime.now())),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Image.asset("assets/Images/loading.gif"),
                );
              }

              var report = snapshot.requireData;
              var checkin = report == "No Data" ? "-----" : report["checkin"];
              var checkout = report == "No Data" ? "-----" : report["checkout"];

              var start = report == "No Data"
                  ? DateFormat('hh:mm a').parse("00:00 AM")
                  : DateFormat('hh:mm a').parse(checkin);

              var end = report == "No Data"
                  ? DateFormat('hh:mm a').parse("00:00 AM")
                  : checkout == "-----"
                      ? DateFormat('hh:mm a').parse("00:00 AM")
                      : DateFormat('hh:mm a').parse(checkout);

              Duration difference = end.difference(start);
              var differenceFinal = ((difference.inSeconds / 3600) - 7.0)
                  .toDouble()
                  .toPrecision(2);

              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12.0)),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            portica,
                            const Color(0xFF6392B0),
                          ],
                        ),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(22.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    widget.userModel.name,
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 22,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'Id: ' + widget.userModel.empId,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    widget.userModel.email,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    widget.userModel.phoneNumber,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    widget.userModel.designation,
                                    style: const TextStyle(
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                              InkWell(
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.1,
                                  width:
                                      MediaQuery.of(context).size.width * 0.2,
                                  child: image != null
                                      ? Image.file(image)
                                      : Image.asset(
                                          'assets/Images/homelogo.png',
                                          fit: BoxFit.cover,
                                        ),
                                ),
                                onTap: () {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text('Change Logo'),
                                        content: const Text(
                                          'You can change the logo to any image of your choice.',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                              _imagePicker();
                                            },
                                            child: const Text('Change'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          checkout == "-----"
                              ? Container()
                              : Center(
                                  child: Text(
                                    'Today You Have Checked Out in ($differenceFinal) Hours',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  portica,
                                  const Color(0xFF6392B0),
                                ],
                                begin: Alignment.topRight,
                                end: Alignment.bottomLeft,
                              ),
                              shape: BoxShape.rectangle,
                              borderRadius: const BorderRadius.only(
                                  bottomLeft: Radius.circular(8.0),
                                  bottomRight: Radius.circular(8.0)),
                            ),
                            padding: const EdgeInsets.all(20.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Attendance',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'In Time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          checkin,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Out Time',
                                          style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            color: Colors.white,
                                          ),
                                        ),
                                        Text(
                                          checkout,
                                          style: const TextStyle(
                                            color: Colors.white,
                                          ),
                                        )
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    // Column(
                                    //   crossAxisAlignment:
                                    //       CrossAxisAlignment.start,
                                    //   children: const [
                                    //     Text(
                                    //       'Status',
                                    //       style: TextStyle(
                                    //         fontWeight: FontWeight.bold,
                                    //         color: Colors.white,
                                    //       ),
                                    //     ),
                                    //     Text(
                                    //       'Perfect',
                                    //       style: TextStyle(
                                    //         color: Colors.white,
                                    //       ),
                                    //     )
                                    //   ],
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Card(
                              color: hippieBlue,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                padding: const EdgeInsets.all(22.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.login,
                                      // size: 70,
                                      color: portica,
                                    ),
                                    Text(
                                      'CHECK IN',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: portica,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              if (checkin != "-----" && checkout == "-----") {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text(
                                        'You have already checked-in.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Dismiss',
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) {
                                    return StatefulBuilder(
                                      builder: (context, setStateDialog) =>
                                          AlertDialog(
                                        title: const Text(
                                          'Confirm Check In',
                                        ),
                                        actions: [
                                          _vicinityLoading
                                              ? const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                )
                                              : TextButton(
                                                  child: const Text(
                                                    'Check-In',
                                                  ),
                                                  onPressed: () async {
                                                    setStateDialog(() {
                                                      _vicinityLoading = true;
                                                    });
                                                    var result = await AllApi()
                                                        .getVicinity(
                                                      phoneNumber: widget
                                                          .userModel
                                                          .phoneNumber,
                                                      latitude: _locationData
                                                          .latitude,
                                                      longitude: _locationData
                                                          .longitude,
                                                    );
                                                    setStateDialog(() {
                                                      _vicinityLoading = false;
                                                    });
                                                    if (result == true) {
                                                      _inTime = DateFormat(
                                                              'hh:mm a')
                                                          .format(
                                                              DateTime.now());
                                                      _inDate = DateFormat(
                                                              'dd-MM-yyyy')
                                                          .format(
                                                              DateTime.now());
                                                      Get.back();
                                                      setState(
                                                        () {
                                                          loading = true;
                                                        },
                                                      );
                                                      await AllApi()
                                                          .postCheckIn(
                                                        checkInTime: _inTime,
                                                        checkOutTime: '-----',
                                                        date: _inDate,
                                                        phoneNumber: widget
                                                            .userModel
                                                            .phoneNumber,
                                                        companyId: widget
                                                            .userModel
                                                            .companyId,
                                                      );

                                                      setState(
                                                        () {
                                                          loading = false;
                                                        },
                                                      );
                                                    } else {
                                                      Get.back();
                                                      showDialog(
                                                        barrierDismissible:
                                                            false,
                                                        context: context,
                                                        builder: (ctx) {
                                                          return AlertDialog(
                                                            title: const Text(
                                                              'Check-in not allowed.',
                                                            ),
                                                            content: const Text(
                                                              'You aren\'t in the vicinity of 250 metres from your office.',
                                                            ),
                                                            actions: [
                                                              TextButton(
                                                                onPressed:
                                                                    () async {
                                                                  Get.back();
                                                                  await AllApi()
                                                                      .postCheckInRequest(
                                                                          companyId: widget
                                                                              .userModel
                                                                              .companyId,
                                                                          date: DateFormat('dd-MM-yyyy')
                                                                              .format(
                                                                            DateTime.now(),
                                                                          ),
                                                                          phoneNumber: widget
                                                                              .userModel
                                                                              .phoneNumber,
                                                                          lat: _locationData
                                                                              .latitude
                                                                              .toString(),
                                                                          lon: _locationData
                                                                              .longitude
                                                                              .toString(),
                                                                          name: widget
                                                                              .userModel
                                                                              .name);
                                                                  var allowCheckIn =
                                                                      await AllApi().getUser(widget
                                                                          .userModel
                                                                          .email);
                                                                  if (allowCheckIn
                                                                      .allowCheckin) {
                                                                    _inTime =
                                                                        DateFormat(
                                                                      'hh:mm a',
                                                                    ).format(
                                                                      DateTime
                                                                          .now(),
                                                                    );
                                                                    _inDate =
                                                                        DateFormat(
                                                                      'dd-MM-yyyy',
                                                                    ).format(
                                                                      DateTime
                                                                          .now(),
                                                                    );
                                                                    Get.back();
                                                                    setState(
                                                                      () {
                                                                        loading =
                                                                            true;
                                                                      },
                                                                    );
                                                                    await AllApi()
                                                                        .postCheckIn(
                                                                      companyId: widget
                                                                          .userModel
                                                                          .companyId,
                                                                      checkInTime:
                                                                          _inTime,
                                                                      checkOutTime:
                                                                          '-----',
                                                                      date:
                                                                          _inDate,
                                                                      phoneNumber: widget
                                                                          .userModel
                                                                          .phoneNumber,
                                                                    );
                                                                    await AllApi()
                                                                        .postOuterGeoList(
                                                                      companyId: widget
                                                                          .userModel
                                                                          .companyId,
                                                                      phoneNumber: widget
                                                                          .userModel
                                                                          .phoneNumber,
                                                                      date:
                                                                          _inDate,
                                                                      lat: _locationData
                                                                          .latitude
                                                                          .toString(),
                                                                      lon: _locationData
                                                                          .longitude
                                                                          .toString(),
                                                                    );
                                                                    Fluttertoast
                                                                        .showToast(
                                                                      msg:
                                                                          "Logged in",
                                                                    );
                                                                    setState(
                                                                      () {
                                                                        loading =
                                                                            false;
                                                                      },
                                                                    );
                                                                  } else {
                                                                    ScaffoldMessenger.of(
                                                                            context)
                                                                        .showSnackBar(
                                                                      const SnackBar(
                                                                        content:
                                                                            Text(
                                                                          'You are not allowed to check-in.',
                                                                        ),
                                                                      ),
                                                                    );
                                                                  }
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Send Request',
                                                                ),
                                                              ),
                                                              TextButton(
                                                                onPressed: () {
                                                                  Get.back();
                                                                },
                                                                child:
                                                                    const Text(
                                                                  'Cancel',
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      );
                                                    }
                                                  },
                                                ),
                                          _vicinityLoading == false
                                              ? TextButton(
                                                  child: const Text(
                                                    'Cancel',
                                                  ),
                                                  onPressed: () {
                                                    Navigator.of(context).pop();
                                                  },
                                                )
                                              : const Text('')
                                        ],
                                      ),
                                    );
                                  },
                                );
                              }
                            },
                          ),
                          InkWell(
                            child: Card(
                              color: prelude,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                padding: const EdgeInsets.all(22.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.logout,
                                      // size: 70,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'CHECK OUT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              if (checkin == "-----") {
                                showDialog(
                                  barrierDismissible: false,
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      title: const Text(
                                        'You need to check-in first.',
                                      ),
                                      actions: [
                                        TextButton(
                                          onPressed: () {
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            'Dismiss',
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                );
                              } else {
                                if (checkout != "-----") {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text(
                                          'You have Checked out Already',
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Dismiss',
                                            ),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                } else {
                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Confirm Check Out',
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              'Check-Out',
                                            ),
                                            onPressed: () async {
                                              _outTime = DateFormat('hh:mm a')
                                                  .format(DateTime.now());
                                              _outDate =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(DateTime.now());
                                              Get.back();
                                              setState(
                                                () {
                                                  loading = true;
                                                },
                                              );
                                              await AllApi().postCheckIn(
                                                companyId:
                                                    widget.userModel.companyId,
                                                checkInTime: checkin,
                                                checkOutTime: _outTime,
                                                date: _outDate,
                                                phoneNumber: widget
                                                    .userModel.phoneNumber,
                                              );
                                              var time1 = DateFormat('hh:mm a')
                                                  .parse(checkin);
                                              var time2 = DateFormat('hh:mm a')
                                                  .parse(widget
                                                      .userModel.reportingTime);
                                              var delayInHours = time2
                                                  .difference(time1)
                                                  .inHours;
                                              var delayInMinutes = time2
                                                  .difference(time1)
                                                  .inMinutes;
                                              var status = '';
                                              if (delayInHours < 0 ||
                                                  delayInMinutes < 0) {
                                                status = 'late';
                                              } else if (delayInHours > 0 ||
                                                  delayInMinutes > 0) {
                                                status = 'early';
                                              } else {
                                                status = 'on-time';
                                              }
                                              await AllApi()
                                                  .postAttendanceReport(
                                                checkInDelayInHours:
                                                    delayInHours.toString(),
                                                checkInDelayInMinutes:
                                                    delayInMinutes.toString(),
                                                checkOutDifference:
                                                    differenceFinal.toString(),
                                                companyId:
                                                    widget.userModel.companyId,
                                                empId: widget.userModel.empId,
                                                status: status,
                                              );

                                              setState(
                                                () {
                                                  loading = false;
                                                },
                                              );
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'Cancel',
                                            ),
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                          )
                                        ],
                                      );
                                    },
                                  );
                                }
                              }
                            },
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                        bottom: 10,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            child: Card(
                              color: summerGreen,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                padding: const EdgeInsets.all(22.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.airplane_ticket,
                                      // size: 70,
                                      color: portica,
                                    ),
                                    Text(
                                      'LEAVES',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: portica,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.to(
                                () => Leaves(
                                  userModel: widget.userModel,
                                ),
                              );
                            },
                          ),
                          InkWell(
                            child: Card(
                              color: mandysPink,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.4,
                                height:
                                    MediaQuery.of(context).size.height * 0.2,
                                padding: const EdgeInsets.all(22.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.book,
                                      // size: 70,
                                      color: hippieBlue,
                                    ),
                                    Text(
                                      'COURSES',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: hippieBlue,
                                        fontSize: 12,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              Get.to(
                                () => Courses(
                                  userModel: widget.userModel,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
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
        drawer: HomeDrawer(
          userModel: widget.userModel,
        ),
        appBar: AppBar(
          backgroundColor: const Color(0xFF6392B0),
          actions: [
            _countDownTimer(),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            child: _home(),
          ),
        ),
      ),
    );
  }
}
