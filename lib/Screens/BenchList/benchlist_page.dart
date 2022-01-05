// import 'package:dropdown_search/dropdown_search.dart';
// import 'package:flutter/material.dart';
// import 'package:hudur/Components/api.dart';
// import 'package:hudur/Components/colors.dart';
// import 'package:hudur/Components/models.dart';

// class BenchList extends StatefulWidget {
//   final UserModel userModel;
//   const BenchList({Key key, this.userModel}) : super(key: key);

//   @override
//   _BenchListState createState() => _BenchListState();
// }

// class _BenchListState extends State<BenchList> {
//   final _formKey = GlobalKey<FormState>();
//   final _allApi = AllApi();

//   UserModel _employeeDetails;
//   var _isLoading = false;
//   var _employeeName = 'Select Employee';
//   var _jobDescription = '';
//   var _selectedValue = 0;
//   var _fromDate = '';
//   var _toDate = '';
//   String _selectedFilter;

//   final List _filters = [
//     'Pending',
//     'Accepted',
//     'Rejected',
//   ];

//   bool _trySubmit() {
//     FocusScope.of(context).unfocus();
//     final isValid = _formKey.currentState.validate();
//     if (isValid) {
//       _formKey.currentState.save();
//     }
//     return isValid;
//   }

//   Widget _requestForm() {
//     return SingleChildScrollView(
//       child: FutureBuilder<List<UserModel>>(
//         future: _allApi.getAllUsers(
//           companyId: widget.userModel.companyId,
//         ),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return Center(
//               child: Image.asset('assets/Images/loading.gif'),
//             );
//           } else {
//             var employeeList = snapshot.data;
//             return Form(
//               key: _formKey,
//               child: Container(
//                 padding: const EdgeInsets.all(12.0),
//                 child: Column(
//                   mainAxisSize: MainAxisSize.min,
//                   children: [
//                     DropdownSearch(
//                       emptyBuilder: (context, searchEntry) => Center(
//                         child: Text(
//                           "No results found for '$searchEntry'",
//                         ),
//                       ),
//                       mode: Mode.MENU,
//                       items: employeeList.map((e) => e.name).toList(),
//                       showSearchBox: true,
//                       onChanged: (value) {
//                         setState(() {
//                           _employeeName = value;
//                         });
//                       },
//                       selectedItem: _employeeName,
//                       dropdownSearchDecoration: const InputDecoration(
//                         label: Text('Select Employee'),
//                         icon: Icon(Icons.person),
//                       ),
//                     ),
//                     SizedBox(
//                       width: MediaQuery.of(context).size.width,
//                       height: MediaQuery.of(context).size.height * 0.15,
//                       child: TextFormField(
//                         maxLines: null,
//                         minLines: null,
//                         expands: true,
//                         validator: (value) {
//                           if (value.isEmpty) {
//                             return 'Please write the job description';
//                           }
//                           return null;
//                         },
//                         onSaved: (value) {
//                           _jobDescription = value;
//                         },
//                         decoration: const InputDecoration(
//                           label: Text('Job Description'),
//                           hintText: 'Write details of the job to be assigned',
//                           icon: Icon(Icons.work),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       padding: const EdgeInsets.all(12.0),
//                       child: const Text(
//                         'Type of replacement:',
//                         style: TextStyle(
//                           fontSize: 16,
//                         ),
//                       ),
//                       alignment: Alignment.topLeft,
//                     ),
//                     Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                       children: [
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.4,
//                           child: RadioListTile(
//                             activeColor: hippieBlue,
//                             value: 1,
//                             title: const FittedBox(
//                               child: Text(
//                                 'Temporary',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                             groupValue: _selectedValue,
//                             onChanged: (value) => setState(
//                               () {
//                                 _selectedValue = value;
//                               },
//                             ),
//                           ),
//                         ),
//                         SizedBox(
//                           width: MediaQuery.of(context).size.width * 0.4,
//                           child: RadioListTile(
//                             activeColor: hippieBlue,
//                             value: 2,
//                             title: const FittedBox(
//                               child: Text(
//                                 'Permanent',
//                                 style: TextStyle(
//                                   fontSize: 15,
//                                 ),
//                               ),
//                             ),
//                             groupValue: _selectedValue,
//                             onChanged: (value) => setState(
//                               () {
//                                 _selectedValue = value;
//                               },
//                             ),
//                           ),
//                         ),
//                       ],
//                     ),
//                     if (_selectedValue == 1)
//                       Column(
//                         children: [
//                           TextFormField(
//                             decoration: const InputDecoration(
//                               label: Text('From'),
//                               hintText:
//                                   'Enter the date from when replacement begins',
//                               icon: Icon(Icons.calendar_today),
//                             ),
//                             keyboardType: TextInputType.datetime,
//                             validator: (value) {
//                               if (value.isEmpty) {
//                                 return 'Please fill out this field';
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _fromDate = value;
//                             },
//                           ),
//                           TextFormField(
//                             decoration: const InputDecoration(
//                               label: Text('To'),
//                               hintText: 'Enter the date when replacement ends',
//                               icon: Icon(Icons.calendar_today),
//                             ),
//                             keyboardType: TextInputType.datetime,
//                             validator: (value) {
//                               if (value.isEmpty) {
//                                 return 'Please fill out this field';
//                               }
//                               return null;
//                             },
//                             onSaved: (value) {
//                               _toDate = value;
//                             },
//                           ),
//                         ],
//                       ),
//                     const SizedBox(
//                       height: 20,
//                     ),
//                     if (_employeeDetails != null)
//                       Column(
//                         children: [
//                           Card(
//                             elevation: 5,
//                             shape: const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(8.0),
//                               ),
//                             ),
//                             child: Container(
//                               width: MediaQuery.of(context).size.width,
//                               padding: const EdgeInsets.all(8.0),
//                               child: Column(
//                                 crossAxisAlignment: CrossAxisAlignment.start,
//                                 children: [
//                                   const Text(
//                                     'Employee Details:',
//                                     style: TextStyle(
//                                       fontSize: 20,
//                                       fontWeight: FontWeight.bold,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     'Name: ${_employeeDetails.name}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     'Id: ${_employeeDetails.empId}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     'Phone: ${_employeeDetails.phoneNumber}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     'Email: ${_employeeDetails.email}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                   const SizedBox(
//                                     height: 5,
//                                   ),
//                                   Text(
//                                     'Manager: ${_employeeDetails.manager}',
//                                     style: const TextStyle(
//                                       fontSize: 16,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             ),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           ElevatedButton(
//                             style: ButtonStyle(
//                               backgroundColor:
//                                   MaterialStateProperty.all(hippieBlue),
//                               shape: MaterialStateProperty.all(
//                                 const RoundedRectangleBorder(
//                                   borderRadius: BorderRadius.all(
//                                     Radius.circular(12.0),
//                                   ),
//                                 ),
//                               ),
//                             ),
//                             child: const Text('Submit'),
//                             onPressed: () async {
//                               final canSubmit = _trySubmit();
//                               if (canSubmit) {
//                                 setState(() {
//                                   _isLoading = true;
//                                 });
//                                 var result = await _allApi.postBenchList(
//                                   userModel: widget.userModel,
//                                   replacementUserModel: _employeeDetails,
//                                   jobDescription: _jobDescription,
//                                   replacementType: _selectedValue == 1
//                                       ? 'Temporary'
//                                       : 'Permanent',
//                                   fromDate: _fromDate,
//                                   toDate: _toDate,
//                                 );
//                                 setState(() {
//                                   _isLoading = false;
//                                 });
//                                 if (result == 'Success') {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content:
//                                           Text('Request sent successfully'),
//                                     ),
//                                   );
//                                 } else {
//                                   ScaffoldMessenger.of(context).showSnackBar(
//                                     const SnackBar(
//                                       content: Text(
//                                         'Request failed',
//                                       ),
//                                     ),
//                                   );
//                                 }
//                               }
//                             },
//                           ),
//                         ],
//                       ),
//                     if (_isLoading)
//                       Center(
//                         child: Image.asset("assets/Images/loading.gif"),
//                       ),
//                     if (!_isLoading && _employeeDetails == null)
//                       ElevatedButton(
//                         child: const Text('Search'),
//                         style: ButtonStyle(
//                           backgroundColor: MaterialStateProperty.all(
//                             hippieBlue,
//                           ),
//                           shape: MaterialStateProperty.all(
//                             const RoundedRectangleBorder(
//                               borderRadius: BorderRadius.all(
//                                 Radius.circular(8.0),
//                               ),
//                             ),
//                           ),
//                         ),
//                         onPressed: () async {
//                           final canSearch = _trySubmit();
//                           if (canSearch && _employeeName != 'Select Employee') {
//                             setState(() {
//                               _isLoading = true;
//                             });
//                             _employeeDetails =
//                                 await _allApi.getemployeeBenchList(
//                               name: _employeeName,
//                             );
//                             setState(() {
//                               _isLoading = false;
//                             });
//                             if (_employeeDetails == null) {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text(
//                                     'Employee details were not found. Please check the name and try again.',
//                                   ),
//                                 ),
//                               );
//                             }
//                           } else {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'Please fill all the details.',
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                   ],
//                 ),
//               ),
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _acceptedRequests() {
//     return Container(
//       padding: const EdgeInsets.all(12.0),
//       child: Column(
//         children: [
//           Container(
//             decoration: BoxDecoration(
//               border: Border.all(),
//               borderRadius: const BorderRadius.all(
//                 Radius.circular(12.0),
//               ),
//             ),
//             padding: const EdgeInsets.all(12.0),
//             height: MediaQuery.of(context).size.height * 0.07,
//             child: DropdownButtonHideUnderline(
//               child: DropdownButton(
//                 borderRadius: const BorderRadius.all(
//                   Radius.circular(12.0),
//                 ),
//                 isExpanded: true,
//                 value: _selectedFilter,
//                 onChanged: (value) {
//                   setState(() {
//                     _selectedFilter = value;
//                   });
//                 },
//                 hint: const Text('Select Filter'),
//                 items: _filters.map(
//                   (e) {
//                     return DropdownMenuItem(
//                       value: e,
//                       child: Text(e),
//                     );
//                   },
//                 ).toList(),
//               ),
//             ),
//           ),
//           const SizedBox(
//             height: 10,
//           ),
//           FutureBuilder<List<BenchListModel>>(
//             future: _allApi.getBenchListRequests(
//               verify: _selectedFilter == 'Accepted'
//                   ? '1'
//                   : _selectedFilter == 'Rejected'
//                       ? '-1'
//                       : '0',
//               companyId: widget.userModel.companyId,
//               empId: widget.userModel.empId,
//             ),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) {
//                 return Center(
//                   child: Image.asset("assets/Images/loading.gif"),
//                 );
//               } else if (snapshot.data.isEmpty) {
//                 return const Center(
//                   child: Text('Nothing to show here.'),
//                 );
//               } else {
//                 var list = snapshot.data;
//                 return Expanded(
//                   child: ListView.builder(
//                     itemCount: list.length,
//                     itemBuilder: (context, index) {
//                       return Card(
//                         elevation: 8,
//                         shape: const RoundedRectangleBorder(
//                           borderRadius: BorderRadius.all(
//                             Radius.circular(12.0),
//                           ),
//                         ),
//                         child: Container(
//                           padding: const EdgeInsets.all(8.0),
//                           height: MediaQuery.of(context).size.height * 0.1,
//                           child: Column(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     'Employee Name: ',
//                                   ),
//                                   Text(
//                                     list[index].replacementName,
//                                   ),
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     'Employee Id: ',
//                                   ),
//                                   Text(
//                                     list[index].replacementEmpId,
//                                   )
//                                 ],
//                               ),
//                               Row(
//                                 mainAxisAlignment:
//                                     MainAxisAlignment.spaceBetween,
//                                 children: [
//                                   const Text(
//                                     'Status: ',
//                                   ),
//                                   Text(
//                                     list[index].verify == '1'
//                                         ? 'Accepted'
//                                         : list[index].verify == '0'
//                                             ? 'Pending'
//                                             : 'Rejected',
//                                   ),
//                                 ],
//                               ),
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
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
//             backgroundColor: hippieBlue,
//             title: const Text('Bench List'),
//             bottom: TabBar(
//               indicatorColor: portica,
//               tabs: const [
//                 Tab(
//                   text: 'Request Form',
//                 ),
//                 Tab(
//                   text: 'Requests',
//                 ),
//               ],
//             ),
//           ),
//           body: TabBarView(
//             children: [
//               _requestForm(),
//               _acceptedRequests(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
