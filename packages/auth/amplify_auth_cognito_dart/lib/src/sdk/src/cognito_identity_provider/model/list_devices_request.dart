// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library amplify_auth_cognito_dart.cognito_identity_provider.model.list_devices_request; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i1;

part 'list_devices_request.g.dart';

/// Represents the request to list the devices.
abstract class ListDevicesRequest
    with _i1.HttpInput<ListDevicesRequest>, _i2.AWSEquatable<ListDevicesRequest>
    implements Built<ListDevicesRequest, ListDevicesRequestBuilder> {
  /// Represents the request to list the devices.
  factory ListDevicesRequest({
    required String accessToken,
    int? limit,
    String? paginationToken,
  }) {
    return _$ListDevicesRequest._(
      accessToken: accessToken,
      limit: limit,
      paginationToken: paginationToken,
    );
  }

  /// Represents the request to list the devices.
  factory ListDevicesRequest.build(
          [void Function(ListDevicesRequestBuilder) updates]) =
      _$ListDevicesRequest;

  const ListDevicesRequest._();

  factory ListDevicesRequest.fromRequest(
    ListDevicesRequest payload,
    _i2.AWSBaseHttpRequest request, {
    Map<String, String> labels = const {},
  }) =>
      payload;

  static const List<_i1.SmithySerializer> serializers = [
    ListDevicesRequestAwsJson11Serializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(ListDevicesRequestBuilder b) {}

  /// A valid access token that Amazon Cognito issued to the user whose list of devices you want to view.
  String get accessToken;

  /// The limit of the device request.
  int? get limit;

  /// The pagination token for the list request.
  String? get paginationToken;
  @override
  ListDevicesRequest getPayload() => this;
  @override
  List<Object?> get props => [
        accessToken,
        limit,
        paginationToken,
      ];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('ListDevicesRequest');
    helper.add(
      'accessToken',
      '***SENSITIVE***',
    );
    helper.add(
      'limit',
      limit,
    );
    helper.add(
      'paginationToken',
      paginationToken,
    );
    return helper.toString();
  }
}

class ListDevicesRequestAwsJson11Serializer
    extends _i1.StructuredSmithySerializer<ListDevicesRequest> {
  const ListDevicesRequestAwsJson11Serializer() : super('ListDevicesRequest');

  @override
  Iterable<Type> get types => const [
        ListDevicesRequest,
        _$ListDevicesRequest,
      ];
  @override
  Iterable<_i1.ShapeId> get supportedProtocols => const [
        _i1.ShapeId(
          namespace: 'aws.protocols',
          shape: 'awsJson1_1',
        )
      ];
  @override
  ListDevicesRequest deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = ListDevicesRequestBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      switch (key) {
        case 'AccessToken':
          result.accessToken = (serializers.deserialize(
            value!,
            specifiedType: const FullType(String),
          ) as String);
          break;
        case 'Limit':
          if (value != null) {
            result.limit = (serializers.deserialize(
              value,
              specifiedType: const FullType(int),
            ) as int);
          }
          break;
        case 'PaginationToken':
          if (value != null) {
            result.paginationToken = (serializers.deserialize(
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
    final payload = (object as ListDevicesRequest);
    final result = <Object?>[
      'AccessToken',
      serializers.serialize(
        payload.accessToken,
        specifiedType: const FullType(String),
      ),
    ];
    if (payload.limit != null) {
      result
        ..add('Limit')
        ..add(serializers.serialize(
          payload.limit!,
          specifiedType: const FullType(int),
        ));
    }
    if (payload.paginationToken != null) {
      result
        ..add('PaginationToken')
        ..add(serializers.serialize(
          payload.paginationToken!,
          specifiedType: const FullType(String),
        ));
    }
    return result;
  }
}
