import 'dart:convert';

import 'package:find_mask/model/store.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class StoreRepository {
  Future<List<Store>> fetch() async {
    // Future가 붙어야 비동기식으로 만들 수 있음 (비동기로 수행이 되는 메서드임을 명시)
    // Future를 동기식으로 실행
    // -> 비동기적으로 실행되는 코드에 동기적으로 순서를 부여하고 싶을때 await 사용(Future 함수 안에서만 사용 가능)
    // 동기와 비동기
    // async - await
    // 비동기 : 두가지 일이 동시에 됨
    Uri url = Uri.https("gist.githubusercontent.com",
        "/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94");
    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    // print(jsonResult['stores']);

    final jsonStores = jsonResult['stores'];
    final stores = <Store>[];

    jsonStores.forEach((e) {
      stores.add(Store.fromJson(e));
    });

    return stores.where((e) {
      return e.remainStat == 'plenty' ||
          e.remainStat == 'some' ||
          e.remainStat == 'few';
    }).toList(); // filter와 같음

    // print('Response status: ${response.statusCode}');
    // print(
    //     'Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}'); // 이렇게 해야 한글 안 깨짐
  }
}
