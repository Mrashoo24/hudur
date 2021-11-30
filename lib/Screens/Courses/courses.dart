import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';

class Courses extends StatefulWidget {
  const Courses({Key key}) : super(key: key);

  @override
  _CoursesState createState() => _CoursesState();
}

class _CoursesState extends State<Courses> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder<List<CoursesModel>>(
        future: AllApi().getCourses(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: Image(image: AssetImage('assets/Images/loading.gif')),
            );
          } else {
            var courseList = snapshot.data;
            return ListView.builder(
              itemCount: courseList.length,
              itemBuilder: (ctx, index) {
                return Card(
                  child: Container(
                      padding: const EdgeInsets.all(12.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                courseList[index].title,
                                style: TextStyle(
                                  color: hippieBlue,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                courseList[index].date,
                                style: const TextStyle(
                                  color: Colors.grey,
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                            onPressed: () {},
                            child: const Text('Register'),
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                  RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                              ),
                              backgroundColor:
                                  MaterialStateProperty.all<Color>(hippieBlue),
                            ),
                          ),
                        ],
                      )),
                );
              },
            );
          }
        },
      ),
    );
  }
}
