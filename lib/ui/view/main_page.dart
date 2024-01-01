
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../model/store.dart';
import '../../viewmodel/store_model.dart';

class MainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final storeModel = Provider.of<StoreModel>(
        context); // 루트 클래스에서 적용한 클래스를 별도의 생성자 주입없이 사용 가능
    return Scaffold(
      appBar: AppBar(
        title: Text('마스크 재고 있는 곳 : ${storeModel.stores.length} 곳'),
        actions: [
          IconButton(
              onPressed: () async {
                await storeModel.fetch();
              },
              icon: const Icon(Icons.refresh))
        ],
      ),
      body: storeModel.isLoading == true
          ? loadingWidget()
          : ListView(
        children: storeModel.stores.where((e) {
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