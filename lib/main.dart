import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'repository/store_repository.dart';
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
  var stores = <Store>[];
  var isLoading = true;

  final storeRepository = StoreRepository();

  Future getData() async {
    setState(() {
      isLoading = true; // 다시 한 번 로딩 중임을 표시
    });
    await storeRepository.fetch().then((stores) {
      setState(() {
        stores = stores;
      });
    });
    setState(() {
      // 화면에 변화가 생길 때 트리거
      // stores.clear();
      print('getDated!');
      isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();

    storeRepository.fetch().then((stores) {
      setState(() {
        this.stores = stores;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${stores.length} 곳'),
        actions: [
          IconButton(onPressed: getData, icon: const Icon(Icons.refresh))
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
    //       await getData();
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
