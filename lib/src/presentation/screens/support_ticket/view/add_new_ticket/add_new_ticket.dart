import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/controller/multiple_image_picker_controller.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/common/widgets/dropdown_bottom_sheet/multiple_image_picker_dropdown_bottom_sheet.dart';
import 'package:qunzo_merchant/src/common/widgets/text_field/common_text_field.dart';
import 'package:qunzo_merchant/src/presentation/screens/support_ticket/controller/add_new_ticket_controller.dart';

class AddNewTicket extends StatefulWidget {
  const AddNewTicket({super.key});

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

class _AddNewTicketState extends State<AddNewTicket> {
  final AddNewTicketController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              CommonAppBar(title: localization!.addNewTicketTitle),
              const SizedBox(height: 30),
              Expanded(
                child: Container(
                  margin: EdgeInsets.symmetric(horizontal: 18),
                  padding: EdgeInsets.symmetric(horizontal: 18),
                  decoration: BoxDecoration(
                    color: AppColors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(24),
                      topRight: Radius.circular(24),
                    ),
                  ),
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(height: 22),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          controller: controller.titleController,
                          labelText: localization.addNewTicketTitleLabel,
                          keyboardType: TextInputType.text,
                        ),
                        const SizedBox(height: 20),
                        CommonTextField(
                          backgroundColor: AppColors.transparent,
                          controller: controller.descriptionController,
                          keyboardType: TextInputType.text,
                          labelText: localization.addNewTicketDescriptionLabel,
                          maxLine: 3,
                        ),
                        const SizedBox(height: 20),
                        GestureDetector(
                          onTap: () => controller.addAttachment(),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Image.asset(
                                PngAssets.addCommonIcon,
                                width: 18,
                                color: AppColors.lightTextPrimary.withValues(
                                  alpha: 0.60,
                                ),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                localization.addNewTicketAddAttach,
                                style: TextStyle(
                                  letterSpacing: 0,
                                  fontSize: 15,
                                  color: AppColors.lightTextPrimary.withValues(
                                    alpha: 0.60,
                                  ),
                                  fontWeight: FontWeight.w900,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 10),
                        Obx(
                          () => Column(
                            children: controller.attachments
                                .map(
                                  (id) => Padding(
                                    padding: EdgeInsets.only(bottom: 20),
                                    child: _buildAttachmentItem(
                                      context,
                                      id,
                                      controller,
                                    ),
                                  ),
                                )
                                .toList(),
                          ),
                        ),
                        SizedBox(height: 30),
                        CommonButton(
                          onPressed: () async {
                            if (!controller.validateForm()) {
                              return;
                            }
                            await controller.addNewTicket();
                          },
                          width: double.infinity,
                          text: localization.addNewTicketAddTicketButton,
                        ),
                        SizedBox(height: 50),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible: controller.isAddTicketLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAttachmentItem(
    BuildContext context,
    int id,
    AddNewTicketController controller,
  ) {
    final MultipleImagePickerController multipleImagePickerController = Get.put(
      MultipleImagePickerController(),
    );
    final localization = AppLocalizations.of(context);

    return GestureDetector(
      onTap: () {
        showImageSourceSheet(id);
      },
      child: Obx(
        () => Stack(
          alignment: Alignment.center,
          children: [
            Image.asset(PngAssets.attachFileTwo),
            if (multipleImagePickerController.images.containsKey(id))
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.file(
                  multipleImagePickerController.images[id]!,
                  width: double.infinity,
                  height: 130,
                  fit: BoxFit.cover,
                ),
              ),
            if (!multipleImagePickerController.images.containsKey(id))
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    PngAssets.uploadCommonIcon,
                    width: 18,
                    fit: BoxFit.contain,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    localization!.addNewTicketAttachFile,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w700,
                      fontSize: 16,
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.60),
                    ),
                  ),
                ],
              ),
            if (controller.attachments.length > 1 ||
                multipleImagePickerController.images.containsKey(id))
              Positioned(
                top: 15,
                right: 8,
                child: GestureDetector(
                  onTap: () => controller.removeAttachment(id),
                  child: Container(
                    padding: EdgeInsets.all(4),
                    width: 25,
                    height: 25,
                    decoration: BoxDecoration(
                      color: AppColors.error,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: Image.asset(
                      PngAssets.closeCommonIcon,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void showImageSourceSheet(int attachmentId) {
    Get.bottomSheet(
      MultipleImagePickerDropdownBottomSheet(attachmentId: attachmentId),
    );
  }
}
