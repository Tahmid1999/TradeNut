import 'package:flutter/material.dart';
import 'package:flutx/themes/text_style.dart';
import 'package:flutx/utils/spacing.dart';
import 'package:flutx/widgets/button/button.dart';
import 'package:flutx/widgets/text/text.dart';
import 'package:flutx/widgets/text_field/text_field.dart';
import 'package:get/get.dart';
import 'package:simple_app/views/theme/app_theme.dart';
import 'package:simple_app/views/theme/constant.dart';

import '../controller/login_controller.dart';
import '../helperFunction/HelperFunction.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late ThemeData theme;
  late AuthController controller;
  late OutlineInputBorder outlineInputBorder;

  TextEditingController userIdController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  bool showPassword = false;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.rentalServiceTheme;
    controller = Get.put(AuthController());
    outlineInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(8)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );



  }
  @override
  Widget build(BuildContext context) {
    HelperFunction.changeSystemUIColor(Colors.white, Colors.white);
    return Scaffold(
      body: Padding(
        padding: FxSpacing.fromLTRB(
          20,
          FxSpacing.safeAreaTop(context) + 20,
          20,
          20,
        ),
        child: MediaQuery.of(context).orientation == Orientation.portrait
            ? Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FxText.displayLarge(
                "Hello",
                fontWeight: 700,
              ),
              FxText.bodyLarge(
                "Sign in to your account",
                fontWeight: 600,
              ),
              FxSpacing.height(40),
              loginForm(),
              FxSpacing.height(20),
              loginButton(),
            ],
          ),
        )
            : Center(
          child: ListView(
            children: [
              FxText.displayLarge(
                "Hello",
                fontWeight: 700,
              ),
              FxText.bodyLarge(
                "Sign in to your account",
                fontWeight: 600,
              ),
              FxSpacing.height(40),
              loginForm(),
              FxSpacing.height(20),
              loginButton(),
            ],
          ),
        ),
      ),
    );
  }


  Widget loginForm() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        userIdField(),
        FxSpacing.height(20),
        passwordField(),
      ],
    );
  }

  Widget userIdField() {
    return TextFormField(
      style: FxTextStyle.bodyMedium(),
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          hintText: "User ID",
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          prefixIcon: Icon(Icons.person),
          contentPadding: FxSpacing.all(16),
          hintStyle: FxTextStyle.bodyMedium(xMuted: true),
          isCollapsed: true),
      maxLines: 1,
      controller: userIdController,
      // validator: controller.validateEmail,
      cursorColor: theme.colorScheme.onBackground,
    );
  }

  Widget passwordField() {
    return TextFormField(
      style: FxTextStyle.bodyMedium(),
      keyboardType: TextInputType.text,
      obscureText:  !showPassword,
      decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.never,
          isDense: true,
          filled: true,
          hintText: "Password",
          enabledBorder: outlineInputBorder,
          focusedBorder: outlineInputBorder,
          border: outlineInputBorder,
          prefixIcon: Icon(Icons.lock),
          suffixIcon: InkWell(
              onTap: () {
               if(showPassword==false){
                 setState(() {
                    showPassword=true;
                 });
                }else{
                  setState(() {
                    showPassword=false;
                  });
               }
              },
              child: Icon(
                  showPassword==false ? Icons.visibility : Icons.visibility_off)),
          contentPadding: FxSpacing.all(16),
          hintStyle: FxTextStyle.bodyMedium(xMuted: true),
          isCollapsed: true),
      maxLines: 1,
      controller: passwordController,
      cursorColor: theme.colorScheme.onBackground,
    );
  }

  Widget loginButton() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        FxText.headlineLarge(
          "Sign In",
          fontWeight: 700,
        ),
        FxSpacing.width(20),
        FxButton(
          onPressed: () {
            if(userIdController.text.isEmpty == false){
              controller.authData.login = int.parse(userIdController.text);
            }
            controller.authData.password = passwordController.text;


            controller.login();
          },
          elevation: 0,
          borderRadiusAll: Constant.buttonRadius.xs,
          child: Icon(
            Icons.keyboard_arrow_right,

            color: theme.colorScheme.onPrimary,
            size: 24,
          ),
        ),
      ],
    );
  }



}

