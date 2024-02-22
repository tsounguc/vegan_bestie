import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/common/widgets/buttons.dart';
import '../../../../core/common/screens/loading/loading.dart';
import '../../../auth/presentation/auth_cubit/auth_cubit.dart';
import 'components/profile_widget.dart';

class EditProfilePage extends StatefulWidget {
  static const String id = "/editProfilePage";

  const EditProfilePage({Key? key}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  TextEditingController _nameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _bioController = TextEditingController();
  bool isFirstTimeLoaded = false;

  @override
  void initState() {
    super.initState();
    setState(() {
      isFirstTimeLoaded = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthCubit, AuthState>(
      builder: (context, state) {
        if (state is LoggedInState) {
          if (isFirstTimeLoaded) {
            // setState(() {
            isFirstTimeLoaded = false;
            // });
            _nameController.text = state.currentUser?.name ?? "";
            _emailController.text = state.currentUser?.email ?? "";
            _bioController.text = state.currentUser?.bio ?? "";
          }
          return GestureDetector(
            onTap: () {
              FocusScope.of(context).requestFocus(new FocusNode());
            },
            child: Scaffold(
              key: _scaffoldKey,
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back, color: Colors.white),
                ),
                title: Text(
                  state.currentUser?.name ?? "",
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
                centerTitle: true,
              ),
              backgroundColor: Theme.of(context).colorScheme.background,
              body: ListView(
                padding: EdgeInsets.symmetric(horizontal: 48, vertical: 16),
                physics: BouncingScrollPhysics(),
                children: [
                  ProfileWidget(isOnEditProfilePage: true),
                  Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 50,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Full Name",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _nameController,
                          validator: (userNameText) {
                            if (userNameText!.isEmpty) {
                              return 'Please enter name';
                            }
                            return null;
                          },
                          // onChanged: (input) => _userName = input,
                          autofocus: false,
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(_formKey.currentContext!).nextFocus();
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Name",
                            hintStyle: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            // floatingLabelStyle: TextStyle(
                            //   color: Colors.white,
                            //   fontSize: 20.sp,
                            //   fontWeight: FontWeight.bold,
                            // ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "Email",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _emailController,
                          validator: (emailText) {
                            if (emailText!.isEmpty) {
                              return 'Please enter a valid email';
                            }
                            return null;
                          },
                          // onChanged: (input) => _email = input,
                          autofocus: false,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () {
                            FocusScope.of(_formKey.currentContext!).nextFocus();
                          },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Email",
                            hintStyle: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                          ),
                        ),
                        SizedBox(
                          height: 25,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 8.0),
                          child: Text(
                            "About",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        TextFormField(
                          controller: _bioController,
                          validator: (bioText) {
                            // if (emailText!.isEmpty) {
                            //   return 'Please enter a valid email';
                            // }
                            return null;
                          },
                          // onChanged: (input) => _email = input,
                          maxLines: 5,
                          maxLength: null,
                          autofocus: false,
                          keyboardType: TextInputType.text,
                          // textInputAction: TextInputAction.next,
                          // onEditingComplete: () {
                          //   FocusScope.of(_formKey.currentContext!).nextFocus();
                          // },
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Colors.white70,
                            hintText: "Tell us about yourself",
                            hintStyle: TextStyle(
                              color: Colors.green.shade900,
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            floatingLabelStyle: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.bold,
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                              borderRadius: BorderRadius.circular(15),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                          ),
                        ),
                        SizedBox(height: 40),
                        LongButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              // BlocProvider.of<AuthCubit>(context).update(_nameController.text, _emailController.text, _bioController.text);
                            }
                          },
                          text: "Save",
                        ),
                        SizedBox(height: 40),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
        return LoadingPage();
      },
    );
  }
}
