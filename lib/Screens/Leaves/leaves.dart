import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';

class Leaves extends StatefulWidget {
  final UserModel userModel;
  const Leaves({Key key, this.userModel}) : super(key: key);

  @override
  _LeavesState createState() => _LeavesState();
}

class _LeavesState extends State<Leaves> {
  int _selectedValue = 0;
  var textFieldValues = [];
  var _selectedFromDate = '';
  var _selectedToDate = '';
  final List _filters = [
    'Pending',
    'Accepted',
    'Rejected',
  ];
  String _selectedFilter;

  File _attachment;
  PlatformFile _attachmentPlatformFile;

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
    @required String title,
    @required String subtitle,
    @required int value,
    @required List details,
    List attachments,
  }) {
    return RadioListTile(
      activeColor: hippieBlue,
      secondary: ElevatedButton(
        style: ButtonStyle(
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(12.0),
              ),
            ),
          ),
          backgroundColor: MaterialStateProperty.all<Color>(hippieBlue),
        ),
        child: const Text('Details'),
        onPressed: value == _selectedValue
            ? () {
                _onPressedDetails(
                  details: details,
                  title: title,
                  attachments: attachments,
                );
              }
            : null,
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

  Widget _requestTab() {
    return FutureBuilder<List<LeaveRequestsModel>>(
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
                        attachments: leaveRequests[index].attachments,
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }
      },
    );
  }

  Widget _historyTab() {
    return Container(
      padding: const EdgeInsets.all(12.0),
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
          FutureBuilder<List<EmployeeLeaveRequestsModel>>(
            future: AllApi().getEmployeeLeaveRequests(
              refId: widget.userModel.refId,
              verify: _selectedFilter == 'Accepted'
                  ? '1'
                  : _selectedFilter == 'Rejected'
                      ? '-1'
                      : '0',
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Image.asset('assets/Images/loading.gif'),
                );
              } else if (snapshot.data.isEmpty) {
                return const Center(
                  child: Text('Nothing to show here.'),
                );
              } else {
                var list = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) {
                      return _historyCard(
                        list: list,
                        index: index,
                      );
                    },
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _historyCard({
    @required List<EmployeeLeaveRequestsModel> list,
    @required int index,
  }) {
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(8.0),
        // height: MediaQuery.of(context).size.height * 0.1,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Title: ',
                ),
                Text(
                  list[index].title,
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Date: ',
                ),
                Text(
                  list[index].date,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'From: ',
                ),
                Text(
                  list[index].from,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'To: ',
                ),
                Text(
                  list[index].to,
                )
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Status: ',
                ),
                Text(
                  list[index].verify == '1'
                      ? 'Accepted'
                      : list[index].verify == '0'
                          ? 'Pending'
                          : 'Rejected',
                ),
              ],
            ),
          ],
        ),
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
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Requests'),
            backgroundColor: hippieBlue,
            bottom: TabBar(
              indicatorColor: portica,
              tabs: const [
                Tab(
                  child: Text('Requests'),
                ),
                Tab(
                  child: Text('History'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _requestTab(),
              _historyTab(),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedDetails({
    @required List details,
    @required String title,
    List attachments,
  }) {
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (ctx) {
        var isLoading = false;
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: isLoading ? null : const Text('Details'),
              content: isLoading
                  ? Container(
                      height: MediaQuery.of(context).size.height * 0.05,
                      alignment: Alignment.center,
                      child: Row(
                        children: const [
                          CircularProgressIndicator(),
                          SizedBox(
                            width: 30,
                          ),
                          Text('Please wait'),
                        ],
                      ),
                    )
                  : SingleChildScrollView(
                      child: Form(
                        key: _formkey,
                        child: Column(
                          children: [
                            SizedBox(
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height * 0.15,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    child: TextFormField(
                                      enabled: false,
                                      decoration: InputDecoration(
                                        hintText: _selectedFromDate == ''
                                            ? 'From'
                                            : _selectedFromDate,
                                        hintStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    onTap: () {
                                      DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        minTime: DateTime.now(),
                                        maxTime: DateTime(2050, 6, 7),
                                        onChanged: (date) {
                                          setStateDialog(() {
                                            _selectedFromDate =
                                                DateFormat('dd/MM/yyyy hh:mm a')
                                                    .format(date);
                                          });
                                        },
                                        onConfirm: (date) {
                                          setStateDialog(() {
                                            _selectedFromDate =
                                                DateFormat('dd/MM/yyyy hh:mm a')
                                                    .format(date);
                                          });
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en,
                                      );
                                    },
                                  ),
                                  InkWell(
                                    child: TextFormField(
                                      decoration: InputDecoration(
                                        hintText: _selectedToDate == ''
                                            ? 'To'
                                            : _selectedToDate,
                                        hintStyle: const TextStyle(
                                          color: Colors.black,
                                        ),
                                      ),
                                      enabled: false,
                                    ),
                                    onTap: () {
                                      DatePicker.showDatePicker(
                                        context,
                                        showTitleActions: true,
                                        minTime: DateTime.now(),
                                        maxTime: DateTime(2050, 6, 7),
                                        onChanged: (date) {
                                          setStateDialog(() {
                                            _selectedToDate =
                                                DateFormat('dd/MM/yyyy hh:mm a')
                                                    .format(date);
                                          });
                                        },
                                        onConfirm: (date) {
                                          setStateDialog(() {
                                            _selectedToDate =
                                                DateFormat('dd/MM/yyyy hh:mm a')
                                                    .format(date);
                                          });
                                        },
                                        currentTime: DateTime.now(),
                                        locale: LocaleType.en,
                                      );
                                    },
                                  ),
                                ],
                              ),
                            ),
                            if (details.isNotEmpty)
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
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
                            const SizedBox(
                              height: 10,
                            ),
                            if (attachments != null)
                              Container(
                                alignment: Alignment.centerLeft,
                                child: const Text('Attachments'),
                              ),
                            const SizedBox(
                              height: 10,
                            ),
                            if (attachments != null && _attachment == null)
                              SizedBox(
                                width: MediaQuery.of(context).size.width,
                                height:
                                    MediaQuery.of(context).size.height * 0.25,
                                child: InkWell(
                                  child: ListView.builder(
                                    itemCount: attachments.length,
                                    itemBuilder: (context, index) {
                                      return TextFormField(
                                        enabled: false,
                                        decoration: InputDecoration(
                                          hintText: attachments[index],
                                        ),
                                      );
                                    },
                                  ),
                                  onTap: () async {
                                    final result =
                                        await FilePicker.platform.pickFiles();
                                    if (result == null) {
                                      return;
                                    } else {
                                      final file = result.files.first;
                                      final newFile = await saveFile(file);
                                      setStateDialog(() {
                                        _attachment = newFile;
                                        _attachmentPlatformFile = file;
                                      });
                                    }
                                  },
                                ),
                              ),
                            if (_attachment != null && attachments != null)
                              _buildFile(),
                          ],
                        ),
                      ),
                    ),
              actions: isLoading
                  ? null
                  : [
                      TextButton(
                        onPressed: () async {
                          var _canSubmit = _trySubmit();
                          if (attachments == null) {
                            if (_canSubmit &&
                                (_selectedFromDate != '' &&
                                    _selectedToDate != '')) {
                              setStateDialog(() {
                                isLoading = true;
                              });
                              var result = await AllApi().postLeaveRequest(
                                empName: widget.userModel.name,
                                companyId: widget.userModel.companyId,
                                date: DateFormat('dd-MM-yyyy')
                                    .format(DateTime.now()),
                                details: textFieldValues,
                                refId: widget.userModel.refId,
                                title: title,
                                fromDate: _selectedFromDate,
                                toDate: _selectedToDate,
                              );

                              setStateDialog(() {
                                isLoading = false;
                              });

                              Get.back();

                              if (result == 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Request Sent.'),
                                  ),
                                );
                                setState(() {
                                  _selectedFromDate = '';
                                  _selectedToDate = '';
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to sent request.'),
                                  ),
                                );
                                setState(() {
                                  _selectedFromDate = '';
                                  _selectedToDate = '';
                                });
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please fill all the details.'),
                                ),
                              );
                            }
                          } else {
                            if (_attachment != null) {
                              setStateDialog(() {
                                isLoading = true;
                              });
                              var result = await AllApi().setFile(_attachment);
                              setStateDialog(() {
                                isLoading = false;
                              });
                              if (result == '1') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Request Sent.'),
                                  ),
                                );
                                setState(() {
                                  _selectedFromDate = '';
                                  _selectedToDate = '';
                                  _attachment = null;
                                });
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to sent request.'),
                                  ),
                                );
                                setState(() {
                                  _selectedFromDate = '';
                                  _selectedToDate = '';
                                  _attachment = null;
                                });
                              }
                              Get.back();
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Please provide attachment.'),
                                ),
                              );
                            }
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
    );
  }

  Widget _buildFile() {
    return InkWell(
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.5,
        height: MediaQuery.of(context).size.height * 0.1,
        child: FittedBox(
          child: Row(
            children: [
              const Icon(
                Icons.file_copy_rounded,
              ),
              const SizedBox(
                width: 5,
              ),
              FittedBox(child: Text(_attachmentPlatformFile.name)),
            ],
          ),
        ),
      ),
      onTap: () async {
        await OpenFile.open(_attachment.path);
      },
    );
  }

  Future<File> saveFile(PlatformFile file) async {
    final appStorage = await getApplicationDocumentsDirectory();
    final newFile = File('${appStorage.path}/${file.name}');
    return File(file.path).copy(newFile.path);
  }
}
