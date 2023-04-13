import 'package:flutter/material.dart';

import '../../utils/utils.dart';
import '../modules.dart';

class DialogPicker extends StatefulWidget {
  DialogPicker({Key? key, required this.tittle, required this.list})
      : super(key: key);
  String tittle;
  List<ItemPicker> list;

  @override
  State<DialogPicker> createState() => _DialogPickerState();
}

class _DialogPickerState extends State<DialogPicker> {
  FocusNode focusNode = FocusNode();
  bool isFocused = false;

  @override
  void initState() {
    super.initState();
    focusNode.addListener(() {
      setState(() {
        isFocused = focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: GestureDetector(
        onTap: () {
          focusNode.unfocus();
        },
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.tittle,
                    style: const TextStyle(fontSize: 16),
                  ),
                  InkWell(
                    onTap: () {},
                    child: Container(
                        padding: const EdgeInsets.all(10),
                        child: Text(
                          'Hủy',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              color: ColorSelect.mainColor,
                              fontSize: 16),
                        )),
                  )
                ],
              ),
              const SizedBox(height: 16),
              Stack(
                alignment: Alignment.center,
                children: <Widget>[
                  TextField(
                    focusNode: focusNode,
                    cursorColor: ColorSelect.mainColor,
                    decoration: InputDecoration(
                      hintText: 'Tìm kiếm',
                      prefixIcon: Icon(Icons.search,
                          color: isFocused ? ColorSelect.mainColor : null),
                      prefixIconColor: ColorSelect.mainColor,
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide(color: ColorSelect.mainColor),
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 300,
                child: ListView.builder(
                  itemCount: widget.list.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(8),
                      child: InkWell(
                        onTap: () {},
                        child: Text(
                          widget.list[index].name ?? '',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    );
                  },
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
