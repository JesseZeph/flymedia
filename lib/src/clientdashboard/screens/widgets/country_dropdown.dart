import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class DropDowView<T> extends StatefulWidget {
  const DropDowView(
      {Key? key, this.onSelect, this.initialValue, required this.items})
      : super(key: key);

  final Function(T?)? onSelect;
  final T? initialValue;
  final List<T> items;

  @override
  State<DropDowView<T>> createState() => _DropDowViewState<T>();
}

class _DropDowViewState<T> extends State<DropDowView<T>> {
  T? selectedValue;
  TextEditingController searchController = TextEditingController();
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
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
                contentPadding: EdgeInsets.only(left: 10.w, top: 15.h),
              ),
              child: Text(
                selectedValue?.toString() ?? '',
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          if (isMenuOpen)
            Container(
              constraints: BoxConstraints(
                maxHeight: Get.height.h * 0.1,
              ),
              child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.items
                        .where((item) => item
                            .toString()
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()))
                        .map((T value) {
                      return ListTile(
                        title: Text(value.toString()),
                        onTap: () {
                          setState(() {
                            selectedValue = value;
                            isMenuOpen = false;
                          });
                          if (widget.onSelect != null) {
                            widget.onSelect!(value);
                          }
                        },
                      );
                    }).toList(),
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

List<String> countriesList = <String>[
  "Singapore",
];

List<String> countryCode = <String>[
  "+65",
];

class DropDownWidget extends StatefulWidget {
  const DropDownWidget({Key? key, this.onSelect, this.initialValue})
      : super(key: key);
  final Function(String?)? onSelect;
  final String? initialValue;

  @override
  State<DropDownWidget> createState() => _DropDownWidgetState();
}

class _DropDownWidgetState extends State<DropDownWidget> {
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

class CountryCode<T> extends StatefulWidget {
  const CountryCode(
      {Key? key, this.onSelect, this.initialValue, required this.items})
      : super(key: key);

  final Function(T?)? onSelect;
  final T? initialValue;
  final List<T> items;

  @override
  State<CountryCode<T>> createState() => _CountryCodeState<T>();
}

class _CountryCodeState<T> extends State<CountryCode<T>> {
  T? selectedValue;
  TextEditingController searchController = TextEditingController();
  bool isMenuOpen = false;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: Get.width.w * 0.20,
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
                // suffixIcon: Icon(
                //   isMenuOpen : null,
                // ),
                contentPadding: EdgeInsets.only(left: 20.w, top: 5.h),
              ),
              child: Text(
                selectedValue?.toString() ?? '',
                style: const TextStyle(
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ),
          ),
          if (isMenuOpen)
            Container(
              constraints: BoxConstraints(
                maxHeight: Get.height.h * 0.05,
              ),
              child: ListView(
                children: [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: widget.items
                        .where((item) => item
                            .toString()
                            .toLowerCase()
                            .contains(searchController.text.toLowerCase()))
                        .map((T value) {
                      return ListTile(
                        title: Text(value.toString()),
                        onTap: () {
                          setState(() {
                            selectedValue = value;
                            isMenuOpen = false;
                          });
                          if (widget.onSelect != null) {
                            widget.onSelect!(value);
                          }
                        },
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
        ],
      ),
    );
  }
}
