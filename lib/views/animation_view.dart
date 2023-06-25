import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ososs/constants/constants.dart';
import 'package:provider/provider.dart';

import '../models/shape.dart';
import '../providers/shape_provider.dart';
import '../providers/user_provider.dart';
import '../styles/app_colors.dart';
import '../styles/app_styles.dart';

class AnimationView extends StatefulWidget {
  AnimationView({Key? key}) : super(key: key);

  @override
  State<AnimationView> createState() => _AnimationViewState();
}

class _AnimationViewState extends State<AnimationView>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () {
              GoRouter.of(context).pop();
            }),
        title: Text('Animations'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        //crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 60,
            padding: EdgeInsets.all(8),
            child: Selector<UserProvider, String>(
              selector: (context, userProvider) => userProvider.user.name!,
              builder: (_, userName, __) {
                print("I GOT INTO SELECTOR Animation View");
                return Container(
                    height: 100,
                    width: size.width,
                    padding:
                        EdgeInsets.only(left: 30, right: 30, top: 5, bottom: 5),
                    child: Center(
                        child: Text(
                      userName.isEmpty ? "your name" : userName,
                      style: AppStyles.blackSmallBoldTextStyle.copyWith(
                        color: AppColors.blackColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    )));
              },
            ),
          ),
          Center(
              child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 50),
                  transitionBuilder: (child, animation) {
                    return SlideTransition(
                        position: Tween(
                                begin: Offset(0.8, 0.0), end: Offset(0.0, 0.0))
                            .animate(_animation),
                        child: child);
                  },
                  child: chooseSelectedShape(context, size))),
          Padding(
            padding: const EdgeInsets.only(left: 50, right: 50),
            child: Container(
              height: 160,
              child: Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        var rectangle = context
                            .read<ShapeProvider>()
                            .Shapes
                            .where((element) =>
                                element.name == Constants.RECTANGLE)
                            .firstOrNull;
                        if (rectangle != null) {
                          context
                              .read<ShapeProvider>()
                              .setSelectedShape(rectangle);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColors.darkPrimaryColor,
                            shape: BoxShape.rectangle),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        var curveRectangle = context
                            .read<ShapeProvider>()
                            .Shapes
                            .where((element) =>
                                element.name == Constants.CURVERECTANGLE)
                            .firstOrNull;
                        if (curveRectangle != null) {
                          context
                              .read<ShapeProvider>()
                              .setSelectedShape(curveRectangle);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: AppColors.primaryColor,
                            borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        var circle = context
                            .read<ShapeProvider>()
                            .Shapes
                            .where(
                                (element) => element.name == Constants.CIRCLE)
                            .firstOrNull;
                        if (circle != null) {
                          context
                              .read<ShapeProvider>()
                              .setSelectedShape(circle);
                        }
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                            color: Colors.red, shape: BoxShape.circle),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

Widget chooseSelectedShape(BuildContext context, Size size) {
  return Selector<ShapeProvider, Shape>(
      selector: (context, shapeProvider) => shapeProvider.SelectedShape!,
      builder: (_, selectedShape, __) {
        if (selectedShape.name == Constants.RECTANGLE) {
          return Container(
            height: size.height / 3,
            width: size.width / 1.4,
            color: AppColors.darkPrimaryColor,
          );
        }
        return Container(
          height: size.height / 3,
          width: size.width / 1.4,
          decoration: selectedShape.name == Constants.CIRCLE
              ? BoxDecoration(shape: BoxShape.circle, color: AppColors.redColor)
              : BoxDecoration(
                  color: AppColors.primaryColor,
                  borderRadius: BorderRadius.circular(12)),
        );
      });
}
