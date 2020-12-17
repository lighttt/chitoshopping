import 'dart:io';

import 'package:chito_shopping/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditProductScreen extends StatefulWidget {
  static const String routeName = "/edit_product_screen";

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  ThemeData themeConst;
  double mHeight, mWidth;
  final _formKey = GlobalKey<FormState>();
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  //image picker
  File _imageFile;
  final imagePicker = ImagePicker();

  void _saveForm() {
    _formKey.currentState.validate();
    if (_imageFile == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please add a product image"),
        backgroundColor: themeConst.errorColor,
      ));
    }
  }

  // capture image from camera
  Future<void> _takePhoto() async {
    final capturePhoto = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(capturePhoto.path);
    });
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaConst = MediaQuery.of(context);
    mHeight = mediaConst.size.height;
    mWidth = mediaConst.size.width;
    themeConst = Theme.of(context);
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: Text("Edit Product"),
      ),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: _takePhoto,
                  child: Container(
                    height: mHeight * 0.2,
                    width: mWidth * 0.4,
                    decoration: BoxDecoration(
                      border: Border.all(color: greyColor, width: 1),
                    ),
                    child: _imageFile == null
                        ? Center(
                            child: Text(
                            "Upload product picture",
                            textAlign: TextAlign.center,
                          ))
                        : Image.file(
                            _imageFile,
                            fit: BoxFit.cover,
                          ),
                  ),
                ),
              ],
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Title",
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Title is required";
                }
                if (value.length < 5) {
                  return "Title must have atleast 5 letters";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Price",
              ),
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.number,
              validator: (value) {
                if (value.isEmpty) {
                  return "Price is required";
                }
                if (double.tryParse(value) == null) {
                  return "Price should be in number format";
                }
                if (double.parse(value) < 0) {
                  return "Price cannot be negative value";
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Description",
              ),
              maxLines: 4,
              keyboardType: TextInputType.multiline,
              validator: (value) {
                if (value.isEmpty) {
                  return "Description is required";
                }
                if (value.length < 10) {
                  return "Description is too short";
                }
                return null;
              },
            ),
            SizedBox(
              height: mHeight * 0.05,
            ),
            RaisedButton.icon(
              color: greenColor,
              icon: Icon(Icons.save),
              textColor: Colors.white,
              onPressed: _saveForm,
              label: Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
