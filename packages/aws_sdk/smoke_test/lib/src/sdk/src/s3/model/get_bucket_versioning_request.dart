// Generated with smithy-dart 0.3.1. DO NOT MODIFY.

library smoke_test.s3.model.get_bucket_versioning_request; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i2;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:meta/meta.dart' as _i3;
import 'package:smithy/smithy.dart' as _i1;

part 'get_bucket_versioning_request.g.dart';

abstract class GetBucketVersioningRequest
    with
        _i1.HttpInput<GetBucketVersioningRequestPayload>,
        _i2.AWSEquatable<GetBucketVersioningRequest>
    implements
        Built<GetBucketVersioningRequest, GetBucketVersioningRequestBuilder>,
        _i1.EmptyPayload,
        _i1.HasPayload<GetBucketVersioningRequestPayload> {
  factory GetBucketVersioningRequest({
    required String bucket,
    String? expectedBucketOwner,
  }) {
    return _$GetBucketVersioningRequest._(
      bucket: bucket,
      expectedBucketOwner: expectedBucketOwner,
    );
  }

  factory GetBucketVersioningRequest.build(
          [void Function(GetBucketVersioningRequestBuilder) updates]) =
      _$GetBucketVersioningRequest;

  const GetBucketVersioningRequest._();

  factory GetBucketVersioningRequest.fromRequest(
    GetBucketVersioningRequestPayload payload,
    _i2.AWSBaseHttpRequest request, {
    Map<String, String> labels = const {},
  }) =>
      GetBucketVersioningRequest.build((b) {
        if (request.headers['x-amz-expected-bucket-owner'] != null) {
          b.expectedBucketOwner =
              request.headers['x-amz-expected-bucket-owner']!;
        }
        if (labels['bucket'] != null) {
          b.bucket = labels['bucket']!;
        }
      });

  static const List<_i1.SmithySerializer> serializers = [
    GetBucketVersioningRequestRestXmlSerializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(GetBucketVersioningRequestBuilder b) {}

  /// The name of the bucket for which to get the versioning information.
  String get bucket;

  /// The account ID of the expected bucket owner. If the bucket is owned by a different account, the request fails with the HTTP status code `403 Forbidden` (access denied).
  String? get expectedBucketOwner;
  @override
  String labelFor(String key) {
    switch (key) {
      case 'Bucket':
        return bucket;
    }
    throw _i1.MissingLabelException(
      this,
      key,
    );
  }

  @override
  GetBucketVersioningRequestPayload getPayload() =>
      GetBucketVersioningRequestPayload();
  @override
  List<Object?> get props => [
        bucket,
        expectedBucketOwner,
      ];
  @override
  String toString() {
    final helper = newBuiltValueToStringHelper('GetBucketVersioningRequest');
    helper.add(
      'bucket',
      bucket,
    );
    helper.add(
      'expectedBucketOwner',
      expectedBucketOwner,
    );
    return helper.toString();
  }
}

@_i3.internal
abstract class GetBucketVersioningRequestPayload
    with
        _i2.AWSEquatable<GetBucketVersioningRequestPayload>
    implements
        Built<GetBucketVersioningRequestPayload,
            GetBucketVersioningRequestPayloadBuilder>,
        _i1.EmptyPayload {
  factory GetBucketVersioningRequestPayload(
          [void Function(GetBucketVersioningRequestPayloadBuilder) updates]) =
      _$GetBucketVersioningRequestPayload;

  const GetBucketVersioningRequestPayload._();

  @BuiltValueHook(initializeBuilder: true)
  static void _init(GetBucketVersioningRequestPayloadBuilder b) {}
  @override
  List<Object?> get props => [];
  @override
  String toString() {
    final helper =
        newBuiltValueToStringHelper('GetBucketVersioningRequestPayload');
    return helper.toString();
  }
}

class GetBucketVersioningRequestRestXmlSerializer
    extends _i1.StructuredSmithySerializer<GetBucketVersioningRequestPayload> {
  const GetBucketVersioningRequestRestXmlSerializer()
      : super('GetBucketVersioningRequest');

  @override
  Iterable<Type> get types => const [
        GetBucketVersioningRequest,
        _$GetBucketVersioningRequest,
        GetBucketVersioningRequestPayload,
        _$GetBucketVersioningRequestPayload,
      ];
  @override
  Iterable<_i1.ShapeId> get supportedProtocols => const [
        _i1.ShapeId(
          namespace: 'aws.protocols',
          shape: 'restXml',
        )
      ];
  @override
  GetBucketVersioningRequestPayload deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    return GetBucketVersioningRequestPayloadBuilder().build();
  }

  @override
  Iterable<Object?> serialize(
    Serializers serializers,
    Object? object, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = <Object?>[
      const _i1.XmlElementName(
        'GetBucketVersioningRequest',
        _i1.XmlNamespace('http://s3.amazonaws.com/doc/2006-03-01/'),
      )
    ];
    return result;
  }
}