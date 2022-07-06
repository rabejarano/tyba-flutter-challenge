import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyba_flutter_challenge/models/university.dart';
import 'package:tyba_flutter_challenge/providers/university_provider.dart';
import 'package:tyba_flutter_challenge/routes.dart';

class UniversityList extends StatelessWidget {
  const UniversityList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<UniversityProvider>(builder: (_, provider, child) {
      return provider.isLoading == false && provider.universities.isNotEmpty
          ? ListView.builder(
              itemCount: provider.universities.length,
              itemBuilder: (_, i) {
                University university = provider.universities[i];
                return Padding(
                  padding: const EdgeInsets.only(bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Navigator.of(context).pushNamed(UNIVERSITY_DETAILS_PAGE,
                          arguments: university);
                    },
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(10)),
                    ),
                    tileColor: Colors.white,
                    leading: university.imageUrl == null
                        ? FlutterLogo()
                        : Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                image: DecorationImage(
                                    image:
                                        FileImage(File(university.imageUrl!)),
                                    fit: BoxFit.cover)),
                            child: Image.file(File(university.imageUrl!)),
                          ),
                    trailing: const Icon(Icons.more_vert),
                    title: Text(university.name!),
                  ),
                );
              },
            )
          : provider.isLoading == false && provider.error.isNotEmpty
              ? const Text("")
              : const Center(child: CircularProgressIndicator());
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
