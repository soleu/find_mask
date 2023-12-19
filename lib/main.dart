import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'model/store.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final stores = <Store>[];
  var isLoading = true;

  Future fetch() async {
    // Future가 붙어야 비동기식으로 만들 수 있음 (비동기로 수행이 되는 메서드임을 명시)
    // Future를 동기식으로 실행
    // -> 비동기적으로 실행되는 코드에 동기적으로 순서를 부여하고 싶을때 await 사용(Future 함수 안에서만 사용 가능)
    // 동기와 비동기
    // async - await
    // 비동기 : 두가지 일이 동시에 됨
    setState(() {
      isLoading = true; // 다시 한 번 로딩 중임을 표시
    });
    Uri url = Uri.https("gist.githubusercontent.com",
        "/junsuk5/bb7485d5f70974deee920b8f0cd1e2f0/raw/063f64d9b343120c2cb01a6555cf9b38761b1d94");
    var response = await http.get(url);

    final jsonResult = jsonDecode(utf8.decode(response.bodyBytes));
    // print(jsonResult['stores']);

    final jsonStores = jsonResult['stores'];

    setState(() {
      // 화면에 변화가 생길 때 트리거
      stores.clear();
      jsonStores.forEach((e) {
        stores.add(Store.fromJson(e));
      });
      print('fetched!');
      isLoading = false;
    });

    // print('Response status: ${response.statusCode}');
    // print(
    //     'Response body: ${jsonDecode(utf8.decode(response.bodyBytes))}'); // 이렇게 해야 한글 안 깨짐
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${stores.length} 곳'),
        actions: [
          IconButton(onPressed: fetch, icon: const Icon(Icons.refresh))
        ],
      ),
      body: isLoading == true
          ? loadingWidget()
          : ListView(
              children: stores.where((e) {
                return e.remainStat == 'plenty' ||
                    e.remainStat == 'some' ||
                    e.remainStat == 'few';
              }) // filter와 같음
                  .map((e) {
                return ListTile(
                  title: Text(e.name ?? ''),
                  subtitle: Text(e.addr ?? ''),
                  trailing: _buildRemainStatWidget(e), // 오른쪽 끝 영역
                );
              }).toList(),
            ),
    );
    //   Center(
    //       child: ElevatedButton(
    //     onPressed: () async {
    //       await fetch();
    //       print(stores.l);
    //     },
    //     child: Text('테스트'),
    //   )),
    // );
  }

  Widget _buildRemainStatWidget(Store store) {
    var remainStat = '판매 중지';
    var desc = '없음';
    var color = Colors.black;
    switch (store.remainStat) {
      case 'plenty':
        remainStat = '충분';
        desc = '100개 이상';
        color = Colors.green;
        break;
      case 'some':
        remainStat = '보통';
        desc = '30개 이상';
        color = Colors.yellow;
        break;
      case 'few':
        remainStat = '부족';
        desc = '2개 이상';
        color = Colors.red;
        break;
      case 'empty':
        remainStat = '';
        desc = '1개 이하';
        color = Colors.grey;
        break;
    }

    return Column(
      children: [
        Text(remainStat,
            style: TextStyle(color: color, fontWeight: FontWeight.bold)),
        Text(
          desc,
          style: TextStyle(color: color),
        )
      ],
    );
  }

  Widget loadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center, // 가운데 정렬
        children: [
          Text('정보를 가져오는 중'),
          CircularProgressIndicator(),
        ],
      ),
    );
  }
}
