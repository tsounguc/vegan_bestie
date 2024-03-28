

// class AuthPage extends StatefulWidget {
//   static const String id = "/authPage";
//
//   const AuthPage({Key? key}) : super(key: key);
//
//   @override
//   State<AuthPage> createState() => _AuthPageState();
// }

// class _AuthPageState extends State<AuthPage> {
//   User? user;
//   AuthState? previousState;
//   Widget? currentPage;
//
//   @override
//   void initState() {
//     // `TODO`: implement initState
//     super.initState();
//     user = FirebaseAuth.instance.currentUser;
//     // BlocProvider.of<AuthCubit>(context).currentUser();
//     FirebaseAuth.instance.authStateChanges().listen((currentUser) {
//       if (currentUser != null) {
//         // if (mounted) {
//         // BlocProvider.of<AuthBloc>(context).currentUser();
//         // }
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     var currentUser = FirebaseAuth.instance.currentUser;
//     if (user?.uid != currentUser?.uid) {
//       BlocProvider.of<AuthBloc>(context).currentUser();
//     }
//     return BlocBuilder<AuthBloc, AuthState>(
//       builder: (context, state) {
//         if (state is LoggedInState || state is ContinueAsGuestState) {
//           previousState = state;
//           currentPage = HomePage();
//           return HomePage();
//         } else if (state is SignedOutState) {
//           previousState = SignedOutState();
//           currentPage = LoginPage();
//           return LoginPage();
//         } else if (state is RegisterState) {
//           previousState = RegisterState();
//           currentPage = RegistrationPage();
//           return RegistrationPage();
//         } else if (state is ForgotPasswordState) {
//           previousState = ForgotPasswordState();
//           currentPage = ForgotPasswordPage();
//           return ForgotPasswordPage();
//         } else if (state is AuthInitialState) {
//           previousState = state;
//           currentPage = WelcomePage();
//           return WelcomePage();
//         } else {
//           return currentPage!;
//         }
//         // return LoginPage();
//       },
//     );
//   }
// }
