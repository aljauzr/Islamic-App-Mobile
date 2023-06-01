import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiDataSource {
  static ApiDataSource instance = ApiDataSource();

  static Future<Map<String, dynamic>> getDoaList() async {
    final response = await http.get(Uri.parse("https://islamic-api-zhirrr.vercel.app/api/doaharian"));
    final body = response.body;

    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      return {"error": true};
    }
  }

  static Future<Map<String, dynamic>> getAsmaulHusnaList() async {
    final response = await http.get(Uri.parse("https://islamic-api-zhirrr.vercel.app/api/asmaulhusna"));
    final body = response.body;

    if (body.isNotEmpty) {
      final jsonBody = json.decode(body);
      return jsonBody;
    } else {
      return {"error": true};
    }
  }
}


