import 'package:ecoparking_flutter/pages/profile/profile_view.dart';
import 'package:flutter/material.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  ProfileController createState() => ProfileController();
}

class ProfileController extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => ProfilePageView(controller: this);
}
