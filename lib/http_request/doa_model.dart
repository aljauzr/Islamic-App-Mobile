class DoaModel {
  final List<Data>? data;

  DoaModel({
    this.data,
  });

  DoaModel.fromJson(Map<String, dynamic> json)
      : data = (json['data'] as List?)?.map((dynamic e) => Data.fromJson(e as Map<String,dynamic>)).toList();

  Map<String, dynamic> toJson() => {
    'data' : data?.map((e) => e.toJson()).toList()
  };
}

class Data {
  final String? title;
  final String? arabic;
  final String? latin;
  final String? translation;

  Data({
    this.title,
    this.arabic,
    this.latin,
    this.translation,
  });

  Data.fromJson(Map<String, dynamic> json)
      : title = json['title'] as String?,
        arabic = json['arabic'] as String?,
        latin = json['latin'] as String?,
        translation = json['translation'] as String?;

  Map<String, dynamic> toJson() => {
    'title' : title,
    'arabic' : arabic,
    'latin' : latin,
    'translation' : translation
  };
}