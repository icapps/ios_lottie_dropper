///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBTEAMAdminTier;
@class DBTEAMMemberAddArg;

#pragma mark - API Object

///
/// The `MemberAddArg` struct.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBTEAMMemberAddArg : NSObject <DBSerializable>

#pragma mark - Instance fields

/// (no description).
@property (nonatomic, readonly, copy) NSString * _Nonnull memberEmail;

/// Member's first name.
@property (nonatomic, readonly, copy) NSString * _Nonnull memberGivenName;

/// Member's last name.
@property (nonatomic, readonly, copy) NSString * _Nonnull memberSurname;

/// External ID for member.
@property (nonatomic, readonly) NSString * _Nullable memberExternalId;

/// Persistent ID for member. This field is only available to teams using
/// persistent ID SAML configuration.
@property (nonatomic, readonly) NSString * _Nullable memberPersistentId;

/// Whether to send a welcome email to the member. If send_welcome_email is
/// false, no email invitation will be sent to the user. This may be useful for
/// apps using single sign-on (SSO) flows for onboarding that want to handle
/// announcements themselves.
@property (nonatomic, readonly) NSNumber * _Nonnull sendWelcomeEmail;

/// (no description).
@property (nonatomic, readonly) DBTEAMAdminTier * _Nonnull role;

#pragma mark - Constructors

///
/// Full constructor for the struct (exposes all instance variables).
///
/// @param memberEmail (no description).
/// @param memberGivenName Member's first name.
/// @param memberSurname Member's last name.
/// @param memberExternalId External ID for member.
/// @param memberPersistentId Persistent ID for member. This field is only
/// available to teams using persistent ID SAML configuration.
/// @param sendWelcomeEmail Whether to send a welcome email to the member. If
/// send_welcome_email is false, no email invitation will be sent to the user.
/// This may be useful for apps using single sign-on (SSO) flows for onboarding
/// that want to handle announcements themselves.
/// @param role (no description).
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithMemberEmail:(NSString * _Nonnull)memberEmail
                            memberGivenName:(NSString * _Nonnull)memberGivenName
                              memberSurname:(NSString * _Nonnull)memberSurname
                           memberExternalId:(NSString * _Nullable)memberExternalId
                         memberPersistentId:(NSString * _Nullable)memberPersistentId
                           sendWelcomeEmail:(NSNumber * _Nullable)sendWelcomeEmail
                                       role:(DBTEAMAdminTier * _Nullable)role;

///
/// Convenience constructor (exposes only non-nullable instance variables with
/// no default value).
///
/// @param memberEmail (no description).
/// @param memberGivenName Member's first name.
/// @param memberSurname Member's last name.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithMemberEmail:(NSString * _Nonnull)memberEmail
                            memberGivenName:(NSString * _Nonnull)memberGivenName
                              memberSurname:(NSString * _Nonnull)memberSurname;

@end

#pragma mark - Serializer Object

///
/// The serialization class for the `MemberAddArg` struct.
///
@interface DBTEAMMemberAddArgSerializer : NSObject

///
/// Serializes `DBTEAMMemberAddArg` instances.
///
/// @param instance An instance of the `DBTEAMMemberAddArg` API object.
///
/// @return A json-compatible dictionary representation of the
/// `DBTEAMMemberAddArg` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBTEAMMemberAddArg * _Nonnull)instance;

///
/// Deserializes `DBTEAMMemberAddArg` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBTEAMMemberAddArg` API object.
///
/// @return An instantiation of the `DBTEAMMemberAddArg` object.
///
+ (DBTEAMMemberAddArg * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
