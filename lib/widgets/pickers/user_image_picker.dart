import 'dart:typed_data';
import 'package:mime/mime.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  const UserImagePicker({
    this.imgPickFn,
  });
  final void Function(
    Uint8List bytes,
    String mimeType,
  ) imgPickFn;

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  Uint8List _pickedImage;
  String _mimeType;

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final ImageSource imageSource = ImageSource.gallery;
    final pickedImageFile = await picker.getImage(
      source: imageSource,
      preferredCameraDevice: CameraDevice.rear,
      imageQuality: 50,
      maxWidth: 150,
    );
    // final pickedImage = Image.network(pickedImageFile.path);
    // final Image image = Image.memory(await pickedImageFile.readAsBytes());
    final Uint8List bytes = await pickedImageFile.readAsBytes();
    final mime = lookupMimeType('', headerBytes: bytes);
    final fileSize = bytes.lengthInBytes;
    print(fileSize.toString());
    switch (mime) {
      case "image/png":
        {
          _mimeType = "png";
        }
        break;
      case "image/gif":
        {
          _mimeType = "gif";
        }
        break;
      case "image/jpeg":
        {
          _mimeType = "jpg";
        }
        break;
      default:
        {
          _mimeType = null;
        }
        break;
    }
    if (_mimeType != null) {
      setState(() {
        _pickedImage = bytes;
      });
      widget.imgPickFn(bytes, _mimeType);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Center(
            child: Text(
              "Tipo de arquivo inválido.\nSelecione um arquivo jpg, png ou gif",
              style: TextStyle(fontSize: 25),
            ),
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 40,
          backgroundImage:
              _pickedImage != null ? Image.memory(_pickedImage).image : null,
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(Icons.image),
          label: Text("Imagem"),
          style: TextButton.styleFrom(
            primary: Theme.of(context).primaryColor,
          ),
        ),
      ],
    );
  }
}
