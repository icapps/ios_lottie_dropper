///
/// Copyright (c) 2016 Dropbox, Inc. All rights reserved.
///
/// Auto-generated by Stone, do not modify.
///

#import "DBTEAMRoutes.h"
#import "DBTeamBaseClient.h"
#import "DBTransportClientProtocol.h"

@implementation DBTeamBaseClient

- (instancetype)initWithTransportClient:(id<DBTransportClient> _Nonnull)client {
  self = [super init];
  if (self) {
    _transportClient = client;
    _teamRoutes = [[DBTEAMRoutes alloc] init:client];
  }
  return self;
}
@end
