import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/buttons.dart';
import '../../../../core/common/widgets/custom_back_button.dart';
import '../../../../core/constants/size_config.dart';
import '../../../../core/common/widgets/vegan_bestie_logo_widget.dart';

class SelectIncorrectInformation extends StatefulWidget {
  static const String id = "/SelectIncorrectInformation";

  const SelectIncorrectInformation({Key? key}) : super(key: key);

  @override
  State<SelectIncorrectInformation> createState() => _SelectIncorrectInformationState();
}

class _SelectIncorrectInformationState extends State<SelectIncorrectInformation> {
  List<IncorrectInformation> items = [
    IncorrectInformation(isSelected: false, information: "Image"),
    IncorrectInformation(isSelected: false, information: "Name"),
    IncorrectInformation(isSelected: false, information: "Nutrition Facts"),
    IncorrectInformation(isSelected: false, information: "Ingredients"),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: 80,
        toolbarHeight: toolbarHeight,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        leading: CustomBackButton(
          color: Colors.black,
        ),
        title: SizedBox(
          width: MediaQuery.of(context).size.width * 0.5,
          child: VeganBestieLogoWidget(size: 25, fontSize: 35),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 50, horizontal: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Text(
                  "Select incorrect information",
                  style: TextStyle(color: Colors.black, fontSize: 20.sp, overflow: TextOverflow.ellipsis),
                ),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return CheckboxListTile(
                  title: Text(
                    items[index].information,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                  value: items[index].isSelected,
                  onChanged: (bool? value) {
                    setState(() {
                      items[index].isSelected = !items[index].isSelected;
                    });
                  },
                );
              },
            ),
            Spacer(),
            LongButton(onPressed: () {}, text: "Next"),
          ],
        ),
      ),
    );
  }
}

class IncorrectInformation {
  bool isSelected;
  String information;

  IncorrectInformation({required this.isSelected, required this.information});
}
