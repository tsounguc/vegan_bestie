import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sheveegan/core/common/widgets/buttons.dart';
import 'package:sheveegan/core/extensions/context_extension.dart';
import 'package:sheveegan/core/utils/core_utils.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/profile/presentation/widgets/send_email_form_field.dart';

class ContactSupportScreen extends StatefulWidget {
  const ContactSupportScreen({super.key});

  static const String id = '/contactSupportScreen';

  @override
  State<ContactSupportScreen> createState() => _ContactSupportScreenState();
}

class _ContactSupportScreenState extends State<ContactSupportScreen> {
  // final TextEditingController _toController = TextEditingController();

  final TextEditingController subjectController = TextEditingController();

  final TextEditingController bodyController = TextEditingController();

  void sendEmail(BuildContext context) {
    context.read<AuthBloc>().add(
          SendEmailEvent(
            subject: subjectController.text.trim(),
            body: '${bodyController.text.trim()} '
                '\nFrom: ${context.currentUser?.name ?? ''} '
                '${context.currentUser?.email ?? ''}',
          ),
        );
  }

  bool get subjectEntered => subjectController.text.trim().isNotEmpty;

  bool get bodyEntered => bodyController.text.trim().isNotEmpty;

  bool get canSend => subjectEntered && bodyEntered;

  @override
  void dispose() {
    subjectController.dispose();
    bodyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthError) {
          CoreUtils.showSnackBar(
            context,
            state.message,
          );
        }
        if (state is EmailSent) {
          CoreUtils.showSnackBar(
            context,
            'Email sent',
          );
          Navigator.of(context).pushNamedAndRemoveUntil(
            '/',
            (route) => false,
          );
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Contact Support'),
          ),
          body: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SendEmailFormField(
                  fieldTitle: 'Subject',
                  hintText: 'Subject',
                  controller: subjectController,
                  borderRadius: BorderRadius.circular(20),
                ),
                SendEmailFormField(
                  fieldTitle: 'Message',
                  hintText: 'Message',
                  controller: bodyController,
                  borderRadius: BorderRadius.circular(20),
                  minLines: 4,
                  maxLines: null,
                  // textInputAction: TextInputAction.send,
                ),
                const SizedBox(height: 25),
                Center(
                  child: Text(
                    'You will receive update via email',
                    style: TextStyle(
                      fontSize: 12.sp,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                StatefulBuilder(
                  builder: (context, refresh) {
                    subjectController.addListener(() => refresh(() {}));
                    bodyController.addListener(() => refresh(() {}));
                    return state is SendingEmail
                        ? const Center(child: CircularProgressIndicator())
                        : LongButton(
                            onPressed: !canSend ? null : () => sendEmail(context),
                            label: 'Save',
                            backgroundColor:
                                !canSend ? Colors.grey : Theme.of(context).buttonTheme.colorScheme?.primary,
                            textColor: Colors.white,
                          );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
