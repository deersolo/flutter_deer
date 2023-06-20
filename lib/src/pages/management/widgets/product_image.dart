import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:deersolo/src/constants/api.dart';

class ProductImage extends StatefulWidget {
  final Function(File? imageFile) callBack;
  final String? imageURL;
  const ProductImage(this.callBack, this.imageURL);

  @override
  State<ProductImage> createState() => _ProductImageState();
}

class _ProductImageState extends State<ProductImage> {
  final _picker = ImagePicker();
  File? _imageFile;
  String? _imageURL;

  @override
  void initState() {
    _imageURL = widget.imageURL;
    super.initState();
  }
  @override
  void dispose() {
    _imageFile?.delete();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildPickerImage(),
          _buildPreviewImage(),
        ],
      ),
    );
  }

  _buildPickerImage() => OutlinedButton.icon(
      onPressed: () {
        _modalPickerImage();
      },
      icon: FaIcon(FontAwesomeIcons.image),
      label: Text('image'));

  dynamic _buildPreviewImage() {
    if ((_imageURL == null || _imageURL!.isEmpty) && _imageFile == null) {
      return SizedBox();
    }
    else {
      final container = (Widget child) => Container(
            color: Colors.grey[100],
            margin: EdgeInsets.only(top: 4),
            alignment: Alignment.center,
            height: 350,
            child: child,
          );

      return _imageURL != null ? container(Image.network('${API.IMAGE_URL}/$_imageURL'))
          : Stack(
        children: [
          container(Image.file(_imageFile!)),
          _buildDeleteImageButton(),
        ],
      );
    }
  }

  _buildDeleteImageButton() => Positioned(
        right: 0,
        child: IconButton(
          onPressed: () {
            setState(() {
              _imageFile = null;
              widget.callBack(null);
            });
          },
          icon: Icon(
            Icons.clear,
            color: Colors.black54,
          ),
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
      );

  void _modalPickerImage() {
    final buildListTile =
        (IconData icon, String title, ImageSource) => ListTile(
              leading: Icon(icon),
              title: Text(title),
              onTap: () {
                Navigator.pop(context);
                _pickImages(ImageSource);
              },
            );

    showModalBottomSheet(
      context: context,
      builder: (context) => Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          buildListTile(
            Icons.photo_library,
            "Choose from photo gallery",
            ImageSource.gallery,
          ),
          buildListTile(
            Icons.photo_camera,
            "Take a picture from camera",
            ImageSource.camera,
          ),
        ],
      ),
    );
  }

  void _pickImages(ImageSource imageSource) {
    _picker
        .getImage(
      source: imageSource,
      imageQuality: 100,
      maxHeight: 1000,
      maxWidth: 1000,
    )
        .then((file) {
      if (file != null) {
        _cropImage(file.path);
      }
    });
  }

  void _cropImage(String file) {
    ImageCropper().cropImage(
      sourcePath: file,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
        CropAspectRatioPreset.ratio3x2,
        CropAspectRatioPreset.original,
        CropAspectRatioPreset.ratio4x3,
        CropAspectRatioPreset.ratio16x9
      ],
      uiSettings: [
        AndroidUiSettings(
            toolbarTitle: 'Cropper',
            toolbarColor: Colors.blueGrey,
            toolbarWidgetColor: Colors.white,
            initAspectRatio: CropAspectRatioPreset.original,
            lockAspectRatio: false),
        IOSUiSettings(
          title: 'Cropper',
        ),
      ],
    ).then((file) {
      if (file != null) {
        setState(() {
          _imageFile = File(file.path);
          widget.callBack(_imageFile!);
          _imageURL = null;
        });
      }
    });
  }
}
