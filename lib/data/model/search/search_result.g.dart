// GENERATED CODE - DO NOT MODIFY BY HAND

part of search_result;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SearchResult> _$searchResultSerializer =
    new _$SearchResultSerializer();

class _$SearchResultSerializer implements StructuredSerializer<SearchResult> {
  @override
  final Iterable<Type> types = const [SearchResult, _$SearchResult];
  @override
  final String wireName = 'SearchResult';

  @override
  Iterable<Object?> serialize(Serializers serializers, SearchResult object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'items',
      serializers.serialize(object.items,
          specifiedType: const FullType(
              BuiltList, const [const FullType.nullable(SearchItem)])),
    ];
    Object? value;
    value = object.nexPageToken;
    if (value != null) {
      result
        ..add('nexPageToken')
        ..add(serializers.serialize(value,
            specifiedType: const FullType(String)));
    }
    return result;
  }

  @override
  SearchResult deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchResultBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'nexPageToken':
          result.nexPageToken = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String?;
          break;
        case 'items':
          result.items.replace(serializers.deserialize(value,
                  specifiedType: const FullType(
                      BuiltList, const [const FullType.nullable(SearchItem)]))!
              as BuiltList<Object?>);
          break;
      }
    }

    return result.build();
  }
}

class _$SearchResult extends SearchResult {
  @override
  final String? nexPageToken;
  @override
  final BuiltList<SearchItem?> items;

  factory _$SearchResult([void Function(SearchResultBuilder)? updates]) =>
      (new SearchResultBuilder()..update(updates)).build();

  _$SearchResult._({this.nexPageToken, required this.items}) : super._() {
    BuiltValueNullFieldError.checkNotNull(items, 'SearchResult', 'items');
  }

  @override
  SearchResult rebuild(void Function(SearchResultBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchResultBuilder toBuilder() => new SearchResultBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchResult &&
        nexPageToken == other.nexPageToken &&
        items == other.items;
  }

  @override
  int get hashCode {
    return $jf($jc($jc(0, nexPageToken.hashCode), items.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchResult')
          ..add('nexPageToken', nexPageToken)
          ..add('items', items))
        .toString();
  }
}

class SearchResultBuilder
    implements Builder<SearchResult, SearchResultBuilder> {
  _$SearchResult? _$v;

  String? _nexPageToken;
  String? get nexPageToken => _$this._nexPageToken;
  set nexPageToken(String? nexPageToken) => _$this._nexPageToken = nexPageToken;

  ListBuilder<SearchItem?>? _items;
  ListBuilder<SearchItem?> get items =>
      _$this._items ??= new ListBuilder<SearchItem?>();
  set items(ListBuilder<SearchItem?>? items) => _$this._items = items;

  SearchResultBuilder();

  SearchResultBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _nexPageToken = $v.nexPageToken;
      _items = $v.items.toBuilder();
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchResult other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SearchResult;
  }

  @override
  void update(void Function(SearchResultBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchResult build() {
    _$SearchResult _$result;
    try {
      _$result = _$v ??
          new _$SearchResult._(
              nexPageToken: nexPageToken, items: items.build());
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'items';
        items.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchResult', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
