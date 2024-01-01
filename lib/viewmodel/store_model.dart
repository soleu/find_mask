import 'package:find_mask/model/store.dart';
import 'package:find_mask/repository/store_repository.dart';
import 'package:flutter/cupertino.dart';

class StoreModel with ChangeNotifier {
  List<Store> stores = [];
  var isLoading = false; // 값 자체는 뷰모델에서 관리. 값에 따라 화면이 변하는건 뷰에서 관지
  final _storeRepository = StoreRepository();

  StoreModel() {
    fetch();
  }

  Future fetch() async {
    isLoading = true;
    notifyListeners(); // 변경이 다 되었음을 통지

    stores = await _storeRepository.fetch();
    isLoading = false;
    notifyListeners(); // 변경이 다 되었음을 통지
  }
}
