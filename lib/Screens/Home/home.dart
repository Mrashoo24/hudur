// ignore_for_file: unused_field

import 'package:flutter/material.dart';
import 'package:flutter_countdown_timer/countdown_timer_controller.dart';
import 'package:flutter_countdown_timer/flutter_countdown_timer.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/models.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';

class Home extends StatefulWidget {
  final UserModel userModel;
  const Home({Key key, this.userModel}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;
  var _isCheckedIn = false;
  var _isCheckedOut = false;
  var _inTime = '';
  var _outTime = '';
  var _inDate = '';
  var _outDate = '';
  var i = 0;

  // var _remainingTimeHours = 0;
  // var _remainingTimeMinutes = 0;
  // var _remainingTimeSeconds = 0;

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
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text(
                'Location permission denied. Please allow it to check-in.')));
        return null;
      }
    }

    _locationData = await location.getLocation();

    return _locationData;
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _countDowmTimer() {
    // int endTime = DateTime.now().millisecondsSinceEpoch + 1000 * 25200;

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
                    1000 * 25200
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
              print("report ${report}");
              var checkin = report == "No Data" ? "-----" : report["checkin"];
              var checkout = report == "No Data" ? "-----" : report["checkout"];
              //  var date = report == "No Data" ? "-----": report["date"];
              // var gotCheckin = DateFormat('hh:mm a').format(DateFormat('hh:mm a').parse(checkin));
              // var gotCheckout = DateFormat('hh:mm a').format(DateFormat('hh:mm a').parse(checkout));
              // if (checkin != "-----") {
              //   _isCheckedIn = true;
              // } else {
              //   _isCheckedIn = false;
              // }
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

              print(
                  "checkout  ${(difference.inSeconds / 3600).toDouble().toPrecision(2)}");
              i++;
              print('checkout value (build $i): $checkout');
              return Container(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      decoration: const BoxDecoration(
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.all(Radius.circular(12.0)),
                        gradient: LinearGradient(
                          begin: Alignment.topRight,
                          end: Alignment.bottomLeft,
                          colors: [
                            Colors.white,
                            Colors.green,
                          ],
                        ),
                      ),
                      width: double.infinity,
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Text(
                              widget.userModel.name,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          checkout == "-----"
                              ? Container()
                              : Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Text(
                                    'Today You Have Checked Out in ($differenceFinal) Hours',
                                    style: const TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.red,
                                    ),
                                  ),
                                ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Container(
                              decoration: const BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    Colors.white,
                                    Colors.green,
                                  ],
                                  begin: Alignment.topRight,
                                  end: Alignment.bottomLeft,
                                ),
                                shape: BoxShape.rectangle,
                                borderRadius: BorderRadius.only(
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
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: const [
                                          Text(
                                            'Status',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              color: Colors.white,
                                            ),
                                          ),
                                          Text(
                                            'Perfect',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          )
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
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
                              color: Colors.amber,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              child: SizedBox(
                                width: 150,
                                height: 170,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.login,
                                      size: 70,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'CHECK IN',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              if (checkin != "-----" && checkout == "-----") {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        backgroundColor: Colors.green,
                                        title: const Text(
                                          'You have already checked-in.',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Dismiss',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      backgroundColor: Colors.green,
                                      title: const Text(
                                        'Confirm Check In',
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      actions: [
                                        TextButton(
                                          child: const Text(
                                            'Check-In',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          onPressed: () async {
                                            var latAndLong =
                                                await getUserLocation();
                                            var result =
                                                await AllApi().getVicinity(
                                              phoneNumber:
                                                  widget.userModel.phoneNumber,
                                              latitude: latAndLong.latitude,
                                              longitude: latAndLong.longitude,
                                            );
                                            print(
                                                'latitude: ${latAndLong.latitude}\nlongitude: ${latAndLong.longitude}');
                                            if (result == 'true') {
                                              _inTime = DateFormat('hh:mm a')
                                                  .format(DateTime.now());
                                              _inDate = DateFormat('dd-MM-yyyy')
                                                  .format(DateTime.now());
                                              Get.back();
                                              setState(() {
                                                loading = true;
                                              });
                                              await AllApi().postCheckIn(
                                                checkInTime: _inTime,
                                                checkOutTime: '-----',
                                                date: _inDate,
                                                phoneNumber: widget
                                                    .userModel.phoneNumber,
                                              );

                                              setState(() {
                                                _isCheckedIn = true;
                                                _isCheckedOut = false;
                                                setState(() {
                                                  loading = false;
                                                });
                                              });
                                            } else {
                                              Get.back();
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(const SnackBar(
                                                      content: Text(
                                                          'You aren\'t in the vicinity of 250 metres from your office.')));
                                            }

                                            // Navigator.of(context).pop();
                                          },
                                        ),
                                        TextButton(
                                          child: const Text(
                                            'Cancel',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
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
                            },
                          ),
                          InkWell(
                            child: Card(
                              color: Colors.amber,
                              shape: const RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(12.0))),
                              child: SizedBox(
                                width: 150,
                                height: 170,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: const [
                                    Icon(
                                      Icons.logout,
                                      size: 70,
                                      color: Colors.white,
                                    ),
                                    Text(
                                      'CHECK OUT',
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ),
                            onTap: () {
                              if (checkin == "-----") {
                                showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        backgroundColor: Colors.green,
                                        title: const Text(
                                          'You need to check-in first.',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context).pop();
                                            },
                                            child: const Text(
                                              'Dismiss',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    });
                              } else {
                                if (checkout != "-----") {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) {
                                        return AlertDialog(
                                          backgroundColor: Colors.green,
                                          title: const Text(
                                            'You have Checked out Already',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.of(context).pop();
                                              },
                                              child: const Text(
                                                'Dismiss',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      });
                                } else {
                                  showDialog(
                                    context: context,
                                    builder: (ctx) {
                                      return AlertDialog(
                                        backgroundColor: Colors.green,
                                        title: const Text(
                                          'Confirm Check Out',
                                          style: TextStyle(
                                            color: Colors.white,
                                          ),
                                        ),
                                        actions: [
                                          TextButton(
                                            child: const Text(
                                              'Check-Out',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
                                            ),
                                            onPressed: () async {
                                              _outTime = DateFormat('hh:mm a')
                                                  .format(DateTime.now());
                                              _outDate =
                                                  DateFormat('dd-MM-yyyy')
                                                      .format(DateTime.now());
                                              Get.back();
                                              setState(() {
                                                loading = true;
                                              });
                                              await AllApi().postCheckIn(
                                                checkInTime: checkin,
                                                checkOutTime: _outTime,
                                                date: _outDate,
                                                phoneNumber: widget
                                                    .userModel.phoneNumber,
                                              );
                                              setState(() {
                                                _isCheckedOut = true;
                                                _isCheckedIn = false;
                                                // _remainingTimeHours = _controller
                                                //     .currentRemainingTime.hours;
                                                // _remainingTimeMinutes =
                                                //     _controller.currentRemainingTime.min;
                                                // _remainingTimeSeconds =
                                                //     _controller.currentRemainingTime.sec;
                                                loading = false;
                                              });
                                            },
                                          ),
                                          TextButton(
                                            child: const Text(
                                              'Cancel',
                                              style: TextStyle(
                                                color: Colors.white,
                                              ),
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
                    )
                  ],
                ),
              );
            });
  }

  Widget _bottomNavigationBar() {
    return BottomNavigationBar(
      currentIndex: _selectedIndex,
      selectedItemColor: Colors.white,
      onTap: (value) {
        _onItemTapped(value);
      },
      items: const [
        BottomNavigationBarItem(
          icon: Icon(
            Icons.home,
            color: Colors.amber,
          ),
          label: 'Home',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book_rounded,
            color: Colors.amber,
          ),
          label: 'Attendance',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.location_city_rounded,
            color: Colors.amber,
          ),
          label: 'Location',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble_outline_rounded,
            color: Colors.amber,
          ),
          label: 'Chat',
          backgroundColor: Colors.green,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.amber,
          ),
          label: 'Settings',
          backgroundColor: Colors.green,
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> _widgetOptions = <Widget>[
      _home(),
      const Text(
        'Index 1: Business',
      ),
      const Text(
        'Index 2: School',
      ),
      const Text(
        'Index 3: School',
      ),
      const Text(
        'Index 4: School',
      ),
    ];
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage('assets/Images/background_image.jpg'),
          fit: BoxFit.cover,
        ),
      ),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.green,
          actions: [
            _countDowmTimer(),
            IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.menu,
                color: Colors.black,
              ),
            ),
          ],
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Container(
            child: _widgetOptions.elementAt(_selectedIndex),
          ),
        ),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }
}
