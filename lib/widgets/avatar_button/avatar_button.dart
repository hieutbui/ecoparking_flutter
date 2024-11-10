import 'package:ecoparking_flutter/resource/image_paths.dart';
import 'package:ecoparking_flutter/widgets/avatar_button/avatar_button_styles.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:getwidget/getwidget.dart';

class AvatarButton extends StatefulWidget {
  final String userAvatar;
  final Function(Uint8List?)? onImageSelected;

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

  Future<void> _pickImage() async {
    try {
      FilePickerResult? result =
          await FilePicker.platform.pickFiles(type: FileType.image);
      if (result != null && result.files.single.bytes != null) {
        setState(() {
          _imageData = result.files.single.bytes;
          widget.onImageSelected?.call(_imageData);
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
            SizedBox(
              height: AvatarButtonStyles.avatarSize,
              width: AvatarButtonStyles.avatarSize,
              child: Container(
                decoration: AvatarButtonStyles.getDecoration(
                  context: context,
                  imageData: _imageData,
                ),
                child: _imageData == null
                    ? Padding(
                        padding: AvatarButtonStyles.iconPersonPadding,
                        child: widget.userAvatar.isEmpty
                            ? SvgPicture.asset(
                                ImagePaths.icPerson,
                                width: AvatarButtonStyles.iconPersonWidth,
                                height: AvatarButtonStyles.iconPersonHeight,
                              )
                            : GFAvatar(
                                backgroundImage:
                                    NetworkImage(widget.userAvatar),
                                size: AvatarButtonStyles.avatarSize,
                                shape: GFAvatarShape.standard,
                              ),
                      )
                    : null,
              ),
            ),
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
