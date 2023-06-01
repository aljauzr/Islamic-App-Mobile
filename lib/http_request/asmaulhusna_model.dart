class AsmaulHusnaModel {
  final List<Data>? data;

  AsmaulHusnaModel({
    this.data,
  });

  AsmaulHusnaModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final String? index;
  final String? latin;
  final String? arabic;
  final String? translationId;
  final String? translationEn;

  Data({
    this.index,
    this.latin,
    this.arabic,
    this.translationId,
    this.translationEn,
  });

  Data.fromJson(Map<String, dynamic> json)
      : index = json['index'] as String?,
        latin = json['latin'] as String?,
        arabic = json['arabic'] as String?,
        translationId = json['translation_id'] as String?,
        translationEn = json['translation_en'] as String?;

  Map<String, dynamic> toJson() => {
    'index' : index,
    'latin' : latin,
    'arabic' : arabic,
    'translation_id' : translationId,
    'translation_en' : translationEn
  };
}