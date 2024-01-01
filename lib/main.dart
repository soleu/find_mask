import 'package:find_mask/ui/view/main_page.dart';
import 'package:find_mask/viewmodel/store_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
// 변경 감지를 최상위 루트 단에 적용 (NotifyListeners 호출시, 통제가 필요한 곳에 적용)
  WidgetsFlutterBinding.ensureInitialized();
  runApp(ChangeNotifierProvider.value(
      value: StoreModel(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: MainPage(),
    );
  }
}

