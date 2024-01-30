import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flymedia_app/constants/colors.dart';

import 'country_dropdown.dart';

class RadioButtonsTile extends StatefulWidget {
  const RadioButtonsTile({
    Key? key,
  }) : super(key: key);

  @override
  RadioButtonsTileState createState() => RadioButtonsTileState();
}

class RadioButtonsTileState extends State<RadioButtonsTile> {
  int? _radioValue; // To keep track of the selected radio button value

  @override
  void initState() {
    super.initState();
    _radioValue = 1; // Set the default value to "Yes"
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Row(
              children: [
                Radio(
                  value: 1,
                  activeColor: AppColors.mainColor,
                  groupValue: _radioValue,
                  onChanged: (value) {
                    setState(() {
                      _radioValue = value;
                    });
                  },
                ),
                Text(
                  "Yes",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            SizedBox(width: 20.w),
            Row(
              children: [
                Radio(
                  value: 2,
                  activeColor: AppColors.mainColor,
                  groupValue: _radioValue,
                  onChanged: (value) {
                    setState(() {
                      _radioValue = value;
                    });
                  },
                ),
                Text(
                  "No",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
        if (_radioValue == 2)
          Column(
            children: [
              Container(
                width: 325.w,
                margin: EdgeInsets.only(top: 30.h),
                child: Text('Select Country',
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        fontSize: 14.sp, fontWeight: FontWeight.w400)),
              ),
              Container(
                padding: EdgeInsets.only(top: 2.h),
                child: const DropDownWidget(),
              ),
            ],
          ),
      ],
    );
  }
}
