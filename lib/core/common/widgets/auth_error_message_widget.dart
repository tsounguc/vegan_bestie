// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
//
// import '../../../features/auth/presentation/auth_cubit/auth_cubit.dart';
//
// class AuthErrorMessageWidget extends StatelessWidget {
//   const AuthErrorMessageWidget({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<AuthCubit, AuthState>(builder: (context, state) {
//       if (state is AuthErrorState && state.error != null) {
//         return Card(
//           margin: EdgeInsets.symmetric(vertical: 15),
//           elevation: 2,
//           color: Colors.white,
//           child: SizedBox(
//             height: 100,
//             child: Row(
//               mainAxisAlignment: MainAxisAlignment.start,
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 VerticalDivider(
//                   color: Colors.red,
//                   width: 5,
//                   thickness: 5,
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//                 Expanded(
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       const Padding(
//                         padding: EdgeInsets.only(top: 8.0, bottom: 3.0),
//                         child: Text(
//                           "ERROR",
//                           style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
//                         ),
//                       ),
//                       Flexible(
//                         child: Text(
//                           state.error,
//                           // style: TextStyle(fontSize: 12),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//                 SizedBox(
//                   width: 15,
//                 ),
//               ],
//             ),
//           ),
//         );
//       }
//       return SizedBox(
//           // height: 140,
//           );
//     });
//   }
// }
