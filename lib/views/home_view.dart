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
      appBar: AppBar(
        title: Text('Home'),
      ),
      body: Column(
        //mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            color: Colors.teal,
            height: 70,
            padding: const EdgeInsets.all(10),
            width: width,
            child: Consumer<UserProvider>(
              builder: (_, provider, __) {
                return TextFormField(
                  controller: nameController,
                  validator: (value) {
                    if (nameController.text.isEmpty) {
                      return "Name is empty ";
                    } else {
                      return null;
                    }
                  },
                  onChanged: (value) {
                    context.read<UserProvider>().setUserName(value);
                    /*setState(() {
                    if (value.isNotEmpty) {
                      isNameControllerFilled = true;
                    } else {
                      isNameControllerFilled = false;
                    }
                  });*/
                  },
                  autovalidateMode: AutovalidateMode.always,
                  style: AppStyles.blackSmallBoldTextStyle,
                  showCursor: true,
                  keyboardType: TextInputType.text,
                  focusNode: nameFocusNode,
                  inputFormatters: const [],
                  decoration: InputDecoration(
                    //labelText: 'Enter your name',
                    /*labelStyle:
                      TextStyle(fontSize: 13, color: AppColors.darkGreyColor),*/
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
          SizedBox(
            height: 20,
          ),
          Selector<UserProvider, String>(
            selector: (context, userProvider) => userProvider.user.name!,
            builder: (_, userName, __) {
              print("I GOT INTO SELECTOR");
              return Container(
                  height: 50,
                  width: width,
                  padding: EdgeInsets.all(5),
                  //color: Colors.orange,
                  child: Center(
                      child: Text(userName.isEmpty ? "your name" : userName)));
            },
          ),
          Container(
            height: 80,
            //color: Colors.orange.shade100,
            child: Center(
              child: Row(children: [
                Icon(
                  Icons.delete,
                  size: 20,
                  color: AppColors.darkRedColor,
                ),
                Text(
                  "Clear text",
                  style: TextStyle(color: AppColors.darkRedColor),
                )
              ]),
            ),
          ),
          Container(
            width: width / 1.1,
            height: 50,
            child: ElevatedButton(
                onPressed: () async {
                  context.read<ShapeProvider>().getAllShapes();
                  context.go(AppRouter.ANIMATION_VIEW);
                },
                child: Text("Go to Page 1"),
                style: AppStyles.primaryButtonStyle),
          ),
          SizedBox(
            height: 30,
          ),
          Container(
            width: width / 1.1,
            height: 50,
            child: ElevatedButton(
                onPressed: () async {
                  await context.read<PokemonProvider>().getAllPokemons();
                  context.read<BaseProvider>().setIsLoading(true);
                  context.go(AppRouter.POKEMON_VIEW);
                },
                child: Text("Go to Page 2"),
                style: AppStyles.darkPrimaryButtonStyle),
          ),
        ],
      ),
    );
  }
}
