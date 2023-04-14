import 'package:flutter/cupertino.dart';

import '../../services/services.dart';
import '../modules.dart';

class BottomSheetProvider extends ChangeNotifier {
  List<LoaiPhanAnh> _loaiPAList = [];
  List<LoaiViPham> _loaiVPList = [];
  List<PhuongXa> _pxList = [];
  List<Duong> _dList = [];

  String? _tenloaiPA;
  String? _phuongXaId;
  String? _duongId;
  DateTime? _fromDate;
  DateTime? _toDate;

  bool isLoadingLPA = false;
  bool isLoadingLVP = false;
  bool isLoadingPX = false;
  bool isLoadingD = false;

  List<LoaiPhanAnh> get loaiPAList => _loaiPAList;
  List<LoaiViPham> get loaiVPList => _loaiVPList;
  List<PhuongXa> get pxList => _pxList;
  List<Duong> get dList => _dList;

  String? get tenloaiPA => _tenloaiPA;
  String? get phuongXaId => _phuongXaId;
  String? get duongId => _duongId;
  DateTime? get fromDate => _fromDate;
  DateTime? get toDate => _toDate;

  void setLoadingLPA(bool value) {
    isLoadingLPA = value;
    notifyListeners();
  }

  void setLoadingLVP(bool value) {
    isLoadingLVP = value;
    notifyListeners();
  }

  void setLoadingPX(bool value) {
    isLoadingPX = value;
    notifyListeners();
  }

  void setLoadingD(bool value) {
    isLoadingD = value;
    notifyListeners();
  }

  void setTenLoaiPA(String? value) {
    _tenloaiPA = value;
    notifyListeners();
  }

  void setPhuongXaId(String? value) {
    _phuongXaId = value;
    notifyListeners();
  }

  void setDuongId(String? value) {
    _duongId = value;
    notifyListeners();
  }

  void setFromDate(DateTime? time) {
    _fromDate = time;
    notifyListeners();
  }

  void setToDate(DateTime? time) {
    _toDate = time;
    notifyListeners();
  }

  void updateLoaiVPList(List<LoaiViPham> list) {
    _loaiVPList = list;
    notifyListeners();
  }

  Future<void> getLPA() async {
    setLoadingLPA(true);
    final List<LoaiPhanAnh> items = await ApiClient().getDataLPA();
    _loaiPAList = items;
    setLoadingLPA(false);
    notifyListeners();
  }

  Future<void> getLVP(int loaiPhanAnhId) async {
    setLoadingLVP(true);
    final List<LoaiViPham> items =
        await ApiClient().getDataLVP(loaiPhanAnhId: loaiPhanAnhId);
    _loaiVPList = items;
    setLoadingLVP(false);
    notifyListeners();
  }

  Future<void> getPXList() async {
    setLoadingPX(true);
    final List<PhuongXa> items = await ApiClient().getDataPX();
    _pxList = items;
    setLoadingPX(false);
    notifyListeners();
  }

  Future<void> getDList(int phuongXaId) async {
    _dList = [];
    setLoadingD(true);
    _duongId = null;
    final List<Duong> items =
        await ApiClient().getDataD(phuongXaId: phuongXaId);
    _dList = items;
    setLoadingD(false);
    notifyListeners();
  }

  @override
  void dispose() {
    print('disposing MyModel');
    super.dispose();
  }
}
