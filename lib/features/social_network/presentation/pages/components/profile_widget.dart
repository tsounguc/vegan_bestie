import 'package:flutter/material.dart';
import 'package:sheveegan/core/custom_circle_avatar.dart';

import '../edit_profile_page.dart';

class ProfileWidget extends StatelessWidget {
  final bool isOnEditProfilePage;
  const ProfileWidget({Key? key, required this.isOnEditProfilePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isOnEditProfilePage) {
          Navigator.of(context).pushNamed(EditProfilePage.id);
        } else {
          debugPrint("Go to image selector");
        }
      },
      child: Center(
        child: Stack(
          children: [
            Center(
              child: Material(
                color: Colors.transparent,
                child: CustomCircleAvatar(
                  size: 75,
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              right: 90,
              child: ClipOval(
                child: Container(
                  padding: EdgeInsets.all(4),
                  color: Theme.of(context).colorScheme.background,
                  child: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(
                      isOnEditProfilePage ? Icons.add_a_photo : Icons.edit,
                      size: 20,
                      color: Colors.white,
                    ),
                    radius: 20,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
