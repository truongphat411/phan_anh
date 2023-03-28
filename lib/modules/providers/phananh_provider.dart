import 'package:flutter/cupertino.dart';

import '../../services/services.dart';
import '../modules.dart';

class PhanAnhProvider extends ChangeNotifier{
  int _currentIndex = 0;
  List<PhanAnh> _itemList = [];
  List<LoaiPhanAnh> _itemListLPA = [];
  int pageIndex = 1;
  int pageSize = 10;
  bool _isFilterLoadRunning = false;
  bool _isLoadMoreRunning = false;

  bool get isFilterLoadRunning => _isFilterLoadRunning;
  bool get isLoadMoreRunning => _isLoadMoreRunning;
  int get currentIndex => _currentIndex;

  List<PhanAnh> get itemList => _itemList;
  List<LoaiPhanAnh>  get itemListLPA => _itemListLPA;

  void updateCurrent(int index){
    _currentIndex = index;
    notifyListeners();
  }

  void updateIsFilterLoadingRunning(bool value){
    _isFilterLoadRunning = value;
    notifyListeners();
  }

  void loadMore() async {
    if ((isFilterLoadRunning == false) && _isLoadMoreRunning == false) {
      _isLoadMoreRunning = true;
      pageIndex += 1; // Increase _page by 1
      final items = await ApiClient().getDataPA(
        pageIndex: pageIndex,
        pageSize: pageSize,
      );
      if (items.isNotEmpty) {
        _itemList.addAll(items);
      }
    }
    _isLoadMoreRunning = false;
    notifyListeners();
  }

  Future<void> getData() async {
    final items = await ApiClient().getDataPA(pageSize: pageSize, pageIndex: pageIndex);
    _itemList = items;
    notifyListeners();
  }

  Future<void> getDataLPA() async {
    final List<LoaiPhanAnh> itemsPA = await ApiClient().getDataLPA();
    _itemListLPA = itemsPA;
    LoaiPhanAnh loaiPhanAnh = LoaiPhanAnh()
      ..loaiPhanAnhId = 0
      ..tenLoaiPhanAnh = 'Tất cả'
      ..moTa = null
      ..maLoaiPhanAnh = null
      ..maPhanLoai = null;
    _itemListLPA.insert(0, loaiPhanAnh);
    notifyListeners();
  }

  Future<void> filterLoad() async {
    _isFilterLoadRunning = true;
    // final items = await ApiClient().getDataPA(
    //     pageSize: pageSize,
    //     pageIndex: pageIndex,
    //     duongId: filter.duongId,
    //     tuNgay: filter.tuNgay,
    //     denNgay: filter.denNgay,
    //     LoaiViPhamIds: filter.loaiViPhamIds,
    //     phuongXaId: filter.phuongXaId);
    // _itemList = items;
    _isFilterLoadRunning = false;
    notifyListeners();
  }


  Future<List<PhanAnh>> getFilter(int idLPA) async {
    if(idLPA == 0){
      return _itemList;
    }
    var items = await ApiClient().getDataPA(pageIndex: pageIndex, pageSize: pageSize,LoaiPhanAnhId: idLPA);
    _itemList = items;
    return _itemList;
  }
}