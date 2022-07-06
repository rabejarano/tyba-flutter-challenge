import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tyba_flutter_challenge/models/university.dart';
import 'package:tyba_flutter_challenge/providers/university_provider.dart';
import 'package:tyba_flutter_challenge/styles.dart';
import 'package:image_picker/image_picker.dart';

class UniversityDetails extends StatefulWidget {
  @override
  State<UniversityDetails> createState() => _UniversityDetailsState();
}

class _UniversityDetailsState extends State<UniversityDetails> {
  late University _university;

  void pickUpImage(ImageSource source) async {
    UniversityProvider _universityProvider =
        Provider.of<UniversityProvider>(context, listen: false);
    try {
      final ImagePicker _picker = ImagePicker();
      final XFile? image = await _picker.pickImage(source: source);
      _universityProvider.addImage(
          university: _university, imagePath: image!.path);

      setState(() {
        _university.imageUrl = image.path;
      });
    } catch (e) {
      print(e);
    }
  }

  void _changeStudentsNumber(value) {
    UniversityProvider _universityProvider =
        Provider.of<UniversityProvider>(context, listen: false);
    final parsedValue = int.parse(value);
    try {
      setState(() {
        _university.numbersOfStudents = parsedValue;
      });
      _universityProvider.addNumberOfStudets(
          university: _university, numbers: parsedValue);
    } catch (e) {
      setState(() {
        _university.numbersOfStudents = 0;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    _university = ModalRoute.of(context)!.settings.arguments as University;

    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          iconTheme: const IconThemeData(
            color: Colors.black,
          ),
          backgroundColor: Theme.of(context).colorScheme.background,
          elevation: 0,
          title: Text(
            _university.name!,
            style: Theme.of(context).textTheme.headline6,
          ),
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, left: 5),
                  child: Text(
                    'Detalles',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                _buildUniversityDetails(context),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 30, left: 5),
                  child: Text(
                    'Configuracion',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                ),
                _buildUniversityActions(context),
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          tooltip: 'github',
          child: const Icon(Icons.add),
        ),
      ),
    );
  }

  Container _buildUniversityDetails(BuildContext context) {
    Widget _buildItem({textLeft, textRight}) => Padding(
          padding: const EdgeInsets.only(bottom: 5, top: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Text(
                  textLeft,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
              Expanded(
                child: Text(
                  textRight,
                  style: Theme.of(context).textTheme.subtitle1,
                ),
              ),
            ],
          ),
        );
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildItem(textLeft: "Name:", textRight: _university.name!),
          _buildItem(textLeft: "Country:", textRight: _university.country),
          _buildItem(
              textLeft: "Country code:", textRight: _university.alphaTwocode),
          _buildItem(
              textLeft: "Numero de estudiantes",
              textRight: _university.numbersOfStudents != null
                  ? _university.numbersOfStudents.toString()
                  : 'Sin especificar'),
          _buildItem(
              textLeft: "Domains:", textRight: _university.domains.join(',')),
          _buildItem(
              textLeft: "Web_pages:",
              textRight: _university.webPages.join(',')),
          _buildItem(
              textLeft: "Imagen:",
              textRight: _university.imageUrl == null ? "Si especificar" : ""),
          _university.imageUrl != null
              ? Padding(
                  padding: const EdgeInsets.only(bottom: 10, top: 10),
                  child: Container(
                    height: 80,
                    width: 80,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        image: DecorationImage(
                            image: FileImage(File(_university.imageUrl!)),
                            fit: BoxFit.cover)),
                    child: _university.imageUrl != null
                        ? Image.file(File(_university.imageUrl!))
                        : Container(),
                  ),
                )
              : Container(),
        ],
      ),
    );
  }

  Widget _buildUniversityActions(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: Colors.white,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(bottom: 5),
            child: Text(
              "Numero de estudiantes",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          TextField(
            onChanged: _changeStudentsNumber,
            keyboardType: TextInputType.number,
            decoration: inputDecoration.copyWith(
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              hintText: "",
              suffixStyle: const TextStyle(fontSize: 12),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 10, top: 20),
            child: Text(
              "Agregar una imagen",
              style: Theme.of(context).textTheme.subtitle1,
            ),
          ),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onPressed: () {
                pickUpImage(ImageSource.gallery);
              },
              child: const Text('DESDE LA GALERIA'),
            ),
          ),
          Center(
            child: TextButton(
              style: TextButton.styleFrom(
                primary: Colors.blue,
                textStyle: const TextStyle(fontSize: 16, color: Colors.blue),
              ),
              onPressed: () {
                pickUpImage(ImageSource.camera);
              },
              child: const Text('DESDE LA CAMARA'),
            ),
          ),
        ],
      ),
    );
  }
}
