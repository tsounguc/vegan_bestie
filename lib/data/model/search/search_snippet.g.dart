// GENERATED CODE - DO NOT MODIFY BY HAND

part of search_snippet;

// **************************************************************************
// BuiltValueGenerator
// **************************************************************************

Serializer<SearchSnippet> _$searchSnippetSerializer =
    new _$SearchSnippetSerializer();

class _$SearchSnippetSerializer implements StructuredSerializer<SearchSnippet> {
  @override
  final Iterable<Type> types = const [SearchSnippet, _$SearchSnippet];
  @override
  final String wireName = 'SearchSnippet';

  @override
  Iterable<Object?> serialize(Serializers serializers, SearchSnippet object,
      {FullType specifiedType = FullType.unspecified}) {
    final result = <Object?>[
      'publishedAt',
      serializers.serialize(object.publishedAt,
          specifiedType: const FullType(String)),
      'channelId',
      serializers.serialize(object.channelId,
          specifiedType: const FullType(String)),
      'title',
      serializers.serialize(object.title,
          specifiedType: const FullType(String)),
      'description',
      serializers.serialize(object.description,
          specifiedType: const FullType(String)),
      'thumbnails',
      serializers.serialize(object.thumbnails,
          specifiedType: const FullType(Thumbnails)),
      'channelTitle',
      serializers.serialize(object.channelTitle,
          specifiedType: const FullType(String)),
    ];

    return result;
  }

  @override
  SearchSnippet deserialize(
      Serializers serializers, Iterable<Object?> serialized,
      {FullType specifiedType = FullType.unspecified}) {
    final result = new SearchSnippetBuilder();

    final iterator = serialized.iterator;
    while (iterator.moveNext()) {
      final key = iterator.current as String;
      iterator.moveNext();
      final Object? value = iterator.current;
      switch (key) {
        case 'publishedAt':
          result.publishedAt = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'channelId':
          result.channelId = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'title':
          result.title = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'description':
          result.description = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
        case 'thumbnails':
          result.thumbnails.replace(serializers.deserialize(value,
              specifiedType: const FullType(Thumbnails))! as Thumbnails);
          break;
        case 'channelTitle':
          result.channelTitle = serializers.deserialize(value,
              specifiedType: const FullType(String)) as String;
          break;
      }
    }

    return result.build();
  }
}

class _$SearchSnippet extends SearchSnippet {
  @override
  final String publishedAt;
  @override
  final String channelId;
  @override
  final String title;
  @override
  final String description;
  @override
  final Thumbnails thumbnails;
  @override
  final String channelTitle;

  factory _$SearchSnippet([void Function(SearchSnippetBuilder)? updates]) =>
      (new SearchSnippetBuilder()..update(updates)).build();

  _$SearchSnippet._(
      {required this.publishedAt,
      required this.channelId,
      required this.title,
      required this.description,
      required this.thumbnails,
      required this.channelTitle})
      : super._() {
    BuiltValueNullFieldError.checkNotNull(
        publishedAt, 'SearchSnippet', 'publishedAt');
    BuiltValueNullFieldError.checkNotNull(
        channelId, 'SearchSnippet', 'channelId');
    BuiltValueNullFieldError.checkNotNull(title, 'SearchSnippet', 'title');
    BuiltValueNullFieldError.checkNotNull(
        description, 'SearchSnippet', 'description');
    BuiltValueNullFieldError.checkNotNull(
        thumbnails, 'SearchSnippet', 'thumbnails');
    BuiltValueNullFieldError.checkNotNull(
        channelTitle, 'SearchSnippet', 'channelTitle');
  }

  @override
  SearchSnippet rebuild(void Function(SearchSnippetBuilder) updates) =>
      (toBuilder()..update(updates)).build();

  @override
  SearchSnippetBuilder toBuilder() => new SearchSnippetBuilder()..replace(this);

  @override
  bool operator ==(Object other) {
    if (identical(other, this)) return true;
    return other is SearchSnippet &&
        publishedAt == other.publishedAt &&
        channelId == other.channelId &&
        title == other.title &&
        description == other.description &&
        thumbnails == other.thumbnails &&
        channelTitle == other.channelTitle;
  }

  @override
  int get hashCode {
    return $jf($jc(
        $jc(
            $jc(
                $jc($jc($jc(0, publishedAt.hashCode), channelId.hashCode),
                    title.hashCode),
                description.hashCode),
            thumbnails.hashCode),
        channelTitle.hashCode));
  }

  @override
  String toString() {
    return (newBuiltValueToStringHelper('SearchSnippet')
          ..add('publishedAt', publishedAt)
          ..add('channelId', channelId)
          ..add('title', title)
          ..add('description', description)
          ..add('thumbnails', thumbnails)
          ..add('channelTitle', channelTitle))
        .toString();
  }
}

class SearchSnippetBuilder
    implements Builder<SearchSnippet, SearchSnippetBuilder> {
  _$SearchSnippet? _$v;

  String? _publishedAt;
  String? get publishedAt => _$this._publishedAt;
  set publishedAt(String? publishedAt) => _$this._publishedAt = publishedAt;

  String? _channelId;
  String? get channelId => _$this._channelId;
  set channelId(String? channelId) => _$this._channelId = channelId;

  String? _title;
  String? get title => _$this._title;
  set title(String? title) => _$this._title = title;

  String? _description;
  String? get description => _$this._description;
  set description(String? description) => _$this._description = description;

  ThumbnailsBuilder? _thumbnails;
  ThumbnailsBuilder get thumbnails =>
      _$this._thumbnails ??= new ThumbnailsBuilder();
  set thumbnails(ThumbnailsBuilder? thumbnails) =>
      _$this._thumbnails = thumbnails;

  String? _channelTitle;
  String? get channelTitle => _$this._channelTitle;
  set channelTitle(String? channelTitle) => _$this._channelTitle = channelTitle;

  SearchSnippetBuilder();

  SearchSnippetBuilder get _$this {
    final $v = _$v;
    if ($v != null) {
      _publishedAt = $v.publishedAt;
      _channelId = $v.channelId;
      _title = $v.title;
      _description = $v.description;
      _thumbnails = $v.thumbnails.toBuilder();
      _channelTitle = $v.channelTitle;
      _$v = null;
    }
    return this;
  }

  @override
  void replace(SearchSnippet other) {
    ArgumentError.checkNotNull(other, 'other');
    _$v = other as _$SearchSnippet;
  }

  @override
  void update(void Function(SearchSnippetBuilder)? updates) {
    if (updates != null) updates(this);
  }

  @override
  _$SearchSnippet build() {
    _$SearchSnippet _$result;
    try {
      _$result = _$v ??
          new _$SearchSnippet._(
              publishedAt: BuiltValueNullFieldError.checkNotNull(
                  publishedAt, 'SearchSnippet', 'publishedAt'),
              channelId: BuiltValueNullFieldError.checkNotNull(
                  channelId, 'SearchSnippet', 'channelId'),
              title: BuiltValueNullFieldError.checkNotNull(
                  title, 'SearchSnippet', 'title'),
              description: BuiltValueNullFieldError.checkNotNull(
                  description, 'SearchSnippet', 'description'),
              thumbnails: thumbnails.build(),
              channelTitle: BuiltValueNullFieldError.checkNotNull(
                  channelTitle, 'SearchSnippet', 'channelTitle'));
    } catch (_) {
      late String _$failedField;
      try {
        _$failedField = 'thumbnails';
        thumbnails.build();
      } catch (e) {
        throw new BuiltValueNestedFieldError(
            'SearchSnippet', _$failedField, e.toString());
      }
      rethrow;
    }
    replace(_$result);
    return _$result;
  }
}

// ignore_for_file: always_put_control_body_on_new_line,always_specify_types,annotate_overrides,avoid_annotating_with_dynamic,avoid_as,avoid_catches_without_on_clauses,avoid_returning_this,deprecated_member_use_from_same_package,lines_longer_than_80_chars,omit_local_variable_types,prefer_expression_function_bodies,sort_constructors_first,test_types_in_equals,unnecessary_const,unnecessary_new
