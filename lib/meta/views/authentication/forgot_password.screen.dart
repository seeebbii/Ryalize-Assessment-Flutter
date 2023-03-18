import 'package:ryalize_assessment/app/constants/assets.constant.dart';
import 'package:ryalize_assessment/components/widgets/app_appbar.dart';
import 'package:ryalize_assessment/core/notifiers/authentication.notifier.dart';
import 'package:flutter/material.dart';
import 'package:ryalize_assessment/app/constants/assets.constant.dart';
import 'package:ryalize_assessment/app/constants/controller.constant.dart';
import 'package:ryalize_assessment/components/widgets/app_appbar.dart';
import 'package:ryalize_assessment/components/widgets/app_divider.dart';
import 'package:ryalize_assessment/components/widgets/app_elevated_button.dart';
import 'package:ryalize_assessment/core/router/router_generator.dart';
import 'package:ryalize_assessment/core/view_models/authentication_VM.dart';
import 'package:ryalize_assessment/meta/utils/app_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

import '../../../components/widgets/app_phone_textfield.dart';
import '../../../components/widgets/app_simple_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  void _trySubmit() async {
    final isValid = context
        .read<AuthenticationScreenVM>()
        .forgotPassFormKey
        .currentState!
        .validate();
    AuthenticationScreenVM authVm = context.read<AuthenticationScreenVM>();
    FocusScope.of(context).unfocus();

    if (isValid) {
      // Send OTP api and prompt user to OTP verification screen

      EasyLoading.show();

      await context
          .read<AuthenticationNotifier>()
          .sendOtp(authVm.countryCode + authVm.phoneController.text.trim());

      EasyLoading.dismiss();
    }
  }

  @override
  Widget build(BuildContext context) {
    AuthenticationScreenVM authenticationScreenVM =
        context.watch<AuthenticationScreenVM>();
    return Scaffold(
      appBar: AppAppbar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 0.2.sh,
              child: Image.asset(Assets.forgotPass),
            ),
            SizedBox(
              height: 0.02.sh,
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 0.03.sw),
              child: Form(
                key: authenticationScreenVM.forgotPassFormKey,
                child: Column(
                  children: [
                    Align(
                      alignment: FractionalOffset.topLeft,
                      child: Text('Forgot password?',
                          style: Theme.of(context).textTheme.displaySmall),
                    ),
                    SizedBox(
                      height: 0.01.sh,
                    ),
                    Align(
                      alignment: FractionalOffset.topLeft,
                      child: Text(
                          'Please enter your username, we will send OTP to your registered number.',
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    const AppPhoneTextField(),
                    SizedBox(
                      height: 0.02.sh,
                    ),
                    Center(
                      child: AppElevatedButton(
                          width: 0.85.sw,
                          borderRadius: 22,
                          onPressed: _trySubmit,
                          buttonText: "Request OTP",
                          textColor: AppTheme.whiteColor,
                          buttonColor: AppTheme.primaryColor),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
