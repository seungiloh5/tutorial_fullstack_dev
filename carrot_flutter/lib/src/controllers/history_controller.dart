import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class HistoryController extends GetxController {
  final box = GetStorage();
  final searchHistory = <String>[].obs;

  @override
  void onInit() {
    super.onInit();
    List<String> storedHistroy = box.read('searchHistory') ?? [];
    searchHistory.addAll(storedHistroy);
  }

  void addSearchTerm(String term) {
    if (searchHistory.contains(term)) {
      searchHistory.remove(term);
    }
    searchHistory.insert(0, term);

    if (searchHistory.length > 10) {
      searchHistory.removeLast();
    }

    _saveToStorage();
  }

  void removeSearchTerm(String term) {
    searchHistory.remove(term);
    _saveToStorage();
  }

  void clearAllSearchTerm() {
    searchHistory.clear();
    _saveToStorage();
  }

  void _saveToStorage() {
    box.write('searchHistory', searchHistory.toList());
  }
}
