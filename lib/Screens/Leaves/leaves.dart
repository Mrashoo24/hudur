import 'package:flutter/material.dart';

class Leaves extends StatefulWidget {
  const Leaves({Key key}) : super(key: key);

  @override
  _LeavesState createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  int _selectedValue = 0;
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
        appBar: AppBar(
          title: const Text('Request'),
          backgroundColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(8.0),
                child: const Text(
                  'Select reason for your leave request: ',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                secondary: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade300)),
                  child: const Text('Details'),
                  onPressed: () {},
                ),
                value: 1,
                title: const Text('Official Mission Statement'),
                subtitle: const Text(
                    'Click the Details button to fill in project details.'),
                groupValue: _selectedValue,
                onChanged: (value) => setState(
                  () {
                    _selectedValue = 1;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                secondary: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade300)),
                  child: const Text('Attach'),
                  onPressed: () {},
                ),
                value: 2,
                title: const Text('Hospital Appointment Permit'),
                subtitle: const Text(
                    'Click the Attach button to attach appointment notice.'),
                groupValue: _selectedValue,
                onChanged: (value) => setState(
                  () {
                    _selectedValue = 2;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                secondary: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade300)),
                  child: const Text('Reason'),
                  onPressed: () {},
                ),
                value: 3,
                title: const Text('Personal Leave'),
                subtitle: const Text(
                    'Click the Reason button to specify leave reason.'),
                groupValue: _selectedValue,
                onChanged: (value) => setState(
                  () {
                    _selectedValue = 3;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                secondary: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade300)),
                  child: const Text('Details'),
                  onPressed: () {},
                ),
                value: 4,
                title: const Text('Study Hour Permit'),
                subtitle: const Text(
                    'Click the Details button to fill in study leave details.'),
                groupValue: _selectedValue,
                onChanged: (value) => setState(
                  () {
                    _selectedValue = 4;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              RadioListTile(
                secondary: ElevatedButton(
                  style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(12.0)))),
                      backgroundColor: MaterialStateProperty.all<Color>(
                          Colors.green.shade300)),
                  child: const Text('Details'),
                  onPressed: () {},
                ),
                value: 5,
                title: const Text('Maternity Hour Permit'),
                subtitle: const Text(
                    'Click the Details button to fill in maternity leave details.'),
                groupValue: _selectedValue,
                onChanged: (value) => setState(
                  () {
                    _selectedValue = 5;
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
