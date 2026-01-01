import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/notification/controller/notification_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/notification/model/notifications_model.dart';
import 'package:qunzo_merchant/src/presentation/widgets/no_data_found.dart';
import 'package:qunzo_merchant/src/presentation/widgets/notification_dynamic_color.dart';
import 'package:qunzo_merchant/src/presentation/widgets/notification_dynamic_icon.dart';

class NotificationScreen extends StatefulWidget {
  const NotificationScreen({super.key});

  @override
  State<NotificationScreen> createState() => _NotificationScreenState();
}

class _NotificationScreenState extends State<NotificationScreen>
    with WidgetsBindingObserver {
  final NotificationController controller = Get.find();
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);
    loadData();
  }

  void _scrollListener() {
    if (_scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200 &&
        controller.hasMorePages.value &&
        !controller.isPageLoading.value) {
      controller.loadMoreNotifications();
    }
  }

  Future<void> loadData() async {
    controller.isLoading.value = true;
    await controller.fetchNotifications();
    controller.isLoading.value = false;
  }

  Future<void> refreshData() async {
    controller.isLoading.value = true;
    await controller.fetchNotifications();
    controller.isLoading.value = false;
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _scrollController.removeListener(_scrollListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final localization = AppLocalizations.of(context);
    return Scaffold(
      appBar: CommonDefaultAppBar(),
      body: Stack(
        children: [
          Column(
            children: [
              CommonAppBar(
                title: localization!.notificationScreenTitle,
                showRightSideWidget: true,
                rightSideWidget: GestureDetector(
                  onTap: () => controller.markAsReadNotification(),
                  child: Text(
                    localization.notificationScreenMarkAll,
                    style: TextStyle(
                      letterSpacing: 0,
                      fontWeight: FontWeight.w900,
                      fontSize: 14,
                      decoration: TextDecoration.underline,
                      decorationColor: AppColors.white,
                      decorationThickness: 2,
                      color: AppColors.white,
                    ),
                  ),
                ),
              ),
              Obx(
                () => Expanded(
                  child: RefreshIndicator(
                    color: AppColors.lightPrimary,
                    onRefresh: () => refreshData(),
                    child: controller.isLoading.value
                        ? CommonLoading()
                        : controller
                              .notificationModel
                              .value
                              .data!
                              .notifications!
                              .isEmpty
                        ? NoDataFound()
                        : ListView.separated(
                            padding: EdgeInsets.only(
                              bottom: 50,
                              top: 30,
                              left: 18,
                              right: 18,
                            ),
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 30);
                            },
                            controller: _scrollController,
                            itemBuilder: (context, index) {
                              final Notificationss notification = controller
                                  .notificationModel
                                  .value
                                  .data!
                                  .notifications![index];

                              return Row(
                                children: [
                                  Expanded(
                                    child: Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          decoration: BoxDecoration(
                                            color:
                                                NotificationDynamicColor.getNotificationColor(
                                                  notification.type,
                                                ),
                                            borderRadius: BorderRadius.circular(
                                              50,
                                            ),
                                          ),
                                          width: 45,
                                          height: 45,
                                          padding: EdgeInsets.all(10),
                                          child: Image.asset(
                                            NotificationDynamicIcon.getNotificationIcon(
                                              notification.type,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(width: 16),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                notification.title ?? '',
                                                style: TextStyle(
                                                  letterSpacing: 0,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  fontWeight: FontWeight.w900,
                                                  fontSize: 16,
                                                  color: AppColors
                                                      .lightTextPrimary,
                                                ),
                                              ),
                                              const SizedBox(height: 6),
                                              Text(
                                                notification.message ?? '',
                                                style: TextStyle(
                                                  letterSpacing: 0,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.30),
                                                ),
                                              ),
                                              const SizedBox(height: 10),
                                              Text(
                                                notification.createdAt ?? '',
                                                style: TextStyle(
                                                  letterSpacing: 0,
                                                  overflow:
                                                      TextOverflow.visible,
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 14,
                                                  color: AppColors
                                                      .lightTextPrimary
                                                      .withValues(alpha: 0.60),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Visibility(
                                    visible: notification.isRead == false,
                                    child: CircleAvatar(
                                      radius: 5,
                                      backgroundColor: AppColors.lightPrimary,
                                    ),
                                  ),
                                ],
                              );
                            },
                            itemCount: controller
                                .notificationModel
                                .value
                                .data!
                                .notifications!
                                .length,
                          ),
                  ),
                ),
              ),
            ],
          ),
          Obx(
            () => Visibility(
              visible:
                  controller.isPageLoading.value ||
                  controller.isNotificationsLoading.value,
              child: CommonLoading(),
            ),
          ),
        ],
      ),
    );
  }
}
