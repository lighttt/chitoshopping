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
  String _id;

  //product vars
  String _title, _price, _description, _category;
  Product _editProduct;

  //image picker
  File _imageFile;
  final imagePicker = ImagePicker();
  bool _isLoading = false;
  bool _isInit = true;

  void _saveForm() async {
    final isValid = _formKey.currentState.validate();

    if (_id == null) {
      print(_imageFile);
      if (_imageFile == null) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please add a product image"),
          backgroundColor: themeConst.errorColor,
        ));
        return;
      }
    } else {
      if (_imageFile == null && _editProduct.imageURL.isEmpty) {
        _scaffoldKey.currentState.showSnackBar(SnackBar(
          content: Text("Please add a product image"),
          backgroundColor: themeConst.errorColor,
        ));
        return;
      }
    }
    if (isValid) {
      _formKey.currentState.save();
      await _addOrUpdateProduct();
    }
  }

  Future<void> _addOrUpdateProduct() async {
    setState(() {
      _isLoading = true;
    });

    final newProduct = Product(
      id: DateTime.now().toString(),
      price: double.parse(_price),
      category: _category,
      description: _description,
      rating: "4.0",
      type: _selectedType,
      title: _title,
    );
    try {
      if (_id != null) {
        print("reached here 2");
        await Provider.of<Products>(context, listen: false)
            .updateProduct(_id, newProduct, _editProduct.imageURL, _imageFile);
      } else {
        print("reached here 3");
        await Provider.of<Products>(context, listen: false)
            .addProduct(newProduct, _imageFile);
      }
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

  // capture image from camera
  Future<void> _takePhoto() async {
    final capturePhoto = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _imageFile = File(capturePhoto.path);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (_isInit) {
      _id = ModalRoute.of(context).settings.arguments as String;
      if (_id != null) {
        _editProduct =
            Provider.of<Products>(context, listen: false).findProductById(_id);
        _selectedType = _editProduct.type;
      } else {
        _editProduct = Product(
            id: "",
            type: "",
            category: "",
            title: "",
            description: "",
            rating: "",
            price: 0.0,
            imageURL: "");
      }
    }
    _isInit = false;
  }

  Widget _getImageWidget() {
    if (_imageFile != null) {
      return Image.file(
        _imageFile,
        fit: BoxFit.cover,
      );
    } else if (_editProduct.imageURL != null) {
      if (_editProduct.imageURL.isNotEmpty) {
        return Image.network(
          _editProduct.imageURL,
          fit: BoxFit.cover,
        );
      } else {
        return Center(
            child: Text(
          "Upload product picture",
          textAlign: TextAlign.center,
        ));
      }
    } else {
      return Center(
          child: Text(
        "Upload product picture",
        textAlign: TextAlign.center,
      ));
    }
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
        title: Text(_id == null ? "Add Product" : "Edit Product"),
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
                      child: _getImageWidget()),
                ),
              ],
            ),
            TextFormField(
              initialValue: _editProduct.title,
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
              initialValue: _id == null ? "" : _editProduct.price.toString(),
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
              initialValue: _editProduct.description,
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
              initialValue: _editProduct.category,
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
