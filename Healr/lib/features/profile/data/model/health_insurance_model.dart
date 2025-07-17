class HealthInsuranceModel {
  final String headFamily;
  final String beneficiaryName;
  final String healthUnit;
  final String fileNumber;

  HealthInsuranceModel({
    required this.headFamily,
    required this.beneficiaryName,
    required this.healthUnit,
    required this.fileNumber,
  });

  Map<String, dynamic> toJson() {
    return {
      'headFamily': headFamily,
      'beneficiaryName': beneficiaryName,
      'healthUnit': healthUnit,
      'fileNumber': fileNumber,
    };
  }

  factory HealthInsuranceModel.fromJson(Map<String, dynamic> json) {
    if (json['data']['healthInsurances'] != null) {
      return HealthInsuranceModel(
        headFamily: json['data']['healthInsurances'][0]['headFamily'],
        beneficiaryName: json['data']['healthInsurances'][0]['beneficiaryName'],
        healthUnit: json['data']['healthInsurances'][0]['healthUnit'],
        fileNumber: json['data']['healthInsurances'][0]['fileNumber'],
      );
    } else if (json['data']['healthInsurance'] != null) {
      return HealthInsuranceModel(
        headFamily: json['data']['healthInsurance']['headFamily'],
        beneficiaryName: json['data']['healthInsurance']['beneficiaryName'],
        healthUnit: json['data']['healthInsurance']['healthUnit'],
        fileNumber: json['data']['healthInsurance']['fileNumber'],
      );
    } else {
      throw Exception("Invalid response format");
    }
  }
}
