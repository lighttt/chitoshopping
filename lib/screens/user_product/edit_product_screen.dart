import 'dart:io';

import 'package:chito_shopping/provider/products_provider.dart';
import 'package:chito_shopping/theme/constants.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

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
  List<String> _productType = ["Flash", "New"];
  String _selectedType;

  //product vars
  String _title, _price, _description, _category;

  //image picker
  File _imageFile;
  final imagePicker = ImagePicker();
  bool _isLoading = false;

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();
    if (_imageFile == null) {
      _scaffoldKey.currentState.showSnackBar(SnackBar(
        content: Text("Please add a product image"),
        backgroundColor: themeConst.errorColor,
      ));
    }
    if (isValid) {
      _formKey.currentState.save();
      setState(() {
        _isLoading = true;
      });
      final newProduct = Product(
        imageURL:
            "https://d4kkpd69xt9l7.cloudfront.net/sys-master/images/h57/hdd/9010331451422/razer-blade-pro-hero-mobile.jpg",
        id: DateTime.now().toString(),
        price: double.parse(_price),
        category: _category,
        description: _description,
        rating: "4.0",
        type: _selectedType,
        title: _title,
      );
      try {
        await Provider.of<Products>(context, listen: false)
            .addProduct(newProduct);
        Navigator.pop(context);
      } catch (error) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Something went wrong! Please try again"),
          backgroundColor: themeConst.errorColor,
        ));
      }
      setState(() {
        _isLoading = false;
      });
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
              onSaved: (value) {
                _title = value;
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
              onSaved: (value) {
                _price = value;
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
              onSaved: (value) {
                _description = value;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: "Category",
              ),
              keyboardType: TextInputType.text,
              validator: (value) {
                if (value.isEmpty) {
                  return "Category is required";
                }
                if (value.length < 4) {
                  return "Category is too short";
                }
                return null;
              },
              onSaved: (value) {
                _category = value;
              },
            ),
            DropdownButtonFormField<String>(
              value: _selectedType,
              decoration: InputDecoration(labelText: "Select product type"),
              items: _productType
                  .map((type) =>
                      DropdownMenuItem(child: Text(type), value: type))
                  .toList(),
              onChanged: (newValue) {
                setState(() {
                  _selectedType = newValue;
                });
              },
              validator: (value) {
                if (value == null) {
                  return "Product type is required";
                }
                return null;
              },
            ),
            SizedBox(
              height: mHeight * 0.05,
            ),
            RaisedButton.icon(
              color: greenColor,
              icon: _isLoading ? Container() : Icon(Icons.save),
              textColor: Colors.white,
              onPressed: _isLoading ? null : _saveForm,
              disabledColor: greenColor,
              label: _isLoading
                  ? Center(
                      child: Container(
                        height: 20,
                        width: 20,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.white,
                        ),
                      ),
                    )
                  : Text("Save"),
            )
          ],
        ),
      ),
    );
  }
}
