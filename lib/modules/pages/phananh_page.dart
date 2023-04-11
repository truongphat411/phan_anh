import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:phan_anh/modules/providers/phananh_provider.dart';
import 'package:provider/provider.dart';

import '../../services/enum/enum.dart';
import '../../utils/utils.dart';
import '../modules.dart';

class PhanAnhPage extends StatefulWidget {
  const PhanAnhPage({Key? key}) : super(key: key);

  @override
  State<PhanAnhPage> createState() => _PhanAnhPageState();
}

class _PhanAnhPageState extends State<PhanAnhPage>
    with SingleTickerProviderStateMixin {
  late final TabController tabController;
  late final PhanAnhProvider provider;
  List<Tab> tabList = [];

  @override
  void initState() {
    super.initState();
    provider = Provider.of<PhanAnhProvider>(context, listen: false);
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        provider.getPA();
      },
    );
    provider.getDataLPA().then((_) {
      tabController = TabController(length: provider.itemListLPA.length, vsync: this);
    });
  }


  @override
  Widget build(BuildContext context) {
    return Consumer<PhanAnhProvider>(
      builder: (context, provider, child) {
        if(provider.apiRequestStatus == APIRequestStatus.loaded){
          return DefaultTabController(
            length: provider.itemListLPA.length,
            child: Scaffold(
                appBar: appBar(provider),
                body: Column(children: [
                  tabBar(provider),
                  Expanded(child: bodyList(provider))
                ])),
          );
        }else if(provider.apiRequestStatus == APIRequestStatus.loading){
            return _buildProgressIndicator();
        }else {
          return _buildProgressIndicator();
        }
      },
    );
  }

  _buildProgressIndicator() {
    return const LoadingWidget();
  }

  PreferredSizeWidget appBar(PhanAnhProvider provider) {
    return AppBar(
      backgroundColor: ColorSelect.mainColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.of(context).pop();
        },
      ),
      title: Text(
        'Xử lý',
        style: TextStyle(color: ColorSelect.primaryColor),
      ),
      centerTitle: true,
      actions: [
        IconButton(
          icon: const Icon(Icons.filter_alt_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ],
    );
  }

  // Widget tabBar(List<LoaiPhanAnh> list, int current, PhanAnhProvider provider) {
  //   return SizedBox(
  //       height: 60,
  //       child: ListView.builder(
  //           shrinkWrap: true,
  //           itemCount: list.length,
  //           scrollDirection: Axis.horizontal,
  //           itemBuilder: (context, index) {
  //             return Column(
  //               children: [
  //                 GestureDetector(
  //                   onTap: () {
  //                     provider.updateCurrent(index);
  //                     provider.getPAFilter(index);
  //                   },
  //                   child: AnimatedContainer(
  //                     duration: const Duration(milliseconds: 100),
  //                     margin: const EdgeInsets.all(5),
  //                     padding: const EdgeInsets.symmetric(
  //                         horizontal: 10, vertical: 10),
  //                     decoration: BoxDecoration(
  //                       color: current == index
  //                           ? ColorSelect.statusBarColor
  //                           : Colors.white,
  //                       borderRadius: current == index
  //                           ? BorderRadius.circular(100)
  //                           : null,
  //                     ),
  //                     child: Center(
  //                       child: Text(
  //                         list[index].tenLoaiPhanAnh ?? '',
  //                         maxLines: 1,
  //                       ),
  //                     ),
  //                   ),
  //                 ),
  //               ],
  //             );
  //           }));
  // }
  Widget tabBar(PhanAnhProvider provider) {
    return SizedBox(
        height: 60,
        child: TabBar(
          controller: tabController,
          tabs: provider.itemListLPA.map((e) => itemLPA(e, provider)).toList(),
        )
    );
  }


  Widget itemLPA(LoaiPhanAnh item, PhanAnhProvider provider) {
    int current = 0;
    return GestureDetector(
      onTap: () {
        provider.updateCurrent(item.loaiPhanAnhId!);
        provider.getPAFilter(item.loaiPhanAnhId!);
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 100),
        margin: const EdgeInsets.all(5),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          color: current == item.loaiPhanAnhId
              ? ColorSelect.statusBarColor
              : Colors.white,
          borderRadius:
              current == item.loaiPhanAnhId ? BorderRadius.circular(100) : null,
        ),
        child: Center(
          child: Text(
            item.tenLoaiPhanAnh ?? '',
            maxLines: 1,
          ),
        ),
      ),
    );
  }

  Widget bodyList(PhanAnhProvider provider) {
    return BodyBuilder(
        apiRequestStatus: provider.apiRequestStatus,
        reload: () {},
        child: provider.itemList.isNotEmpty
            ? TabBarView(
            controller: tabController,
            children: provider.itemListLPA.map((e) => itemPhanAnh(context: context, index: e.loaiPhanAnhId!, provider: provider)).toList())
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Hiện chưa có dữ liệu'),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            color: Colors.blue),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 20),
                        child: const Text(
                          'Tải lại',
                          style: TextStyle(color: Colors.white),
                        ),
                      ),
                    )
                  ],
                ),
              ));
  }

  Widget itemPhanAnh(
      {required BuildContext context,
      required int index,
      required PhanAnhProvider provider}) {
    final item = provider.itemList;
    final itemImage = item[index].tepDinhKems?[0].duongDan;
    String dateString = item[index].ngayPhanAnh ?? '';
    DateTime date = DateTime.parse(dateString);
    String formattedDate = DateFormat('HH:mm dd/MM/yyyy').format(date);
    return Card(
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            color: ColorSelect.mainColor,
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Nội dung phản ánh',
                  style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: ColorSelect.primaryColor),
                ),
                Icon(
                  Icons.more_horiz_outlined,
                  color: ColorSelect.primaryColor,
                )
              ],
            ),
          ),
          SizedBox(
            height: 100,
            width: 100,
            child: Image.network(
              'http://demo.vietinfo.tech:9998/BinhThanh/Website$itemImage',
              errorBuilder: (BuildContext context, Object exception,
                  StackTrace? stackTrace) {
                return Container(
                  color: Colors.grey,
                  alignment: Alignment.center,
                  child: const Icon(
                    Icons.error,
                    color: Colors.white,
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Column(
              children: [
                Row(
                  children: [
                    const Text(
                      'Ngày phản ánh: ',
                      style: TextStyle(fontSize: 14),
                    ),
                    Text(
                      formattedDate,
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    )
                  ],
                ),
                Row(
                  children: [
                    const Text(
                      'Hành vi vi phạm: ',
                      style: TextStyle(fontSize: 14),
                    ),
                    Flexible(
                      child: Text(
                        item[index].loaiViPham!.tenLoaiViPham ?? '',
                        style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.red,
                            overflow: TextOverflow.ellipsis),
                      ),
                    )
                  ],
                ),
                const Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      'Nội dung phản ánh: ',
                      style: TextStyle(fontSize: 14),
                    )),
                Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      item[index].noiDung ?? '',
                      style: const TextStyle(
                          fontSize: 16, fontWeight: FontWeight.w500),
                    )),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
            child: Align(
              alignment: Alignment.bottomRight,
              child: Text(
                  item[index].tinhTrangPhanAnh?.tenTinhTrangCongChuc ?? '',
                  style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: ColorSelect.mainColor)),
            ),
          )
        ],
      ),
    );
  }

  Future<void> bottomSheet() async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (context) => const BottomSheetPA());
  }
}
