class NoSuratJalan {
  final String ShipmentLetterCodeAndCounter;


  NoSuratJalan({required this.ShipmentLetterCodeAndCounter});
factory NoSuratJalan.fromJson(Map<String, dynamic> json) {
    return NoSuratJalan(
      ShipmentLetterCodeAndCounter: json['ShipmentLetterCodeAndCounter'],
      
    );
  }
}