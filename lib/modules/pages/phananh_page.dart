import 'package:flutter/material.dart';
import 'package:phan_anh/modules/providers/phananh_provider.dart';
import 'package:provider/provider.dart';

import '../modules.dart';

class PhanAnhPage extends StatefulWidget {
  const PhanAnhPage({Key? key}) : super(key: key);

  @override
  State<PhanAnhPage> createState() => _PhanAnhPageState();
}

class _PhanAnhPageState extends State<PhanAnhPage> {
  PhanAnhProvider provider = PhanAnhProvider();

  @override
  void initState() {
    super.initState();
    provider.getPA();
    provider.getDataLPA();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => provider,
      child: Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_sharp),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          title: const Text(
            'Xử lý phản ánh',
            style: TextStyle(color: Colors.white),
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
        ),
        body: Consumer<PhanAnhProvider>(
          builder: (context, value, child) {
            final list = provider.itemListLPA;
            final current = provider.currentIndex;
            if (provider.itemListLPA.isEmpty) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return Column(children: [
                SizedBox(
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
                                  provider.updateCurrent(index);
                                  provider.getPAFilter(index);
                                },
                                child: AnimatedContainer(
                                  duration: const Duration(milliseconds: 100),
                                  margin: const EdgeInsets.all(5),
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 5, vertical: 10),
                                  decoration: BoxDecoration(
                                    color: current == index
                                        ? Colors.white70
                                        : Colors.white54,
                                    borderRadius: current == index
                                        ? BorderRadius.circular(10)
                                        : null,
                                    border: current == index
                                        ? Border.all(
                                            color: Colors.black, width: 1)
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
                        })),
                Expanded(
                  child: BodyBuilder(
                      apiRequestStatus: provider.apiRequestStatus,
                      reload: () {},
                      child: provider.itemList.isNotEmpty ? ListView(
                        controller: provider.controller,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: provider.itemList.length,
                            itemBuilder: (context, index) {
                              return itemPhanAnh(
                                  context: context,
                                  index: index,
                                  provider: provider);
                            },
                          ),
                          const SizedBox(height: 10.0),
                          provider.loadingMore
                              ? SizedBox(
                                  height: 80.0,
                                  child: _buildProgressIndicator(),
                                )
                              : const SizedBox(),
                        ],
                      ) : Column(
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
                              padding:
                              const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                              child: const Text(
                                'Tải lại',
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          )
                        ],
                      )),
                )
              ]);
            }
          },
        ),
      ),
    );
  }

  _buildProgressIndicator() {
    return const LoadingWidget();
  }

  Widget itemPhanAnh(
      {required BuildContext context,
      required int index,
      required PhanAnhProvider provider}) {
    final item = provider.itemList;
    return Container(
            color: Colors.grey,
            child: Card(
              elevation: 2,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  children: [
                    Container(
                      color: Colors.grey,
                      width: 100,
                      height: 100,
                      alignment: Alignment.center,
                      child: const Icon(
                        Icons.error,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      children: [
                        const Text('Ngày phản ánh:'),
                        Text(item[index].ngayPhanAnh ?? '')
                      ],
                    ),
                    const Align(
                        alignment: Alignment.topLeft, child: Text('Địa chỉ:')),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(item[index].diaChi ?? '')),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Hành vi vi phạm:')),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          item[index].loaiViPham!.tenLoaiViPham ?? '',
                          maxLines: 2,
                        )),
                    const Align(
                        alignment: Alignment.topLeft,
                        child: Text('Nội dung phản ánh:')),
                    Align(
                        alignment: Alignment.topLeft,
                        child: Text(item[index].noiDung ?? '')),
                  ],
                ),
              ),
            ),
          );
  }
  // Future<void> bottomSheet() async {
  //   await showModalBottomSheet(
  //       context: context,
  //       isScrollControlled: true,
  //       isDismissible: false,
  //       shape: const RoundedRectangleBorder(
  //           borderRadius: BorderRadius.vertical(
  //             top: Radius.circular(20),
  //           )),
  //       builder: (context) => BottomSheet );
  // }
}
