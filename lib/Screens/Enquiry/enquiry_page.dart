// import 'package:flutter/material.dart';
// import 'package:hudur/Components/api.dart';
// import 'package:hudur/Components/colors.dart';
// import 'package:hudur/Components/models.dart';

// class Enquiry extends StatefulWidget {
//   final UserModel userModel;
//   const Enquiry({Key key, this.userModel}) : super(key: key);

//   @override
//   _EnquiryState createState() => _EnquiryState();
// }

// class _EnquiryState extends State<Enquiry> {
//   final _formKey = GlobalKey<FormState>();
//   final _allApi = AllApi();

//   var _subject = '';
//   var _description = '';

//   var _isLoading = false;
//   // final _emailRegExp = RegExp(
//   //     r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

//   bool _trySubmit() {
//     FocusScope.of(context).unfocus();
//     final isValid = _formKey.currentState.validate();
//     if (isValid) {
//       _formKey.currentState.save();
//     }
//     return isValid;
//   }

//   Widget _enquiryTab() {
//     return SingleChildScrollView(
//       child: Form(
//         key: _formKey,
//         child: Container(
//           padding: const EdgeInsets.all(12.0),
//           child: Column(
//             children: [
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: const Text(
//                   'Write in your query in the description box with subject.',
//                   style: TextStyle(
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               Container(
//                 alignment: Alignment.topLeft,
//                 child: const Text(
//                   'A mail will be sent to the HR.',
//                   style: TextStyle(
//                     fontSize: 20,
//                   ),
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               TextFormField(
//                 decoration: const InputDecoration(
//                   border: OutlineInputBorder(
//                     borderRadius: BorderRadius.all(
//                       Radius.circular(8.0),
//                     ),
//                   ),
//                   label: Text('Subject'),
//                   hintText: 'Enter the subject of your enquiry email.',
//                 ),
//                 validator: (value) {
//                   if (value.isEmpty) {
//                     return 'Please fill in the subject.';
//                   }
//                   return null;
//                 },
//                 onSaved: (value) {
//                   _subject = value;
//                 },
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               SizedBox(
//                 height: MediaQuery.of(context).size.height * 0.2,
//                 child: TextFormField(
//                   keyboardType: TextInputType.multiline,
//                   expands: true,
//                   minLines: null,
//                   maxLines: null,
//                   decoration: const InputDecoration(
//                     border: OutlineInputBorder(
//                       borderRadius: BorderRadius.all(
//                         Radius.circular(8.0),
//                       ),
//                     ),
//                     label: Text('Description'),
//                     hintText: 'Enter the description of your enquiry email.',
//                   ),
//                   validator: (value) {
//                     if (value.isEmpty) {
//                       return 'Please fill in the description.';
//                     }
//                     return null;
//                   },
//                   onSaved: (value) {
//                     _description = value;
//                   },
//                 ),
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               const SizedBox(
//                 height: 10,
//               ),
//               _isLoading
//                   ? const CircularProgressIndicator()
//                   : ElevatedButton(
//                       style: ButtonStyle(
//                         backgroundColor: MaterialStateProperty.all(hippieBlue),
//                         shape: MaterialStateProperty.all(
//                           const RoundedRectangleBorder(
//                             borderRadius: BorderRadius.all(
//                               Radius.circular(12.0),
//                             ),
//                           ),
//                         ),
//                       ),
//                       child: const Text('Send Email'),
//                       onPressed: () async {
//                         final canSubmit = _trySubmit();
//                         if (canSubmit) {
//                           setState(() {
//                             _isLoading = true;
//                           });
//                           await _allApi.postEnquiry(
//                             empName: widget.userModel.name,
//                             subject: _subject,
//                             description: _description,
//                             refId: widget.userModel.refId,
//                             companyId: widget.userModel.companyId,
//                           );
//                           var result = await _allApi.sendEmail(
//                             subject: _subject,
//                             content: _description,
//                           );
//                           setState(() {
//                             _isLoading = false;
//                           });
//                           if (result == 'success') {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Mail has been sent.'),
//                               ),
//                             );
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text('Failed to send email.'),
//                               ),
//                             );
//                           }
//                         }
//                       },
//                     ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   Widget _replyTab() {
//     return Container();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       decoration: const BoxDecoration(
//         image: DecorationImage(
//           image: AssetImage('assets/Images/background_image.jpg'),
//           fit: BoxFit.fill,
//         ),
//       ),
//       child: DefaultTabController(
//         length: 2,
//         child: Scaffold(
//           backgroundColor: Colors.transparent,
//           appBar: AppBar(
//             title: const Text('Enquiry'),
//             centerTitle: true,
//             backgroundColor: hippieBlue,
//             bottom: TabBar(
//               tabs: const [
//                 Tab(
//                   child: Text('Enquiry'),
//                 ),
//                 Tab(
//                   child: Text('Reply'),
//                 ),
//               ],
//               indicatorColor: portica,
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               _enquiryTab(),
//               _replyTab(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
