import 'dart:io';

import 'package:deersolo/src/models/product.dart';
import 'package:flutter/material.dart';

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
                )
              ],
            ),
          ),
        ));
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: Text(_isEdit ? 'Edit Product' : 'Create Product'),
      actions: [
        TextButton(
          onPressed: () {
            _form.currentState!.save();
            print(_product.name);
            print(_product.price.toString());
            print(_product.stock.toString());
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
}
