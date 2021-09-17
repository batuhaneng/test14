import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

abstract class BilgilerRepository {
  Future<List<Bilgiler>> BilgileriGetir();
}

class BilgilerDaoRepository implements BilgilerRepository {
  List<Bilgiler> parseBilgilerCevap(String cevap) {
    return BilgilerCevap.fromJson(json.decode(cevap)).BilgilerListesi;
  }

  @override
  Future<List<Bilgiler>> BilgileriGetir() async {
    var url = Uri.parse("http://test11.internative.net/Login/SignIn");
    var cevap = await http.get(url);
    return parseBilgilerCevap(cevap.body);
  }
}

class BilgilerCevap {
  int success;
  List<Bilgiler> BilgilerListesi;
  BilgilerCevap(this.success, this.BilgilerListesi);

  factory BilgilerCevap.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["bilgiler"] as List;
    Iterable<Bilgiler> BilgilerListesi = jsonArray
        .map((jsonArrayNesnesi) => Bilgiler.fromJson(jsonArrayNesnesi));
    return BilgilerCevap(json["success"] as int, BilgilerListesi);
  }
}

class Bilgiler {
  String HasError;
  String Token;
  String Message;

  Bilgiler(this.HasError, this.Token, this.Message);

  factory Bilgiler.fromJson(Map<String, dynamic> json) {
    return Bilgiler(json["HasError"] as String, json["Token"] as String,
        json["Message"] as String);
  }
}
