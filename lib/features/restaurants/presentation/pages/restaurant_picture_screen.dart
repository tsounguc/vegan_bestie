import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/screens/loading/loading.dart';
import 'package:sheveegan/core/common/widgets/custom_back_button.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';

class RestaurantPictureScreen extends StatelessWidget {
  RestaurantPictureScreen({
    required this.image,
    required this.tag,
    super.key,
  });

  static const String id = '/restaurantPictureScreen';

  final DecorationImage image;
  final String tag;
  int currentPosition = 0;
  double height = 0;

  @override
  Widget build(BuildContext context) {
    final user = context.currentUser;
    return BlocListener<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is ProfilePicDeleted) {
          CoreUtils.showSnackBar(context, 'Restaurants picture deleted');
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        backgroundColor: Theme.of(context).colorScheme.background,
        extendBodyBehindAppBar: true,
        extendBody: true,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          surfaceTintColor: Colors.transparent,
          leading: const CustomBackButton(),
          centerTitle: true,
          actions: [
            if (user?.photoUrl != null && user!.photoUrl!.isNotEmpty)
              Padding(
                padding: const EdgeInsets.only(right: 8),
                child: TextButton(
                  onPressed: () {
                    context.read<AuthBloc>().add(DeleteProfilePicEvent(user: user));
                  },
                  child: Text(
                    'Delete Profile',
                    style: TextStyle(
                      fontSize: 14.sp,
                      // color: Theme.of(context).textTheme.titleLarge?.color,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              )
          ],
        ),
        body: Container(
          color: Colors.black,
          padding: const EdgeInsets.symmetric(vertical: 150),
          child: Center(
            child: Hero(
              tag: tag,
              child: tag.isNotEmpty &&
                      !tag.contains(
                        '_empty.photo',
                      )
                  ? CachedNetworkImage(
                      imageUrl: tag,
                      fit: BoxFit.cover,
                      placeholder: (context, percentage) {
                        return const LoadingPage(
                          backgroundColor: Colors.black,
                        );
                      },
                      errorWidget: (context, error, child) {
                        return const Center(
                          child: Padding(
                            padding: EdgeInsets.only(top: 150),
                            child: Icon(
                              Icons.person,
                              color: Colors.grey,
                              size: 400,
                            ),
                          ),
                        );
                      },
                    )
                  : const Center(
                      child: Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Icon(
                          Icons.person,
                          color: Colors.grey,
                          size: 400,
                        ),
                      ),
                    ),
            ),
          ),
        ),
      ),
    );
  }
}
