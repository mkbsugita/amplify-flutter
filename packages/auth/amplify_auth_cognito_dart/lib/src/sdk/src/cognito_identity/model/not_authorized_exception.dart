// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library amplify_auth_cognito_dart.cognito_identity.model.not_authorized_exception; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i1;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i2;

part 'not_authorized_exception.g.dart';

/// Thrown when a user is not authorized to access the requested resource.
abstract class NotAuthorizedException
    with _i1.AWSEquatable<NotAuthorizedException>
    implements
        Built<NotAuthorizedException, NotAuthorizedExceptionBuilder>,
        _i2.SmithyHttpException {
  /// Thrown when a user is not authorized to access the requested resource.
  factory NotAuthorizedException({String? message}) {
    return _$NotAuthorizedException._(message: message);
  }

  /// Thrown when a user is not authorized to access the requested resource.
  factory NotAuthorizedException.build(
          [void Function(NotAuthorizedExceptionBuilder) updates]) =
      _$NotAuthorizedException;

  const NotAuthorizedException._();

  /// Constructs a [NotAuthorizedException] from a [payload] and [response].
  factory NotAuthorizedException.fromResponse(
    NotAuthorizedException payload,
    _i1.AWSBaseHttpResponse response,
  ) =>
      payload.rebuild((b) {
        b.headers = response.headers;
      });

  static const List<_i2.SmithySerializer> serializers = [
    NotAuthorizedExceptionAwsJson11Serializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(NotAuthorizedExceptionBuilder b) {}

  /// The message returned by a NotAuthorizedException
  @override
  String? get message;
  @override
  _i2.ShapeId get shapeId => const _i2.ShapeId(
        namespace: 'com.amazonaws.cognitoidentity',
        shape: 'NotAuthorizedException',
      );
  @override
  _i2.RetryConfig? get retryConfig => null;
  @override
  @BuiltValueField(compare: false)
  int get statusCode => 403;
  @override
  @BuiltValueField(compare: false)
  Map<String, String>? get headers;
  @override
  Exception? get underlyingException => null;
  @override
  List<Object?> get props => [message];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('NotAuthorizedException');
    helper.add(
      'message',
      message,
    );
    return helper.toString();
  }
}

class NotAuthorizedExceptionAwsJson11Serializer
    extends _i2.StructuredSmithySerializer<NotAuthorizedException> {
  const NotAuthorizedExceptionAwsJson11Serializer()
      : super('NotAuthorizedException');

  @override
  Iterable<Type> get types => const [
        NotAuthorizedException,
        _$NotAuthorizedException,
      ];
  @override
  Iterable<_i2.ShapeId> get supportedProtocols => const [
        _i2.ShapeId(
          namespace: 'aws.protocols',
          shape: 'awsJson1_1',
        )
      ];
  @override
  NotAuthorizedException deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = NotAuthorizedExceptionBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      switch (key) {
        case 'message':
          if (value != null) {
            result.message = (serializers.deserialize(
              value,
              specifiedType: const FullType(String),
            ) as String);
          }
          break;
      }
    }

    return result.build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Object? object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final payload = (object as NotAuthorizedException);
    final result = <Object?>[];
    if (payload.message != null) {
      result
        ..add('message')
        ..add(serializers.serialize(
          payload.message!,
          specifiedType: const FullType(String),
        ));
    }
    return result;
  }
}
