import 'package:hudur/Components/colors.dart';
import 'package:flutter/material.dart';
import 'package:hudur/Components/models.dart';
import 'package:hudur/Components/api.dart';

class Announcement extends StatefulWidget {
  const Announcement({ Key key }) : super(key: key);

  @override
  _AnnouncementState createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: FutureBuilder(
        future: getAnnounce(),
        builder: (context, snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: Image(image: AssetImage('assets/Images/loading.gif')),
            );
          }
          else {
            // ignore: unused_local_variable
            var announceList = snapshot.data;
            return ListView.builder(
              itemCount: announceList.length,
              itemBuilder: (ctx,  index) {
                return Card(
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(12.0),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(
                        announceList[index].image,
                      ),
                    ),
                    title: 
                      Text(announceList[index].name,
                        style:  TextStyle(
                          color: hippieBlue,
                          fontSize: 20, fontWeight: FontWeight.bold),    
                    ),
                    subtitle: 
                    Text(
                      announceList[index].text,
                      style: const TextStyle(
                        color: Colors.grey
                      ),           
                    ),
                    onTap: () {},
                  ),
                );
              },
            );
          }
        }
      ),
    );
  }
}
class DetailPage extends StatelessWidget {
  
  final AnnounceModel announceModel;

  const DetailPage(data, {Key key, this.announceModel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(announceModel.name),
        
      ),
    );
  }
}