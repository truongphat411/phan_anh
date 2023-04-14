import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../services/services.dart';
import '../modules.dart';

class PhanAnhProvider extends ChangeNotifier {
  final ScrollController _controller = ScrollController();
  final ApiClient _apiClient = ApiClient();
  int _currentIndex = 0;
  List<PhanAnh> _itemList = [];
  List<LoaiPhanAnh> _itemListLPA = [];
  List<PhuongXa> _itemListPX = [];
  List<LoaiViPham> _itemListLVP = [];
  int pageIndex = 1;
  int pageSize = 10;
  bool loadingMore = false;
  bool loadMore = true;
  bool loadLPA = false;
  bool loadPA = false;
  bool loadFilter = false;
  Filter? filter;

  ScrollController get controller => _controller;
  ApiClient get apiClient => _apiClient;
  int get currentIndex => _currentIndex;
  List<PhanAnh> get itemList => _itemList;
  List<LoaiPhanAnh> get itemListLPA => _itemListLPA;
  List<PhuongXa> get itemListPX => _itemListPX;
  List<LoaiViPham> get itemListLVP => _itemListLVP;

  listener() {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (!loadingMore) {
          paginate();
          // Animate to bottom of list
          Timer(const Duration(milliseconds: 100), () {
            _controller.animateTo(
              _controller.position.maxScrollExtent,
              duration: const Duration(milliseconds: 100),
              curve: Curves.easeIn,
            );
          });
        }
      }
    });
  }

  getPA() async {
    setLoadPA(true);
    try {
      var items =
          await apiClient.getDataPA(pageSize: pageSize, pageIndex: pageIndex);
      _itemList = items;
      setLoadPA(false);
      listener();
    } catch (e) {
      setLoadPA(true);
      rethrow;
    }
  }

  paginate() async {
    if (!loadPA && !loadingMore && loadMore) {
      Timer(const Duration(milliseconds: 100), () {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      });
      loadingMore = true;
      pageIndex += 1;
      notifyListeners();
      try {
        final items = await _apiClient.getDataPA(
          pageIndex: pageIndex,
          pageSize: pageSize,
        );
        if (items.isNotEmpty) {
          _itemList.addAll(items);
        }
        loadingMore = false;
        notifyListeners();
      } catch (e) {
        loadMore = false;
        loadingMore = false;
        notifyListeners();
        rethrow;
      }
    }
  }

  void updateCurrent(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> getData() async {
    try {
      _itemListLPA = [];
      setLoadLPA(true);
      final List<LoaiPhanAnh> itemsPA = await ApiClient().getDataLPA();
      _itemListLPA = itemsPA;
      final List<PhuongXa> itemsPX = await ApiClient().getDataPX();
      _itemListPX = itemsPX;
      LoaiPhanAnh loaiPhanAnh = LoaiPhanAnh()
        ..loaiPhanAnhId = 0
        ..tenLoaiPhanAnh = 'Tất cả'
        ..moTa = null
        ..maLoaiPhanAnh = null
        ..maPhanLoai = null;
      _itemListLPA.insert(0, loaiPhanAnh);
      setLoadLPA(false);
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  getPAFilter(Filter value) async {
    try {
      pageIndex = 1;
      filter = value;
      setLoadPA(true);
      if (value.phananh?.loaiPhanAnhId != 0) {
        _itemList = await apiClient.getDataPA(
            pageSize: pageSize, pageIndex: pageIndex, LoaiPhanAnhId: value.phananh?.loaiPhanAnhId);
        _itemListLVP = await apiClient.getDataLVP(loaiPhanAnhId: value.phananh!.loaiPhanAnhId!);
        filter?.loaiViPhamIds = _itemListLVP;
        filter?.phananh = value.phananh;
        filter?.phuongXa =value.phuongXa;
        filter?.duong = value.duong;
        filter?.tuNgay = value.tuNgay;
        filter?.denNgay = value.denNgay;
      } else {
        _itemList =
            await apiClient.getDataPA(pageSize: pageSize, pageIndex: pageIndex);
        filter?.phuongXa =value.phuongXa;
        filter?.duong = value.duong;
        filter?.tuNgay = value.tuNgay;
        filter?.denNgay = value.denNgay;
      }
      setLoadPA(false);
      listener();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void setLoadLPA(bool value) {
    loadLPA = value;
    notifyListeners();
  }

  void setLoadPA(bool value) {
    loadPA = value;
    notifyListeners();
  }
}
