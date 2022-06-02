// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
      matchesInvitations: (json['matchesInvitations'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      id: json['_id'] as String?,
      username: json['username'] as String?,
      email: json['email'] as String?,
      name: json['name'] as String?,
      surname: json['surname'] as String?,
      password: json['password'] as String?,
      gender: json['gender'] as String?,
      level: (json['level'] as num?)?.toDouble(),
      friends:
          (json['friends'] as List<dynamic>?)?.map((e) => e as String).toList(),
      friendsRequests: (json['friendsRequests'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      position: json['position'] as String?,
      image: json['image'] as String?,
      isAdmin: json['isAdmin'] as bool? ?? false,
    );

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
      '_id': instance.id,
      'username': instance.username,
      'email': instance.email,
      'name': instance.name,
      'surname': instance.surname,
      'password': instance.password,
      'gender': instance.gender,
      'position': instance.position,
      'image': instance.image,
      'level': instance.level,
      'friends': instance.friends,
      'friendsRequests': instance.friendsRequests,
      'matchesInvitations': instance.matchesInvitations,
      'isAdmin': instance.isAdmin,
    };
