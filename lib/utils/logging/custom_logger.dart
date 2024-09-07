import 'package:loggy/loggy.dart';

mixin ControllerLoggy implements LoggyType {
  @override
  Loggy<ControllerLoggy> get loggy =>
      Loggy<ControllerLoggy>('Controller Loggy - $runtimeType');
}
