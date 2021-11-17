import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Widget _home() {
    return Container(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          Card(
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(8.0))),
            color: Color.alphaBlend(Colors.blueAccent, Colors.white),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Padding(
                    padding: EdgeInsets.all(20.0),
                    child: Text(
                      'Azzan Saeed Thani Juma Khawan',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'Attendance',
                          style: TextStyle(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'In Time',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '07:30 AM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Out Time',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                ),
                                Text(
                                  '02:30 PM',
                                  style: TextStyle(
                                    color: Colors.white,
                                  ),
                                )
                              ],
                            ),
                            const SizedBox(
                              width: 30,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  'Status',
                                  style: TextStyle(
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
                ],
              ),
            ),
          )
        ],
      ),
    );
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
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.book_rounded,
            color: Colors.amber,
          ),
          label: 'Attendance',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.location_city_rounded,
            color: Colors.amber,
          ),
          label: 'Location',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.chat_bubble_outline_rounded,
            color: Colors.amber,
          ),
          label: 'Chat',
          backgroundColor: Colors.black,
        ),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.amber,
          ),
          label: 'Settings',
          backgroundColor: Colors.black,
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
          backgroundColor: Colors.white,
          actions: [
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
        body: Container(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: _bottomNavigationBar(),
      ),
    );
  }
}
