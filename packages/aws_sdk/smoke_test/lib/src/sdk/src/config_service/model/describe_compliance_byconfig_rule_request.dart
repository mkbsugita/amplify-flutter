// Copyright 2022 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
//
//      http://www.apache.org/licenses/LICENSE-2.0
//
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Generated with smithy-dart 0.1.0. DO NOT MODIFY.

library smoke_test.config_service.model.describe_compliance_byconfig_rule_request; // ignore_for_file: no_leading_underscores_for_library_prefixes

import 'package:aws_common/aws_common.dart' as _i2;
import 'package:built_collection/built_collection.dart' as _i3;
import 'package:built_value/built_value.dart';
import 'package:built_value/serializer.dart';
import 'package:smithy/smithy.dart' as _i1;
import 'package:smoke_test/src/sdk/src/config_service/model/compliance_type.dart'
    as _i4;

part 'describe_compliance_byconfig_rule_request.g.dart';

abstract class DescribeComplianceByconfigRuleRequest
    with
        _i1.HttpInput<DescribeComplianceByconfigRuleRequest>,
        _i2.AWSEquatable<DescribeComplianceByconfigRuleRequest>
    implements
        Built<DescribeComplianceByconfigRuleRequest,
            DescribeComplianceByconfigRuleRequestBuilder> {
  factory DescribeComplianceByconfigRuleRequest({
    _i3.BuiltList<_i4.ComplianceType>? complianceTypes,
    _i3.BuiltList<String>? configRuleNames,
    String? nextToken,
  }) {
    return _$DescribeComplianceByconfigRuleRequest._(
      complianceTypes: complianceTypes,
      configRuleNames: configRuleNames,
      nextToken: nextToken,
    );
  }

  factory DescribeComplianceByconfigRuleRequest.build(
      [void Function(DescribeComplianceByconfigRuleRequestBuilder)
          updates]) = _$DescribeComplianceByconfigRuleRequest;

  const DescribeComplianceByconfigRuleRequest._();

  factory DescribeComplianceByconfigRuleRequest.fromRequest(
    DescribeComplianceByconfigRuleRequest payload,
    _i2.AWSBaseHttpRequest request, {
    Map<String, String> labels = const {},
  }) =>
      payload;

  static const List<_i1.SmithySerializer> serializers = [
    DescribeComplianceByconfigRuleRequestAwsJson11Serializer()
  ];

  @BuiltValueHook(initializeBuilder: true)
  static void _init(DescribeComplianceByconfigRuleRequestBuilder b) {}

  /// Filters the results by compliance.
  ///
  /// The allowed values are `COMPLIANT` and `NON_COMPLIANT`.
  _i3.BuiltList<_i4.ComplianceType>? get complianceTypes;

  /// Specify one or more Config rule names to filter the results by rule.
  _i3.BuiltList<String>? get configRuleNames;

  /// The `nextToken` string returned on a previous page that you use to get the next page of results in a paginated response.
  String? get nextToken;
  @override
  DescribeComplianceByconfigRuleRequest getPayload() => this;
  @override
  List<Object?> get props => [
        complianceTypes,
        configRuleNames,
        nextToken,
      ];
  @override
  String toString() {
    final helper =
        newBuiltValueToStringHelper('DescribeComplianceByconfigRuleRequest');
    helper.add(
      'complianceTypes',
      complianceTypes,
    );
    helper.add(
      'configRuleNames',
      configRuleNames,
    );
    helper.add(
      'nextToken',
      nextToken,
    );
    return helper.toString();
  }
}

class DescribeComplianceByconfigRuleRequestAwsJson11Serializer extends _i1
    .StructuredSmithySerializer<DescribeComplianceByconfigRuleRequest> {
  const DescribeComplianceByconfigRuleRequestAwsJson11Serializer()
      : super('DescribeComplianceByconfigRuleRequest');

  @override
  Iterable<Type> get types => const [
        DescribeComplianceByconfigRuleRequest,
        _$DescribeComplianceByconfigRuleRequest,
      ];
  @override
  Iterable<_i1.ShapeId> get supportedProtocols => const [
        _i1.ShapeId(
          namespace: 'aws.protocols',
          shape: 'awsJson1_1',
        )
      ];
  @override
  DescribeComplianceByconfigRuleRequest deserialize(
    Serializers serializers,
    Iterable<Object?> serialized, {
    FullType specifiedType = FullType.unspecified,
  }) {
    final result = DescribeComplianceByconfigRuleRequestBuilder();
    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final value = iterator.current;
      switch (key) {
        case 'ComplianceTypes':
          if (value != null) {
            result.complianceTypes.replace((serializers.deserialize(
              value,
              specifiedType: const FullType(
                _i3.BuiltList,
                [FullType(_i4.ComplianceType)],
              ),
            ) as _i3.BuiltList<_i4.ComplianceType>));
          }
          break;
        case 'ConfigRuleNames':
          if (value != null) {
            result.configRuleNames.replace((serializers.deserialize(
              value,
              specifiedType: const FullType(
                _i3.BuiltList,
                [FullType(String)],
              ),
            ) as _i3.BuiltList<String>));
          }
          break;
        case 'NextToken':
          if (value != null) {
            result.nextToken = (serializers.deserialize(
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
    final payload = (object as DescribeComplianceByconfigRuleRequest);
    final result = <Object?>[];
    if (payload.complianceTypes != null) {
      result
        ..add('ComplianceTypes')
        ..add(serializers.serialize(
          payload.complianceTypes!,
          specifiedType: const FullType(
            _i3.BuiltList,
            [FullType(_i4.ComplianceType)],
          ),
        ));
    }
    if (payload.configRuleNames != null) {
      result
        ..add('ConfigRuleNames')
        ..add(serializers.serialize(
          payload.configRuleNames!,
          specifiedType: const FullType(
            _i3.BuiltList,
            [FullType(String)],
          ),
        ));
    }
    if (payload.nextToken != null) {
      result
        ..add('NextToken')
        ..add(serializers.serialize(
          payload.nextToken!,
          specifiedType: const FullType(String),
        ));
    }
    return result;
  }
}