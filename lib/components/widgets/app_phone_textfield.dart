import 'package:ryalize_assessment/core/notifiers/authentication.notifier.dart';
import 'package:ryalize_assessment/core/view_models/authentication_VM.dart';
import 'package:ryalize_assessment/meta/utils/app_theme.dart';
import 'package:ryalize_assessment/core/view_models/authentication_VM.dart';
import 'package:ryalize_assessment/meta/utils/app_theme.dart';
import 'package:ryalize_assessment/meta/utils/base_helper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:intl_phone_field/country_picker_dialog.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:provider/provider.dart';

class AppPhoneTextField extends StatefulWidget {
  final bool isSignup;

  const AppPhoneTextField({Key? key, this.isSignup = false}) : super(key: key);

  @override
  State<AppPhoneTextField> createState() => _AppPhoneTextFieldState();
}

class _AppPhoneTextFieldState extends State<AppPhoneTextField> {
  String phoneText = '';

  @override
  Widget build(BuildContext context) {
    var authenticationScreenVM = context.watch<AuthenticationScreenVM>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        IntlPhoneField(
          flagsButtonPadding: EdgeInsets.symmetric(horizontal: 0.03.sw),
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: AppTheme.blackColor,
              textBaseline: TextBaseline.alphabetic),
          onSaved: (phone) {
            authenticationScreenVM.setPhoneNumber(phone);
          },
          invalidNumberMessage: "Invalid Number",
          validator: (str) async {
            authenticationScreenVM.setPhoneNumber(str);

            try {
              bool isValid = await BaseHelper.isPhoneNoValid(
                  authenticationScreenVM.phoneNumberWithoutCountryCode,
                  str?.countryISOCode ?? "",
                  "",
                  authenticationScreenVM.countryCode);

              if (authenticationScreenVM.phoneNumberWithoutCountryCode.isEmpty ||
                  authenticationScreenVM.phoneNumberWithoutCountryCode == '') {
                return "Invalid Number";
              }
              if (!isValid) {
                return "Invalid Number";
              }
              if (authenticationScreenVM.phoneNumberWithoutCountryCode.length ==
                  1) {
                return "Invalid Number";
              }
              if (authenticationScreenVM.phoneNumberWithoutCountryCode == '') {
                return "Invalid Number";
              }
              return null;
            } catch (e) {
              return "Invalid Number";
            }
          },
          inputFormatters: [
            FilteringTextInputFormatter.allow(RegExp("[0-9]")),
          ],
          disableLengthCheck: false,
          controller: authenticationScreenVM.phoneController,
          textInputAction: TextInputAction.next,
          decoration: InputDecoration(
            fillColor: AppTheme.textFieldFillColor,
            filled: true,
            hintText: 'Phone Number',
            hintStyle: Theme.of(context).inputDecorationTheme.hintStyle,
            labelStyle: Theme.of(context).textTheme.bodyLarge,
            floatingLabelStyle: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppTheme.primaryColor),
            border: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide:
                  BorderSide(color: AppTheme.fieldOutlineColor, width: 1.5),
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide: BorderSide(color: AppTheme.primaryColor, width: 1.5),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(10.0),
              ),
              borderSide:
                  BorderSide(color: AppTheme.fieldOutlineColor, width: 1.5),
            ),
          ),
          dropdownIcon: const Icon(
            Icons.expand_more,
            color: AppTheme.blackColor,
          ),
          initialCountryCode: 'PK',
          onChanged: widget.isSignup
              ? (phone) {}
              : (phone) => debugPrint(phone.completeNumber),
          dropdownIconPosition: IconPosition.trailing,
          pickerDialogStyle: PickerDialogStyle(
              countryNameStyle: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(fontWeight: FontWeight.w500, fontSize: 14.sp),
              searchFieldInputDecoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.bodyLarge,
                floatingLabelStyle: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(color: AppTheme.primaryColor),
                hintText: "Search Country",
                border: const OutlineInputBorder(
                    borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                )),
                focusedBorder: const OutlineInputBorder(
                  borderRadius: BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide:
                      BorderSide(color: AppTheme.blackColor, width: 1.5),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: const BorderRadius.all(
                    Radius.circular(10.0),
                  ),
                  borderSide:
                      BorderSide(color: AppTheme.fieldOutlineColor, width: 0.0),
                ),
              )),
        ),
        widget.isSignup && phoneText != ''
            ? const SizedBox(
                height: 2,
              )
            : const SizedBox.shrink(),
        widget.isSignup
            ? Padding(
                padding: EdgeInsets.symmetric(horizontal: 0.02.sw),
                child: Text(
                  phoneText,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: authenticationScreenVM.phoneNumberAvailable
                          ? AppTheme.green
                          : AppTheme.red),
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}
