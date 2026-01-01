import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/controller/image_picker_controller.dart';
import 'package:qunzo_merchant/src/common/controller/user_profile_controller.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/common_single_date_picker.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/common_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/image_picker_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/presentation/screens/profile_settings/controller/profile_settings_controller.dart';

class ProfileSettingsScreen extends StatefulWidget {
  const ProfileSettingsScreen({super.key});

  @override
  State<ProfileSettingsScreen> createState() => _ProfileSettingsScreenState();
}

class _ProfileSettingsScreenState extends State<ProfileSettingsScreen> {
  final ProfileSettingsController controller = Get.find();
  final ImagePickerController imagePickerController = Get.put(
    ImagePickerController(),
  );
  final UserProfileController userProfileController = Get.find();

  @override
  void initState() {
    super.initState();
    loadData();
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await userProfileController.fetchUserProfile();
    final user = userProfileController.userProfileModel.value.data!.user;
    controller.firstNameController.text = user?.firstName ?? "";
    controller.lastNameController.text = user?.lastName ?? "";
    controller.userNameController.text = user?.username ?? "";
    controller.gender.value = user?.gender == "male" ? "Male" : "Female";
    controller.genderController.text = controller.gender.value;
    controller.dateOfBirth.value = user?.dateOfBirth ?? "";
    controller.emailAddressController.text = user?.email ?? "";
    controller.phoneController.text = user?.phone ?? "";
    controller.countryCode.value = user?.country ?? "";
    controller.cityController.text = user?.city ?? "";
    controller.zipCodeController.text = user?.zipCode ?? "";
    controller.addressController.text = user?.address ?? "";
    controller.joiningDateController.text = DateFormat(
      "yyyy-MM-dd HH:mm:ss",
    ).format(DateTime.parse(user?.createdAt ?? ""));
    await controller.fetchCountries();
    controller.isLoading.value = false;
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Obx(() {
            if (controller.isLoading.value) {
              return CommonLoading();
            }

            return SingleChildScrollView(
              child: Column(
                children: [
                  CommonAppBar(title: localization!.profileSettingsTitle),
                  const SizedBox(height: 30),
                  _buildHeaderSection(),
                  const SizedBox(height: 35),
                  Container(
                    decoration: BoxDecoration(
                      color: AppColors.white,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(24),
                        topLeft: Radius.circular(24),
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 18),
                    margin: const EdgeInsets.symmetric(horizontal: 18),
                    child: Column(
                      children: [
                        const SizedBox(height: 18),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.name,
                          labelText: localization.profileSettingsFirstName,
                          controller: controller.firstNameController,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.name,
                          labelText: localization.profileSettingsLastName,
                          controller: controller.lastNameController,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.name,
                          labelText: localization.profileSettingsUserName,
                          controller: controller.userNameController,
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            child: Image.asset(
                              PngAssets.arrowDownCommonIcon,
                              width: 10,
                            ),
                          ),
                          onTap: () {
                            Get.bottomSheet(
                              CommonDropdownBottomSheet(
                                notFoundText:
                                    localization.profileSettingsNoGenderFound,
                                title: localization
                                    .profileSettingsSelectGenderTitle,
                                dropdownItems: ["Male", "Female", "Others"],
                                selectedItem: controller.gender,
                                onValueSelected: (value) {
                                  controller.gender.value = value;
                                  controller.genderController.text = value;
                                },
                              ),
                            );
                          },
                          labelText: localization.profileSettingsGender,
                          controller: controller.genderController,
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        CommonSingleDatePicker(
                          labelText: localization.profileSettingsDateOfBirth,
                          fillColor: AppColors.transparent,
                          onDateSelected: (DateTime value) {
                            final dateFormat = DateFormat(
                              "dd/MM/yyyy",
                            ).format(value);
                            controller.dateOfBirth.value = dateFormat;
                          },
                          initialDate: controller.dateOfBirth.value.isNotEmpty
                              ? DateTime.tryParse(controller.dateOfBirth.value)
                              : null,
                          hintText: localization.profileSettingsDateOfBirth,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          keyboardType: TextInputType.emailAddress,
                          labelText: localization.profileSettingsEmailAddress,
                          controller: controller.emailAddressController,
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          labelText: localization.profileSettingsPhone,
                          controller: controller.phoneController,
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(left: 14, right: 14),
                            child: Image.asset(
                              PngAssets.arrowDownCommonIcon,
                              width: 10,
                            ),
                          ),
                          onTap: () {
                            Get.bottomSheet(
                              CommonDropdownBottomSheet(
                                showSearch: true,
                                height: 500,
                                notFoundText:
                                    localization.profileSettingsNoCountryFound,
                                title: localization
                                    .profileSettingsSelectCountryTitle,
                                dropdownItems: controller.countryList
                                    .map((item) => item.name.toString())
                                    .toList(),
                                selectedItem: controller.country,
                                onValueSelected: (value) {
                                  final selectedCountry = controller.countryList
                                      .firstWhere((item) => item.name == value);
                                  controller.countryCode.value =
                                      selectedCountry.code ?? "";
                                  controller.country.value =
                                      selectedCountry.name ?? "";
                                  controller.countryController.text =
                                      selectedCountry.name ?? "";
                                },
                              ),
                              isScrollControlled: true,
                              backgroundColor: Colors.transparent,
                            );
                          },
                          labelText: localization.profileSettingsCountry,
                          controller: controller.countryController,

                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          labelText: localization.profileSettingsCity,
                          controller: controller.cityController,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          labelText: localization.profileSettingsZipCode,
                          controller: controller.zipCodeController,
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          labelText: localization.profileSettingsJoiningDate,
                          controller: controller.joiningDateController,
                          keyboardType: TextInputType.datetime,
                          readOnly: true,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          maxLine: 3,
                          backgroundColor: AppColors.transparent,
                          labelText: localization.profileSettingsAddress,
                          controller: controller.addressController,
                          keyboardType: TextInputType.streetAddress,
                        ),
                        SizedBox(height: 30),
                        CommonButton(
                          onPressed: () => controller.submitUpdateProfile(),
                          width: double.infinity,
                          text: localization.profileSettingsSaveChanges,
                        ),
                        SizedBox(height: 30),
                      ],
                    ),
                  ),
                ],
              ),
            );
          }),
          Obx(
            () => Visibility(
              visible: controller.isProfileUpdateLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeaderSection() {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Image.asset(PngAssets.profileSettingsShape),
        Stack(
          clipBehavior: Clip.none,
          alignment: Alignment.bottomRight,
          children: [
            GestureDetector(
              onTap: () {
                showImageSourceSheet();
              },
              child: Obx(
                () => Container(
                  width: 115,
                  height: 115,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(40),
                    image: imagePickerController.selectedImage.value != null
                        ? DecorationImage(
                            image: FileImage(
                              imagePickerController.selectedImage.value!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : userProfileController
                              .userProfileModel
                              .value
                              .data!
                              .user!
                              .avatar!
                              .isNotEmpty
                        ? DecorationImage(
                            image: NetworkImage(
                              userProfileController
                                  .userProfileModel
                                  .value
                                  .data!
                                  .user!
                                  .avatar!,
                            ),
                            fit: BoxFit.cover,
                          )
                        : null,
                  ),
                  child:
                      imagePickerController.selectedImage.value == null &&
                          userProfileController
                              .userProfileModel
                              .value
                              .data!
                              .user!
                              .avatar!
                              .isEmpty
                      ? Center(
                          child: Text(
                            "${userProfileController.userProfileModel.value.data!.user!.firstName!.trim().isNotEmpty ? userProfileController.userProfileModel.value.data!.user!.firstName!.trim()[0].toUpperCase() : ''}"
                            "${userProfileController.userProfileModel.value.data!.user!.lastName!.trim().isNotEmpty ? userProfileController.userProfileModel.value.data!.user!.lastName!.trim()[0].toUpperCase() : ''}",
                            style: TextStyle(
                              fontWeight: FontWeight.w700,
                              fontSize: 28,
                              color: AppColors.lightPrimary,
                            ),
                          ),
                        )
                      : null,
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                showImageSourceSheet();
              },
              child: Transform.translate(
                offset: Offset(10, 2),
                child: Container(
                  padding: EdgeInsets.all(7),
                  width: 34,
                  height: 38,
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: Color(0xFFF5F5F5)),
                  ),
                  child: Image.asset(PngAssets.profileSettingsCameraIcon),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void showImageSourceSheet() {
    Get.bottomSheet(ImagePickerDropdownBottomSheet());
  }
}
