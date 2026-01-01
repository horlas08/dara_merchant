import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/controller/country_controller.dart';
import 'package:qunzo_merchant/src/common/controller/register_fields_controller.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_auth_text_field.dart';
import 'package:qunzo_merchant/src/helper/toast_helper.dart';
import 'package:qunzo_merchant/src/presentation/screens/auth/register/controller/personal_info_controller.dart';

class PersonalInfoScreen extends StatefulWidget {
  const PersonalInfoScreen({super.key});

  @override
  State<PersonalInfoScreen> createState() => _PersonalInfoScreenState();
}

class _PersonalInfoScreenState extends State<PersonalInfoScreen> {
  final bool isPersonalInfoEdit =
      Get.arguments?["is_personal_info_edit"] ?? false;
  final PersonalInfoController controller = Get.find();
  final CountryController countryController = Get.find<CountryController>();
  final RegisterFieldsController registerFieldsController =
      Get.find<RegisterFieldsController>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (isPersonalInfoEdit == true) {
        loadPersonalData();
      } else {
        loadData();
      }
    });
  }

  Future<void> loadPersonalData() async {
    controller.isLoading.value = true;
    await controller.fetchUser();
    await registerFieldsController.fetchRegisterFields();
    final user = controller.userModel.value.data?.user;
    controller.firstNameController.text = user?.firstName ?? "";
    controller.lastNameController.text = user?.lastName ?? "";
    controller.userNameController.text = user?.username ?? "";
    controller.gender.value = user?.gender == "male"
        ? "Male"
        : user?.gender == "female"
        ? "Female"
        : "Other";
    controller.genderController.text = controller.gender.value;
    controller.phoneNoController.text = user?.phone ?? "";
    controller.countryCode.value = user?.country ?? "";
    await controller.fetchCountries();
    controller.isLoading.value = false;
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await registerFieldsController.fetchRegisterFields();
    if (registerFieldsController.registerFields["merchant_country_show"] ==
        "1") {
      await countryController.fetchCountries();
      _setSelectedCountry();
    }
    controller.isLoading.value = false;
  }

  void _setSelectedCountry() {
    final selectedCountry = countryController.countryList.firstWhereOrNull(
      (country) => country.selected == true,
    );

    if (selectedCountry != null) {
      controller.countryController.text = selectedCountry.name ?? "";
      controller.countryCode.value = selectedCountry.code ?? "";
      controller.countryDialCode.value = selectedCountry.dialCode ?? "";
      controller.country.value = selectedCountry.name ?? "";
      controller.phoneNoController.text = selectedCountry.dialCode ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context)!;

    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(statusBarIconBrightness: Brightness.light),
      child: Scaffold(
        body: Obx(
          () => controller.isLoading.value
              ? CommonLoading()
              : Stack(
                  children: [
                    SingleChildScrollView(
                      child: Column(
                        children: [
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Image.asset(PngAssets.authHeaderFrame),
                              Padding(
                                padding: EdgeInsets.only(
                                  left: 40.w,
                                  bottom: 32.h,
                                ),
                                child: Text(
                                  localization.personalInfoTitle,
                                  style: TextStyle(
                                    letterSpacing: 0,
                                    fontWeight: FontWeight.w900,
                                    fontSize: 22.sp,
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 70.h),
                          Container(
                            width: double.infinity,
                            margin: EdgeInsets.symmetric(horizontal: 18.w),
                            padding: EdgeInsets.only(
                              top: 3.h,
                              left: 18.w,
                              right: 18.w,
                            ),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30.r),
                                topRight: Radius.circular(30.r),
                              ),
                              color: AppColors.white,
                            ),
                            child: Column(
                              children: [
                                SizedBox(height: 20.h),
                                Row(
                                  children: [
                                    Container(
                                      width: 20.w,
                                      height: 2.h,
                                      color: AppColors.lightTextPrimary
                                          .withValues(alpha: 0.10),
                                    ),
                                    SizedBox(width: 8.w),
                                    Text(
                                      localization.personalInfoSectionTitle,
                                      style: TextStyle(
                                        letterSpacing: 0,
                                        fontWeight: FontWeight.w900,
                                        fontSize: 16.sp,
                                        color: AppColors.lightTextPrimary,
                                      ),
                                    ),
                                    SizedBox(width: 8.w),
                                    Container(
                                      width: 90.w,
                                      height: 2.h,
                                      color: AppColors.lightTextPrimary
                                          .withValues(alpha: 0.10),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 30.h),
                                CommonAuthTextInputField(
                                  isRequired: true,
                                  controller: controller.firstNameController,
                                  keyboardType: TextInputType.name,
                                  labelText:
                                      localization.personalInfoFirstNameLabel,
                                ),
                                SizedBox(height: 20.h),
                                CommonAuthTextInputField(
                                  isRequired: true,
                                  controller: controller.lastNameController,
                                  keyboardType: TextInputType.name,
                                  labelText:
                                      localization.personalInfoLastNameLabel,
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        registerFieldsController
                                            .registerFields["merchant_username_show"] ==
                                        "1",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20.h),
                                        CommonAuthTextInputField(
                                          isRequired:
                                              registerFieldsController
                                                  .registerFields["merchant_username_validation"] ==
                                              "1",
                                          controller:
                                              controller.userNameController,
                                          keyboardType: TextInputType.name,
                                          labelText: localization
                                              .personalInfoUsernameLabel,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        registerFieldsController
                                            .registerFields["merchant_country_show"] ==
                                        "1",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20.h),
                                        CommonAuthTextInputField(
                                          isRequired:
                                              registerFieldsController
                                                  .registerFields["merchant_country_validation"] ==
                                              "1",
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.only(
                                              left: 15.w,
                                              right: 8.w,
                                            ),
                                            child: Image.asset(
                                              PngAssets.arrowDownCommonIcon,
                                              width: 20.w,
                                              color: AppColors.lightTextPrimary
                                                  .withValues(alpha: 0.30),
                                            ),
                                          ),
                                          controller:
                                              controller.countryController,
                                          keyboardType: TextInputType.none,
                                          readOnly: true,
                                          onTap: () {
                                            Get.bottomSheet(
                                              CommonDropdownBottomSheet(
                                                showSearch: true,
                                                height: 500,
                                                notFoundText: localization
                                                    .personalInfoCountryNotFound,
                                                title: localization
                                                    .personalInfoSelectCountryTitle,
                                                dropdownItems: countryController
                                                    .countryList
                                                    .map(
                                                      (item) =>
                                                          item.name.toString(),
                                                    )
                                                    .toList(),
                                                selectedItem:
                                                    controller.country,
                                                onValueSelected: (value) {
                                                  final selectedCountry =
                                                      countryController
                                                          .countryList
                                                          .firstWhere(
                                                            (item) =>
                                                                item.name ==
                                                                value,
                                                          );
                                                  controller.countryCode.value =
                                                      selectedCountry.code ??
                                                      "";
                                                  controller.country.value =
                                                      selectedCountry.name ??
                                                      "";
                                                  controller
                                                          .countryController
                                                          .text =
                                                      selectedCountry.name ??
                                                      "";
                                                  controller
                                                          .countryDialCode
                                                          .value =
                                                      selectedCountry
                                                          .dialCode ??
                                                      "";
                                                  controller.phoneNoController
                                                      .clear();
                                                  controller
                                                          .phoneNoController
                                                          .text =
                                                      selectedCountry
                                                          .dialCode ??
                                                      "";
                                                },
                                              ),
                                              isScrollControlled: true,
                                              backgroundColor:
                                                  Colors.transparent,
                                            );
                                          },
                                          labelText: localization
                                              .personalInfoCountryLabel,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        registerFieldsController
                                            .registerFields["merchant_phone_show"] ==
                                        "1",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20.h),
                                        CommonAuthTextInputField(
                                          isRequired:
                                              registerFieldsController
                                                  .registerFields["merchant_phone_validation"] ==
                                              "1",
                                          controller:
                                              controller.phoneNoController,
                                          labelText: localization
                                              .personalInfoPhoneLabel,
                                          keyboardType: TextInputType.phone,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Obx(
                                  () => Visibility(
                                    visible:
                                        registerFieldsController
                                            .registerFields["merchant_gender_show"] ==
                                        "1",
                                    child: Column(
                                      children: [
                                        SizedBox(height: 20.h),
                                        CommonAuthTextInputField(
                                          isRequired:
                                              registerFieldsController
                                                  .registerFields["merchant_gender_validation"] ==
                                              "1",
                                          suffixIcon: Padding(
                                            padding: EdgeInsets.only(
                                              left: 15.w,
                                              right: 8.w,
                                            ),
                                            child: Image.asset(
                                              PngAssets.arrowDownCommonIcon,
                                              width: 20.w,
                                              color: AppColors.lightTextPrimary
                                                  .withValues(alpha: 0.30),
                                            ),
                                          ),
                                          onTap: () {
                                            Get.bottomSheet(
                                              CommonDropdownBottomSheet(
                                                notFoundText: localization
                                                    .personalInfoGenderNotFound,
                                                title: localization
                                                    .personalInfoSelectGenderTitle,
                                                dropdownItems: [
                                                  "Male",
                                                  "Female",
                                                  "Other",
                                                ],
                                                selectedItem: controller.gender,
                                                onValueSelected: (value) {
                                                  controller.gender.value =
                                                      value;
                                                  controller
                                                          .genderController
                                                          .text =
                                                      value;
                                                },
                                              ),
                                            );
                                          },
                                          labelText: localization
                                              .personalInfoGenderLabel,
                                          controller:
                                              controller.genderController,
                                          readOnly: true,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(height: 30.h),
                                CommonButton(
                                  onPressed: () => validateFields(),
                                  width: double.infinity,
                                  text: localization.personalInfoSubmitButton,
                                ),
                                SizedBox(height: 30.h),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    Obx(
                      () => Visibility(
                        visible: controller.isSubmitLoading.value,
                        child: CommonLoading(),
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }

  void validateFields() async {
    final localization = AppLocalizations.of(context)!;
    final validations = [
      _ValidationCheck(
        condition: controller.firstNameController.text.isEmpty,
        errorMessage: localization.personalInfoFirstNameRequired,
      ),
      _ValidationCheck(
        condition: controller.lastNameController.text.isEmpty,
        errorMessage: localization.personalInfoLastNameRequired,
      ),
      _ValidationCheck(
        condition:
            registerFieldsController.registerFields["merchant_username_show"] ==
                "1" &&
            controller.userNameController.text.isEmpty,
        errorMessage: localization.personalInfoUsernameRequired,
      ),
      _ValidationCheck(
        condition:
            registerFieldsController
                    .registerFields["merchant_country_validation"] ==
                "1" &&
            controller.countryController.text.isEmpty,
        errorMessage: localization.personalInfoCountryRequired,
      ),
      _ValidationCheck(
        condition:
            registerFieldsController
                    .registerFields["merchant_phone_validation"] ==
                "1" &&
            controller.phoneNoController.text.isEmpty,
        errorMessage: localization.personalInfoPhoneRequired,
      ),
      _ValidationCheck(
        condition:
            registerFieldsController
                    .registerFields["merchant_gender_validation"] ==
                "1" &&
            controller.genderController.text.isEmpty,
        errorMessage: localization.personalInfoGenderRequired,
      ),
    ];

    for (final validation in validations) {
      if (validation.condition) {
        ToastHelper().showErrorToast(validation.errorMessage);
        return;
      }
    }

    await controller.submitPersonalInfo();
  }
}

class _ValidationCheck {
  final bool condition;
  final String errorMessage;

  _ValidationCheck({required this.condition, required this.errorMessage});
}
