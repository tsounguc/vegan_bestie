import 'package:flutter/material.dart';
import 'package:sheveegan/core/custom_circle_avatar.dart';

class ProfileWidget extends StatelessWidget {
  const ProfileWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
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
            right: 85,
            child: ClipOval(
              child: Container(
                padding: EdgeInsets.all(4),
                color: Theme.of(context).colorScheme.background,
                child: CircleAvatar(
                  backgroundColor: Colors.blue,
                  child: Icon(
                    Icons.edit,
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
    );
  }
}
