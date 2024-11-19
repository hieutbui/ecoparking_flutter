import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/avatar_button/avatar_button_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';

class AvatarButton extends StatefulWidget {
  final String userAvatar;
  final Function(Uint8List?, String?)? onImageSelected;

  const AvatarButton({
    super.key,
    required this.userAvatar,
    this.onImageSelected,
  });

  @override
  State<AvatarButton> createState() => _AvatarButtonState();
}

class _AvatarButtonState extends State<AvatarButton> {
  Uint8List? _imageData;
  String? _fileExtension;

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null &&
          result.files.single.bytes != null &&
          result.files.single.extension != null) {
        setState(() {
          _imageData = result.files.single.bytes;
          _fileExtension = result.files.single.extension;
          widget.onImageSelected?.call(_imageData, _fileExtension);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: _pickImage,
        child: Stack(
          alignment: AlignmentDirectional.bottomEnd,
          children: <Widget>[
            if (widget.userAvatar.isNotEmpty && _imageData == null) ...[
              GFAvatar(
                backgroundImage: NetworkImage(widget.userAvatar),
                size: AvatarButtonStyles.avatarSize,
                shape: GFAvatarShape.circle,
              )
            ] else if (_imageData == null) ...[
              Container(
                width: AvatarButtonStyles.avatarSize,
                height: AvatarButtonStyles.avatarSize,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.grey,
                ),
                child: SvgPicture.asset(
                  ImagePaths.icPerson,
                  width: AvatarButtonStyles.iconPersonWidth,
                  height: AvatarButtonStyles.iconPersonHeight,
                ),
              ),
            ] else ...[
              Container(
                width: AvatarButtonStyles.avatarSize,
                height: AvatarButtonStyles.avatarSize,
                decoration: AvatarButtonStyles.getDecoration(
                  context: context,
                  imageData: _imageData,
                ),
              ),
            ],
            Transform.translate(
              offset: AvatarButtonStyles.editRectanglesOffset,
              child: Container(
                height: AvatarButtonStyles.editRectanglesSize,
                width: AvatarButtonStyles.editRectanglesSize,
                alignment: Alignment.center,
                decoration:
                    AvatarButtonStyles.getEditRectangleDecoration(context),
                child: const Icon(
                  Icons.edit,
                  size: AvatarButtonStyles.iconEditSize,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
