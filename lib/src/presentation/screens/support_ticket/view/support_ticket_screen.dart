import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:qunzo_merchant/l10n/app_localizations.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/app/routes/routes.dart';
import 'package:qunzo_merchant/src/common/services/settings_service.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/app_bar/common_default_app_bar.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';
import 'package:qunzo_merchant/src/common/widgets/common_loading.dart';
import 'package:qunzo_merchant/src/presentation/screens/support_ticket/controller/support_ticket_controller.dart';
import 'package:qunzo_merchant/src/presentation/screens/support_ticket/model/support_ticket_model.dart';
import 'package:qunzo_merchant/src/presentation/screens/support_ticket/view/reply_ticket/reply_ticket.dart';
import 'package:qunzo_merchant/src/presentation/widgets/no_data_found.dart';

class SupportTicketScreen extends StatefulWidget {
  const SupportTicketScreen({super.key});

  @override
  State<SupportTicketScreen> createState() => _SupportTicketScreenState();
}

class _SupportTicketScreenState extends State<SupportTicketScreen>
    with WidgetsBindingObserver {
  final SupportTicketController controller = Get.find();
  late ScrollController _scrollController;
  final SettingsService settingsService = Get.find();

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
      controller.loadMoreSupportTickets();
    }
  }

  Future<void> loadData() async {
    if (!controller.isInitialDataLoaded.value) {
      controller.isLoading.value = true;
      await controller.fetchSupportTickets();
      controller.isLoading.value = false;
      controller.isInitialDataLoaded.value = true;
    }
  }

  Future<void> refreshData() async {
    controller.isLoading.value = true;
    await controller.fetchSupportTickets();
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
      body: Obx(
        () => Stack(
          children: [
            Column(
              children: [
                CommonAppBar(
                  title: localization!.supportTicketTitle,
                  showRightSideWidget: true,
                  rightSideWidget: GestureDetector(
                    onTap: () => Get.toNamed(BaseRoute.addNewTicket),
                    child: Container(
                      padding: EdgeInsets.all(5),
                      width: 35,
                      height: 35,
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Image.asset(PngAssets.addCircleCommonIcon),
                    ),
                  ),
                ),
                _buildTransactionsList(),
              ],
            ),

            Visibility(
              visible: controller.isPageLoading.value,
              child: const CommonLoading(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionsList() {
    final localization = AppLocalizations.of(context);
    final tickets = controller.supportTicketModel.value.data?.tickets ?? [];

    if (controller.isLoading.value) {
      return Expanded(child: CommonLoading());
    }

    if (tickets.isEmpty) {
      return Expanded(child: NoDataFound());
    }

    return Expanded(
      child: RefreshIndicator(
        color: AppColors.lightPrimary,
        onRefresh: () => refreshData(),
        child: controller.isLoading.value
            ? CommonLoading()
            : ListView.separated(
                physics: AlwaysScrollableScrollPhysics(),
                controller: _scrollController,
                padding: const EdgeInsets.only(
                  left: 18,
                  right: 18,
                  bottom: 50,
                  top: 30,
                ),
                itemBuilder: (context, index) {
                  final Tickets ticket = tickets[index];

                  return Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: AppColors.white,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    ticket.title ?? "",
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w900,
                                      fontSize: 18,
                                      color: AppColors.lightTextPrimary,
                                      overflow: TextOverflow.visible,
                                    ),
                                  ),
                                  SizedBox(height: 10),
                                  Text(
                                    DateFormat("dd MMM,yyyy - hh:mm a").format(
                                      DateTime.parse(
                                        ticket.canReply == true
                                            ? ticket.updatedAt!
                                            : ticket.createdAt!,
                                      ),
                                    ),
                                    style: TextStyle(
                                      letterSpacing: 0,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 15,
                                      color: AppColors.lightTextPrimary
                                          .withValues(alpha: 0.30),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              width: 70,
                              height: 30,
                              alignment: Alignment.center,
                              decoration: BoxDecoration(
                                color: ticket.status == "open"
                                    ? AppColors.success
                                    : AppColors.error,
                                borderRadius: BorderRadius.circular(100),
                              ),
                              child: Text(
                                ticket.status == "open"
                                    ? localization!.supportTicketStatusOpen
                                    : localization!.supportTicketStatusClosed,
                                style: TextStyle(
                                  color: AppColors.white,
                                  fontWeight: FontWeight.w900,
                                  letterSpacing: 0,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Divider(
                          height: 0,
                          color: AppColors.lightTextPrimary.withValues(
                            alpha: 0.10,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CommonButton(
                          onPressed: () => Get.to(
                            () =>
                                ReplayTicket(ticketUid: ticket.uuid.toString()),
                          ),
                          backgroundColor: AppColors.lightPrimary.withValues(
                            alpha: 0.06,
                          ),
                          borderWidth: 2,
                          borderColor: AppColors.lightPrimary.withValues(
                            alpha: 0.40,
                          ),
                          textColor: AppColors.lightTextPrimary,
                          text: localization.supportTicketViewButton,
                        ),
                      ],
                    ),
                  );
                },
                separatorBuilder: (context, index) =>
                    const SizedBox(height: 16),
                itemCount: tickets.length,
              ),
      ),
    );
  }
}
