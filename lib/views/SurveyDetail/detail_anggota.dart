import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loan_application_admin/API/models/history_models.dart';
import 'package:loan_application_admin/core/theme/color.dart';
import 'package:loan_application_admin/utils/routes/my_app_route.dart';
import 'package:loan_application_admin/views/SurveyDetail/iqy_anggota_controller.dart';
import 'package:loan_application_admin/widgets/SurveyDetail/field_readonly.dart';
import 'package:loan_application_admin/widgets/custom_appbar.dart';

class SurveyDetail extends StatefulWidget {
  const SurveyDetail({super.key});

  @override
  _SurveyDetailState createState() => _SurveyDetailState();
}

class _SurveyDetailState extends State<SurveyDetail> {
  final IqyAnggotaController iqyAnggotaController =
      Get.put(IqyAnggotaController());

  late String cifId;
  late String trxSurvey;
  @override
  void initState() {
    super.initState();
    final Datum arguments = Get.arguments;
    cifId = arguments.cifID?.toString() ?? '';
    trxSurvey = arguments.application.trxSurvey?.toString() ?? '';
    print("wwww : cifId=$cifId, trxSurvey=$trxSurvey");
    iqyAnggotaController.getSurveyListanggota(id_search: cifId.toString());
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: 'Debitur Detail',
        onBack: () => Get.offAllNamed('/dashboard'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //sudah
                    FieldReadonly(
                      label: 'NIK',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.enik_no.value,
                      keyboardType: TextInputType.number,
                    ),
                    //sudah
                    FieldReadonly(
                      label: 'Nama',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.full_name.value,
                      keyboardType: TextInputType.text,
                    ),
                    //belum
                    FieldReadonly(
                      label: 'No. Telpon',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.phone.value,
                      keyboardType: TextInputType.text,
                    ),
                    //sudah
                    FieldReadonly(
                      label: 'Alamat',
                      width: double.infinity,
                      height: 58,
                      value: iqyAnggotaController.sector_city.value,
                      keyboardType: TextInputType.text,
                    ),
                    FieldReadonly(
                      label: 'Detail Alamat',
                      width: double.infinity,
                      height: 58,
                      value: iqyAnggotaController.address_line1.value,
                      keyboardType: TextInputType.text,
                    ),
                    //sudah
                    FieldReadonly(
                      label: 'Kota Lahir',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.city_born.value,
                      keyboardType: TextInputType.text,
                    ),
                    //belum
                    FieldReadonly(
                      label: 'Tanggal Lahir',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.date_born.value,
                      keyboardType: TextInputType.text,
                    ),
                    //belum
                    FieldReadonly(
                      label: 'Pekerjaan',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.deskripsiPekerjaan.value,
                      keyboardType: TextInputType.text,
                    ),
                    FieldReadonly(
                      label: 'Nama pasangan',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.pasangan_nama.value,
                      keyboardType: TextInputType.text,
                    ),
                    FieldReadonly(
                      label: 'NIK pasangan',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.pasangan_idcard.value,
                      keyboardType: TextInputType.text,
                    ),
                    FieldReadonly(
                      label: 'Gender',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.gender.value,
                      keyboardType: TextInputType.text,
                    ),
                    FieldReadonly(
                      label: 'Status Verifikasi Document',
                      width: double.infinity,
                      height: 50,
                      value: iqyAnggotaController.gender.value,
                      keyboardType: TextInputType.text,
                    ),
                  ],
                )),
            const SizedBox(height: 30),
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                onPressed: () => Get.toNamed(
                  MyAppRoutes.detaildocumen,
                  arguments: {
                    'trxSurvey': trxSurvey,
                    'cifId': cifId,
                  },
                ), // Pass the trx_survey value
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.casualbutton1,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Selanjutnya',
                      style: TextStyle(
                          fontSize: 16,
                          color: AppColors.pureWhite,
                          fontFamily: 'Outfit'),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.arrow_forward_outlined,
                        color: Colors.white),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }
}
