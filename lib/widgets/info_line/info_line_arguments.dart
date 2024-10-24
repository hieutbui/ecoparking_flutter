import 'package:equatable/equatable.dart';

class InfoLineArguments with EquatableMixin {
  final String title;
  final String info;
  final bool isShowDivider;

  const InfoLineArguments({
    required this.title,
    required this.info,
    this.isShowDivider = false,
  });

  @override
  List<Object?> get props => [
        title,
        info,
        isShowDivider,
      ];
}
