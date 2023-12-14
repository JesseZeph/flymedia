import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DropDowView extends StatefulWidget {
  const DropDowView({Key? key, this.onSelect, this.initialValue})
      : super(key: key);
  final Function(String?)? onSelect;
  final String? initialValue;

  @override
  State<DropDowView> createState() => _DropDowViewState();
}

class _DropDowViewState extends State<DropDowView> {
  String? selectedFollowing;
  TextEditingController searchController = TextEditingController();
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    selectedFollowing = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 325.w,
      margin: EdgeInsets.only(top: 10.h),
      decoration: BoxDecoration(
        border: Border.all(
          width: 1,
          color: Colors.grey.withOpacity(0.5),
        ),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              setState(() {
                isMenuOpen = !isMenuOpen;
              });
            },
            child: InputDecorator(
              decoration: InputDecoration(
                border: InputBorder.none,
                suffixIcon: Icon(
                  isMenuOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
                ),
                contentPadding: EdgeInsets.only(left: 10.w, top: 10.h),
              ),
              child: Text(
                selectedFollowing ?? '',
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          if (isMenuOpen)
            SizedBox(
              height: 250.h,
              child: Column(
                children: [
                  Expanded(
                    child: ListView(
                      children: viewsList
                          .where((city) => city
                              .toLowerCase()
                              .contains(searchController.text.toLowerCase()))
                          .map((String value) {
                        return ListTile(
                          title: Text(value),
                          onTap: () {
                            setState(() {
                              selectedFollowing = value;
                              isMenuOpen = false;
                            });
                            if (widget.onSelect != null) {
                              widget.onSelect!(value);
                            }
                          },
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}

List<String> viewsList = <String>[
  "10k - 50k",
  "50k - 200k",
  "200k - 500k",
  "500k - 1m",
  "1m and above"
];
