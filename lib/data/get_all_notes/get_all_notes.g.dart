// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get_all_notes.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetAllNotes _$GetAllNotesFromJson(Map<String, dynamic> json) => GetAllNotes(
      data: (json['data'] as List<dynamic>?)
              ?.map((e) => NoteModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$GetAllNotesToJson(GetAllNotes instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
