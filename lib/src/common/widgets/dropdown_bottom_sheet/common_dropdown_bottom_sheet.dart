import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:qunzo_merchant/src/app/constants/app_colors.dart';
import 'package:qunzo_merchant/src/app/constants/assets_path/png_assets.dart';
import 'package:qunzo_merchant/src/common/widgets/button/common_button.dart';

class CommonDropdownBottomSheet extends StatefulWidget {
  final String title;
  final String? notFoundText;
  final List<String> dropdownItems;
  final RxString selectedItem;
  final Function(String)? onValueSelected;
  final double height;
  final bool showSearch;
  final double borderRadius;
  final double? topLeftBorderRadius;
  final double? topRightBorderRadius;
  final double? bottomLeftBorderRadius;
  final double? bottomRightBorderRadius;

  const CommonDropdownBottomSheet({
    super.key,
    required this.title,
    required this.dropdownItems,
    required this.selectedItem,
    this.onValueSelected,
    this.height = 400,
    this.notFoundText,
    this.showSearch = false,
    this.borderRadius = 8,
    this.topLeftBorderRadius,
    this.topRightBorderRadius,
    this.bottomLeftBorderRadius,
    this.bottomRightBorderRadius,
  });

  @override
  State<CommonDropdownBottomSheet> createState() =>
      _CommonDropdownBottomSheetState();
}

class _CommonDropdownBottomSheetState extends State<CommonDropdownBottomSheet> {
  late String selectedValue;
  late TextEditingController _searchController;
  late List<String> _filteredItems;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.selectedItem.value;
    _searchController = TextEditingController();
    _filteredItems = List.from(widget.dropdownItems);
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _filterItems(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredItems = List.from(widget.dropdownItems);
      } else {
        _filteredItems = widget.dropdownItems
            .where((item) => item.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      margin: EdgeInsets.symmetric(horizontal: 18),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(24),
          topRight: Radius.circular(24),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 12),
          Center(
            child: Container(
              width: 45,
              height: 6,
              decoration: BoxDecoration(
                color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
                borderRadius: BorderRadius.circular(30),
              ),
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Text(
              widget.title,
              style: TextStyle(
                letterSpacing: 0,
                fontWeight: FontWeight.w900,
                fontSize: 18,
                color: AppColors.lightTextPrimary,
              ),
            ),
          ),
          const SizedBox(height: 16),
          Divider(
            indent: 18,
            endIndent: 18,
            height: 0,
            color: AppColors.lightTextPrimary.withValues(alpha: 0.16),
          ),
          if (widget.showSearch) ...[
            Container(
              margin: EdgeInsets.only(left: 18, right: 18, top: 20),
              height: 54,
              child: TextField(
                controller: _searchController,
                onChanged: _filterItems,
                textAlignVertical: TextAlignVertical.center,
                decoration: InputDecoration(
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  labelText: 'Search',
                  labelStyle: TextStyle(
                    color: AppColors.lightTextTertiary,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  floatingLabelStyle: TextStyle(
                    color: AppColors.lightTextTertiary,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(left: 12, right: 16),
                    child: Image.asset(
                      PngAssets.searchCommonIcon,
                      color: AppColors.lightTextPrimary,
                      width: 18,
                    ),
                  ),
                  filled: true,
                  fillColor: AppColors.transparent,
                  enabledBorder: OutlineInputBorder(
                    borderRadius: _getBorderRadius(),
                    borderSide: BorderSide(
                      color: AppColors.lightTextPrimary.withValues(alpha: 0.10),
                      width: 2,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: _getBorderRadius(),
                    borderSide: BorderSide(
                      color: AppColors.lightPrimary.withValues(alpha: 0.80),
                      width: 2,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 15.8,
                  ),
                ),
                style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 18,
                  color: AppColors.lightTextPrimary,
                ),
              ),
            ),
          ],
          Expanded(
            child: _filteredItems.isEmpty
                ? _buildEmptyState(
                    notFoundText: widget.notFoundText ?? "No items found",
                  )
                : SingleChildScrollView(
                    physics: AlwaysScrollableScrollPhysics(),
                    child: Column(
                      children: [
                        ListView.builder(
                          padding: EdgeInsets.only(
                            left: 18,
                            right: 18,
                            top: 16,
                          ),
                          itemCount: _filteredItems.length,
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            final item = _filteredItems[index];
                            final isSelected = selectedValue == item;

                            return ListTile(
                              dense: true,
                              visualDensity: VisualDensity.compact,
                              contentPadding: EdgeInsets.zero,
                              onTap: () {
                                setState(() {
                                  selectedValue = isSelected ? '' : item;
                                });
                              },
                              leading: Container(
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? AppColors.lightPrimary
                                        : AppColors.lightTextPrimary.withValues(
                                            alpha: 0.20,
                                          ),
                                    width: 2,
                                  ),
                                ),
                                child: isSelected
                                    ? Center(
                                        child: Container(
                                          width: 10,
                                          height: 10,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: AppColors.lightPrimary,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),
                              title: Transform.translate(
                                offset: Offset(0, -1),
                                child: Text(
                                  item,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.lightTextPrimary
                                        : AppColors.lightTextPrimary.withValues(
                                            alpha: 0.6,
                                          ),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 0,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: CommonButton(
              text: "Apply",
              onPressed: () {
                widget.selectedItem.value = selectedValue;
                widget.onValueSelected?.call(selectedValue);
                Get.back();
              },
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

  Widget _buildEmptyState({required String notFoundText}) {
    return SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.search_off_rounded,
            size: 50,
            color: AppColors.lightTextTertiary,
          ),
          SizedBox(height: 2),
          Text(
            notFoundText,
            style: TextStyle(
              fontSize: 18,
              color: AppColors.lightTextPrimary,
              fontWeight: FontWeight.w700,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }

  BorderRadius _getBorderRadius() {
    return BorderRadius.only(
      topLeft: Radius.circular(
        widget.topLeftBorderRadius ?? widget.borderRadius,
      ),
      topRight: Radius.circular(
        widget.topRightBorderRadius ?? widget.borderRadius,
      ),
      bottomLeft: Radius.circular(
        widget.bottomLeftBorderRadius ?? widget.borderRadius,
      ),
      bottomRight: Radius.circular(
        widget.bottomRightBorderRadius ?? widget.borderRadius,
      ),
    );
  }
}
