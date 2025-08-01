import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';
import 'package:loan_application_admin/views/home/home_controller.dart';
import 'package:loan_application_admin/widgets/survey_box.dart';

class SurveyList extends StatefulWidget {
  const SurveyList({super.key});

  @override
  _SurveyListState createState() => _SurveyListState();
}

class _SurveyListState extends State<SurveyList> {
  final HomeController controller = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    controller.getHistory(); // Fetch dynamic history list
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.pureWhite,
      body: Column(
        children: [
          const SizedBox(height: 20),
          Container(
            width: double.infinity,
            height: 57,
            color: Colors.white,
            child: const Center(
              child: Text(
                'Survey List',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontFamily: 'Outfit',
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              color: AppColors.black,
              backgroundColor: Colors.white,
              onRefresh: () async {
                await Future(() => controller.getHistory());
              },
              child: Obx(() {
                final list = controller.surveyList;
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
                      onTap: () => Get.toNamed(
                        MyAppRoutes.surveyDetail,
                        arguments: item,
                      ),
                      child: SurveyBox(
                        name: item.fullName,
                        date: DateFormat('yyyy-MM-dd')
                            .format(item.application.trxDate),
                        location: item.sectorCity,
                        image: (item.document?.docPerson.isNotEmpty ?? false)
                            ? item.document!.docPerson[0].img
                            : 'https://salonlfc.com/wp-content/uploads/2018/01/image-not-found-scaled-1150x647.png',
                        status: statusText,
                        statusColor: statusColor,
                        plafond: item.application.plafond,
                        aged: '${item.aged} Years',
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
