import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/resources/vegan_icon.dart';

class VeganStatusTextField extends StatefulWidget {
  const VeganStatusTextField({
    required this.controller,
    required this.fieldTitle,
    super.key,
  });

  final TextEditingController controller;
  final String fieldTitle;

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
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldTitle.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 10),
            child: Text(
              widget.fieldTitle,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 12,
              ),
            ),
          ),
        if (widget.fieldTitle.isNotEmpty) const SizedBox(height: 10),
        IField(
          controller: widget.controller,
          hintText: selectedStatus == 'Other' ? 'Type vegan status' : 'Vegan Status',
          keyboardType: TextInputType.text,
          readOnly: selectedStatus != 'Other',
          suffixIcon: DropdownMenu(
            menuStyle: MenuStyle(
              backgroundColor: MaterialStatePropertyAll(
                context.theme.colorScheme.background,
              ),
              surfaceTintColor: MaterialStatePropertyAll(
                context.theme.colorScheme.background,
              ),
            ),
            inputDecorationTheme: InputDecorationTheme(
              contentPadding: EdgeInsets.zero,
              isDense: true,
              iconColor: context.theme.iconTheme.color,
              prefixIconColor: context.theme.iconTheme.color,
              suffixIconColor: context.theme.iconTheme.color,
              border: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(55),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.transparent),
                borderRadius: BorderRadius.circular(55),
              ),
            ),
            dropdownMenuEntries: veganStatusItems
                .map(
                  (e) => DropdownMenuEntry(
                    value: e.title,
                    label: '',
                    labelWidget: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if (e.title == 'Vegan' || e.title == 'Vegetarian' || e.title == 'Non Veg')
                          e.icon
                        else
                          Icon(
                            Icons.add,
                            color: context.theme.iconTheme.color,
                          ),
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
                                        : context.theme.textTheme.bodyMedium?.color,
                          ),
                        ),
                      ],
                    ),
                    // trailingIcon: e.icon,
                  ),
                )
                .toList(),
            onSelected: (value) {
              if (value != null) {
                setState(() {
                  selectedStatus = value;
                  widget.controller.text = value == 'Other' ? '' : value;
                });
              }
            },
          ),
        ),
        SizedBox(
          height: widget.fieldTitle.isNotEmpty ? 30 : 25,
        )
      ],
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
