import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../services/services.dart';
import '../modules.dart';

class PhanAnhProvider extends ChangeNotifier {
  final ScrollController _controller = ScrollController();
  APIRequestStatus _apiRequestStatus = APIRequestStatus.loading;
  final ApiClient _apiClient = ApiClient();
  int _currentIndex = 0;
  List<PhanAnh> _itemList = [];
  List<LoaiPhanAnh> _itemListLPA = [];
  int pageIndex = 1;
  int pageSize = 10;
  bool _loadingMore = false;
  bool _loadMore = true;

  ScrollController get controller => _controller;
  APIRequestStatus get apiRequestStatus => _apiRequestStatus;
  ApiClient get apiClient => _apiClient;
  int get currentIndex => _currentIndex;
  List<PhanAnh> get itemList => _itemList;
  List<LoaiPhanAnh> get itemListLPA => _itemListLPA;
  bool get loadingMore => _loadingMore;
  bool get loadMore => _loadMore;

  listener() {
    _controller.addListener(() {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (!_loadingMore) {
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
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      var items =
          await apiClient.getDataPA(pageSize: pageSize, pageIndex: pageIndex);
      _itemList = items;
      setApiRequestStatus(APIRequestStatus.loaded);
      listener();
    } catch (e) {
      setApiRequestStatus(APIRequestStatus.error);
      rethrow;
    }
  }

  paginate() async {
    if (_apiRequestStatus != APIRequestStatus.loading &&
        !_loadingMore &&
        _loadMore) {
      Timer(const Duration(milliseconds: 100), () {
        _controller.jumpTo(_controller.position.maxScrollExtent);
      });
      _loadingMore = true;
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
        _loadingMore = false;
        notifyListeners();
      } catch (e) {
        _loadMore = false;
        _loadingMore = false;
        notifyListeners();
        rethrow;
      }
    }
  }

  void updateCurrent(int index) {
    _currentIndex = index;
    notifyListeners();
  }

  Future<void> getDataLPA() async {
    try{
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
    }catch(e){
      setApiRequestStatus(APIRequestStatus.error);
    }
  }

  getPAFilter(int idLPA) async {
    try {
      setApiRequestStatus(APIRequestStatus.loading);
      List<PhanAnh> items;
      if (idLPA != 0) {
        items = await apiClient.getDataPA(pageSize: pageSize, pageIndex: pageIndex, LoaiPhanAnhId: idLPA);
      }else{
        items = await apiClient.getDataPA(pageSize: pageSize, pageIndex: pageIndex);
      }
      _itemList = items;
      setApiRequestStatus(APIRequestStatus.loaded);
      listener();
      notifyListeners();
    } catch (e) {
      setApiRequestStatus(APIRequestStatus.error);
      rethrow;
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    _apiRequestStatus = value;
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
  }
}
