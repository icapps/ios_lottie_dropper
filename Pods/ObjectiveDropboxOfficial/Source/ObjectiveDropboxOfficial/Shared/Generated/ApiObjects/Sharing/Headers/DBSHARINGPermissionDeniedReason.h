///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBSHARINGPermissionDeniedReason;

#pragma mark - API Object

///
/// The `PermissionDeniedReason` union.
///
/// Possible reasons the user is denied a permission.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBSHARINGPermissionDeniedReason : NSObject <DBSerializable>

#pragma mark - Instance fields

/// The `DBSHARINGPermissionDeniedReasonTag` enum type represents the possible
/// tag states with which the `DBSHARINGPermissionDeniedReason` union can exist.
typedef NS_ENUM(NSInteger, DBSHARINGPermissionDeniedReasonTag) {
  /// User is not on the same team as the folder owner.
  DBSHARINGPermissionDeniedReasonUserNotSameTeamAsOwner,

  /// User is prohibited by the owner from taking the action.
  DBSHARINGPermissionDeniedReasonUserNotAllowedByOwner,

  /// Target is indirectly a member of the folder, for example by being part
  /// of a group.
  DBSHARINGPermissionDeniedReasonTargetIsIndirectMember,

  /// Target is the owner of the folder.
  DBSHARINGPermissionDeniedReasonTargetIsOwner,

  /// Target is the user itself.
  DBSHARINGPermissionDeniedReasonTargetIsSelf,

  /// Target is not an active member of the team.
  DBSHARINGPermissionDeniedReasonTargetNotActive,

  /// Folder is team folder for a limited team.
  DBSHARINGPermissionDeniedReasonFolderIsLimitedTeamFolder,

  /// The content owner needs to be on a Dropbox team to perform this action.
  DBSHARINGPermissionDeniedReasonOwnerNotOnTeam,

  /// The user does not have permission to perform this action on the link.
  DBSHARINGPermissionDeniedReasonPermissionDenied,

  /// The user's team policy prevents performing this action on the link.
  DBSHARINGPermissionDeniedReasonRestrictedByTeam,

  /// The user's account type does not support this action.
  DBSHARINGPermissionDeniedReasonUserAccountType,

  /// The user needs to be on a Dropbox team to perform this action.
  DBSHARINGPermissionDeniedReasonUserNotOnTeam,

  /// Folder is inside of another shared folder.
  DBSHARINGPermissionDeniedReasonFolderIsInsideSharedFolder,

  /// (no description).
  DBSHARINGPermissionDeniedReasonOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBSHARINGPermissionDeniedReasonTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "user_not_same_team_as_owner".
///
/// Description of the "user_not_same_team_as_owner" tag state: User is not on
/// the same team as the folder owner.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithUserNotSameTeamAsOwner;

///
/// Initializes union class with tag state of "user_not_allowed_by_owner".
///
/// Description of the "user_not_allowed_by_owner" tag state: User is prohibited
/// by the owner from taking the action.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithUserNotAllowedByOwner;

///
/// Initializes union class with tag state of "target_is_indirect_member".
///
/// Description of the "target_is_indirect_member" tag state: Target is
/// indirectly a member of the folder, for example by being part of a group.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithTargetIsIndirectMember;

///
/// Initializes union class with tag state of "target_is_owner".
///
/// Description of the "target_is_owner" tag state: Target is the owner of the
/// folder.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithTargetIsOwner;

///
/// Initializes union class with tag state of "target_is_self".
///
/// Description of the "target_is_self" tag state: Target is the user itself.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithTargetIsSelf;

///
/// Initializes union class with tag state of "target_not_active".
///
/// Description of the "target_not_active" tag state: Target is not an active
/// member of the team.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithTargetNotActive;

///
/// Initializes union class with tag state of "folder_is_limited_team_folder".
///
/// Description of the "folder_is_limited_team_folder" tag state: Folder is team
/// folder for a limited team.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithFolderIsLimitedTeamFolder;

///
/// Initializes union class with tag state of "owner_not_on_team".
///
/// Description of the "owner_not_on_team" tag state: The content owner needs to
/// be on a Dropbox team to perform this action.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithOwnerNotOnTeam;

///
/// Initializes union class with tag state of "permission_denied".
///
/// Description of the "permission_denied" tag state: The user does not have
/// permission to perform this action on the link.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithPermissionDenied;

///
/// Initializes union class with tag state of "restricted_by_team".
///
/// Description of the "restricted_by_team" tag state: The user's team policy
/// prevents performing this action on the link.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithRestrictedByTeam;

///
/// Initializes union class with tag state of "user_account_type".
///
/// Description of the "user_account_type" tag state: The user's account type
/// does not support this action.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithUserAccountType;

///
/// Initializes union class with tag state of "user_not_on_team".
///
/// Description of the "user_not_on_team" tag state: The user needs to be on a
/// Dropbox team to perform this action.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithUserNotOnTeam;

///
/// Initializes union class with tag state of "folder_is_inside_shared_folder".
///
/// Description of the "folder_is_inside_shared_folder" tag state: Folder is
/// inside of another shared folder.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithFolderIsInsideSharedFolder;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithOther;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value
/// "user_not_same_team_as_owner".
///
/// @return Whether the union's current tag state has value
/// "user_not_same_team_as_owner".
///
- (BOOL)isUserNotSameTeamAsOwner;

///
/// Retrieves whether the union's current tag state has value
/// "user_not_allowed_by_owner".
///
/// @return Whether the union's current tag state has value
/// "user_not_allowed_by_owner".
///
- (BOOL)isUserNotAllowedByOwner;

///
/// Retrieves whether the union's current tag state has value
/// "target_is_indirect_member".
///
/// @return Whether the union's current tag state has value
/// "target_is_indirect_member".
///
- (BOOL)isTargetIsIndirectMember;

///
/// Retrieves whether the union's current tag state has value "target_is_owner".
///
/// @return Whether the union's current tag state has value "target_is_owner".
///
- (BOOL)isTargetIsOwner;

///
/// Retrieves whether the union's current tag state has value "target_is_self".
///
/// @return Whether the union's current tag state has value "target_is_self".
///
- (BOOL)isTargetIsSelf;

///
/// Retrieves whether the union's current tag state has value
/// "target_not_active".
///
/// @return Whether the union's current tag state has value "target_not_active".
///
- (BOOL)isTargetNotActive;

///
/// Retrieves whether the union's current tag state has value
/// "folder_is_limited_team_folder".
///
/// @return Whether the union's current tag state has value
/// "folder_is_limited_team_folder".
///
- (BOOL)isFolderIsLimitedTeamFolder;

///
/// Retrieves whether the union's current tag state has value
/// "owner_not_on_team".
///
/// @return Whether the union's current tag state has value "owner_not_on_team".
///
- (BOOL)isOwnerNotOnTeam;

///
/// Retrieves whether the union's current tag state has value
/// "permission_denied".
///
/// @return Whether the union's current tag state has value "permission_denied".
///
- (BOOL)isPermissionDenied;

///
/// Retrieves whether the union's current tag state has value
/// "restricted_by_team".
///
/// @return Whether the union's current tag state has value
/// "restricted_by_team".
///
- (BOOL)isRestrictedByTeam;

///
/// Retrieves whether the union's current tag state has value
/// "user_account_type".
///
/// @return Whether the union's current tag state has value "user_account_type".
///
- (BOOL)isUserAccountType;

///
/// Retrieves whether the union's current tag state has value
/// "user_not_on_team".
///
/// @return Whether the union's current tag state has value "user_not_on_team".
///
- (BOOL)isUserNotOnTeam;

///
/// Retrieves whether the union's current tag state has value
/// "folder_is_inside_shared_folder".
///
/// @return Whether the union's current tag state has value
/// "folder_is_inside_shared_folder".
///
- (BOOL)isFolderIsInsideSharedFolder;

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
/// The serialization class for the `DBSHARINGPermissionDeniedReason` union.
///
@interface DBSHARINGPermissionDeniedReasonSerializer : NSObject

///
/// Serializes `DBSHARINGPermissionDeniedReason` instances.
///
/// @param instance An instance of the `DBSHARINGPermissionDeniedReason` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBSHARINGPermissionDeniedReason` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBSHARINGPermissionDeniedReason * _Nonnull)instance;

///
/// Deserializes `DBSHARINGPermissionDeniedReason` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBSHARINGPermissionDeniedReason` API object.
///
/// @return An instantiation of the `DBSHARINGPermissionDeniedReason` object.
///
+ (DBSHARINGPermissionDeniedReason * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
