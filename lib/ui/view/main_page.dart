import 'package:find_mask/ui/widget/remain_stat_list_tile.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
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
              children: storeModel.stores.map((e) {
                return RemainStatListTile(e);
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
