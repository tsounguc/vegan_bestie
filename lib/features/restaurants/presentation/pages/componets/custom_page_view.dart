import 'package:flutter/material.dart';
import 'package:sheveegan/core/resources/media_resources.dart';
import 'package:sheveegan/core/services/router/app_router.dart';
import 'package:sheveegan/features/restaurants/domain/entities/restaurant.dart';
import 'package:sheveegan/features/restaurants/presentation/pages/restaurant_picture_screen.dart';

class CustomPageView extends StatefulWidget {
  const CustomPageView({required this.restaurant, super.key});

  final Restaurant restaurant;

  @override
  State<CustomPageView> createState() => _CustomPageViewState();
}

class _CustomPageViewState extends State<CustomPageView> {
  PageController pageController = PageController(viewportFraction: 0.87);
  var _currentPageValue = 0.0;
  final double _scaleFactor = 0.85;
  int currentPosition = 0;
  double height = 0;

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currentPageValue = pageController.page!;
      });
      debugPrint('Current value is $_currentPageValue');
    });
  }

  @override
  void dispose() {
    super.dispose();
    pageController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (height <= 0) {
      height = MediaQuery.of(context).size.height * 0.35;
    }
    return PageView.builder(
      controller: pageController,
      itemCount: widget.restaurant.photos.length,
      itemBuilder: (BuildContext context, int position) {
        debugPrint('CurrentPageValue = $_currentPageValue');
        debugPrint('Position = $position');
        currentPosition = position;
        var matrix = Matrix4.identity();
        if (position == _currentPageValue.floor()) {
          final currentScale = 1 - (_currentPageValue - position) * (1 - _scaleFactor);
          final currentTransformation = height * (1 - currentScale) / 2;
          matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransformation, 0);
        } else if (position == _currentPageValue.floor() + 1) {
          final currentScale = _scaleFactor + (_currentPageValue - position + 1) * (1 - _scaleFactor);
          final currentTransformation = height * (1 - currentScale) / 2;
          matrix = Matrix4.diagonal3Values(1, currentScale, 1);
          matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransformation, 0);
        } else if (position == _currentPageValue.floor() - 1) {
          final currentScale = 1 - (_currentPageValue - position) * (1 - _scaleFactor);
          final currentTransformation = height * (1 - currentScale) / 2;
          matrix = Matrix4.diagonal3Values(1, currentScale, 1);
          matrix = Matrix4.diagonal3Values(1, currentScale, 1)..setTranslationRaw(0, currentTransformation, 0);
        } else {
          final currentScale = _scaleFactor;
          matrix = Matrix4.diagonal3Values(1, currentScale, 1);
          matrix = Matrix4.diagonal3Values(1, currentScale, 1)
            ..setTranslationRaw(0, height * (1 - _scaleFactor), 1);
        }
        return Transform(
          transform: matrix,
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pushNamed(
                RestaurantPictureScreen.id,
                arguments: RestaurantPictureScreenArguments(
                  widget.restaurant.photos[position],
                ),
              );
            },
            child: Hero(
              tag: widget.restaurant.photos[position],
              child: Container(
                height: height,
                margin: const EdgeInsets.only(
                  left: 5,
                  right: 5,
                  top: 10,
                  bottom: 10,
                ),
                decoration: BoxDecoration(
                  color: Colors.grey,
                  borderRadius: BorderRadius.circular(15),
                  // border: Border.all(color: Colors.black12),
                  boxShadow: _currentPageValue != position
                      ? const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            offset: Offset(2, 4),
                          ),
                        ]
                      : const [
                          BoxShadow(
                            color: Colors.black38,
                            blurRadius: 2,
                            offset: Offset(2, 4),
                          ),
                        ],
                  image: widget.restaurant.photos[position].isNotEmpty &&
                          !widget.restaurant.photos[position].contains(
                            '_empty.photo',
                          )
                      ? DecorationImage(
                          fit: BoxFit.fill,
                          image: NetworkImage(
                            widget.restaurant.photos[position],
                          ),
                        )
                      : const DecorationImage(
                          fit: BoxFit.contain,
                          // colorFilter: ColorFilter.mode(Colors.grey, BlendMode.darken),
                          image: AssetImage(MediaResources.tofu),
                        ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
