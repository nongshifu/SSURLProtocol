

#import "DLGMem.h"
#import "DLGMemUI.h"
#import "DLGMemUIView.h"
//#include "mem.h"

@interface DLGMem () <DLGMemUIViewDelegate> {

}

@property (nonatomic, weak) DLGMemUIView *memView;

@end

@implementation DLGMem




- (void)launchDLGMem {
    [DLGMemUI addDLGMemUIView:self];
}





@end
