import 'dart:convert';
import 'package:chatgpt/constant.dart';
import 'package:http/http.dart' as http;

class fetchFromAPI {
  final apikey = apiKey;
  static String url = url1;

  static sendMsg(String input) async {
    final response = await http.post(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        "Authorization": "Bearer $apiKey"
      },
      body: jsonEncode(
        {
          "model": "text-davinci-003",
          "prompt": input.toString(),
          'temperature': 0,
          'max_tokens': 500,
          'top_p': 1,
          'frequency_penalty': 0.0,
          'presence_penalty': 0.0,
        },
      ),
    );

    try {
      if (response.statusCode == 200) {
        var data = jsonDecode(response.body.toString());
        var msg = data['choices'][0]['text'];
        return msg;
      } else {
        print('Failed to Fetch Data');
        return 'Failed to Fetch Data';
      }
    } catch (e) {
      print(e.toString());
      return e.toString();
    }
  }
}
