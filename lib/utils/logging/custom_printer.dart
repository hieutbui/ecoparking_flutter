import 'package:loggy/loggy.dart';

class CustomPrinter extends LoggyPrinter {
  @override
  void onLog(LogRecord record) {
    const prettyPrinter = PrettyPrinter(
      showColors: true,
    );
    final color = prettyPrinter.levelColor(record.level);
    final emoji = prettyPrinter.levelPrefix(record.level);
    final message = record.message;
    final time = record.time;

    print([color!('$emoji $time $message')]);
  }
}
