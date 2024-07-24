import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/i_field.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';

class EnterPasswordDialog extends StatefulWidget {
  const EnterPasswordDialog({super.key});

  @override
  State<EnterPasswordDialog> createState() => _EnterPasswordDialogState();
}

class _EnterPasswordDialogState extends State<EnterPasswordDialog> {
  final textController = TextEditingController();
  bool obscurePassword = true;

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<AuthBloc>(context);

    return BlocListener<AuthBloc, AuthState>(
      listener: (_, state) {
        AuthState previousState = const AuthInitial();
        if (state is AccountDeleted) {
          CoreUtils.showSnackBar(context, 'Account Deleted', durationInMilliSecond: 1500);
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/',
            (route) => false,
          );
        }
        if (state is AuthError) {
          Navigator.of(context).pop();

          CoreUtils.showSnackBar(context, state.message, durationInMilliSecond: 2000);
          previousState = state;
        }
        if (state is AuthLoading) {
          previousState = state;
          CoreUtils.showLoadingDialog(context);
        }
      },
      child: AlertDialog(
        // backgroundColor: Colors.yellow[600],
        backgroundColor: context.theme.cardTheme.color,
        surfaceTintColor: context.theme.cardTheme.color,
        title: Text(
          'Enter Password',
          style: context.theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            fontSize: 14.sp,
          ),
        ),
        content: IField(
          controller: textController,
          hintText: 'Enter Password',
          obscureText: obscurePassword,
          keyboardType: TextInputType.visiblePassword,
          suffixIcon: IconButton(
            onPressed: () => setState(() {
              obscurePassword = !obscurePassword;
            }),
            icon: Icon(
              obscurePassword ? Icons.visibility_outlined : Icons.visibility_off_outlined,
              color: Colors.grey,
            ),
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: Text(
              'CANCEL',
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
              ),
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text(
              'DELETE ACCOUNT',
              style: context.theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w500,
                fontSize: 12.sp,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              // final navigator = Navigator.of(context);
              bloc.add(
                DeleteAccountEvent(
                  password: textController.text.trim(),
                ),
              );
              context.savedProductsProvider.savedProductsList = null;
              context.savedRestaurantsProvider.savedRestaurantsList = null;
            },
          ),
        ],
      ),
    );
  }
}
