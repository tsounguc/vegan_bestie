import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../auth_cubit/auth_cubit.dart';
import '../login_page.dart';

class OtherAuthOptions extends StatefulWidget {
  final String pageId;
  const OtherAuthOptions({Key? key, required this.pageId}) : super(key: key);

  @override
  State<OtherAuthOptions> createState() => _OtherAuthOptionsState();
}

class _OtherAuthOptionsState extends State<OtherAuthOptions> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: IconButton(
              onPressed: () {
                if (widget.pageId == LoginPage.id) {
                  BlocProvider.of<AuthCubit>(context).signInWithFacebook();
                }
              },
              icon: Icon(
                FontAwesomeIcons.facebookF,
                // size: 35,
                color: Colors.blue,
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: Center(
            child: IconButton(
              onPressed: () {
                if (widget.pageId == LoginPage.id) {
                  BlocProvider.of<AuthCubit>(context).signInWithGoogle();
                }
              },
              // icon: Icon(
              //   FontAwesomeIcons.google,
              //   color: Colors.black,
              //   // size: 35,
              // ),
              icon: CachedNetworkImage(
                imageUrl: 'http://pngimg.com/uploads/google/google_PNG19635.png',
                fit: BoxFit.cover,
              ),
            ),
          ),
        ),
        Container(
          height: 50,
          width: 100,
          decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black, width: 1),
              borderRadius: BorderRadius.circular(10)),
          child: IconButton(
            onPressed: () {},
            icon: Icon(
              FontAwesomeIcons.apple,
              // size: 35,
              color: Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
