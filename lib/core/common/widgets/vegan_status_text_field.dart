import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/vegan_icon.dart';

class VeganStatusTextField extends StatefulWidget {
  VeganStatusTextField({required this.controller, super.key});

  final TextEditingController controller;

  @override
  State<VeganStatusTextField> createState() => _VeganStatusTextFieldState();
}

class _VeganStatusTextFieldState extends State<VeganStatusTextField> {
  String selectedStatus = '';

  final veganStatusItems = [
    const VeganStatusItem(
      title: 'Vegan',
      icon: Icon(
        VeganIcon.veganIcon,
        color: Colors.green,
      ),
    ),
    const VeganStatusItem(
      title: 'Vegetarian',
      icon: Icon(
        VeganIcon.veganIcon,
        color: Colors.purple,
      ),
    ),
    const VeganStatusItem(
      title: 'Non Veg',
      icon: Icon(
        Icons.lunch_dining,
        color: Colors.red,
      ),
    ),
    const VeganStatusItem(
      title: 'Other',
      icon: Icon(Icons.add),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return IField(
      controller: widget.controller,
      hintText: selectedStatus == 'Other' ? 'Type vegan status' : 'Vegan Status',
      keyboardType: TextInputType.text,
      readOnly: selectedStatus != 'Other',
      suffixIcon: DropdownMenu(
        inputDecorationTheme: const InputDecorationTheme(
          isDense: true,
        ),
        dropdownMenuEntries: veganStatusItems
            .map(
              (e) => DropdownMenuEntry(
                value: e.title,
                label: '',
                labelWidget: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    e.icon,
                    const SizedBox(width: 20),
                    Text(
                      e.title,
                      style: TextStyle(
                          color: e.title == 'Vegan'
                              ? Colors.green
                              : e.title == 'Vegetarian'
                                  ? Colors.purple
                                  : e.title == 'Non Veg'
                                      ? Colors.red
                                      : null),
                    ),
                  ],
                ),
                // trailingIcon: e.icon,
              ),
            )
            .toList(),
        menuStyle: MenuStyle(surfaceTintColor: MaterialStatePropertyAll(context.theme.colorScheme.background)),
        onSelected: (value) {
          if (value != null) {
            setState(() {
              selectedStatus = value;
              widget.controller.text = value == 'Other' ? '' : value;
            });
          }
        },
      ),
    );
  }
}

class VeganStatusItem extends Equatable {
  const VeganStatusItem({
    required this.title,
    required this.icon,
  });

  final String title;
  final Icon icon;

  @override
  List<Object?> get props => [title, icon];
}
