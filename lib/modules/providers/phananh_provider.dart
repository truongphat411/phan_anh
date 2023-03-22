import 'package:flutter/cupertino.dart';

import '../../services/services.dart';
import '../modules.dart';

class PhanAnhProvider extends ChangeNotifier{
  List<PhanAnh> _itemList = [];
  List<LoaiPhanAnh> _itemListLPA = [];
  int pageIndex = 1;
  int pageSize = 10;
  bool _isFirstLoadRunning = false;
  bool _isFilterLoadRunning = false;
  bool _isLoadMoreRunning = false;

  bool get isFirstLoadRunning => _isFirstLoadRunning;
  bool get isFilterLoadRunning => _isFilterLoadRunning;
  bool get isLoadMoreRunning => _isLoadMoreRunning;

  List<PhanAnh> get itemList => _itemList;
  List<LoaiPhanAnh>  get itemListLPA => _itemListLPA;

  void loadMore() async {
    if ((isFirstLoadRunning == false || isFilterLoadRunning == false) && _isLoadMoreRunning == false) {
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

  Future<void> firstLoad() async {
    _isFirstLoadRunning = true;
    final items =
    await ApiClient().getDataPA(pageSize: pageSize, pageIndex: pageIndex);
    _itemList = items;
    _isFirstLoadRunning = false;
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

  Future<void> getLoaiPAList() async {
    _isFirstLoadRunning = true;
    final List<LoaiPhanAnh> items = await ApiClient().getDataLPA();
    _itemListLPA = items;
    LoaiPhanAnh loaiPhanAnh = LoaiPhanAnh()
      ..loaiPhanAnhId = 0
      ..tenLoaiPhanAnh = 'Tất cả'
      ..moTa = null
      ..maLoaiPhanAnh = null
      ..maPhanLoai = null;
    _isFirstLoadRunning = false;
    _itemListLPA.insert(0, loaiPhanAnh);
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}