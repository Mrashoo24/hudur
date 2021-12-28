import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';
import 'package:intl/intl.dart';

class Leaves extends StatefulWidget {
  final UserModel userModel;
  const Leaves({Key key, this.userModel}) : super(key: key);

  @override
  _LeavesState createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  int _selectedValue = 0;

  final GlobalKey<FormState> _formkey = GlobalKey<FormState>();

  bool _trySubmit() {
    var _isValid = _formkey.currentState.validate();
    if (_isValid) {
      FocusScope.of(context).unfocus();
      _formkey.currentState.save();
    }
    return _isValid;
  }

  Widget _radioListTile({
    String title,
    String subtitle,
    int value,
    List details,
  }) {
    var textFieldValues = [];
    return RadioListTile(
      activeColor: hippieBlue,
      secondary: ElevatedButton(
        style: ButtonStyle(
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(12.0)))),
            backgroundColor: MaterialStateProperty.all<Color>(hippieBlue)),
        child: const Text('Details'),
        onPressed: () {
          showDialog(
            context: context,
            builder: (ctx) {
              return AlertDialog(
                title: const Text('Details'),
                content: Form(
                  key: _formkey,
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height,
                    child: ListView.builder(
                      itemCount: details.length,
                      itemBuilder: (ctx, index) {
                        return TextFormField(
                          decoration: InputDecoration(
                            hintText: details[index],
                          ),
                          onSaved: (value) {
                            textFieldValues.add(value);
                          },
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please fill out this field';
                            }
                            return null;
                          },
                        );
                      },
                    ),
                  ),
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      var _canSubmit = _trySubmit();
                      if (_canSubmit) {
                        await AllApi().postLeaveRequest(
                          widget.userModel.phoneNumber,
                          DateFormat('dd-MM-yyyy').format(DateTime.now()),
                          title,
                          textFieldValues,
                          widget.userModel.companyId,
                        );
                        Get.back();
                      }
                    },
                    child: const Text('Submit'),
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
      value: value,
      title: Text(
        title,
      ),
      subtitle: Text(
        subtitle,
      ),
      groupValue: _selectedValue,
      onChanged: (value) => setState(
        () {
          _selectedValue = value;
        },
      ),
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
          title: const Text('Requests'),
          backgroundColor: hippieBlue,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder<List<LeaveRequestsModel>>(
            future: AllApi().getLeaveRequests(widget.userModel.companyId),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Image.asset('assets/Images/loading.gif'),
                );
              } else {
                var leaveRequests = snapshot.data;
                return SizedBox(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text(
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
                      Expanded(
                        child: ListView.builder(
                          itemCount: leaveRequests.length,
                          itemBuilder: (context, index) {
                            return _radioListTile(
                              title: leaveRequests[index].title,
                              subtitle: leaveRequests[index].subtitle,
                              value: index + 1,
                              details: leaveRequests[index].details,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}
