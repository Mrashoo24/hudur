import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';

class BenchList extends StatefulWidget {
  final UserModel userModel;
  const BenchList({Key key, this.userModel}) : super(key: key);

  @override
  _BenchListState createState() => _BenchListState();
}

class _BenchListState extends State<BenchList> {
  final _formKey = GlobalKey<FormState>();
  final _allApi = AllApi();

  UserModel _employeeDetails;
  var _isLoading = false;
  var _employeeName = '';
  var _jobDescription = '';
  var _selectedValue = 0;
  var _fromDate = '';
  var _toDate = '';

  bool _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
    }
    return isValid;
  }

  Widget _requestForm() {
    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: const EdgeInsets.all(12.0),
          child: Column(
            children: [
              TextFormField(
                validator: (value) {
                  if (value.isEmpty) {
                    return 'Please enter the name of the employee to be assigned';
                  }
                  return null;
                },
                onSaved: (value) {
                  _employeeName = value;
                },
                decoration: const InputDecoration(
                  label: Text('Employee Name'),
                  hintText: 'Enter name of the employee you are assigning',
                  icon: Icon(Icons.person),
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.15,
                child: TextFormField(
                  maxLines: null,
                  minLines: null,
                  expands: true,
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please write the job description';
                    }
                    return null;
                  },
                  onSaved: (value) {
                    _jobDescription = value;
                  },
                  decoration: const InputDecoration(
                    label: Text('Job Description'),
                    hintText: 'Write details of the job to be assigned',
                    icon: Icon(Icons.work),
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.all(12.0),
                child: const Text(
                  'Type of replacement:',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                alignment: Alignment.topLeft,
              ),
              Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RadioListTile(
                      activeColor: hippieBlue,
                      value: 1,
                      title: const Text(
                        'Temporary',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      groupValue: _selectedValue,
                      onChanged: (value) => setState(
                        () {
                          _selectedValue = value;
                        },
                      ),
                    ),
                  ),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.4,
                    child: RadioListTile(
                      activeColor: hippieBlue,
                      value: 2,
                      title: const Text(
                        'Permanent',
                        style: TextStyle(
                          fontSize: 15,
                        ),
                      ),
                      groupValue: _selectedValue,
                      onChanged: (value) => setState(
                        () {
                          _selectedValue = value;
                        },
                      ),
                    ),
                  ),
                ],
              ),
              if (_selectedValue == 1)
                Column(
                  children: [
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('From'),
                        hintText: 'Enter the date from when replacement begins',
                        icon: Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please fill out this field';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _fromDate = value;
                      },
                    ),
                    TextFormField(
                      decoration: const InputDecoration(
                        label: Text('To'),
                        hintText: 'Enter the date when replacement ends',
                        icon: Icon(Icons.calendar_today),
                      ),
                      keyboardType: TextInputType.datetime,
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please fill out this field';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _toDate = value;
                      },
                    ),
                  ],
                ),
              const SizedBox(
                height: 20,
              ),
              if (_employeeDetails != null)
                Column(
                  children: [
                    Card(
                      elevation: 5,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Employee Details:',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Name: ${_employeeDetails.name}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Id: ${_employeeDetails.empId}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Phone: ${_employeeDetails.phoneNumber}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Email: ${_employeeDetails.email}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                            const SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Manager: ${_employeeDetails.manager}',
                              style: const TextStyle(
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ElevatedButton(
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(hippieBlue),
                        shape: MaterialStateProperty.all(
                          const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(12.0),
                            ),
                          ),
                        ),
                      ),
                      child: const Text('Submit'),
                      onPressed: () async {
                        final canSubmit = _trySubmit();
                        if (canSubmit) {
                          setState(() {
                            _isLoading = true;
                          });
                          var result = await _allApi.postBenchList(
                            userModel: widget.userModel,
                            replacementUserModel: _employeeDetails,
                            jobDescription: _jobDescription,
                            replacementType:
                                _selectedValue == 1 ? 'Temporary' : 'Permanent',
                            fromDate: _fromDate,
                            toDate: _toDate,
                          );
                          setState(() {
                            _isLoading = false;
                          });
                          if (result == 'Success') {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Request sent successfully'),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  'Request failed',
                                ),
                              ),
                            );
                          }
                        }
                      },
                    ),
                  ],
                ),
              if (_isLoading)
                Center(
                  child: Image.asset("assets/Images/loading.gif"),
                ),
              if (!_isLoading && _employeeDetails == null)
                ElevatedButton(
                  child: const Text('Search'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(
                      hippieBlue,
                    ),
                    shape: MaterialStateProperty.all(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                    ),
                  ),
                  onPressed: () async {
                    final canSearch = _trySubmit();
                    if (canSearch) {
                      setState(() {
                        _isLoading = true;
                      });
                      _employeeDetails = await _allApi.getemployeeBenchList(
                        name: _employeeName,
                      );
                      setState(() {
                        _isLoading = false;
                      });
                      if (_employeeDetails == null) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                                'Employee details were not found. Please check the name and try again.'),
                          ),
                        );
                      }
                    }
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _acceptedRequests() {
    return FutureBuilder<List<BenchListModel>>(
      future: _allApi.getBenchListRequests(
        companyId: widget.userModel.companyId,
        empId: widget.userModel.empId,
        verify: '1',
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
          return ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              return Card(
                child: Container(
                  padding: const EdgeInsets.all(8.0),
                  height: MediaQuery.of(context).size.height * 0.1,
                  child: Column(
                    children: [
                      Text(
                        'Employee Name: ' + list[index].replacementName,
                      ),
                      Text(
                        'Employee Id: ' + list[index].replacementEmpId,
                      ),
                      Text(
                        'Status: ' + list[index].verify == '1'
                            ? 'Accepted'
                            : 'Rejected',
                      ),
                    ],
                  ),
                ),
              );
            },
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
          // colorFilter: ColorFilter.mode(
          //   Colors.white.withOpacity(0.6),
          //   BlendMode.dstATop,
          // ),
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: hippieBlue,
            title: const Text('Bench List'),
            bottom: TabBar(
              indicatorColor: portica,
              tabs: const [
                Tab(
                  text: 'Request From',
                ),
                Tab(
                  text: 'Accepted Requests',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _requestForm(),
              _acceptedRequests(),
            ],
          ),
        ),
      ),
    );
  }
}
