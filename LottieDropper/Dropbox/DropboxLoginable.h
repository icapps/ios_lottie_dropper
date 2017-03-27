
@protocol DropboxLoginable <NSObject>

- (void) proceed;
- (void) failWithError: (NSError*) error;

@end
