///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import <Foundation/Foundation.h>

#import "DBSerializableProtocol.h"

@class DBSHARINGListFoldersContinueError;

#pragma mark - API Object

///
/// The `ListFoldersContinueError` union.
///
/// This class implements the `DBSerializable` protocol (serialize and
/// deserialize instance methods), which is required for all Obj-C SDK API route
/// objects.
///
@interface DBSHARINGListFoldersContinueError : NSObject <DBSerializable>

#pragma mark - Instance fields

/// The `DBSHARINGListFoldersContinueErrorTag` enum type represents the possible
/// tag states with which the `DBSHARINGListFoldersContinueError` union can
/// exist.
typedef NS_ENUM(NSInteger, DBSHARINGListFoldersContinueErrorTag) {
  /// `cursor` in `DBSHARINGListFoldersContinueArg` is invalid.
  DBSHARINGListFoldersContinueErrorInvalidCursor,

  /// (no description).
  DBSHARINGListFoldersContinueErrorOther,

};

/// Represents the union's current tag state.
@property (nonatomic, readonly) DBSHARINGListFoldersContinueErrorTag tag;

#pragma mark - Constructors

///
/// Initializes union class with tag state of "invalid_cursor".
///
/// Description of the "invalid_cursor" tag state: `cursor` in
/// `DBSHARINGListFoldersContinueArg` is invalid.
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithInvalidCursor;

///
/// Initializes union class with tag state of "other".
///
/// @return An initialized instance.
///
- (nonnull instancetype)initWithOther;

#pragma mark - Tag state methods

///
/// Retrieves whether the union's current tag state has value "invalid_cursor".
///
/// @return Whether the union's current tag state has value "invalid_cursor".
///
- (BOOL)isInvalidCursor;

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
/// The serialization class for the `DBSHARINGListFoldersContinueError` union.
///
@interface DBSHARINGListFoldersContinueErrorSerializer : NSObject

///
/// Serializes `DBSHARINGListFoldersContinueError` instances.
///
/// @param instance An instance of the `DBSHARINGListFoldersContinueError` API
/// object.
///
/// @return A json-compatible dictionary representation of the
/// `DBSHARINGListFoldersContinueError` API object.
///
+ (NSDictionary * _Nonnull)serialize:(DBSHARINGListFoldersContinueError * _Nonnull)instance;

///
/// Deserializes `DBSHARINGListFoldersContinueError` instances.
///
/// @param dict A json-compatible dictionary representation of the
/// `DBSHARINGListFoldersContinueError` API object.
///
/// @return An instantiation of the `DBSHARINGListFoldersContinueError` object.
///
+ (DBSHARINGListFoldersContinueError * _Nonnull)deserialize:(NSDictionary * _Nonnull)dict;

@end
