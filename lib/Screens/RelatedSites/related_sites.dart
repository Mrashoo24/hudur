import 'package:flutter/material.dart';
import 'package:hudur/Components/api.dart';
import 'package:hudur/Components/colors.dart';
import 'package:hudur/Components/models.dart';

class RelatedSites extends StatefulWidget {
  const RelatedSites({Key key}) : super(key: key);

  @override
  State<RelatedSites> createState() => _RelatedSitesState();
}

class _RelatedSitesState extends State<RelatedSites> {
  final _allApi = AllApi();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Related Sites'),
        centerTitle: true,
        backgroundColor: hippieBlue,
      ),
      body: FutureBuilder<List<RelatedSitesModel>>(
        future: _allApi.getRelatedSites(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: Image.asset("assets/Images/loading.gif"),
            );
          } else {
            var relatedSitesList = snapshot.data;
            return ListView.builder(
              itemCount: relatedSitesList.length,
              itemBuilder: (context, index) {
                return Card(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(
                      Radius.circular(12.0),
                    ),
                  ),
                  elevation: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.1,
                    padding: const EdgeInsets.all(12.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          relatedSitesList[index].name,
                          style: const TextStyle(fontSize: 18),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Text(relatedSitesList[index].url),
                      ],
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}
