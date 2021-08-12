#import <WebKit/WebKit.h>
#import "SCLAlertView.h"

#import "DLGMem.h"
#import "EOCURLProtocol.h"
@interface DLGMemEntry : NSObject
@end
@implementation DLGMemEntry : NSObject

static void __attribute__((constructor)) entry() {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [[DLGMem alloc] launchDLGMem];
    });
}




@end
