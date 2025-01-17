// GENERATED CODE - DO NOT MODIFY BY HAND

part of smoke_test.dynamo_db_streams.model.describe_stream_input;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

class _$DescribeStreamInput extends DescribeStreamInput {
  @override
  final String? exclusiveStartShardId;
  @override
  final int? limit;
  @override
  final String streamArn;

  factory _$DescribeStreamInput(
          [void Function(DescribeStreamInputBuilder)? updates]) =>
      (new DescribeStreamInputBuilder()..update(updates))._build();

  _$DescribeStreamInput._(
      {this.exclusiveStartShardId, this.limit, required this.streamArn})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        streamArn, r'DescribeStreamInput', 'streamArn');
  }

  @override
  DescribeStreamInput rebuild(
          void Function(DescribeStreamInputBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  DescribeStreamInputBuilder toBuilder() =>
      new DescribeStreamInputBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is DescribeStreamInput &&
        exclusiveStartShardId == other.exclusiveStartShardId &&
        limit == other.limit &&
        streamArn == other.streamArn;
  }

  @override
  int get hashCode {
    var _$hash = 0;
    _$hash = $jc(_$hash, exclusiveStartShardId.hashCode);
    _$hash = $jc(_$hash, limit.hashCode);
    _$hash = $jc(_$hash, streamArn.hashCode);
    _$hash = $jf(_$hash);
    return _$hash;
  }
}

class DescribeStreamInputBuilder
    implements Builder<DescribeStreamInput, DescribeStreamInputBuilder> {
  _$DescribeStreamInput? _$v;

  String? _exclusiveStartShardId;
  String? get exclusiveStartShardId => _$this._exclusiveStartShardId;
  set exclusiveStartShardId(String? exclusiveStartShardId) =>
      _$this._exclusiveStartShardId = exclusiveStartShardId;

  int? _limit;
  int? get limit => _$this._limit;
  set limit(int? limit) => _$this._limit = limit;

  String? _streamArn;
  String? get streamArn => _$this._streamArn;
  set streamArn(String? streamArn) => _$this._streamArn = streamArn;

  DescribeStreamInputBuilder() {
    DescribeStreamInput._init(this);
  }

  DescribeStreamInputBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _exclusiveStartShardId = $v.exclusiveStartShardId;
      _limit = $v.limit;
      _streamArn = $v.streamArn;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(DescribeStreamInput other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$DescribeStreamInput;
  }

  @override
  void update(void Function(DescribeStreamInputBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  DescribeStreamInput build() => _build();

  _$DescribeStreamInput _build() {
    final _$result = _$v ??
        new _$DescribeStreamInput._(
            exclusiveStartShardId: exclusiveStartShardId,
            limit: limit,
            streamArn: BuiltValueNullFieldError.checkNotNull(
                streamArn, r'DescribeStreamInput', 'streamArn'));
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: deprecated_member_use_from_same_package,type=lint
