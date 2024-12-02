import 'package:ecoparking_flutter/di/global/get_it_initializer.dart';
import 'package:flutter/material.dart';
import 'package:get_it/get_it.dart';

typedef OnFinishedBind = void Function();

abstract class BaseDi {
  void bind({OnFinishedBind? onFinishedBind}) {
    debugPrint('DI::bind() start binding');
    setUp(getIt);

    onFinishedBind?.call();
  }

  void setUp(GetIt get);
}
