// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_fact.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatFact _$CatFactFromJson(Map<String, dynamic> json) => CatFact(
  fact: json['fact'] as String,
  length: (json['length'] as num).toInt(),
);

Map<String, dynamic> _$CatFactToJson(CatFact instance) => <String, dynamic>{
  'fact': instance.fact,
  'length': instance.length,
};
