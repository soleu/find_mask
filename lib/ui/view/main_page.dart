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
        body: _buildBody(storeModel));
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

  Widget _buildBody(StoreModel storeModel) {
    if (storeModel.isLoading == true) {
      return loadingWidget();
    }
    if (storeModel.stores.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text('반경 5km 이내 재고가 있는 매장이 없습니다.'),
            Text('또는 인터넷이 연결되어 있는지 확인해주세요.'),
          ],
        ),
      );
    }
    return ListView(
        children: storeModel.stores.map((e) {
      return RemainStatListTile(e);
    }).toList());
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
