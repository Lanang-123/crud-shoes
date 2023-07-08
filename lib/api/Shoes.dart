import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ShoesController {
  final String baseUrl = "https://apishoes.000webhostapp.com/api/shoes";
  
  Future <List<dynamic>> getShoes () async {
     final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(response.body)["data"];
        return jsonData;
      } else {
        throw Exception('Failed to fetch products');
      }
  }

  Future<Map<String,dynamic>> getShoeById(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/detail/$id'));
    if (response.statusCode == 200) {
      final Map<String,dynamic> jsonData = json.decode(response.body);
      return jsonData;
    } else {
      throw Exception('Failed to fetch product');
    }
  }


   Future createShoes(String title, String desc, String price, String image) async {
      var url = Uri.parse(baseUrl);
      var response = await http.post(url,
          body: {
            'title': title,
            'description': desc,
            'price': price,
            'images':image
          },
        );

        if (response.statusCode == 200) {
          print('Shoes created successfully');
        } else {
          print('Failed to create shoes. Error code: ${response.statusCode}');
        }
  }

  Future updateShoes(var id,String title, String desc, String price, String image) async {
      var url = Uri.parse(baseUrl +'/$id');
      var response = await http.post(url,
          body: {
            'title': title,
            'description': desc,
            'price': price,
            'images':image
          },
        );

        if (response.statusCode == 200) {
          print('Shoes update successfully');
        } else {
          print('Failed to create shoes. Error code: ${response.statusCode}');
        }
  }

  Future<void> deleteShoes(int id) async {
    final response = await http.get(Uri.parse('$baseUrl/delete/$id'));
    var res = json.decode(response.body);

    
    return res;
  }
}