import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tpro/models/account.dart';
import 'package:tpro/models/accounts.dart';
import 'package:tpro/models/img.dart';
import 'package:tpro/models/imgs.dart';
import 'package:tpro/models/index.dart';
import 'package:tpro/models/type_img.dart';
import 'package:tpro/models/type_imgs.dart';

class Services {
  static const String list_img_url =
      "http://192.168.1.20/database_minipro_mobile/list_images";
  static const String acc_url =
      "http://192.168.1.20/database_minipro_mobile/accounts";
  static const String type_img_url =
      "http://192.168.1.20/database_minipro_mobile/type_images";
  static const String list_com =
      "http://192.168.1.20/database_minipro_mobile/list_comments";

  static Future<Coms> getcoms() async {
    try {
      final response = await http.get(Uri.parse(list_com));
      if (200 == response.statusCode) {
        return parseComs(response.body);
      } else {
        return Coms();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Coms();
    }
  }

  static Coms parseComs(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Com> coms = parsed.map<Com>((json) => Com.fromJson(json)).toList();
    Coms p = Coms();
    p.coms = coms;
    return p;
  }

  static Future<Type_imgs> getTypeimgs() async {
    try {
      final response = await http.get(Uri.parse(type_img_url));
      if (200 == response.statusCode) {
        return parseTypeimgs(response.body);
      } else {
        return Type_imgs();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Type_imgs();
    }
  }

  static Type_imgs parseTypeimgs(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Type_img> typeImgs =
        parsed.map<Type_img>((json) => Type_img.fromJson(json)).toList();
    Type_imgs p = Type_imgs();
    p.type_imgs = typeImgs;
    return p;
  }

  static Future<Imgs> getImgsByUser(int id) async {
    try {
      final response = await http.get(Uri.parse(
          'http://192.168.1.20/database_minipro_mobile/list_image/id_acc/$id'));
      print(response.body);
      if (200 == response.statusCode) {
        return parseImgs(response.body);
      } else {
        return Imgs();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Imgs();
    }
  }

  static Future<Imgs> getImgs() async {
    try {
      final response = await http.get(Uri.parse(list_img_url));
      print(response.body);
      if (200 == response.statusCode) {
        return parseImgs(response.body);
      } else {
        return Imgs();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Imgs();
    }
  }

  static Imgs parseImgs(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Img> imgs = parsed.map<Img>((json) => Img.fromJson(json)).toList();
    Imgs p = Imgs();
    p.imgs = imgs;
    return p;
  }

  static Future<Accounts> getAccounts() async {
    try {
      final response = await http.get(Uri.parse(acc_url));
      if (200 == response.statusCode) {
        return parseAccounts(response.body);
      } else {
        return Accounts();
      }
    } catch (e) {
      print('Error ${e.toString()}');
      return Accounts();
    }
  }

  static Accounts parseAccounts(String responseBody) {
    final parsed = json.decode(responseBody).cast<Map<String, dynamic>>();
    List<Account> accs =
        parsed.map<Account>((json) => Account.fromJson(json)).toList();
    Accounts a = Accounts();
    a.accounts = accs;
    return a;
  }
}
