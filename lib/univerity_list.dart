import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyba_flutter_challenge/models/university.dart';
import 'package:tyba_flutter_challenge/providers/university_provider.dart';

class UniversityList extends StatelessWidget {
  const UniversityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UniversityProvider>(builder: (_, provider, child) {
      return ListView.builder(
        itemCount: provider.universities.length,
        itemBuilder: (_, i) {
          University university = provider.universities[i];
          return Padding(
            padding: EdgeInsets.only(bottom: 15),
            child: ListTile(
              shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              tileColor: Colors.white,
              leading: const FlutterLogo(),
              trailing: const Icon(Icons.more_vert),
              title: Text(university.name!),
            ),
          );
        },
      );
    });
  }
}

class UniversityItem extends StatelessWidget {
  const UniversityItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
