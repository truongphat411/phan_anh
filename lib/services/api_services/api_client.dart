import 'package:dio/dio.dart';

import '../../modules/modules.dart';

class ApiClient {
  final Dio dio = Dio();
  final String baseUrl = 'http://demo.vietinfo.tech:9998/BinhThanh/PhanAnh';

  Future<List<PhanAnh>> getDataPA(
      {required int pageIndex,
      required int pageSize,
      List<int>? LoaiViPhamIds,
      String? tuNgay,
      String? denNgay,
      int? duongId,
      int? phuongXaId,
      int? LoaiPhanAnhId
      }) async {
    try {
      String url =
          '$baseUrl/phananhs?DonViId=0&DeviceId=abcdef&NguoiGuiId=123456789&pageIndex=$pageIndex&pageSize=$pageSize';
      if (tuNgay != null) {
        url += '&tuNgay=$tuNgay';
      }
      if (denNgay != null) {
        url += '&denNgay=$denNgay';
      }
      if (duongId != null) {
        url += '&duongId=$duongId';
      }
      if (phuongXaId != null) {
        url += '&phuongXaId=$phuongXaId';
      }
      if(LoaiPhanAnhId != null) {
        url += '&LoaiPhanAnhId=$LoaiPhanAnhId';
      }
      if (LoaiViPhamIds != null && LoaiViPhamIds.isNotEmpty) {
        String urlLVP = '';
        for (var i in LoaiViPhamIds) {
          urlLVP += '&LoaiViPhamIds=$i';
        }
        url += urlLVP;
      }
      print('PhatNMT-url: $url');
      final response = await dio.get(url);
      if (response.statusCode == 200) {
        final data = response.data['data'];
        List<PhanAnh> itemsList = [];
        for (var item in data) {
          itemsList.add(PhanAnh.fromJson(item));
        }
        return itemsList;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<LoaiPhanAnh>> getDataLPA() async {
    try {
      final response = await dio.get(
          '$baseUrl/danh-muc/loai-phan-anhs');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        List<LoaiPhanAnh> itemsList = [];
        for (var item in data) {
          itemsList.add(LoaiPhanAnh.fromJson(item));
        }
        return itemsList;
      } else {
        throw Exception('Failed to load items');
      }
    }catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<PhuongXa>> getDataPX() async {
    try {
      final response = await dio.get(
          '$baseUrl/danh-muc/phuong-xas');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        List<PhuongXa> itemsList = [];
        for (var item in data) {
          itemsList.add(PhuongXa.fromJson(item));
        }
        return itemsList;
      } else {
        throw Exception('Failed to load items');
      }
    }catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<Duong>> getDataD(
      {required int phuongXaId}) async {
    try {
      final response = await dio.get(
          '$baseUrl/danh-muc/phuong-xas/$phuongXaId/duongs');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        List<Duong> itemsList = [];
        for (var item in data) {
          itemsList.add(Duong.fromJson(item));
        }
        return itemsList;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<LoaiViPham>> getDataLVP(
      {required int loaiPhanAnhId}) async {
    try {
      final response = await dio.get(
          '$baseUrl/danh-muc/loai-phan-anhs/$loaiPhanAnhId/loai-vi-phams');
      if (response.statusCode == 200) {
        final data = response.data['data'];
        List<LoaiViPham> itemsList = [];
        for (var item in data) {
          itemsList.add(LoaiViPham.fromJson(item));
        }
        return itemsList;
      } else {
        throw Exception('Failed to load items');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
