import 'dart:io';

import 'package:another_flushbar/flushbar.dart';
import 'package:deersolo/src/models/product.dart';
import 'package:deersolo/src/pages/management/widgets/product_image.dart';
import 'package:deersolo/src/services/network_service.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ManagementPage extends StatefulWidget {
  const ManagementPage({Key? key}) : super(key: key);

  @override
  State<ManagementPage> createState() => _ManagementPageState();
}

class _ManagementPageState extends State<ManagementPage> {
  late bool _isEdit;
  final _spacing = 12.0;
  late Product _product;
  final _form = GlobalKey<FormState>();
  File? _imageFile;

  @override
  void initState() {
    _isEdit = false;
    _product = Product(
      id: null,
      name: null,
      image: null,
      stock: null,
      price: null,
      createdAt: null,
      updatedAt: null,
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Object? arguments = ModalRoute.of(context)?.settings.arguments;
    if (arguments is Product) {
      _isEdit = true;
      _product = arguments;
    }
    return Scaffold(
        appBar: _buildAppBar(),
        body: Form(
          key: _form,
          child: Padding(
            padding: EdgeInsets.all(_spacing),
            child: Column(
              children: [
                _buildNameInput(),
                SizedBox(
                  height: 8,
                ),
                Row(
                  children: [
                    Flexible(
                      child: _buildPriceInput(),
                      flex: 1,
                    ),
                    SizedBox(width: _spacing),
                    Flexible(
                      child: _buildStockInput(),
                      flex: 1,
                    ),
                  ],
                ),
                ProductImage(
                  callBack,
                  _product.image,
                ),
              ],
            ),
          ),
        ));
  }

  callBack(File? imageFile) {
    this._imageFile = imageFile;
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_isEdit ? 'Edit Product' : 'Create Product'),
      actions: [
        if (_isEdit) _buildDeleteButton(),
        TextButton(
          onPressed: () {
            _form.currentState!.save();
            FocusScope.of(context).requestFocus(FocusNode());
            if(_isEdit){
              editProduct();
            }
            else{
              addProduct();
            }

          },
          child: Text(
            'submit',
            style: TextStyle(
              color: Colors.white,
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  InputDecoration inputStyle(label) => InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(
          color: Colors.black12,
          width: 2,
        )),
        labelText: label,
      );

  TextFormField _buildNameInput() => TextFormField(
        decoration: inputStyle('name'),
        onSaved: (value) {
          _product.name = value!.isNotEmpty ? value : '--';
        },
      );

  TextFormField _buildPriceInput() => TextFormField(
        decoration: inputStyle('price'),
        keyboardType: TextInputType.number,
        onSaved: (value) {
          if (value!.isNotEmpty) {
            _product.price = int.parse(value!);
          } else {
            _product.price = 0;
          }
        },
      );

  TextFormField _buildStockInput() => TextFormField(
        decoration: inputStyle('stock'),
        keyboardType: TextInputType.number,
        onSaved: (value) {
          if (value!.isNotEmpty) {
            _product.stock = int.parse(value!);
          } else {
            _product.stock = 0;
          }
        },
      );

  void addProduct() {
    NetworkService()
        .addProduct(imageFile: _imageFile, product: _product)
        .then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(error.toString(),
          icon: FontAwesomeIcons.timesCircle, color: Colors.red);
    });
  }

  void showAlertBar(
    String message, {
    IconData icon = FontAwesomeIcons.checkCircle,
    Color color = Colors.green,
  }) {
    Flushbar(
      message: message,
      icon: FaIcon(
        icon,
        size: 28.0,
        color: color,
      ),
      flushbarPosition: FlushbarPosition.TOP,
      duration: Duration(seconds: 3),
      flushbarStyle: FlushbarStyle.GROUNDED,
    )..show(context);
  }

  IconButton _buildDeleteButton() => IconButton(
      onPressed: () {
        showDialog<void>(
          context: context,
          builder: (BuildContext dialogContext) {
            return AlertDialog(
              title: Text('Delete Product'),
              content: Text('Are you sure you want to delete?'),
              actions: <Widget>[
                TextButton(
                  child: Text('cancel'),
                  onPressed: () {
                    Navigator.of(dialogContext).pop(); // Dismiss alert dialog
                  },
                ),
                TextButton(
                  child: Text(
                    'ok',
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () {
                    Navigator.of(dialogContext).pop();
                    deleteProduct();// Dismiss alert dialog
                  },
                ),
              ],
            );
          },
        );
      },
      icon: Icon(Icons.delete_outline));

  void deleteProduct() {
    NetworkService()
        .deleteProduct(_product.id)
        .then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(error.toString(),
          icon: FontAwesomeIcons.timesCircle, color: Colors.red);
    });
  }

  void editProduct() {
    NetworkService()
        .editProduct(product: _product, imageFile: _imageFile )
        .then((result) {
      Navigator.pop(context);
      showAlertBar(result);
    }).catchError((error) {
      showAlertBar(error.toString(),
          icon: FontAwesomeIcons.timesCircle, color: Colors.red);
    });
  }
}
