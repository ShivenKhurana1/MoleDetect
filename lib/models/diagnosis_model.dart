class Diagnosis {
  String? diagnosis;
  double? confidence;
  String? risk;
  String? riskTitle;
  String? description;
  String? recommendationTitle;
  String? recommendationDescription;

  Diagnosis.fromJson(Map<String, dynamic> json)
      : confidence = json['confidence'],
        risk = json['risk'],
        riskTitle = json['riskTitle'],
        diagnosis = json['diagnosis'],
        description = json['description'],
        recommendationTitle = json['recommendationTitle'],
        recommendationDescription = json['recommendationDescription'];
}
