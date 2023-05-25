import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
//import 'package:image_picker/image_picker.dart';


class ProductImage extends StatefulWidget {
  const ProductImage({Key? key}) : super(key: key);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  late File _imageFile = File('path');
  //final _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPickerImage(),
          //_buildPreviewImage(),
        ],
      ),
    );
  }

  _buildPickerImage() => OutlinedButton.icon(
      onPressed: () {
        //_modalPickerImage();
        debugPrint('Received click test');
      },
      icon: FaIcon(FontAwesomeIcons.image),
      label: Text('image'));

  dynamic _buildPreviewImage() {
    if (_imageFile != 'path') {
      return SizedBox();
    } else {
      final container = (Widget child) => Container(
            color: Colors.grey[100],
            margin: EdgeInsets.only(top: 4),
            alignment: Alignment.center,
            height: 350,
            child: child,
          );

      return Stack(
        children: [
          container(Image.file(_imageFile)),
          _buildDeleteImageButton(),
        ],
      );
    }
  }

  _buildDeleteImageButton() => Positioned(
        right: 0,
        child: IconButton(
          onPressed: () {
            //todo
          },
          icon: Icon(
            Icons.clear,
            color: Colors.black54,
          ),
        ),
      );

  // void _modalPickerImage() {
  //   final buildListTile =
  //       (IconData icon, String title, ImageSource) => ListTile(
  //             leading: Icon(icon),
  //             title: Text(title),
  //             onTap: () {
  //               Navigator.pop(context);
  //               _pickImages(ImageSource);
  //             },
  //           );
  //
  //   showModalBottomSheet(
  //     context: context,
  //     builder: (context) => Column(
  //       mainAxisSize: MainAxisSize.min,
  //       children: <Widget>[
  //         buildListTile(
  //           Icons.photo_camera,
  //           "Take a picture from camera",
  //           ImageSource.camera,
  //         ),
  //         buildListTile(
  //           Icons.photo_library,
  //           "Choose from photo library",
  //           ImageSource.gallery,
  //         ),
  //       ],
  //     ),
  //   );
  // }
  //
  // void _pickImages(ImageSource imageSource) {
  //   _picker
  //       .getImage(
  //     source: imageSource,
  //     imageQuality: 70,
  //     maxHeight: 500,
  //     maxWidth: 500,
  //   )
  //       .then((file) {
  //     if (file != null) {
  //       setState(() {
  //         _imageFile = File(file.path);
  //       });
  //     }
  //   });
  // }
}
