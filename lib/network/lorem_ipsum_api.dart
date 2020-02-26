
import 'package:http/http.dart' as http;

class LoremIpsumApi {

  static Future<String> getLoremIpsum() async {
    var url = "https://loripsum.net/api";

    print("Get > $url");

    var response = await http.get(url);

    String text = response.body;

    text = text.replaceAll("<p>", "");
    text = text.replaceAll("</p>", "");

    return text;
  }


}