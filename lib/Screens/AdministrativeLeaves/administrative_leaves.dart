import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';

class AdministrativeLeaves extends StatefulWidget {
  final UserModel userModel;
  const AdministrativeLeaves({Key key, this.userModel}) : super(key: key);

  @override
  _AdministrativeLeavesState createState() => _AdministrativeLeavesState();
}

class _AdministrativeLeavesState extends State<AdministrativeLeaves> {
  final _allApi = AllApi();
  final _formKey = GlobalKey<FormState>();

  var _days = '';

  bool _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
    }
    return isValid;
  }

  Widget _request() {
    return Form(
      key: _formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        padding: const EdgeInsets.all(12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                label: Text(
                  'Number of days',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                hintText: 'Enter number of days for leaves.',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(12.0),
                  ),
                ),
              ),
              validator: (value) {
                if (value.isEmpty) {
                  return 'Please fill this field';
                } else if (int.parse(value) > 5 || int.parse(value) < 0) {
                  return 'Leaves can be maximum of 5 days and minimum 1 day';
                }
                return null;
              },
              onSaved: (value) {
                _days = value;
              },
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(hippieBlue),
              ),
              child: const Text('Submit'),
              onPressed: () async {
                final canSubmit = _trySubmit();
                if (canSubmit) {
                  var result = await _allApi.postAdminLeave(
                    days: _days,
                    refId: widget.userModel.refId,
                    employeeName: widget.userModel.name,
                    companyId: widget.userModel.companyId,
                    verify: '0',
                  );
                  if (result == 'success') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Request Sent'),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Request Failed'),
                      ),
                    );
                  }
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _accepted() {
    return FutureBuilder<List<AdminLeavesModel>>(
      future: _allApi.getAdminLeaves(
        verify: '1',
        companyId: widget.userModel.companyId,
        refId: widget.userModel.refId,
      ),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: Image.asset("assets/Images/loading.gif"),
          );
        } else if (snapshot.data.isEmpty) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const [
              Text(
                'Nothing to show here.',
                style: TextStyle(
                  fontSize: 22,
                ),
              ),
            ],
          );
        } else {
          var adminLeavesList = snapshot.data;
          return Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            padding: const EdgeInsets.all(12.0),
            child: ListView.builder(
              itemCount: adminLeavesList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.2,
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Name: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              adminLeavesList[index].employeeName,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Days: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              adminLeavesList[index].days,
                              style: const TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Text(
                              'Status: ',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                            Text(
                              'Accepted',
                              style: TextStyle(
                                fontSize: 18,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
          image: const AssetImage('assets/Images/background_image.jpg'),
          fit: BoxFit.fill,
          colorFilter: ColorFilter.mode(
            Colors.black.withOpacity(0.6),
            BlendMode.dstATop,
          ),
        ),
      ),
      child: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            title: const Text('Administrative Leave'),
            backgroundColor: hippieBlue,
            bottom: const TabBar(
              tabs: [
                Text(
                  'Request',
                ),
                Text(
                  'Accepted',
                ),
              ],
            ),
          ),
          body: TabBarView(
            children: [
              _request(),
              _accepted(),
            ],
          ),
        ),
      ),
    );
  }
}
