import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:sheveegan/core/failures_successes/failures.dart';
import 'package:sheveegan/features/auth/domain/entities/user_entity.dart';
import 'package:sheveegan/features/auth/domain/usecases/create_with_email_and_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/delete_account.dart';
import 'package:sheveegan/features/auth/domain/usecases/delete_profile_picture.dart';
import 'package:sheveegan/features/auth/domain/usecases/forgot_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/get_current_user.dart';
import 'package:sheveegan/features/auth/domain/usecases/sign_in_with_email_and_password.dart';
import 'package:sheveegan/features/auth/domain/usecases/update_user.dart';
import 'package:sheveegan/features/auth/presentation/auth_bloc/auth_bloc.dart';
import 'package:sheveegan/features/auth/domain/usecases/send_email.dart';

class MockSignInWithEmailAndPassword extends Mock implements SignInWithEmailAndPassword {}

class MockCreateUserAccount extends Mock implements CreateUserAccount {}

class MockForgotPassword extends Mock implements ForgotPassword {}

class MockUpdateUser extends Mock implements UpdateUser {}

class MockDeleteProfilePicture extends Mock implements DeleteProfilePicture {}

class MockDeleteAccount extends Mock implements DeleteAccount {}

class MockGetCurrentUser extends Mock implements GetCurrentUser {}

class MockSendEmail extends Mock implements SendEmail {}

void main() {
  late SignInWithEmailAndPassword signInWithEmailAndPassword;
  late CreateUserAccount createUserAccount;
  late ForgotPassword forgotPassword;
  late UpdateUser updateUser;
  late SendEmail sendEmail;
  late DeleteProfilePicture deleteProfilePicture;
  late DeleteAccount deleteAccount;
  late GetCurrentUser getCurrentUser;
  late AuthBloc bloc;

  late SignInParams testSignInParams;
  late CreateUserAccountParams testCreateUserAccountParams;
  late UpdateUserParams testUpdateUserParams;

  late SignInWithEmailAndPasswordFailure testSignInFailure;
  late CreateWithEmailAndPasswordFailure testCreateUserAccountFailure;
  late ForgotPasswordFailure testForgotPasswordFailure;
  late UpdateUserDataFailure testUpdateUserFailure;
  setUp(() {
    signInWithEmailAndPassword = MockSignInWithEmailAndPassword();
    createUserAccount = MockCreateUserAccount();
    forgotPassword = MockForgotPassword();
    updateUser = MockUpdateUser();
    sendEmail = MockSendEmail();
    deleteProfilePicture = MockDeleteProfilePicture();
    deleteAccount = MockDeleteAccount();
    getCurrentUser = MockGetCurrentUser();

    bloc = AuthBloc(
      signInWithEmailAndPassword: signInWithEmailAndPassword,
      createUserAccount: createUserAccount,
      forgotPassword: forgotPassword,
      sendEmail: sendEmail,
      updateUser: updateUser,
      deleteProfilePic: deleteProfilePicture,
      deleteAccount: deleteAccount,
      getCurrentUser: getCurrentUser,
    );

    testSignInFailure = SignInWithEmailAndPasswordFailure(
      message: 'message',
      statusCode: 500,
    );
    testCreateUserAccountFailure = CreateWithEmailAndPasswordFailure(
      message: 'message',
      statusCode: 500,
    );

    testForgotPasswordFailure = ForgotPasswordFailure(
      message: 'message',
      statusCode: 500,
    );

    testUpdateUserFailure = UpdateUserDataFailure(
      message: 'message',
      statusCode: 500,
    );
  });

  setUpAll(() {
    testSignInParams = const SignInParams.empty();
    testCreateUserAccountParams = const CreateUserAccountParams.empty();
    testUpdateUserParams = const UpdateUserParams.empty();
    registerFallbackValue(testSignInParams);
    registerFallbackValue(testCreateUserAccountParams);
    registerFallbackValue(testUpdateUserParams);
  });

  tearDown(() => bloc.close());

  test(
      'given AuthBloc '
      'when bloc is instantiated '
      'then initial state should be [AuthInitial] ', () async {
    // Arrange
    // Act
    // Assert
    expect(bloc.state, const AuthInitial());
  });
  const testUser = UserEntity.empty();

  group('signInWithEmailAndPassword - ', () {
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.signInWithEmailAndPassword] is called '
      'and completed successfully '
      'then emit [AuthLoading, SignedIn]',
      build: () {
        when(
          () => signInWithEmailAndPassword(any()),
        ).thenAnswer((_) async => const Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInWithEmailAndPasswordEvent(
          email: testSignInParams.email,
          password: testSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedIn(testUser),
      ],
      verify: (bloc) {
        verify(() => signInWithEmailAndPassword(testSignInParams)).called(1);
        verifyNoMoreInteractions(signInWithEmailAndPassword);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.signInWithEmailAndPassword] is called unsuccessful '
      'then emit [AuthLoading, AuthError]',
      build: () {
        when(
          () => signInWithEmailAndPassword(any()),
        ).thenAnswer((_) async => Left(testSignInFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        SignInWithEmailAndPasswordEvent(
          email: testSignInParams.email,
          password: testSignInParams.password,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: testSignInFailure.message),
      ],
      verify: (bloc) {
        verify(() => signInWithEmailAndPassword(testSignInParams)).called(1);
        verifyNoMoreInteractions(signInWithEmailAndPassword);
      },
    );
  });

  group('createUserAccount - ', () {
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.createUserAccount] is called '
      'and completed successfully '
      'then emit [AuthLoading, SignedUp]',
      build: () {
        when(
          () => createUserAccount(any()),
        ).thenAnswer((_) async => const Right(testUser));
        return bloc;
      },
      act: (bloc) => bloc.add(
        CreateUserAccountEvent(
          email: testCreateUserAccountParams.email,
          password: testCreateUserAccountParams.password,
          fullName: testCreateUserAccountParams.fullName,
          veganStatus: testCreateUserAccountParams.veganStatus,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const SignedUp(testUser),
      ],
      verify: (bloc) {
        verify(() => createUserAccount(testCreateUserAccountParams)).called(1);
        verifyNoMoreInteractions(createUserAccount);
      },
    );
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.createUserAccount] is called unsuccessful '
      'then emit [AuthLoading, AuthError]',
      build: () {
        when(
          () => createUserAccount(any()),
        ).thenAnswer((_) async => Left(testCreateUserAccountFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        CreateUserAccountEvent(
          email: testCreateUserAccountParams.email,
          password: testCreateUserAccountParams.password,
          fullName: testCreateUserAccountParams.fullName,
          veganStatus: testCreateUserAccountParams.veganStatus,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: testCreateUserAccountFailure.message),
      ],
      verify: (bloc) {
        verify(() => createUserAccount(testCreateUserAccountParams)).called(1);
        verifyNoMoreInteractions(createUserAccount);
      },
    );
  });

  group('forgotPassword - ', () {
    const testEmail = 'testemail@gmail.com';
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.forgotPassword] is called '
      'and completed successfully '
      'then emit [AuthLoading, ForgotPasswordSent]',
      build: () {
        when(
          () => forgotPassword(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent(
          email: testEmail,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const ForgotPasswordSent(),
      ],
      verify: (bloc) {
        verify(() => forgotPassword(testEmail)).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.forgotPassword] is called unsuccessful '
      'then emit [AuthLoading, AuthError]',
      build: () {
        when(
          () => forgotPassword(any()),
        ).thenAnswer((_) async => Left(testForgotPasswordFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        const ForgotPasswordEvent(
          email: testEmail,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: testForgotPasswordFailure.message),
      ],
      verify: (bloc) {
        verify(() => forgotPassword(testEmail)).called(1);
        verifyNoMoreInteractions(forgotPassword);
      },
    );
  });

  group('updateUser - ', () {
    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.updateUser] is called '
      'and completed successfully '
      'then emit [AuthLoading, UserUpdated]',
      build: () {
        when(
          () => updateUser(any()),
        ).thenAnswer((_) async => const Right(null));
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: testUpdateUserParams.action,
          userData: testUpdateUserParams.userData,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        const UserUpdated(),
      ],
      verify: (bloc) {
        verify(() => updateUser(testUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );

    blocTest<AuthBloc, AuthState>(
      'given AuthBloc '
      'when [AuthBloc.updateUser] is called unsuccessful '
      'then emit [AuthLoading, AuthError]',
      build: () {
        when(
          () => updateUser(any()),
        ).thenAnswer((_) async => Left(testUpdateUserFailure));
        return bloc;
      },
      act: (bloc) => bloc.add(
        UpdateUserEvent(
          action: testUpdateUserParams.action,
          userData: testUpdateUserParams.userData,
        ),
      ),
      expect: () => [
        const AuthLoading(),
        AuthError(message: testUpdateUserFailure.message),
      ],
      verify: (bloc) {
        verify(() => updateUser(testUpdateUserParams)).called(1);
        verifyNoMoreInteractions(updateUser);
      },
    );
  });
}
