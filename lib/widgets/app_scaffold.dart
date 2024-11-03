import 'package:flutter/material.dart';

class AppScaffold extends StatelessWidget {
  final String title;
  final Widget body;
  final bool? showBackButton;

  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          title,
          style: Theme.of(context).textTheme.displaySmall!.copyWith(
                color: Colors.black,
              ),
        ),
        leading: (showBackButton ?? false)
            ? IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () => Navigator.of(context).pop(),
              )
            : null,
      ),
      body: body,
    );
  }
}
