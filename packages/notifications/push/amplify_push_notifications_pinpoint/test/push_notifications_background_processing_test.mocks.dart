// Mocks generated by Mockito 5.3.2 from annotations
// in amplify_push_notifications_pinpoint/test/push_notifications_background_processing_test.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i7;

import 'package:amplify_auth_cognito/src/auth_plugin_impl.dart' as _i10;
import 'package:amplify_auth_cognito_dart/amplify_auth_cognito_dart.dart'
    as _i4;
import 'package:amplify_core/amplify_core.dart' as _i5;
import 'package:amplify_push_notifications_pinpoint/amplify_push_notifications_pinpoint.dart'
    as _i8;
import 'package:amplify_secure_storage/amplify_secure_storage.dart' as _i6;
import 'package:amplify_secure_storage_dart/amplify_secure_storage_dart.dart'
    as _i2;
import 'package:aws_common/aws_common.dart' as _i3;
import 'package:mockito/mockito.dart' as _i1;

import 'push_notifications_background_processing_test.dart' as _i9;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeAmplifySecureStorageConfig_0 extends _i1.SmartFake
    implements _i2.AmplifySecureStorageConfig {
  _FakeAmplifySecureStorageConfig_0(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAWSLogger_1 extends _i1.SmartFake implements _i3.AWSLogger {
  _FakeAWSLogger_1(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCognitoAuthStateMachine_2 extends _i1.SmartFake
    implements _i4.CognitoAuthStateMachine {
  _FakeCognitoAuthStateMachine_2(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeAmplifyLogger_3 extends _i1.SmartFake implements _i5.AmplifyLogger {
  _FakeAmplifyLogger_3(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCognitoSignUpResult_4 extends _i1.SmartFake
    implements _i4.CognitoSignUpResult {
  _FakeCognitoSignUpResult_4(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCognitoAuthSession_5 extends _i1.SmartFake
    implements _i4.CognitoAuthSession {
  _FakeCognitoAuthSession_5(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeFederateToIdentityPoolResult_6 extends _i1.SmartFake
    implements _i4.FederateToIdentityPoolResult {
  _FakeFederateToIdentityPoolResult_6(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCognitoSignInResult_7 extends _i1.SmartFake
    implements _i4.CognitoSignInResult {
  _FakeCognitoSignInResult_7(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCognitoResendSignUpCodeResult_8 extends _i1.SmartFake
    implements _i4.CognitoResendSignUpCodeResult {
  _FakeCognitoResendSignUpCodeResult_8(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUpdateUserAttributeResult_9 extends _i1.SmartFake
    implements _i5.UpdateUserAttributeResult {
  _FakeUpdateUserAttributeResult_9(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeConfirmUserAttributeResult_10 extends _i1.SmartFake
    implements _i5.ConfirmUserAttributeResult {
  _FakeConfirmUserAttributeResult_10(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeResendUserAttributeConfirmationCodeResult_11 extends _i1.SmartFake
    implements _i5.ResendUserAttributeConfirmationCodeResult {
  _FakeResendUserAttributeConfirmationCodeResult_11(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeUpdatePasswordResult_12 extends _i1.SmartFake
    implements _i5.UpdatePasswordResult {
  _FakeUpdatePasswordResult_12(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCognitoResetPasswordResult_13 extends _i1.SmartFake
    implements _i4.CognitoResetPasswordResult {
  _FakeCognitoResetPasswordResult_13(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCognitoAuthUser_14 extends _i1.SmartFake
    implements _i4.CognitoAuthUser {
  _FakeCognitoAuthUser_14(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

class _FakeCognitoSignOutResult_15 extends _i1.SmartFake
    implements _i4.CognitoSignOutResult {
  _FakeCognitoSignOutResult_15(
    Object parent,
    Invocation parentInvocation,
  ) : super(
          parent,
          parentInvocation,
        );
}

/// A class which mocks [AmplifySecureStorage].
///
/// See the documentation for Mockito's code generation for more information.
class MockAmplifySecureStorage extends _i1.Mock
    implements _i6.AmplifySecureStorage {
  MockAmplifySecureStorage() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.AmplifySecureStorageConfig get config => (super.noSuchMethod(
        Invocation.getter(#config),
        returnValue: _FakeAmplifySecureStorageConfig_0(
          this,
          Invocation.getter(#config),
        ),
      ) as _i2.AmplifySecureStorageConfig);
  @override
  String get runtimeTypeName => (super.noSuchMethod(
        Invocation.getter(#runtimeTypeName),
        returnValue: '',
      ) as String);
  @override
  _i3.AWSLogger get logger => (super.noSuchMethod(
        Invocation.getter(#logger),
        returnValue: _FakeAWSLogger_1(
          this,
          Invocation.getter(#logger),
        ),
      ) as _i3.AWSLogger);
  @override
  _i7.Future<void> delete({required String? key}) => (super.noSuchMethod(
        Invocation.method(
          #delete,
          [],
          {#key: key},
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<String?> read({required String? key}) => (super.noSuchMethod(
        Invocation.method(
          #read,
          [],
          {#key: key},
        ),
        returnValue: _i7.Future<String?>.value(),
      ) as _i7.Future<String?>);
  @override
  _i7.Future<void> write({
    required String? key,
    required String? value,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #write,
          [],
          {
            #key: key,
            #value: value,
          },
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [AmplifyPushNotificationsPinpoint].
///
/// See the documentation for Mockito's code generation for more information.
class MockAmplifyPushNotificationsPinpoint extends _i1.Mock
    implements _i8.AmplifyPushNotificationsPinpoint {
  @override
  _i7.Stream<String> get onTokenReceived => (super.noSuchMethod(
        Invocation.getter(#onTokenReceived),
        returnValue: _i7.Stream<String>.empty(),
        returnValueForMissingStub: _i7.Stream<String>.empty(),
      ) as _i7.Stream<String>);
  @override
  _i7.Stream<_i5.PushNotificationMessage>
      get onNotificationReceivedInForeground => (super.noSuchMethod(
            Invocation.getter(#onNotificationReceivedInForeground),
            returnValue: _i7.Stream<_i5.PushNotificationMessage>.empty(),
            returnValueForMissingStub:
                _i7.Stream<_i5.PushNotificationMessage>.empty(),
          ) as _i7.Stream<_i5.PushNotificationMessage>);
  @override
  _i7.Stream<_i5.PushNotificationMessage> get onNotificationOpened =>
      (super.noSuchMethod(
        Invocation.getter(#onNotificationOpened),
        returnValue: _i7.Stream<_i5.PushNotificationMessage>.empty(),
        returnValueForMissingStub:
            _i7.Stream<_i5.PushNotificationMessage>.empty(),
      ) as _i7.Stream<_i5.PushNotificationMessage>);
  @override
  _i5.Category get category => (super.noSuchMethod(
        Invocation.getter(#category),
        returnValue: _i5.Category.analytics,
        returnValueForMissingStub: _i5.Category.analytics,
      ) as _i5.Category);
  @override
  void onNotificationReceivedInBackground(
          _i5.OnRemoteMessageCallback? callback) =>
      super.noSuchMethod(
        Invocation.method(
          #onNotificationReceivedInBackground,
          [callback],
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i7.Future<void> identifyUser({
    required String? userId,
    required _i5.AnalyticsUserProfile? userProfile,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #identifyUser,
          [],
          {
            #userId: userId,
            #userProfile: userProfile,
          },
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> configure({
    _i5.AmplifyConfig? config,
    required _i5.AmplifyAuthProviderRepository? authProviderRepo,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #configure,
          [],
          {
            #config: config,
            #authProviderRepo: authProviderRepo,
          },
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<bool> requestPermissions({
    bool? alert = true,
    bool? badge = true,
    bool? sound = true,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #requestPermissions,
          [],
          {
            #alert: alert,
            #badge: badge,
            #sound: sound,
          },
        ),
        returnValue: _i7.Future<bool>.value(false),
        returnValueForMissingStub: _i7.Future<bool>.value(false),
      ) as _i7.Future<bool>);
  @override
  _i7.Future<_i5.PushNotificationPermissionStatus> getPermissionStatus() =>
      (super.noSuchMethod(
        Invocation.method(
          #getPermissionStatus,
          [],
        ),
        returnValue: _i7.Future<_i5.PushNotificationPermissionStatus>.value(
            _i5.PushNotificationPermissionStatus.shouldRequest),
        returnValueForMissingStub:
            _i7.Future<_i5.PushNotificationPermissionStatus>.value(
                _i5.PushNotificationPermissionStatus.shouldRequest),
      ) as _i7.Future<_i5.PushNotificationPermissionStatus>);
  @override
  _i7.Future<int> getBadgeCount() => (super.noSuchMethod(
        Invocation.method(
          #getBadgeCount,
          [],
        ),
        returnValue: _i7.Future<int>.value(0),
        returnValueForMissingStub: _i7.Future<int>.value(0),
      ) as _i7.Future<int>);
  @override
  _i7.Future<void> setBadgeCount(int? badgeCount) => (super.noSuchMethod(
        Invocation.method(
          #setBadgeCount,
          [badgeCount],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  P cast<P extends _i5.AmplifyPluginInterface>() => (super.noSuchMethod(
        Invocation.method(
          #cast,
          [],
        ),
        returnValue: _i9.castNotif<P>(),
        returnValueForMissingStub: _i9.castNotif<P>(),
      ) as P);
  @override
  _i7.Future<void> addPlugin(
          {required _i5.AmplifyAuthProviderRepository? authProviderRepo}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addPlugin,
          [],
          {#authProviderRepo: authProviderRepo},
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> reset() => (super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}

/// A class which mocks [AmplifyAuthCognito].
///
/// See the documentation for Mockito's code generation for more information.
class MockAmplifyAuthCognito extends _i1.Mock
    implements _i10.AmplifyAuthCognito {
  @override
  String get runtimeTypeName => (super.noSuchMethod(
        Invocation.getter(#runtimeTypeName),
        returnValue: '',
        returnValueForMissingStub: '',
      ) as String);
  @override
  _i4.CognitoAuthStateMachine get stateMachine => (super.noSuchMethod(
        Invocation.getter(#stateMachine),
        returnValue: _FakeCognitoAuthStateMachine_2(
          this,
          Invocation.getter(#stateMachine),
        ),
        returnValueForMissingStub: _FakeCognitoAuthStateMachine_2(
          this,
          Invocation.getter(#stateMachine),
        ),
      ) as _i4.CognitoAuthStateMachine);
  @override
  set stateMachine(_i4.CognitoAuthStateMachine? stateMachine) =>
      super.noSuchMethod(
        Invocation.setter(
          #stateMachine,
          stateMachine,
        ),
        returnValueForMissingStub: null,
      );
  @override
  _i5.Category get category => (super.noSuchMethod(
        Invocation.getter(#category),
        returnValue: _i5.Category.analytics,
        returnValueForMissingStub: _i5.Category.analytics,
      ) as _i5.Category);
  @override
  _i5.AmplifyLogger get logger => (super.noSuchMethod(
        Invocation.getter(#logger),
        returnValue: _FakeAmplifyLogger_3(
          this,
          Invocation.getter(#logger),
        ),
        returnValueForMissingStub: _FakeAmplifyLogger_3(
          this,
          Invocation.getter(#logger),
        ),
      ) as _i5.AmplifyLogger);
  @override
  _i7.Future<void> addPlugin(
          {required _i5.AmplifyAuthProviderRepository? authProviderRepo}) =>
      (super.noSuchMethod(
        Invocation.method(
          #addPlugin,
          [],
          {#authProviderRepo: authProviderRepo},
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> configure({
    _i5.AmplifyConfig? config,
    required _i5.AmplifyAuthProviderRepository? authProviderRepo,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #configure,
          [],
          {
            #config: config,
            #authProviderRepo: authProviderRepo,
          },
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i4.CognitoSignUpResult> signUp({
    required String? username,
    required String? password,
    _i4.CognitoSignUpOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signUp,
          [],
          {
            #username: username,
            #password: password,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.CognitoSignUpResult>.value(
            _FakeCognitoSignUpResult_4(
          this,
          Invocation.method(
            #signUp,
            [],
            {
              #username: username,
              #password: password,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i4.CognitoSignUpResult>.value(
            _FakeCognitoSignUpResult_4(
          this,
          Invocation.method(
            #signUp,
            [],
            {
              #username: username,
              #password: password,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.CognitoSignUpResult>);
  @override
  _i7.Future<void> close() => (super.noSuchMethod(
        Invocation.method(
          #close,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i4.CognitoAuthSession> fetchAuthSession(
          {_i4.CognitoSessionOptions? options}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchAuthSession,
          [],
          {#options: options},
        ),
        returnValue:
            _i7.Future<_i4.CognitoAuthSession>.value(_FakeCognitoAuthSession_5(
          this,
          Invocation.method(
            #fetchAuthSession,
            [],
            {#options: options},
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.CognitoAuthSession>.value(_FakeCognitoAuthSession_5(
          this,
          Invocation.method(
            #fetchAuthSession,
            [],
            {#options: options},
          ),
        )),
      ) as _i7.Future<_i4.CognitoAuthSession>);
  @override
  _i7.Future<_i4.FederateToIdentityPoolResult> federateToIdentityPool({
    required String? token,
    required _i5.AuthProvider? provider,
    _i4.FederateToIdentityPoolOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #federateToIdentityPool,
          [],
          {
            #token: token,
            #provider: provider,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.FederateToIdentityPoolResult>.value(
            _FakeFederateToIdentityPoolResult_6(
          this,
          Invocation.method(
            #federateToIdentityPool,
            [],
            {
              #token: token,
              #provider: provider,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.FederateToIdentityPoolResult>.value(
                _FakeFederateToIdentityPoolResult_6(
          this,
          Invocation.method(
            #federateToIdentityPool,
            [],
            {
              #token: token,
              #provider: provider,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.FederateToIdentityPoolResult>);
  @override
  _i7.Future<void> clearFederationToIdentityPool() => (super.noSuchMethod(
        Invocation.method(
          #clearFederationToIdentityPool,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<_i4.CognitoSignInResult> signInWithWebUI({
    _i5.AuthProvider? provider,
    _i4.CognitoSignInWithWebUIOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signInWithWebUI,
          [],
          {
            #provider: provider,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.CognitoSignInResult>.value(
            _FakeCognitoSignInResult_7(
          this,
          Invocation.method(
            #signInWithWebUI,
            [],
            {
              #provider: provider,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i4.CognitoSignInResult>.value(
            _FakeCognitoSignInResult_7(
          this,
          Invocation.method(
            #signInWithWebUI,
            [],
            {
              #provider: provider,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.CognitoSignInResult>);
  @override
  _i7.Future<_i4.CognitoSignUpResult> confirmSignUp({
    required String? username,
    required String? confirmationCode,
    _i4.CognitoConfirmSignUpOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #confirmSignUp,
          [],
          {
            #username: username,
            #confirmationCode: confirmationCode,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.CognitoSignUpResult>.value(
            _FakeCognitoSignUpResult_4(
          this,
          Invocation.method(
            #confirmSignUp,
            [],
            {
              #username: username,
              #confirmationCode: confirmationCode,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i4.CognitoSignUpResult>.value(
            _FakeCognitoSignUpResult_4(
          this,
          Invocation.method(
            #confirmSignUp,
            [],
            {
              #username: username,
              #confirmationCode: confirmationCode,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.CognitoSignUpResult>);
  @override
  _i7.Future<_i4.CognitoResendSignUpCodeResult> resendSignUpCode({
    required String? username,
    _i4.CognitoResendSignUpCodeOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #resendSignUpCode,
          [],
          {
            #username: username,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.CognitoResendSignUpCodeResult>.value(
            _FakeCognitoResendSignUpCodeResult_8(
          this,
          Invocation.method(
            #resendSignUpCode,
            [],
            {
              #username: username,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.CognitoResendSignUpCodeResult>.value(
                _FakeCognitoResendSignUpCodeResult_8(
          this,
          Invocation.method(
            #resendSignUpCode,
            [],
            {
              #username: username,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.CognitoResendSignUpCodeResult>);
  @override
  _i7.Future<_i4.CognitoSignInResult> signIn({
    required String? username,
    String? password,
    _i4.CognitoSignInOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #signIn,
          [],
          {
            #username: username,
            #password: password,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.CognitoSignInResult>.value(
            _FakeCognitoSignInResult_7(
          this,
          Invocation.method(
            #signIn,
            [],
            {
              #username: username,
              #password: password,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i4.CognitoSignInResult>.value(
            _FakeCognitoSignInResult_7(
          this,
          Invocation.method(
            #signIn,
            [],
            {
              #username: username,
              #password: password,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.CognitoSignInResult>);
  @override
  _i7.Future<_i4.CognitoSignInResult> confirmSignIn({
    required String? confirmationValue,
    _i4.CognitoConfirmSignInOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #confirmSignIn,
          [],
          {
            #confirmationValue: confirmationValue,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.CognitoSignInResult>.value(
            _FakeCognitoSignInResult_7(
          this,
          Invocation.method(
            #confirmSignIn,
            [],
            {
              #confirmationValue: confirmationValue,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i4.CognitoSignInResult>.value(
            _FakeCognitoSignInResult_7(
          this,
          Invocation.method(
            #confirmSignIn,
            [],
            {
              #confirmationValue: confirmationValue,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.CognitoSignInResult>);
  @override
  _i7.Future<
      List<
          _i5.AuthUserAttribute<
              _i5.CognitoUserAttributeKey>>> fetchUserAttributes(
          {_i5.FetchUserAttributesOptions? options}) =>
      (super.noSuchMethod(
        Invocation.method(
          #fetchUserAttributes,
          [],
          {#options: options},
        ),
        returnValue: _i7.Future<
                List<_i5.AuthUserAttribute<_i5.CognitoUserAttributeKey>>>.value(
            <_i5.AuthUserAttribute<_i5.CognitoUserAttributeKey>>[]),
        returnValueForMissingStub: _i7.Future<
                List<_i5.AuthUserAttribute<_i5.CognitoUserAttributeKey>>>.value(
            <_i5.AuthUserAttribute<_i5.CognitoUserAttributeKey>>[]),
      ) as _i7
          .Future<List<_i5.AuthUserAttribute<_i5.CognitoUserAttributeKey>>>);
  @override
  _i7.Future<_i5.UpdateUserAttributeResult> updateUserAttribute({
    required _i5.CognitoUserAttributeKey? userAttributeKey,
    required String? value,
    _i4.CognitoUpdateUserAttributeOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updateUserAttribute,
          [],
          {
            #userAttributeKey: userAttributeKey,
            #value: value,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i5.UpdateUserAttributeResult>.value(
            _FakeUpdateUserAttributeResult_9(
          this,
          Invocation.method(
            #updateUserAttribute,
            [],
            {
              #userAttributeKey: userAttributeKey,
              #value: value,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.UpdateUserAttributeResult>.value(
                _FakeUpdateUserAttributeResult_9(
          this,
          Invocation.method(
            #updateUserAttribute,
            [],
            {
              #userAttributeKey: userAttributeKey,
              #value: value,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i5.UpdateUserAttributeResult>);
  @override
  _i7.Future<Map<_i5.CognitoUserAttributeKey, _i5.UpdateUserAttributeResult>>
      updateUserAttributes({
    required List<_i5.AuthUserAttribute<_i5.AuthUserAttributeKey>>? attributes,
    _i4.CognitoUpdateUserAttributesOptions? options,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #updateUserAttributes,
              [],
              {
                #attributes: attributes,
                #options: options,
              },
            ),
            returnValue: _i7.Future<
                    Map<_i5.CognitoUserAttributeKey,
                        _i5.UpdateUserAttributeResult>>.value(
                <_i5.CognitoUserAttributeKey, _i5.UpdateUserAttributeResult>{}),
            returnValueForMissingStub: _i7.Future<
                    Map<_i5.CognitoUserAttributeKey,
                        _i5.UpdateUserAttributeResult>>.value(
                <_i5.CognitoUserAttributeKey, _i5.UpdateUserAttributeResult>{}),
          ) as _i7.Future<
              Map<_i5.CognitoUserAttributeKey, _i5.UpdateUserAttributeResult>>);
  @override
  _i7.Future<_i5.ConfirmUserAttributeResult> confirmUserAttribute({
    required _i5.CognitoUserAttributeKey? userAttributeKey,
    required String? confirmationCode,
    _i5.ConfirmUserAttributeOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #confirmUserAttribute,
          [],
          {
            #userAttributeKey: userAttributeKey,
            #confirmationCode: confirmationCode,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i5.ConfirmUserAttributeResult>.value(
            _FakeConfirmUserAttributeResult_10(
          this,
          Invocation.method(
            #confirmUserAttribute,
            [],
            {
              #userAttributeKey: userAttributeKey,
              #confirmationCode: confirmationCode,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i5.ConfirmUserAttributeResult>.value(
                _FakeConfirmUserAttributeResult_10(
          this,
          Invocation.method(
            #confirmUserAttribute,
            [],
            {
              #userAttributeKey: userAttributeKey,
              #confirmationCode: confirmationCode,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i5.ConfirmUserAttributeResult>);
  @override
  _i7.Future<_i5.ResendUserAttributeConfirmationCodeResult>
      resendUserAttributeConfirmationCode({
    required _i5.CognitoUserAttributeKey? userAttributeKey,
    _i4.CognitoResendUserAttributeConfirmationCodeOptions? options,
  }) =>
          (super.noSuchMethod(
            Invocation.method(
              #resendUserAttributeConfirmationCode,
              [],
              {
                #userAttributeKey: userAttributeKey,
                #options: options,
              },
            ),
            returnValue:
                _i7.Future<_i5.ResendUserAttributeConfirmationCodeResult>.value(
                    _FakeResendUserAttributeConfirmationCodeResult_11(
              this,
              Invocation.method(
                #resendUserAttributeConfirmationCode,
                [],
                {
                  #userAttributeKey: userAttributeKey,
                  #options: options,
                },
              ),
            )),
            returnValueForMissingStub:
                _i7.Future<_i5.ResendUserAttributeConfirmationCodeResult>.value(
                    _FakeResendUserAttributeConfirmationCodeResult_11(
              this,
              Invocation.method(
                #resendUserAttributeConfirmationCode,
                [],
                {
                  #userAttributeKey: userAttributeKey,
                  #options: options,
                },
              ),
            )),
          ) as _i7.Future<_i5.ResendUserAttributeConfirmationCodeResult>);
  @override
  _i7.Future<_i5.UpdatePasswordResult> updatePassword({
    required String? oldPassword,
    required String? newPassword,
    _i4.CognitoUpdatePasswordOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #updatePassword,
          [],
          {
            #oldPassword: oldPassword,
            #newPassword: newPassword,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i5.UpdatePasswordResult>.value(
            _FakeUpdatePasswordResult_12(
          this,
          Invocation.method(
            #updatePassword,
            [],
            {
              #oldPassword: oldPassword,
              #newPassword: newPassword,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i5.UpdatePasswordResult>.value(
            _FakeUpdatePasswordResult_12(
          this,
          Invocation.method(
            #updatePassword,
            [],
            {
              #oldPassword: oldPassword,
              #newPassword: newPassword,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i5.UpdatePasswordResult>);
  @override
  _i7.Future<_i4.CognitoResetPasswordResult> resetPassword({
    required String? username,
    _i4.CognitoResetPasswordOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #resetPassword,
          [],
          {
            #username: username,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.CognitoResetPasswordResult>.value(
            _FakeCognitoResetPasswordResult_13(
          this,
          Invocation.method(
            #resetPassword,
            [],
            {
              #username: username,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.CognitoResetPasswordResult>.value(
                _FakeCognitoResetPasswordResult_13(
          this,
          Invocation.method(
            #resetPassword,
            [],
            {
              #username: username,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.CognitoResetPasswordResult>);
  @override
  _i7.Future<_i4.CognitoResetPasswordResult> confirmResetPassword({
    required String? username,
    required String? newPassword,
    required String? confirmationCode,
    _i4.CognitoConfirmResetPasswordOptions? options,
  }) =>
      (super.noSuchMethod(
        Invocation.method(
          #confirmResetPassword,
          [],
          {
            #username: username,
            #newPassword: newPassword,
            #confirmationCode: confirmationCode,
            #options: options,
          },
        ),
        returnValue: _i7.Future<_i4.CognitoResetPasswordResult>.value(
            _FakeCognitoResetPasswordResult_13(
          this,
          Invocation.method(
            #confirmResetPassword,
            [],
            {
              #username: username,
              #newPassword: newPassword,
              #confirmationCode: confirmationCode,
              #options: options,
            },
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.CognitoResetPasswordResult>.value(
                _FakeCognitoResetPasswordResult_13(
          this,
          Invocation.method(
            #confirmResetPassword,
            [],
            {
              #username: username,
              #newPassword: newPassword,
              #confirmationCode: confirmationCode,
              #options: options,
            },
          ),
        )),
      ) as _i7.Future<_i4.CognitoResetPasswordResult>);
  @override
  _i7.Future<_i4.CognitoAuthUser> getCurrentUser(
          {_i5.AuthUserOptions? options}) =>
      (super.noSuchMethod(
        Invocation.method(
          #getCurrentUser,
          [],
          {#options: options},
        ),
        returnValue:
            _i7.Future<_i4.CognitoAuthUser>.value(_FakeCognitoAuthUser_14(
          this,
          Invocation.method(
            #getCurrentUser,
            [],
            {#options: options},
          ),
        )),
        returnValueForMissingStub:
            _i7.Future<_i4.CognitoAuthUser>.value(_FakeCognitoAuthUser_14(
          this,
          Invocation.method(
            #getCurrentUser,
            [],
            {#options: options},
          ),
        )),
      ) as _i7.Future<_i4.CognitoAuthUser>);
  @override
  _i7.Future<void> rememberDevice() => (super.noSuchMethod(
        Invocation.method(
          #rememberDevice,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<void> forgetDevice([_i4.CognitoDevice? device]) =>
      (super.noSuchMethod(
        Invocation.method(
          #forgetDevice,
          [device],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  _i7.Future<List<_i4.CognitoDevice>> fetchDevices() => (super.noSuchMethod(
        Invocation.method(
          #fetchDevices,
          [],
        ),
        returnValue:
            _i7.Future<List<_i4.CognitoDevice>>.value(<_i4.CognitoDevice>[]),
        returnValueForMissingStub:
            _i7.Future<List<_i4.CognitoDevice>>.value(<_i4.CognitoDevice>[]),
      ) as _i7.Future<List<_i4.CognitoDevice>>);
  @override
  _i7.Future<_i4.CognitoSignOutResult> signOut({_i5.SignOutOptions? options}) =>
      (super.noSuchMethod(
        Invocation.method(
          #signOut,
          [],
          {#options: options},
        ),
        returnValue: _i7.Future<_i4.CognitoSignOutResult>.value(
            _FakeCognitoSignOutResult_15(
          this,
          Invocation.method(
            #signOut,
            [],
            {#options: options},
          ),
        )),
        returnValueForMissingStub: _i7.Future<_i4.CognitoSignOutResult>.value(
            _FakeCognitoSignOutResult_15(
          this,
          Invocation.method(
            #signOut,
            [],
            {#options: options},
          ),
        )),
      ) as _i7.Future<_i4.CognitoSignOutResult>);
  @override
  _i7.Future<void> deleteUser() => (super.noSuchMethod(
        Invocation.method(
          #deleteUser,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
  @override
  P cast<P extends _i5.AmplifyPluginInterface>() => (super.noSuchMethod(
        Invocation.method(
          #cast,
          [],
        ),
        returnValue: _i9.castAuth<P>(),
        returnValueForMissingStub: _i9.castAuth<P>(),
      ) as P);
  @override
  _i7.Future<void> reset() => (super.noSuchMethod(
        Invocation.method(
          #reset,
          [],
        ),
        returnValue: _i7.Future<void>.value(),
        returnValueForMissingStub: _i7.Future<void>.value(),
      ) as _i7.Future<void>);
}