import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../services/local_storage_services/local_storage_services.dart';

class CountryRow {
  const CountryRow({
    required this.name,
    required this.billingCode,
    required this.languageCode,
    required this.locale,
  });

  final String name;
  final String billingCode;
  final String languageCode;
  final Locale locale;
}

class CountriesController extends GetxController {
  static const List<CountryRow> rows = [
    CountryRow(
      name: 'Sweden',
      billingCode: 'SE',
      languageCode: 'sv',
      locale: Locale('sv', 'SE'),
    ),
    CountryRow(
      name: 'United States',
      billingCode: 'US',
      languageCode: 'en',
      locale: Locale('en', 'US'),
    ),
    CountryRow(
      name: 'Saudi Arabia',
      billingCode: 'SA',
      languageCode: 'ar',
      locale: Locale('ar', 'SA'),
    ),
    CountryRow(
      name: 'United Arab Emirates',
      billingCode: 'AE',
      languageCode: 'ar',
      locale: Locale('ar', 'AE'),
    ),
  ];

  Future<void> select(int index) async {
    final row = rows[index];
    await LocalStorageService().setBillingCountryCode(row.billingCode);
    await LocalStorageService().setLanguageCode(row.languageCode);
    Get.updateLocale(row.locale);
    Get.snackbar('Region updated', '${row.name} · billing ${row.billingCode}');
    Get.back<void>();
  }
}
