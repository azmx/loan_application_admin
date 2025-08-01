import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';
import 'package:loan_application_admin/views/home/home_controller.dart';
import 'package:loan_application_admin/widgets/History/filter_button.dart';
import 'package:loan_application_admin/widgets/History/searchbar.dart';
import 'package:loan_application_admin/widgets/survey_box.dart';

class HistoryAdmin extends StatefulWidget {
  const HistoryAdmin({super.key});

  @override
  State<HistoryAdmin> createState() => _HistoryAdminState();
}

class _HistoryAdminState extends State<HistoryAdmin> {
  final HomeController controller = Get.put(HomeController());
  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    controller.getHistory(); // Fetch history data
    searchController.addListener(() {
      controller.filterSearch(searchController.text);
    });
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Column(
        children: [
          const SizedBox(height: 30),
          CustomSearchBar(
            controller: searchController,
            onChanged: (query) => controller.filterSearch(query),
          ),
          FilterButtons(
            onFilterSelected: (status) => controller.filterByStatus(status),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.black,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await Future(() => controller.getHistory());
              },
              child: Obx(() {
                final list = controller.filteredList;
                if (list.isEmpty) {
                  return const Center(child: Text('No survey data available.'));
                }
                return ListView.builder(
                  padding: const EdgeInsets.all(10),
                  itemCount: list.length,
                  itemBuilder: (context, index) {
                    final item = list[index];
                    final statusText =
                        item.status?.value ?? item.application.toString();
                    final statusColor = controller.getStatusColor(statusText);

                    return GestureDetector(
                      onTap: () =>
                          Get.toNamed(MyAppRoutes.surveyDetail, arguments: item
// Convert to String for navigation
                              ),
                      child: SurveyBox(
                        name: item.fullName,
                        aged: item.aged,
                        location: item.sectorCity,
                        plafond: item.application.plafond,
                        date: DateFormat('yyyy-MM-dd')
                            .format(item.application.trxDate),
                        image: (item.document?.docPerson.isNotEmpty ?? false)
                            ? item.document!.docPerson[0].img
                            : 'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png',
                        status: statusText,
                        statusColor: statusColor,
                      ),
                    );
                  },
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
