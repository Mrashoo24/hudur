import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';

class Services extends StatefulWidget {
  final UserModel userModel;
  const Services({Key key, this.userModel}) : super(key: key);

  @override
  _ServicesState createState() => _ServicesState();
}

class _ServicesState extends State<Services> {
  final _formKey = GlobalKey<FormState>();
  final _allApi = AllApi();
  final _services = [
    'Certificate with detailed salary',
    'Certificate with total salary',
    'Certificate without salary',
  ];
  final List _filters = [
    'Pending',
    'Accepted',
    'Rejected',
  ];
  String _selectedFilter;
  List<String> _textFieldValues = [];
  var _isOpening = false;
  List<ServicesModel> _requestsList;
  List<DynamicServiceRequestModel> _dynamicRequests;

  Widget _servicesList() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: MediaQuery.of(context).size.height,
          height: MediaQuery.of(context).size.width,
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: _services.length,
            itemBuilder: (context, index) {
              return _servicesCard(
                servicesList: _services,
                index: index,
                onPressedRequest: () {
                  _onPressedRequest(
                    certificateName: _services[index],
                  );
                },
              );
            },
          ),
        ),
        const Padding(
          padding: EdgeInsets.all(8.0),
          child: Text('More Services'),
        ),
        Expanded(
          child: FutureBuilder<List<ServiceDynamicModel>>(
            future: _allApi.getDynamicServices(
              companyId: widget.userModel.companyId,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return const Center(
                  child: Image(
                    image: AssetImage('assets/Images/loading.gif'),
                  ),
                );
              }
              var list = snapshot.data;
              return ListView.builder(
                itemCount: list.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      title: Text(
                        list[index].name,
                      ),
                      trailing: ElevatedButton(
                        child: const Text('Request'),
                        style: ButtonStyle(
                          shape:
                              MaterialStateProperty.all<RoundedRectangleBorder>(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                8.0,
                              ),
                            ),
                          ),
                          backgroundColor: MaterialStateProperty.all<Color>(
                            hippieBlue,
                          ),
                        ),
                        onPressed: () {
                          _onPressedDynamicRequest(
                            certificateName: list[index].name,
                            serviceDynamicId: list[index].serviceDynamicId,
                          );
                        },
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _servicesCard({
    @required List<String> servicesList,
    @required int index,
    @required Function onPressedRequest,
  }) {
    return Card(
      elevation: 8,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(12.0),
        ),
      ),
      child: Container(
        padding: const EdgeInsets.all(12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FittedBox(
                  child: Text(
                    servicesList[index],
                    style: TextStyle(
                      color: hippieBlue,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            ElevatedButton(
              onPressed: onPressedRequest,
              child: const Text('Request'),
              style: ButtonStyle(
                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      8.0,
                    ),
                  ),
                ),
                backgroundColor: MaterialStateProperty.all<Color>(
                  hippieBlue,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _requests() {
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
          FutureBuilder<List<ServicesModel>>(
            future: _allApi.getServices(
              verify: _selectedFilter == 'Accepted'
                  ? '1'
                  : _selectedFilter == 'Rejected'
                      ? '-1'
                      : '0',
              companyId: widget.userModel.companyId,
              refId: widget.userModel.refId,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Image.asset("assets/Images/loading.gif"),
                );
              } else if (snapshot.data.isEmpty) {
                return const Center(
                  child: Text('Nothing to show here.'),
                );
              } else {
                var list = snapshot.data;
                _requestsList = list;
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      var refreshList = await _allApi.getServices(
                        verify: _selectedFilter == 'Accepted'
                            ? '1'
                            : _selectedFilter == 'Rejected'
                                ? '-1'
                                : '0',
                        companyId: widget.userModel.companyId,
                        refId: widget.userModel.refId,
                      );
                      setState(() {
                        _requestsList = refreshList;
                      });
                    },
                    child: ListView.builder(
                      itemCount: _requestsList.length,
                      itemBuilder: (context, index) {
                        return _requestCard(
                          list: _requestsList,
                          index: index,
                          onPressedView: () {
                            _onPressedView(
                              list: _requestsList,
                              index: index,
                            );
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _requestCard({
    @required List<ServicesModel> list,
    @required int index,
    @required Function onPressedView,
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
                  'Certificate Name: ',
                ),
                Text(
                  list[index].certificateName,
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
                  'Status: ',
                ),
                Text(
                  list[index].verify == '1'
                      ? 'Accepted'
                      : list[index].verify == '0'
                          ? list[index].fileName == null
                              ? 'Pending from HR'
                              : 'Pending from Manager'
                          : 'Rejected',
                ),
              ],
            ),
            if (list[index].verify == '1')
              Container(
                alignment: Alignment.centerRight,
                child: ElevatedButton(
                  child: const Text('View'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      hippieBlue,
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(12.0),
                        ),
                      ),
                    ),
                  ),
                  onPressed: onPressedView,
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _dynamicRequestCard({
    @required List<DynamicServiceRequestModel> list,
    @required int index,
    @required Function onPressedView,
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
                  'Date ',
                ),
                Text(
                  list[index].date,
                ),
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
                          ? list[index].fileName == null
                              ? 'Pending from HR'
                              : 'Pending from Manager'
                          : 'Rejected',
                ),
              ],
            ),
            if (list[index].verify == '1')
              _isOpening
                  ? const CircularProgressIndicator()
                  : Container(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        child: const Text('View'),
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all(
                            hippieBlue,
                          ),
                          shape: MaterialStateProperty.all(
                            const RoundedRectangleBorder(
                              borderRadius: BorderRadius.all(
                                Radius.circular(12.0),
                              ),
                            ),
                          ),
                        ),
                        onPressed: onPressedView,
                      ),
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
        length: 3,
        child: Scaffold(
          // floatingActionButton: FloatingActionButton(
          //   child: const Icon(
          //     Icons.add,
          //     color: Colors.white,
          //   ),
          //   backgroundColor: hippieBlue,
          //   onPressed: _customRequest,
          // ),
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Services'),
            backgroundColor: hippieBlue,
            bottom: TabBar(
              indicatorColor: portica,
              tabs: const [
                Tab(
                  child: Text('Services'),
                ),
                Tab(
                  child: Text('Requests'),
                ),
                Tab(
                  child: Text('More Requests'),
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _servicesList(),
              _requests(),
              _dynamicRequest(),
            ],
          ),
        ),
      ),
    );
  }

  void _onPressedDynamicRequest({
    @required String certificateName,
    @required String serviceDynamicId,
  }) {
    var isLoading = false;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: isLoading
                  ? null
                  : const Text(
                      'Request for the service?',
                    ),
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
                  : const Text(
                      'Are you sure you want to request for the service?',
                    ),
              actions: isLoading
                  ? null
                  : [
                      TextButton(
                        child: const Text('Request'),
                        onPressed: () async {
                          setStateDialog(() {
                            isLoading = true;
                          });
                          var result = await _allApi.postDynamicServices(
                            serviceDynamicId: serviceDynamicId,
                            refId: widget.userModel.refId,
                            date:
                                DateFormat('yyyy-MM-dd').format(DateTime.now()),
                            verify: '0',
                            companyId: widget.userModel.companyId,
                            empName: widget.userModel.name,
                            managerRefId: widget.userModel.managerid,
                            hrRefId: widget.userModel.hrId,
                          );
                          setStateDialog(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                          if (result == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Request sent successfully.',
                                ),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to send request.'),
                              ),
                            );
                          }
                        },
                      ),
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
            );
          },
        );
      },
    );
  }

  Widget _dynamicRequest() {
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
          FutureBuilder<List<DynamicServiceRequestModel>>(
            future: _allApi.getDynamicServiceRequest(
              verify: _selectedFilter == 'Accepted'
                  ? '1'
                  : _selectedFilter == 'Rejected'
                      ? '-1'
                      : '0',
              companyId: widget.userModel.companyId,
              refId: widget.userModel.refId,
            ),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(
                  child: Image.asset("assets/Images/loading.gif"),
                );
              } else if (snapshot.data.isEmpty) {
                return const Center(
                  child: Text('Nothing to show here.'),
                );
              } else {
                var list = snapshot.data;
                _dynamicRequests = list;
                return Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      var refreshList = await _allApi.getDynamicServiceRequest(
                        verify: _selectedFilter == 'Accepted'
                            ? '1'
                            : _selectedFilter == 'Rejected'
                                ? '-1'
                                : '0',
                        companyId: widget.userModel.companyId,
                        refId: widget.userModel.refId,
                      );
                      setState(() {
                        _dynamicRequests = refreshList;
                      });
                    },
                    child: ListView.builder(
                      itemCount: _dynamicRequests.length,
                      itemBuilder: (context, index) {
                        return _dynamicRequestCard(
                          list: _dynamicRequests,
                          index: index,
                          onPressedView: () async {
                            setState(() {
                              _isOpening = true;
                            });
                            var file = await _allApi.loadFile(
                              url:
                                  'http://faizeetech.com/pdf/${_dynamicRequests[index].fileName}',
                              fileName: _dynamicRequests[index].fileName,
                            );
                            await OpenFile.open(file.path);
                            setState(() {
                              _isOpening = false;
                            });
                          },
                        );
                      },
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }

  // void _customRequest() {
  //   var isLoading = false;
  //   showDialog(
  //     barrierDismissible: false,
  //     context: context,
  //     builder: (context) {
  //       return StatefulBuilder(
  //         builder: (context, setStateDialog) {
  //           return AlertDialog(
  //             title: isLoading ? null : const Text('Other'),
  //             content: isLoading
  //                 ? Container(
  //                     height: MediaQuery.of(context).size.height * 0.05,
  //                     alignment: Alignment.center,
  //                     child: Row(
  //                       children: const [
  //                         CircularProgressIndicator(),
  //                         SizedBox(
  //                           width: 30,
  //                         ),
  //                         Text('Please wait'),
  //                       ],
  //                     ),
  //                   )
  //                 : FutureBuilder<List<ServiceDynamicModel>>(
  //                     future: _allApi.getDynamicServices(
  //                       companyId: widget.userModel.companyId,
  //                     ),
  //                     builder: (context, snapshot) {
  //                       if (!snapshot.hasData) {
  //                         return const Center(
  //                           child: CircularProgressIndicator(),
  //                           heightFactor: 0.3,
  //                         );
  //                       }
  //                       var dynamicServices = snapshot.data;
  //                       return SizedBox(
  //                         width: MediaQuery.of(context).size.width,
  //                         height: MediaQuery.of(context).size.height * 0.2,
  //                         child: Form(
  //                           key: _formKey,
  //                           child: ListView.builder(
  //                             itemCount: dynamicServices.length,
  //                             itemBuilder: (context, index) {
  //                               return _textField(
  //                                 fields: dynamicServices[index].fields,
  //                                 index: index,
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       );
  //                     },
  //                   ),
  //             actions: isLoading
  //                 ? null
  //                 : [
  //                     TextButton(
  //                       onPressed: () async {
  //                         setStateDialog(() {
  //                           isLoading = true;
  //                         });
  //                         final canSubmit = _trySubmit();
  //                         if (canSubmit) {
  //                           await _allApi.postDynamicServices(
  //                             refId: widget.userModel.refId,
  //                             date: DateFormat('yyyy-MM-dd').format(
  //                               DateTime.now(),
  //                             ),
  //                             verify: '0',
  //                             companyId: widget.userModel.companyId,
  //                             empName: widget.userModel.name,
  //                             fields: _textFieldValues,
  //                           );
  //                         } else {
  //                           Fluttertoast.showToast(
  //                             msg: 'Please fill all details.',
  //                           );
  //                         }
  //                         setStateDialog(() {
  //                           isLoading = false;
  //                         });
  //                         Get.back();
  //                         Fluttertoast.showToast(
  //                           msg: 'Request Sent',
  //                         );
  //                       },
  //                       child: const Text("Submit"),
  //                     ),
  //                     TextButton(
  //                       onPressed: () {
  //                         Get.back();
  //                       },
  //                       child: const Text("Cancel"),
  //                     ),
  //                   ],
  //           );
  //         },
  //       );
  //     },
  //   );
  // }

  // Widget _textField({
  //   @required List fields,
  //   @required int index,
  // }) {
  //   return SizedBox(
  //     width: MediaQuery.of(context).size.width,
  //     height: MediaQuery.of(context).size.height * 0.2,
  //     child: ListView.builder(
  //       itemCount: fields.length,
  //       itemBuilder: (context, index) {
  //         return TextFormField(
  //           decoration: InputDecoration(
  //             label: Text(
  //               fields[index],
  //             ),
  //           ),
  //           validator: (value) {
  //             if (value.isEmpty) {
  //               return 'Please fill this field';
  //             }
  //             return null;
  //           },
  //           onSaved: (value) {
  //             _textFieldValues.add(value);
  //           },
  //         );
  //       },
  //     ),
  //   );
  // }

  // bool _trySubmit() {
  //   FocusScope.of(context).unfocus();
  //   final isValid = _formKey.currentState.validate();
  //   if (isValid) {
  //     _formKey.currentState.save();
  //   }
  //   return isValid;
  // }

  void _onPressedRequest({@required String certificateName}) {
    var isLoading = false;
    showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: isLoading
                  ? null
                  : const Text(
                      'Request for the service?',
                    ),
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
                  : const Text(
                      'Are you sure you want to request for the service?',
                    ),
              actions: isLoading
                  ? null
                  : [
                      TextButton(
                        child: const Text('Request'),
                        onPressed: () async {
                          setStateDialog(() {
                            isLoading = true;
                          });
                          var result = await _allApi.postServices(
                              empName: widget.userModel.name,
                              companyId: widget.userModel.companyId,
                              date: DateFormat('yyyy-MM-dd').format(
                                DateTime.now(),
                              ),
                              refId: widget.userModel.refId,
                              verify: '0',
                              certificateName: certificateName.toLowerCase(),
                              hr_refid: widget.userModel.hrId,
                              manager_refid: widget.userModel.managerid);
                          setStateDialog(() {
                            isLoading = false;
                          });
                          Navigator.of(context).pop();
                          if (result == 'success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Request sent successfully.'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Failed to send request.'),
                              ),
                            );
                          }
                        },
                      ),
                      TextButton(
                        child: const Text('Cancel'),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
            );
          },
        );
      },
    );
  }

  void _onPressedView({
    @required List<ServicesModel> list,
    @required int index,
  }) async {
    if (list[index].fileName != null) {
      var file = await _allApi.loadFile(
        url: 'http://faizeetech.com/pdf/${list[index].fileName}',
        fileName: list[index].fileName,
      );
      OpenFile.open(file.path);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            '''
File isn't available. Wait for the HR to send the file.''',
          ),
        ),
      );
    }
  }
}
