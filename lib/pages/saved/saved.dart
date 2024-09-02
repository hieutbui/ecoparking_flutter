import 'package:ecoparking_flutter/pages/saved/saved_view.dart';
import 'package:flutter/material.dart';

class SavedPage extends StatefulWidget {
  const SavedPage({super.key});

  @override
  SavedController createState() => SavedController();
}

class SavedController extends State<SavedPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => SavedPageView(controller: this);
}
