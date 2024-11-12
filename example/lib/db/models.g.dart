// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'models.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetModelDataCollection on Isar {
  IsarCollection<ModelData> get modelDatas => this.collection();
}

const ModelDataSchema = CollectionSchema(
  name: r'ModelData',
  id: -3916496497560821984,
  properties: {
    r'ext': PropertySchema(
      id: 0,
      name: r'ext',
      type: IsarType.string,
    ),
    r'info': PropertySchema(
      id: 1,
      name: r'info',
      type: IsarType.objectList,
      target: r'ModelInfo',
    ),
    r'mName': PropertySchema(
      id: 2,
      name: r'mName',
      type: IsarType.string,
    ),
    r'policy': PropertySchema(
      id: 3,
      name: r'policy',
      type: IsarType.string,
    ),
    r'sUrl': PropertySchema(
      id: 4,
      name: r'sUrl',
      type: IsarType.string,
    )
  },
  estimateSize: _modelDataEstimateSize,
  serialize: _modelDataSerialize,
  deserialize: _modelDataDeserialize,
  deserializeProp: _modelDataDeserializeProp,
  idName: r'id',
  indexes: {
    r'mName': IndexSchema(
      id: 5607541375393408118,
      name: r'mName',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'mName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'ModelInfo': ModelInfoSchema},
  getId: _modelDataGetId,
  getLinks: _modelDataGetLinks,
  attach: _modelDataAttach,
  version: '1.0.10',
);

int _modelDataEstimateSize(
  ModelData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.ext.length * 3;
  {
    final list = object.info;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[ModelInfo]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount +=
              ModelInfoSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  bytesCount += 3 + object.mName.length * 3;
  bytesCount += 3 + object.policy.length * 3;
  bytesCount += 3 + object.sUrl.length * 3;
  return bytesCount;
}

void _modelDataSerialize(
  ModelData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.ext);
  writer.writeObjectList<ModelInfo>(
    offsets[1],
    allOffsets,
    ModelInfoSchema.serialize,
    object.info,
  );
  writer.writeString(offsets[2], object.mName);
  writer.writeString(offsets[3], object.policy);
  writer.writeString(offsets[4], object.sUrl);
}

ModelData _modelDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ModelData();
  object.ext = reader.readString(offsets[0]);
  object.id = id;
  object.info = reader.readObjectList<ModelInfo>(
    offsets[1],
    ModelInfoSchema.deserialize,
    allOffsets,
    ModelInfo(),
  );
  object.mName = reader.readString(offsets[2]);
  object.policy = reader.readString(offsets[3]);
  object.sUrl = reader.readString(offsets[4]);
  return object;
}

P _modelDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<ModelInfo>(
        offset,
        ModelInfoSchema.deserialize,
        allOffsets,
        ModelInfo(),
      )) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _modelDataGetId(ModelData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _modelDataGetLinks(ModelData object) {
  return [];
}

void _modelDataAttach(IsarCollection<dynamic> col, Id id, ModelData object) {
  object.id = id;
}

extension ModelDataByIndex on IsarCollection<ModelData> {
  Future<ModelData?> getByMName(String mName) {
    return getByIndex(r'mName', [mName]);
  }

  ModelData? getByMNameSync(String mName) {
    return getByIndexSync(r'mName', [mName]);
  }

  Future<bool> deleteByMName(String mName) {
    return deleteByIndex(r'mName', [mName]);
  }

  bool deleteByMNameSync(String mName) {
    return deleteByIndexSync(r'mName', [mName]);
  }

  Future<List<ModelData?>> getAllByMName(List<String> mNameValues) {
    final values = mNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'mName', values);
  }

  List<ModelData?> getAllByMNameSync(List<String> mNameValues) {
    final values = mNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'mName', values);
  }

  Future<int> deleteAllByMName(List<String> mNameValues) {
    final values = mNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'mName', values);
  }

  int deleteAllByMNameSync(List<String> mNameValues) {
    final values = mNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'mName', values);
  }

  Future<Id> putByMName(ModelData object) {
    return putByIndex(r'mName', object);
  }

  Id putByMNameSync(ModelData object, {bool saveLinks = true}) {
    return putByIndexSync(r'mName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByMName(List<ModelData> objects) {
    return putAllByIndex(r'mName', objects);
  }

  List<Id> putAllByMNameSync(List<ModelData> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'mName', objects, saveLinks: saveLinks);
  }
}

extension ModelDataQueryWhereSort
    on QueryBuilder<ModelData, ModelData, QWhere> {
  QueryBuilder<ModelData, ModelData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ModelDataQueryWhere
    on QueryBuilder<ModelData, ModelData, QWhereClause> {
  QueryBuilder<ModelData, ModelData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterWhereClause> mNameEqualTo(
      String mName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'mName',
        value: [mName],
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterWhereClause> mNameNotEqualTo(
      String mName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mName',
              lower: [],
              upper: [mName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mName',
              lower: [mName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mName',
              lower: [mName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'mName',
              lower: [],
              upper: [mName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ModelDataQueryFilter
    on QueryBuilder<ModelData, ModelData, QFilterCondition> {
  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'ext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'ext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'ext',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'ext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'ext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'ext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'ext',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'ext',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> extIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'ext',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> infoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'info',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> infoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'info',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> infoLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'info',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> infoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'info',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> infoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'info',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> infoLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'info',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition>
      infoLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'info',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> infoLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'info',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mName',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> mNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mName',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'policy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'policy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'policy',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> policyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'policy',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sUrl',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sUrl',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sUrl',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sUrl',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> sUrlIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sUrl',
        value: '',
      ));
    });
  }
}

extension ModelDataQueryObject
    on QueryBuilder<ModelData, ModelData, QFilterCondition> {
  QueryBuilder<ModelData, ModelData, QAfterFilterCondition> infoElement(
      FilterQuery<ModelInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'info');
    });
  }
}

extension ModelDataQueryLinks
    on QueryBuilder<ModelData, ModelData, QFilterCondition> {}

extension ModelDataQuerySortBy on QueryBuilder<ModelData, ModelData, QSortBy> {
  QueryBuilder<ModelData, ModelData, QAfterSortBy> sortByExt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ext', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> sortByExtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ext', Sort.desc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> sortByMName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mName', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> sortByMNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mName', Sort.desc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> sortByPolicy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'policy', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> sortByPolicyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'policy', Sort.desc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> sortBySUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sUrl', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> sortBySUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sUrl', Sort.desc);
    });
  }
}

extension ModelDataQuerySortThenBy
    on QueryBuilder<ModelData, ModelData, QSortThenBy> {
  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenByExt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ext', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenByExtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'ext', Sort.desc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenByMName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mName', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenByMNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mName', Sort.desc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenByPolicy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'policy', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenByPolicyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'policy', Sort.desc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenBySUrl() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sUrl', Sort.asc);
    });
  }

  QueryBuilder<ModelData, ModelData, QAfterSortBy> thenBySUrlDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sUrl', Sort.desc);
    });
  }
}

extension ModelDataQueryWhereDistinct
    on QueryBuilder<ModelData, ModelData, QDistinct> {
  QueryBuilder<ModelData, ModelData, QDistinct> distinctByExt(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'ext', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModelData, ModelData, QDistinct> distinctByMName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModelData, ModelData, QDistinct> distinctByPolicy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'policy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<ModelData, ModelData, QDistinct> distinctBySUrl(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sUrl', caseSensitive: caseSensitive);
    });
  }
}

extension ModelDataQueryProperty
    on QueryBuilder<ModelData, ModelData, QQueryProperty> {
  QueryBuilder<ModelData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ModelData, String, QQueryOperations> extProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'ext');
    });
  }

  QueryBuilder<ModelData, List<ModelInfo>?, QQueryOperations> infoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'info');
    });
  }

  QueryBuilder<ModelData, String, QQueryOperations> mNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mName');
    });
  }

  QueryBuilder<ModelData, String, QQueryOperations> policyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'policy');
    });
  }

  QueryBuilder<ModelData, String, QQueryOperations> sUrlProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sUrl');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetLocalModelDataCollection on Isar {
  IsarCollection<LocalModelData> get localModelDatas => this.collection();
}

const LocalModelDataSchema = CollectionSchema(
  name: r'LocalModelData',
  id: -4064965174486069147,
  properties: {
    r'fName': PropertySchema(
      id: 0,
      name: r'fName',
      type: IsarType.string,
    ),
    r'isSelect': PropertySchema(
      id: 1,
      name: r'isSelect',
      type: IsarType.bool,
    ),
    r'lmInfo': PropertySchema(
      id: 2,
      name: r'lmInfo',
      type: IsarType.object,
      target: r'LocalModelInfo',
    )
  },
  estimateSize: _localModelDataEstimateSize,
  serialize: _localModelDataSerialize,
  deserialize: _localModelDataDeserialize,
  deserializeProp: _localModelDataDeserializeProp,
  idName: r'id',
  indexes: {
    r'fName': IndexSchema(
      id: 354457879255014933,
      name: r'fName',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'fName',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'LocalModelInfo': LocalModelInfoSchema},
  getId: _localModelDataGetId,
  getLinks: _localModelDataGetLinks,
  attach: _localModelDataAttach,
  version: '1.0.10',
);

int _localModelDataEstimateSize(
  LocalModelData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.fName.length * 3;
  {
    final value = object.lmInfo;
    if (value != null) {
      bytesCount += 3 +
          LocalModelInfoSchema.estimateSize(
              value, allOffsets[LocalModelInfo]!, allOffsets);
    }
  }
  return bytesCount;
}

void _localModelDataSerialize(
  LocalModelData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.fName);
  writer.writeBool(offsets[1], object.isSelect);
  writer.writeObject<LocalModelInfo>(
    offsets[2],
    allOffsets,
    LocalModelInfoSchema.serialize,
    object.lmInfo,
  );
}

LocalModelData _localModelDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalModelData();
  object.fName = reader.readString(offsets[0]);
  object.id = id;
  object.isSelect = reader.readBool(offsets[1]);
  object.lmInfo = reader.readObjectOrNull<LocalModelInfo>(
    offsets[2],
    LocalModelInfoSchema.deserialize,
    allOffsets,
  );
  return object;
}

P _localModelDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readBool(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<LocalModelInfo>(
        offset,
        LocalModelInfoSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _localModelDataGetId(LocalModelData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _localModelDataGetLinks(LocalModelData object) {
  return [];
}

void _localModelDataAttach(
    IsarCollection<dynamic> col, Id id, LocalModelData object) {
  object.id = id;
}

extension LocalModelDataByIndex on IsarCollection<LocalModelData> {
  Future<LocalModelData?> getByFName(String fName) {
    return getByIndex(r'fName', [fName]);
  }

  LocalModelData? getByFNameSync(String fName) {
    return getByIndexSync(r'fName', [fName]);
  }

  Future<bool> deleteByFName(String fName) {
    return deleteByIndex(r'fName', [fName]);
  }

  bool deleteByFNameSync(String fName) {
    return deleteByIndexSync(r'fName', [fName]);
  }

  Future<List<LocalModelData?>> getAllByFName(List<String> fNameValues) {
    final values = fNameValues.map((e) => [e]).toList();
    return getAllByIndex(r'fName', values);
  }

  List<LocalModelData?> getAllByFNameSync(List<String> fNameValues) {
    final values = fNameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'fName', values);
  }

  Future<int> deleteAllByFName(List<String> fNameValues) {
    final values = fNameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'fName', values);
  }

  int deleteAllByFNameSync(List<String> fNameValues) {
    final values = fNameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'fName', values);
  }

  Future<Id> putByFName(LocalModelData object) {
    return putByIndex(r'fName', object);
  }

  Id putByFNameSync(LocalModelData object, {bool saveLinks = true}) {
    return putByIndexSync(r'fName', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByFName(List<LocalModelData> objects) {
    return putAllByIndex(r'fName', objects);
  }

  List<Id> putAllByFNameSync(List<LocalModelData> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'fName', objects, saveLinks: saveLinks);
  }
}

extension LocalModelDataQueryWhereSort
    on QueryBuilder<LocalModelData, LocalModelData, QWhere> {
  QueryBuilder<LocalModelData, LocalModelData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension LocalModelDataQueryWhere
    on QueryBuilder<LocalModelData, LocalModelData, QWhereClause> {
  QueryBuilder<LocalModelData, LocalModelData, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterWhereClause> idNotEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterWhereClause> fNameEqualTo(
      String fName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'fName',
        value: [fName],
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterWhereClause>
      fNameNotEqualTo(String fName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fName',
              lower: [],
              upper: [fName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fName',
              lower: [fName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fName',
              lower: [fName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'fName',
              lower: [],
              upper: [fName],
              includeUpper: false,
            ));
      }
    });
  }
}

extension LocalModelDataQueryFilter
    on QueryBuilder<LocalModelData, LocalModelData, QFilterCondition> {
  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fName',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      fNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fName',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      isSelectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isSelect',
        value: value,
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      lmInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lmInfo',
      ));
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition>
      lmInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lmInfo',
      ));
    });
  }
}

extension LocalModelDataQueryObject
    on QueryBuilder<LocalModelData, LocalModelData, QFilterCondition> {
  QueryBuilder<LocalModelData, LocalModelData, QAfterFilterCondition> lmInfo(
      FilterQuery<LocalModelInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lmInfo');
    });
  }
}

extension LocalModelDataQueryLinks
    on QueryBuilder<LocalModelData, LocalModelData, QFilterCondition> {}

extension LocalModelDataQuerySortBy
    on QueryBuilder<LocalModelData, LocalModelData, QSortBy> {
  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy> sortByFName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fName', Sort.asc);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy> sortByFNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fName', Sort.desc);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy> sortByIsSelect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelect', Sort.asc);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy>
      sortByIsSelectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelect', Sort.desc);
    });
  }
}

extension LocalModelDataQuerySortThenBy
    on QueryBuilder<LocalModelData, LocalModelData, QSortThenBy> {
  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy> thenByFName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fName', Sort.asc);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy> thenByFNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fName', Sort.desc);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy> thenByIsSelect() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelect', Sort.asc);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QAfterSortBy>
      thenByIsSelectDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isSelect', Sort.desc);
    });
  }
}

extension LocalModelDataQueryWhereDistinct
    on QueryBuilder<LocalModelData, LocalModelData, QDistinct> {
  QueryBuilder<LocalModelData, LocalModelData, QDistinct> distinctByFName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<LocalModelData, LocalModelData, QDistinct> distinctByIsSelect() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isSelect');
    });
  }
}

extension LocalModelDataQueryProperty
    on QueryBuilder<LocalModelData, LocalModelData, QQueryProperty> {
  QueryBuilder<LocalModelData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<LocalModelData, String, QQueryOperations> fNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fName');
    });
  }

  QueryBuilder<LocalModelData, bool, QQueryOperations> isSelectProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isSelect');
    });
  }

  QueryBuilder<LocalModelData, LocalModelInfo?, QQueryOperations>
      lmInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lmInfo');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChatDataCollection on Isar {
  IsarCollection<ChatData> get chatDatas => this.collection();
}

const ChatDataSchema = CollectionSchema(
  name: r'ChatData',
  id: -2556562556259390621,
  properties: {
    r'cId': PropertySchema(
      id: 0,
      name: r'cId',
      type: IsarType.string,
    ),
    r'cInfo': PropertySchema(
      id: 1,
      name: r'cInfo',
      type: IsarType.objectList,
      target: r'ChatInfo',
    ),
    r'lmInfo': PropertySchema(
      id: 2,
      name: r'lmInfo',
      type: IsarType.object,
      target: r'LocalModelInfo',
    )
  },
  estimateSize: _chatDataEstimateSize,
  serialize: _chatDataSerialize,
  deserialize: _chatDataDeserialize,
  deserializeProp: _chatDataDeserializeProp,
  idName: r'id',
  indexes: {
    r'cId': IndexSchema(
      id: 9156665231097638132,
      name: r'cId',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'cId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {
    r'LocalModelInfo': LocalModelInfoSchema,
    r'ChatInfo': ChatInfoSchema
  },
  getId: _chatDataGetId,
  getLinks: _chatDataGetLinks,
  attach: _chatDataAttach,
  version: '1.0.10',
);

int _chatDataEstimateSize(
  ChatData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.cId.length * 3;
  {
    final list = object.cInfo;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        final offsets = allOffsets[ChatInfo]!;
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += ChatInfoSchema.estimateSize(value, offsets, allOffsets);
        }
      }
    }
  }
  {
    final value = object.lmInfo;
    if (value != null) {
      bytesCount += 3 +
          LocalModelInfoSchema.estimateSize(
              value, allOffsets[LocalModelInfo]!, allOffsets);
    }
  }
  return bytesCount;
}

void _chatDataSerialize(
  ChatData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cId);
  writer.writeObjectList<ChatInfo>(
    offsets[1],
    allOffsets,
    ChatInfoSchema.serialize,
    object.cInfo,
  );
  writer.writeObject<LocalModelInfo>(
    offsets[2],
    allOffsets,
    LocalModelInfoSchema.serialize,
    object.lmInfo,
  );
}

ChatData _chatDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatData();
  object.cId = reader.readString(offsets[0]);
  object.cInfo = reader.readObjectList<ChatInfo>(
    offsets[1],
    ChatInfoSchema.deserialize,
    allOffsets,
    ChatInfo(),
  );
  object.id = id;
  object.lmInfo = reader.readObjectOrNull<LocalModelInfo>(
    offsets[2],
    LocalModelInfoSchema.deserialize,
    allOffsets,
  );
  return object;
}

P _chatDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<ChatInfo>(
        offset,
        ChatInfoSchema.deserialize,
        allOffsets,
        ChatInfo(),
      )) as P;
    case 2:
      return (reader.readObjectOrNull<LocalModelInfo>(
        offset,
        LocalModelInfoSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _chatDataGetId(ChatData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _chatDataGetLinks(ChatData object) {
  return [];
}

void _chatDataAttach(IsarCollection<dynamic> col, Id id, ChatData object) {
  object.id = id;
}

extension ChatDataByIndex on IsarCollection<ChatData> {
  Future<ChatData?> getByCId(String cId) {
    return getByIndex(r'cId', [cId]);
  }

  ChatData? getByCIdSync(String cId) {
    return getByIndexSync(r'cId', [cId]);
  }

  Future<bool> deleteByCId(String cId) {
    return deleteByIndex(r'cId', [cId]);
  }

  bool deleteByCIdSync(String cId) {
    return deleteByIndexSync(r'cId', [cId]);
  }

  Future<List<ChatData?>> getAllByCId(List<String> cIdValues) {
    final values = cIdValues.map((e) => [e]).toList();
    return getAllByIndex(r'cId', values);
  }

  List<ChatData?> getAllByCIdSync(List<String> cIdValues) {
    final values = cIdValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'cId', values);
  }

  Future<int> deleteAllByCId(List<String> cIdValues) {
    final values = cIdValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'cId', values);
  }

  int deleteAllByCIdSync(List<String> cIdValues) {
    final values = cIdValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'cId', values);
  }

  Future<Id> putByCId(ChatData object) {
    return putByIndex(r'cId', object);
  }

  Id putByCIdSync(ChatData object, {bool saveLinks = true}) {
    return putByIndexSync(r'cId', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByCId(List<ChatData> objects) {
    return putAllByIndex(r'cId', objects);
  }

  List<Id> putAllByCIdSync(List<ChatData> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'cId', objects, saveLinks: saveLinks);
  }
}

extension ChatDataQueryWhereSort on QueryBuilder<ChatData, ChatData, QWhere> {
  QueryBuilder<ChatData, ChatData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChatDataQueryWhere on QueryBuilder<ChatData, ChatData, QWhereClause> {
  QueryBuilder<ChatData, ChatData, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterWhereClause> idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterWhereClause> idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterWhereClause> cIdEqualTo(String cId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'cId',
        value: [cId],
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterWhereClause> cIdNotEqualTo(
      String cId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cId',
              lower: [],
              upper: [cId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cId',
              lower: [cId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cId',
              lower: [cId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'cId',
              lower: [],
              upper: [cId],
              includeUpper: false,
            ));
      }
    });
  }
}

extension ChatDataQueryFilter
    on QueryBuilder<ChatData, ChatData, QFilterCondition> {
  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cId',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cInfo',
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cInfo',
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cInfoLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cInfo',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cInfoIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cInfo',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cInfoIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cInfo',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cInfoLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cInfo',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition>
      cInfoLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cInfo',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cInfoLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cInfo',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> lmInfoIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lmInfo',
      ));
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> lmInfoIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lmInfo',
      ));
    });
  }
}

extension ChatDataQueryObject
    on QueryBuilder<ChatData, ChatData, QFilterCondition> {
  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> cInfoElement(
      FilterQuery<ChatInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'cInfo');
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterFilterCondition> lmInfo(
      FilterQuery<LocalModelInfo> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'lmInfo');
    });
  }
}

extension ChatDataQueryLinks
    on QueryBuilder<ChatData, ChatData, QFilterCondition> {}

extension ChatDataQuerySortBy on QueryBuilder<ChatData, ChatData, QSortBy> {
  QueryBuilder<ChatData, ChatData, QAfterSortBy> sortByCId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cId', Sort.asc);
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterSortBy> sortByCIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cId', Sort.desc);
    });
  }
}

extension ChatDataQuerySortThenBy
    on QueryBuilder<ChatData, ChatData, QSortThenBy> {
  QueryBuilder<ChatData, ChatData, QAfterSortBy> thenByCId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cId', Sort.asc);
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterSortBy> thenByCIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'cId', Sort.desc);
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChatData, ChatData, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }
}

extension ChatDataQueryWhereDistinct
    on QueryBuilder<ChatData, ChatData, QDistinct> {
  QueryBuilder<ChatData, ChatData, QDistinct> distinctByCId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'cId', caseSensitive: caseSensitive);
    });
  }
}

extension ChatDataQueryProperty
    on QueryBuilder<ChatData, ChatData, QQueryProperty> {
  QueryBuilder<ChatData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChatData, String, QQueryOperations> cIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cId');
    });
  }

  QueryBuilder<ChatData, List<ChatInfo>?, QQueryOperations> cInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'cInfo');
    });
  }

  QueryBuilder<ChatData, LocalModelInfo?, QQueryOperations> lmInfoProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lmInfo');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ModelInfoSchema = Schema(
  name: r'ModelInfo',
  id: 1358516549140155991,
  properties: {
    r'hasDownloaded': PropertySchema(
      id: 0,
      name: r'hasDownloaded',
      type: IsarType.bool,
    ),
    r'hash': PropertySchema(
      id: 1,
      name: r'hash',
      type: IsarType.string,
    ),
    r'quantMethod': PropertySchema(
      id: 2,
      name: r'quantMethod',
      type: IsarType.string,
    ),
    r'size': PropertySchema(
      id: 3,
      name: r'size',
      type: IsarType.string,
    )
  },
  estimateSize: _modelInfoEstimateSize,
  serialize: _modelInfoSerialize,
  deserialize: _modelInfoDeserialize,
  deserializeProp: _modelInfoDeserializeProp,
);

int _modelInfoEstimateSize(
  ModelInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.hash;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.quantMethod;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.size;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _modelInfoSerialize(
  ModelInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.hasDownloaded);
  writer.writeString(offsets[1], object.hash);
  writer.writeString(offsets[2], object.quantMethod);
  writer.writeString(offsets[3], object.size);
}

ModelInfo _modelInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ModelInfo();
  object.hasDownloaded = reader.readBoolOrNull(offsets[0]);
  object.hash = reader.readStringOrNull(offsets[1]);
  object.quantMethod = reader.readStringOrNull(offsets[2]);
  object.size = reader.readStringOrNull(offsets[3]);
  return object;
}

P _modelInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    case 3:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ModelInfoQueryFilter
    on QueryBuilder<ModelInfo, ModelInfo, QFilterCondition> {
  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      hasDownloadedIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hasDownloaded',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      hasDownloadedIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hasDownloaded',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      hasDownloadedEqualTo(bool? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasDownloaded',
        value: value,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'hash',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'hash',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hash',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'hash',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'hash',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hash',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> hashIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'hash',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      quantMethodIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'quantMethod',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      quantMethodIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'quantMethod',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> quantMethodEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      quantMethodGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> quantMethodLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> quantMethodBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      quantMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> quantMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> quantMethodContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> quantMethodMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quantMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      quantMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition>
      quantMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quantMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'size',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'size',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'size',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'size',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'size',
        value: '',
      ));
    });
  }

  QueryBuilder<ModelInfo, ModelInfo, QAfterFilterCondition> sizeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'size',
        value: '',
      ));
    });
  }
}

extension ModelInfoQueryObject
    on QueryBuilder<ModelInfo, ModelInfo, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LocalModelInfoSchema = Schema(
  name: r'LocalModelInfo',
  id: 4420714860981192413,
  properties: {
    r'mName': PropertySchema(
      id: 0,
      name: r'mName',
      type: IsarType.string,
    ),
    r'mPath': PropertySchema(
      id: 1,
      name: r'mPath',
      type: IsarType.string,
    ),
    r'policy': PropertySchema(
      id: 2,
      name: r'policy',
      type: IsarType.string,
    ),
    r'quantMethod': PropertySchema(
      id: 3,
      name: r'quantMethod',
      type: IsarType.string,
    )
  },
  estimateSize: _localModelInfoEstimateSize,
  serialize: _localModelInfoSerialize,
  deserialize: _localModelInfoDeserialize,
  deserializeProp: _localModelInfoDeserializeProp,
);

int _localModelInfoEstimateSize(
  LocalModelInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.mName.length * 3;
  bytesCount += 3 + object.mPath.length * 3;
  bytesCount += 3 + object.policy.length * 3;
  bytesCount += 3 + object.quantMethod.length * 3;
  return bytesCount;
}

void _localModelInfoSerialize(
  LocalModelInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.mName);
  writer.writeString(offsets[1], object.mPath);
  writer.writeString(offsets[2], object.policy);
  writer.writeString(offsets[3], object.quantMethod);
}

LocalModelInfo _localModelInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalModelInfo();
  object.mName = reader.readString(offsets[0]);
  object.mPath = reader.readString(offsets[1]);
  object.policy = reader.readString(offsets[2]);
  object.quantMethod = reader.readString(offsets[3]);
  return object;
}

P _localModelInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LocalModelInfoQueryFilter
    on QueryBuilder<LocalModelInfo, LocalModelInfo, QFilterCondition> {
  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mName',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mName',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'mPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'mPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'mPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'mPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mPath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      mPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'mPath',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'policy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'policy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'policy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'policy',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      policyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'policy',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quantMethod',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quantMethod',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quantMethod',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quantMethod',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalModelInfo, LocalModelInfo, QAfterFilterCondition>
      quantMethodIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quantMethod',
        value: '',
      ));
    });
  }
}

extension LocalModelInfoQueryObject
    on QueryBuilder<LocalModelInfo, LocalModelInfo, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const ChatInfoSchema = Schema(
  name: r'ChatInfo',
  id: -6411271119876511933,
  properties: {
    r'content': PropertySchema(
      id: 0,
      name: r'content',
      type: IsarType.string,
    ),
    r'time': PropertySchema(
      id: 1,
      name: r'time',
      type: IsarType.long,
    ),
    r'uName': PropertySchema(
      id: 2,
      name: r'uName',
      type: IsarType.string,
    )
  },
  estimateSize: _chatInfoEstimateSize,
  serialize: _chatInfoSerialize,
  deserialize: _chatInfoDeserialize,
  deserializeProp: _chatInfoDeserializeProp,
);

int _chatInfoEstimateSize(
  ChatInfo object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.content;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.uName;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _chatInfoSerialize(
  ChatInfo object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.content);
  writer.writeLong(offsets[1], object.time);
  writer.writeString(offsets[2], object.uName);
}

ChatInfo _chatInfoDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChatInfo();
  object.content = reader.readStringOrNull(offsets[0]);
  object.time = reader.readLongOrNull(offsets[1]);
  object.uName = reader.readStringOrNull(offsets[2]);
  return object;
}

P _chatInfoDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension ChatInfoQueryFilter
    on QueryBuilder<ChatInfo, ChatInfo, QFilterCondition> {
  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'content',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'content',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'content',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'content',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> contentIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'content',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> timeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'time',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> timeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'time',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> timeEqualTo(
      int? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> timeGreaterThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> timeLessThan(
    int? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'time',
        value: value,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> timeBetween(
    int? lower,
    int? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'time',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'uName',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'uName',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uName',
        value: '',
      ));
    });
  }

  QueryBuilder<ChatInfo, ChatInfo, QAfterFilterCondition> uNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uName',
        value: '',
      ));
    });
  }
}

extension ChatInfoQueryObject
    on QueryBuilder<ChatInfo, ChatInfo, QFilterCondition> {}
