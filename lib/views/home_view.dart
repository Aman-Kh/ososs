import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:go_router/go_router.dart';
import 'package:ososs/models/user.dart';
import 'package:ososs/providers/pokemon_provider.dart';
import 'package:provider/provider.dart';

import '../providers/base_provider.dart';
import '../providers/shape_provider.dart';
import '../providers/user_provider.dart';
import '../routing/app_router.dart';
import '../styles/app_colors.dart';
import '../styles/app_styles.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  TextEditingController nameController = TextEditingController(text: "");
  FocusNode nameFocusNode = FocusNode();

  bool isNameControllerFilled = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    initialization();
  }

  void initialization() async {
    await Future.delayed(const Duration(seconds: 3));
    FlutterNativeSplash.remove();
  }

  @override
  Widget build(BuildContext context) {
    //var size = context.size;
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            height: 70,
            padding:
                const EdgeInsets.only(left: 20, right: 20, top: 10, bottom: 10),
            width: width,
            child: Consumer<UserProvider>(
              builder: (_, provider, __) {
                return TextFormField(
                  controller: nameController,
                  onChanged: (value) {
                    context.read<UserProvider>().setUserName(value);
                  },
                  autovalidateMode: AutovalidateMode.always,
                  style: AppStyles.blackSmallBoldTextStyle,
                  showCursor: true,
                  keyboardType: TextInputType.text,
                  focusNode: nameFocusNode,
                  inputFormatters: const [],
                  decoration: InputDecoration(
                    hintText: 'Enter your name',
                    focusedBorder: UnderlineInputBorder(
                      borderSide:
                          BorderSide(color: AppColors.primaryColor, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(2.0)),
                    ),
                  ),
                );
              },
            ),
          ),
          Selector<UserProvider, String>(
            selector: (context, userProvider) => userProvider.user.name!,
            builder: (_, userName, __) {
              print("I GOT INTO SELECTOR");
              return Container(
                  height: 100,
                  width: width,
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
          SizedBox(
            height: 100,
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              InkWell(
                onTap: () {
                  nameController.clear();
                  context.read<UserProvider>().setUserName('');
                },
                child: Container(
                  height: 80,
                  padding:
                      EdgeInsets.only(top: 10, bottom: 5, right: 5, left: 5),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.delete,
                          size: 20,
                          color: AppColors.darkRedColor,
                        ),
                        Text(
                          "Clear text",
                          style: AppStyles.blackSmallBoldTextStyle.copyWith(
                            color: AppColors.darkRedColor,
                            fontSize: 15,
                          ),
                        )
                      ]),
                ),
              ),
              Container(
                width: width / 1.1,
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                    onPressed: () async {
                      context.read<ShapeProvider>().getAllShapes();
                      context.read<ShapeProvider>().setSelectedShape(
                          context.read<ShapeProvider>().Shapes[0]);
                      context.read<ShapeProvider>().setBorderRadius(500.0);
                      context.read<ShapeProvider>().setColor(Colors.red);
                      GoRouter.of(context).push(AppRouter.ANIMATION_VIEW);
                    },
                    child: Text(
                      "Go to Page 1",
                      style: AppStyles.blackSmallBoldTextStyle.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 15,
                      ),
                    ),
                    style: AppStyles.primaryButtonStyle),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: width / 1.1,
                height: 50,
                padding: EdgeInsets.only(left: 10, right: 10),
                child: ElevatedButton(
                    onPressed: () async {
                      context.read<PokemonProvider>().getAllPokemons();

                      GoRouter.of(context).push(AppRouter.POKEMON_VIEW);
                    },
                    child: Text(
                      "Go to Page 2",
                      style: AppStyles.blackSmallBoldTextStyle.copyWith(
                        color: AppColors.whiteColor,
                        fontSize: 15,
                      ),
                    ),
                    style: AppStyles.darkPrimaryButtonStyle),
              ),
              SizedBox(
                height: 10,
              )
            ],
          )
        ],
      ),
    );
  }
}
