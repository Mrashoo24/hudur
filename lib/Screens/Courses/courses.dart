// import 'package:flutter/material.dart';
// import 'package:hudur/Components/api.dart';
// import 'package:hudur/Components/colors.dart';
// import 'package:hudur/Components/models.dart';

// class Courses extends StatefulWidget {
//   final UserModel userModel;
//   const Courses({Key key, this.userModel}) : super(key: key);

//   @override
//   _CoursesState createState() => _CoursesState();
// }

// class _CoursesState extends State<Courses> {
//   final _allApi = AllApi();

//   Widget _courseCard({
//     @required List<CoursesModel> courseList,
//     @required int index,
//     @required Function onPressedRegister,
//   }) {
//     return Card(
//       elevation: 8,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(12.0),
//         ),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   courseList[index].title,
//                   style: TextStyle(
//                     color: hippieBlue,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   courseList[index].hrId,
//                   style: TextStyle(
//                     color: hippieBlue,
//                   ),
//                 ),
//                 Text(
//                   courseList[index].venue,
//                   style: TextStyle(
//                     color: hippieBlue,
//                   ),
//                 ),
//                 Text(
//                   courseList[index].date,
//                   style: const TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             ElevatedButton(
//               onPressed: onPressedRegister,
//               child: const Text('Register'),
//               style: ButtonStyle(
//                 shape: MaterialStateProperty.all<RoundedRectangleBorder>(
//                   RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(
//                       8.0,
//                     ),
//                   ),
//                 ),
//                 backgroundColor: MaterialStateProperty.all<Color>(
//                   hippieBlue,
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _enrolledCourseCard({
//     @required List<PresentCoursesModel> courseList,
//     @required int index,
//   }) {
//     return Card(
//       elevation: 8,
//       shape: const RoundedRectangleBorder(
//         borderRadius: BorderRadius.all(
//           Radius.circular(12.0),
//         ),
//       ),
//       child: Container(
//         padding: const EdgeInsets.all(12.0),
//         child: Row(
//           mainAxisAlignment: MainAxisAlignment.spaceBetween,
//           children: [
//             Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 Text(
//                   courseList[index].title,
//                   style: TextStyle(
//                     color: hippieBlue,
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 const SizedBox(
//                   height: 5,
//                 ),
//                 Text(
//                   courseList[index].hrId,
//                   style: TextStyle(
//                     color: hippieBlue,
//                   ),
//                 ),
//                 Text(
//                   courseList[index].venue,
//                   style: TextStyle(
//                     color: hippieBlue,
//                   ),
//                 ),
//                 Text(
//                   courseList[index].date,
//                   style: const TextStyle(
//                     color: Colors.grey,
//                   ),
//                 ),
//               ],
//             ),
//             Column(
//               children: [
//                 Text(
//                   courseList[index].checkIn == ''
//                       ? '-----'
//                       : courseList[index].checkIn,
//                 ),
//                 Text(
//                   courseList[index].checkOut == ''
//                       ? '-----'
//                       : courseList[index].checkOut,
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _hrCourses() {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: FutureBuilder<List<CoursesModel>>(
//         future: _allApi.getCourses(widget.userModel.companyId),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: Image(
//                 image: AssetImage('assets/Images/loading.gif'),
//               ),
//             );
//           } else {
//             var courseList = snapshot.data;
//             return ListView.builder(
//               itemCount: courseList.length,
//               itemBuilder: (ctx, index) {
//                 return _courseCard(
//                   courseList: courseList,
//                   index: index,
//                   onPressedRegister: () {
//                     _onPressedRegister(
//                       coursesModel: courseList[index],
//                       empId: widget.userModel.empId,
//                       empName: widget.userModel.name,
//                       empPhone: widget.userModel.phoneNumber,
//                     );
//                   },
//                 );
//               },
//             );
//           }
//         },
//       ),
//     );
//   }

//   Widget _enrolledCourses() {
//     return Container(
//       padding: const EdgeInsets.all(8.0),
//       width: MediaQuery.of(context).size.width,
//       height: MediaQuery.of(context).size.height,
//       child: FutureBuilder<List<PresentCoursesModel>>(
//         future: _allApi.getPresentCourses(
//           companyId: widget.userModel.companyId,
//           empId: widget.userModel.empId,
//         ),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(
//               child: Image(
//                 image: AssetImage('assets/Images/loading.gif'),
//               ),
//             );
//           } else if (snapshot.data.isEmpty) {
//             return const Center(
//               child: Text('No courses enrolled yet'),
//             );
//           } else {
//             var courseList = snapshot.data;
//             return ListView.builder(
//               itemCount: courseList.length,
//               itemBuilder: (ctx, index) {
//                 return _enrolledCourseCard(
//                   courseList: courseList,
//                   index: index,
//                 );
//               },
//             );
//           }
//         },
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
//           appBar: AppBar(
//             title: const Text('Courses'),
//             backgroundColor: hippieBlue,
//             bottom: TabBar(
//               indicatorColor: portica,
//               tabs: const [
//                 Tab(
//                   child: Text('HR Courses'),
//                 ),
//                 Tab(
//                   child: Text('Enrolled Courses'),
//                 ),
//               ],
//             ),
//           ),
//           backgroundColor: Colors.transparent,
//           body: TabBarView(
//             children: [
//               _hrCourses(),
//               _enrolledCourses(),
//             ],
//           ),
//         ),
//       ),
//     );
//   }

//   void _onPressedRegister({
//     @required CoursesModel coursesModel,
//     @required String empName,
//     @required String empId,
//     @required String empPhone,
//   }) async {
//     var isLoading = false;
//     showDialog(
//       barrierDismissible: false,
//       context: context,
//       builder: (context) {
//         return StatefulBuilder(
//           builder: (context, setStateDialog) {
//             return AlertDialog(
//               title: isLoading
//                   ? null
//                   : const Text(
//                       'Register for the course?',
//                     ),
//               content: isLoading
//                   ? Container(
//                       height: MediaQuery.of(context).size.height * 0.05,
//                       alignment: Alignment.center,
//                       child: Row(
//                         children: const [
//                           CircularProgressIndicator(),
//                           SizedBox(
//                             width: 30,
//                           ),
//                           Text('Please wait'),
//                         ],
//                       ),
//                     )
//                   : const Text(
//                       'Are you sure you want to register for the course?',
//                     ),
//               actions: isLoading
//                   ? null
//                   : [
//                       TextButton(
//                         child: const Text('Register'),
//                         onPressed: () async {
//                           setStateDialog(() {
//                             isLoading = true;
//                           });
//                           var isRegistered =
//                               await _allApi.checkIfRegisteredCourse(
//                             courseId: coursesModel.courseId,
//                             empId: empId,
//                           );
//                           if (isRegistered == 'not registered') {
//                             var result = await _allApi.registerCourse(
//                               coursesModel: coursesModel,
//                               empName: empName,
//                               empId: empId,
//                               empPhone: empPhone,
//                             );
//                             setStateDialog(() {
//                               isLoading = false;
//                             });
//                             Navigator.of(context).pop();
//                             if (result == 'registered') {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Registered successfully.'),
//                                 ),
//                               );
//                             } else {
//                               ScaffoldMessenger.of(context).showSnackBar(
//                                 const SnackBar(
//                                   content: Text('Failed to register.'),
//                                 ),
//                               );
//                             }
//                           } else {
//                             setStateDialog(() {
//                               isLoading = false;
//                             });
//                             Navigator.of(context).pop();
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               const SnackBar(
//                                 content: Text(
//                                   'You have already registered.',
//                                 ),
//                               ),
//                             );
//                           }
//                         },
//                       ),
//                       TextButton(
//                         child: const Text('Cancel'),
//                         onPressed: () {
//                           Navigator.of(context).pop();
//                         },
//                       ),
//                     ],
//             );
//           },
//         );
//       },
//     );
//   }
// }
