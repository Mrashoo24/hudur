import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';

class LateReason extends StatefulWidget {
  final UserModel userModel;
  const LateReason({Key key, this.userModel}) : super(key: key);

  @override
  _LateReasonState createState() => _LateReasonState();
}

class _LateReasonState extends State<LateReason> {
  final _formKey = GlobalKey<FormState>();
  final _allApi = AllApi();

  var _subject = '';
  var _description = '';

  var _isLoading = false;

  bool _trySubmit() {
    FocusScope.of(context).unfocus();
    final isValid = _formKey.currentState.validate();
    if (isValid) {
      _formKey.currentState.save();
    }
    return isValid;
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
          title: const Text('Reason for late check-in'),
          centerTitle: true,
          backgroundColor: hippieBlue,
        ),
        body: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Container(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                children: [
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      '''
Write in your reason with your details in the description box with subject.''',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.topLeft,
                    child: const Text(
                      'A mail will be sent to the HR and the Manager.',
                      style: TextStyle(
                        fontSize: 20,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(8.0),
                        ),
                      ),
                      label: Text('Subject'),
                      hintText: 'Enter the subject of your enquiry email.',
                    ),
                    validator: (value) {
                      if (value.isEmpty) {
                        return 'Please fill in the subject.';
                      }
                      return null;
                    },
                    onSaved: (value) {
                      _subject = value;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.2,
                    child: TextFormField(
                      keyboardType: TextInputType.multiline,
                      expands: true,
                      minLines: null,
                      maxLines: null,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(
                            Radius.circular(8.0),
                          ),
                        ),
                        label: Text('Description'),
                        hintText:
                            'Enter the description of your enquiry email.',
                      ),
                      validator: (value) {
                        if (value.isEmpty) {
                          return 'Please fill in the description.';
                        }
                        return null;
                      },
                      onSaved: (value) {
                        _description = value;
                      },
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  _isLoading
                      ? const CircularProgressIndicator()
                      : ElevatedButton(
                          style: ButtonStyle(
                            backgroundColor:
                                MaterialStateProperty.all(hippieBlue),
                            shape: MaterialStateProperty.all(
                              const RoundedRectangleBorder(
                                borderRadius: BorderRadius.all(
                                  Radius.circular(12.0),
                                ),
                              ),
                            ),
                          ),
                          child: const Text('Send Email'),
                          onPressed: () async {
                            final canSubmit = _trySubmit();
                            if (canSubmit) {
                              setState(() {
                                _isLoading = true;
                              });
                              await _allApi.postLateCheckInReason(
                                subject: _subject,
                                description: _description,
                                employeeId: widget.userModel.empId,
                                companyId: widget.userModel.companyId,
                                empName: widget.userModel.name,
                              );
                              var result = await _allApi.sendEmail(
                                subject: _subject,
                                content: _description,
                              );
                              setState(() {
                                _isLoading = false;
                              });
                              if (result == 'success') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Mail has been sent.'),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text('Failed to send email.'),
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
        ),
      ),
    );
  }
}
