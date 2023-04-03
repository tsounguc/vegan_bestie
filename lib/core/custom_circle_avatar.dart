import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../features/auth/presentation/auth_cubit/auth_cubit.dart';

class CustomCircleAvatar extends StatefulWidget {
  double? size;

  CustomCircleAvatar({Key? key, this.size}) : super(key: key);

  @override
  State<CustomCircleAvatar> createState() => _CustomCircleAvatarState();
}

class _CustomCircleAvatarState extends State<CustomCircleAvatar> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is LoggedInState) {
          return CircleAvatar(
            backgroundColor: Colors.grey.shade200,
            backgroundImage: state.currentUser?.photoUrl != null && state.currentUser!.photoUrl!.isNotEmpty
                ? NetworkImage(state.currentUser!.photoUrl!)
                : null,
            child: state.currentUser?.photoUrl != null
                ? null
                : Center(
                    child: Icon(
                      Icons.person,
                      size: widget.size,
                      color: Colors.black,
                    ),
                  ),
            radius: widget.size,
          );
        }
        return Container();
      },
    );
  }
}
