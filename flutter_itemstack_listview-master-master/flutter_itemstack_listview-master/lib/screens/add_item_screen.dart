import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutterstackeditemlist/providers/freezer_items.dart';
import 'package:provider/provider.dart';

import '../widgets/image_input.dart';


class AddItemScreen extends StatefulWidget {
  static const routeName = '/add-item';

  @override
  _AddItemScreen createState() => _AddItemScreen();
}

class _AddItemScreen extends State<AddItemScreen> {
  final _categoryController = TextEditingController();
  File _pickedImage;

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _saveItem() {
    if (_categoryController.text.isEmpty || _pickedImage == null) {
      return;
    }
    Provider.of<FreezerItems>(context, listen: false) // false because we are not interested in updates here
        .addFreezerItem(_categoryController.text, _pickedImage); // we just want to dispatch the action in this line
      Navigator.of(context).pop(); // here we leave this page 
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Tilføj varer'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(labelText: 'Kategori'),
                      controller: _categoryController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    ImageInput(_selectImage),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Tilføj en vare'),
            onPressed: _saveItem,
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
          ),
        ],
      ),
    );
  }
}
