import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import '../../../../../core/loading.dart';
import '../../restaurant_cubit/restaurant_details_cubit.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({Key? key}) : super(key: key);

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  PageController pageController = PageController(viewportFraction: 0.87);
  var _currentPageValue = 0.0;
  double _scaleFactor = 0.85;
  int currentPosition = 0;
  double height = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
      debugPrint("Current value is $_currentPageValue");
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // double height = MediaQuery.of(context).size.height * 0.43;
    if (height <= 0) {
      height = MediaQuery.of(context).size.height * 0.35;
    }
    // double width = MediaQuery.of(context).size.width * 0.90;
    return BlocBuilder<RestaurantDetailsCubit, RestaurantDetailsState>(
      builder: (context, state) {
        if (state is RestaurantDetailsFoundState) {
          return PageView.builder(
            controller: pageController,
            itemCount: state.restaurantDetailsEntity!.photos!.length,
            itemBuilder: (BuildContext context, int position) {
              print("CurrentPageValue = $_currentPageValue");
              debugPrint("Position = $position");
              currentPosition = position;
              Matrix4 matrix = new Matrix4.identity();
              if (position == _currentPageValue.floor()) {
                var currentScale =
                    1 - (_currentPageValue - position) * (1 - _scaleFactor);
                var currentTransformation = height * (1 - currentScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currentScale, 1)
                  ..setTranslationRaw(0, currentTransformation, 0);
              } else if (position == _currentPageValue.floor() + 1) {
                var currentScale = _scaleFactor +
                    (_currentPageValue - position + 1) * (1 - _scaleFactor);
                var currentTransformation = height * (1 - currentScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currentScale, 1);
                matrix = Matrix4.diagonal3Values(1, currentScale, 1)
                  ..setTranslationRaw(0, currentTransformation, 0);
              } else if (position == _currentPageValue.floor() - 1) {
                var currentScale =
                    1 - (_currentPageValue - position) * (1 - _scaleFactor);
                var currentTransformation = height * (1 - currentScale) / 2;
                matrix = Matrix4.diagonal3Values(1, currentScale, 1);
                matrix = Matrix4.diagonal3Values(1, currentScale, 1)
                  ..setTranslationRaw(0, currentTransformation, 0);
              } else {
                var currentScale = _scaleFactor;
                matrix = Matrix4.diagonal3Values(1, currentScale, 1);
                matrix = Matrix4.diagonal3Values(1, currentScale, 1)
                  ..setTranslationRaw(0, height * (1 - _scaleFactor), 1);
              }
              return Transform(
                transform: matrix,
                child: Container(
                  height: height,
                  // width: width,
                  margin: const EdgeInsets.only(
                    left: 5,
                    right: 5,
                    top: 10,
                    bottom: 10,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    border: Border.all(color: Colors.black26),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.black45,
                    //     spreadRadius: 1,
                    //     blurRadius: 6,
                    //     offset: Offset(0, 2),
                    //   ),
                    // ],
                    image: DecorationImage(
                      fit: BoxFit.fill,
                      image: NetworkImage(
                        state.restaurantDetailsEntity?.photos?[position]
                                    .photoReference ==
                                null
                            ? state.restaurantDetailsEntity!.icon!
                            : "https://maps.googleapis.com/maps/api/place/photo?maxwidth=400&photo_reference=${state.restaurantDetailsEntity!.photos![position].photoReference}&key=${dotenv.env['GOOGLE_PLACES_API_KEY']}",
                      ),
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return LoadingPage();
        }
      },
    );
  }
}
