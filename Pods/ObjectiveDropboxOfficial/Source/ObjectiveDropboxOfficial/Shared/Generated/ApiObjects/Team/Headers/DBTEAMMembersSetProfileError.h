///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMMembersSetProfileError;

#pragma mark - API Object

///
/// The `MembersSetProfileError` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMMembersSetProfileError : NSObject <DBSerializable>

#pragma mark - Instance fields

/// The `DBTEAMMembersSetProfileErrorTag` enum type represents the possible tag
/// states with which the `DBTEAMMembersSetProfileError` union can exist.
typedef NS_ENUM(NSInteger, DBTEAMMembersSetProfileErrorTag) {
  /// No matching user found. The provided team_member_id, email, or
  /// external_id does not exist on this team.
  DBTEAMMembersSetProfileErrorUserNotFound,

  /// The user is not a member of the team.
  DBTEAMMembersSetProfileErrorUserNotInTeam,

  /// It is unsafe to use both external_id and new_external_id
  DBTEAMMembersSetProfileErrorExternalIdAndNewExternalIdUnsafe,

  /// None of new_email, new_given_name, new_surname, or new_external_id are
  /// specified
  DBTEAMMembersSetProfileErrorNoNewDataSpecified,

  /// Email is already reserved for another user.
  DBTEAMMembersSetProfileErrorEmailReservedForOtherUser,

  /// The external ID is already in use by another team member.
  DBTEAMMembersSetProfileErrorExternalIdUsedByOtherUser,

  /// Pending team member's email cannot be modified.
  DBTEAMMembersSetProfileErrorSetProfileDisallowed,

  /// Parameter new_email cannot be empty.
  DBTEAMMembersSetProfileErrorParamCannotBeEmpty,

  /// Persistent ID is only available to teams with persistent ID SAML
  /// configuration. Please contact Dropbox for more information.
  DBTEAMMembersSetProfileErrorPersistentIdDisabled,

  /// The persistent ID is already in use by another team member.
  DBTEAMMembersSetProfileErrorPersistentIdUsedByOtherUser,

  /// (no description).
  DBTEAMMembersSetProfileErrorOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBTEAMMembersSetProfileErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "user_not_found".
///
/// Description of the "user_not_found" tag state: No matching user found. The
/// provided team_member_id, email, or external_id does not exist on this team.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithUserNotFound;

///
/// Initializes union class with tag state of "user_not_in_team".
///
/// Description of the "user_not_in_team" tag state: The user is not a member of
/// the team.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithUserNotInTeam;

///
/// Initializes union class with tag state of
/// "external_id_and_new_external_id_unsafe".
///
/// Description of the "external_id_and_new_external_id_unsafe" tag state: It is
/// unsafe to use both external_id and new_external_id
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithExternalIdAndNewExternalIdUnsafe;

///
/// Initializes union class with tag state of "no_new_data_specified".
///
/// Description of the "no_new_data_specified" tag state: None of new_email,
/// new_given_name, new_surname, or new_external_id are specified
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithNoNewDataSpecified;

///
/// Initializes union class with tag state of "email_reserved_for_other_user".
///
/// Description of the "email_reserved_for_other_user" tag state: Email is
/// already reserved for another user.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithEmailReservedForOtherUser;

///
/// Initializes union class with tag state of "external_id_used_by_other_user".
///
/// Description of the "external_id_used_by_other_user" tag state: The external
/// ID is already in use by another team member.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithExternalIdUsedByOtherUser;

///
/// Initializes union class with tag state of "set_profile_disallowed".
///
/// Description of the "set_profile_disallowed" tag state: Pending team member's
/// email cannot be modified.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithSetProfileDisallowed;

///
/// Initializes union class with tag state of "param_cannot_be_empty".
///
/// Description of the "param_cannot_be_empty" tag state: Parameter new_email
/// cannot be empty.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithParamCannotBeEmpty;

///
/// Initializes union class with tag state of "persistent_id_disabled".
///
/// Description of the "persistent_id_disabled" tag state: Persistent ID is only
/// available to teams with persistent ID SAML configuration. Please contact
/// Dropbox for more information.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithPersistentIdDisabled;

///
/// Initializes union class with tag state of
/// "persistent_id_used_by_other_user".
///
/// Description of the "persistent_id_used_by_other_user" tag state: The
/// persistent ID is already in use by another team member.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithPersistentIdUsedByOtherUser;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithOther;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "user_not_found".
///
/// @return Whether the union's current tag state has value "user_not_found".
///
- (BOOL)isUserNotFound;

///
/// Retrieves whether the union's current tag state has value
/// "user_not_in_team".
///
/// @return Whether the union's current tag state has value "user_not_in_team".
///
- (BOOL)isUserNotInTeam;

///
/// Retrieves whether the union's current tag state has value
/// "external_id_and_new_external_id_unsafe".
///
/// @return Whether the union's current tag state has value
/// "external_id_and_new_external_id_unsafe".
///
- (BOOL)isExternalIdAndNewExternalIdUnsafe;

///
/// Retrieves whether the union's current tag state has value
/// "no_new_data_specified".
///
/// @return Whether the union's current tag state has value
/// "no_new_data_specified".
///
- (BOOL)isNoNewDataSpecified;

///
/// Retrieves whether the union's current tag state has value
/// "email_reserved_for_other_user".
///
/// @return Whether the union's current tag state has value
/// "email_reserved_for_other_user".
///
- (BOOL)isEmailReservedForOtherUser;

///
/// Retrieves whether the union's current tag state has value
/// "external_id_used_by_other_user".
///
/// @return Whether the union's current tag state has value
/// "external_id_used_by_other_user".
///
- (BOOL)isExternalIdUsedByOtherUser;

///
/// Retrieves whether the union's current tag state has value
/// "set_profile_disallowed".
///
/// @return Whether the union's current tag state has value
/// "set_profile_disallowed".
///
- (BOOL)isSetProfileDisallowed;

///
/// Retrieves whether the union's current tag state has value
/// "param_cannot_be_empty".
///
/// @return Whether the union's current tag state has value
/// "param_cannot_be_empty".
///
- (BOOL)isParamCannotBeEmpty;

///
/// Retrieves whether the union's current tag state has value
/// "persistent_id_disabled".
///
/// @return Whether the union's current tag state has value
/// "persistent_id_disabled".
///
- (BOOL)isPersistentIdDisabled;

///
/// Retrieves whether the union's current tag state has value
/// "persistent_id_used_by_other_user".
///
/// @return Whether the union's current tag state has value
/// "persistent_id_used_by_other_user".
///
- (BOOL)isPersistentIdUsedByOtherUser;

///
/// Retrieves whether the union's current tag state has value "other".
///
/// @return Whether the union's current tag state has value "other".
///
- (BOOL)isOther;

///
/// Retrieves string value of union's current tag state.
///
/// @return A human-readable string representing the union's current tag state.
///
- (NSString * _Nonnull)tagName;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `DBTEAMMembersSetProfileError` union.
///
@interface DBTEAMMembersSetProfileErrorSerializer : NSObject

///
/// Serializes `DBTEAMMembersSetProfileError` instances.
///
/// @param instance An instance of the `DBTEAMMembersSetProfileError` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMMembersSetProfileError` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBTEAMMembersSetProfileError * _Nonnull)instance;

///
/// Deserializes `DBTEAMMembersSetProfileError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMMembersSetProfileError` API object.
///
/// @return An instantiation of the `DBTEAMMembersSetProfileError` object.
///
+ (DBTEAMMembersSetProfileError * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
