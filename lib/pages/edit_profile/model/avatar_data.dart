import 'dart:typed_data';

import 'package:equatable/equatable.dart';

class AvatarData with EquatableMixin {
  final Uint8List bytes;
  final String fileExtension;

  const AvatarData({
    required this.bytes,
    required this.fileExtension,
  });

  @override
  List<Object?> get props => [
        bytes,
        fileExtension,
      ];
}
