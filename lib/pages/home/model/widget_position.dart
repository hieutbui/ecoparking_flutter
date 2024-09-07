import 'package:equatable/equatable.dart';

class WidgetPosition with EquatableMixin {
  final double? top;
  final double? right;
  final double? bottom;
  final double? left;

  WidgetPosition({
    this.top,
    this.right,
    this.bottom,
    this.left,
  });

  @override
  List<Object?> get props => [
        top,
        right,
        bottom,
        left,
      ];
}
