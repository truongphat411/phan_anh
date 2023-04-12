import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../services/services.dart';
import '../modules.dart';

class PhanAnhProvider extends ChangeNotifier {
  final ScrollController _controller = ScrollController();
  APIRequestStatus _apiRequestStatus = APIRequestStatus.loading;
  final ApiClient _apiClient = ApiClient();
  int _currentIndex = 0;
  List<PhanAnh> itemList = [];
  List<LoaiPhanAnh> _itemListLPA = [];
  int pageIndex = 1;
  int pageSize = 10;
  bool loadingMore = false;
  bool loadMore = true;


  ScrollController get controller => _controller;
  APIRequestStatus get apiRequestStatus => _apiRequestStatus;
  ApiClient get apiClient => _apiClient;
  int get currentIndex => _currentIndex;
  //List<PhanAnh> get itemList => _itemList;
  List<LoaiPhanAnh> get itemListLPA => _itemListLPA;

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
    setApiRequestStatus(APIRequestStatus.loading);
    try {
      var items =
          await apiClient.getDataPA(pageSize: pageSize, pageIndex: pageIndex);
      itemList = items;
      setApiRequestStatus(APIRequestStatus.loaded);
      listener();
    } catch (e) {
      setApiRequestStatus(APIRequestStatus.error);
      rethrow;
    }
  }

  paginate() async {
    if (_apiRequestStatus != APIRequestStatus.loading &&
        !loadingMore &&
        loadMore) {
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
          itemList.addAll(items);
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

  Future<void> getDataLPA() async {
    try{
      _itemListLPA = [];
      setApiRequestStatus(APIRequestStatus.loading);
      final List<LoaiPhanAnh> itemsPA = await ApiClient().getDataLPA();
      _itemListLPA = itemsPA;
      LoaiPhanAnh loaiPhanAnh = LoaiPhanAnh()
        ..loaiPhanAnhId = 0
        ..tenLoaiPhanAnh = 'Tất cả'
        ..moTa = null
        ..maLoaiPhanAnh = null
        ..maPhanLoai = null;
      _itemListLPA.insert(0, loaiPhanAnh);
      setApiRequestStatus(APIRequestStatus.loaded);
      notifyListeners();
    }catch(e){
      rethrow;
    }
  }

  getPAFilter(int idLPA) async {
    try {
      pageIndex = 1;
      setApiRequestStatus(APIRequestStatus.loading);
      if (idLPA != 0) {
        itemList = await apiClient.getDataPA(pageSize: pageSize, pageIndex: pageIndex, LoaiPhanAnhId: idLPA);
      }else{
        itemList = await apiClient.getDataPA(pageSize: pageSize, pageIndex: pageIndex);
      }
      setApiRequestStatus(APIRequestStatus.loaded);
      listener();
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  void setApiRequestStatus(APIRequestStatus value) {
    _apiRequestStatus = value;
    notifyListeners();
  }
}
