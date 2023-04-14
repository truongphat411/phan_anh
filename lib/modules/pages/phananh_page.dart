import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:intl/intl.dart';
import 'package:phan_anh/modules/components/dialog_picker.dart';
import 'package:phan_anh/services/enum/api_request_status.dart';
import 'package:provider/provider.dart';

import '../../utils/utils.dart';
import '../modules.dart';

class PhanAnhPage extends StatefulWidget {
  const PhanAnhPage({Key? key}) : super(key: key);

  @override
  State<PhanAnhPage> createState() => _PhanAnhPageState();
}

class _PhanAnhPageState extends State<PhanAnhPage> {
  @override
  void initState() {
    super.initState();
    SchedulerBinding.instance.addPostFrameCallback(
      (_) {
        Provider.of<PhanAnhProvider>(context, listen: false).getPA();
        Provider.of<PhanAnhProvider>(context, listen: false).getData();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    Filter filter = Filter();
    List<LoaiPhanAnh> listLPA = [];
    return Scaffold(
      appBar: appBar(context, filter,listLPA),
      body: Consumer<PhanAnhProvider>(
        builder: (context, provider, child) {
          if (provider.loadLPA) {
            return const Center(child: LoadingWidget());
          } else {
            listLPA = provider.itemListLPA;
            return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  tabBar(provider, filter),
                  Consumer<PhanAnhProvider>(
                    builder: (context, provider, child) {
                      return Expanded(child: bodyList(provider));
                    },
                  )
                ]);
          }
        },
      ),
    );
  }

  PreferredSizeWidget appBar(BuildContext context, Filter filter,List<LoaiPhanAnh> listLPA) {
    return AppBar(
      backgroundColor: ColorSelect.mainColor,
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_rounded),
        onPressed: () {
          Navigator.pop(context);
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
            bottomSheet(filter,listLPA);
          },
        ),
      ],
    );
  }

  Widget tabBar(PhanAnhProvider provider, Filter filter) {
    final list = provider.itemListLPA;
    final current = provider.currentIndex;
    return SizedBox(
        height: 60,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      LoaiPhanAnh lpa = provider.itemListLPA.firstWhere(
                          (element) => element.loaiPhanAnhId == index);
                      filter.phananh = lpa;
                      provider.updateCurrent(index);
                      provider.getPAFilter(filter);
                      print('PhatNMT-debug-filter:${filter.phananh}');
                    },
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.all(5),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 10),
                      decoration: BoxDecoration(
                        color: current == index
                            ? ColorSelect.statusBarColor
                            : Colors.white,
                        borderRadius: current == index
                            ? BorderRadius.circular(100)
                            : null,
                      ),
                      child: Center(
                        child: Text(
                          list[index].tenLoaiPhanAnh ?? '',
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ),
                ],
              );
            }));
  }

  Widget bodyList(PhanAnhProvider provider) {
    if (provider.loadPA) {
      return const Center(
        child: LoadingWidget(),
      );
    } else {
      return Container(
        color: ColorSelect.backGroundColor,
        child: provider.itemList.isNotEmpty
            ? ListView(
                controller: provider.controller,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: provider.itemList.length,
                    itemBuilder: (context, index) {
                      return itemPhanAnh(
                          context: context, index: index, provider: provider);
                    },
                  ),
                  const SizedBox(height: 10.0),
                  provider.loadingMore
                      ? const SizedBox(
                          height: 80.0,
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : const SizedBox(),
                ],
              )
            : Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Không có phản ánh',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text('Hiện không có phản ánh nào',
                        style: TextStyle(
                          fontSize: 14,
                        )),
                    const SizedBox(
                      height: 20,
                    ),
                    InkWell(
                      child: Container(
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            color: ColorSelect.statusBarColor),
                        padding: const EdgeInsets.symmetric(
                            vertical: 10, horizontal: 28),
                        child: Text(
                          'Tải lại',
                          style: TextStyle(
                              color: ColorSelect.mainColor,
                              fontWeight: FontWeight.w900),
                        ),
                      ),
                    )
                  ],
                ),
              ),
      );
    }
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
      shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      elevation: 2,
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: Column(
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(10)),
              color: ColorSelect.mainColor,
            ),
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

  Future<void> bottomSheet(Filter filter,List<LoaiPhanAnh> listLPA) async {
    await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        isDismissible: false,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
          top: Radius.circular(20),
        )),
        builder: (context) => BottomSheetPA(
              filter: filter,
              listLPA: listLPA,
            ));
  }
}
