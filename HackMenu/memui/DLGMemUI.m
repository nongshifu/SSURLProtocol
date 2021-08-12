
#import "DLGMemUI.h"
#import "DLGMemUIView.h"

@implementation DLGMemUI

+ (void)addDLGMemUIView:(id<DLGMemUIViewDelegate>)delegate {
    UIApplication *application = [UIApplication sharedApplication];
    if (application) {
        [DLGMemUI addDLGMemUIViewToWindow:application.keyWindow withDelegate:delegate];
        return;
    }
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [DLGMemUI addDLGMemUIView:delegate];
    });
}

+ (void)addDLGMemUIViewToWindow:(UIWindow *)window withDelegate:(id<DLGMemUIViewDelegate>)delegate{
    CGRect frame = CGRectMake(100, 100, 50, 50);
    DLGMemUIView *view = [DLGMemUIView instance];
    view.delegate = delegate;
    view.translatesAutoresizingMaskIntoConstraints = YES;
    view.autoresizingMask = UIViewAutoresizingNone;
    view.frame = frame;
    view.alpha = 1.0f;//透明
    [window addSubview:view];
    [window setDLGMemUIView:view];
    
    NSArray *gestures = view.gestureRecognizers;
    if (gestures == nil || gestures.count == 0) {
        UIPanGestureRecognizer *pan = [[UIPanGestureRecognizer alloc] initWithTarget:window action:@selector(handleGesture:)];
        [view addGestureRecognizer:pan];
        
        UITapGestureRecognizer *tttap = [[UITapGestureRecognizer alloc] initWithTarget:window action:@selector(handleTTTapGesture:)];
        tttap.numberOfTapsRequired = 3;
        tttap.numberOfTouchesRequired = 3;
//        view.alpha = 1.0f;//透明
        [window addGestureRecognizer:tttap];
    }
    
    if ([delegate respondsToSelector:@selector(DLGMemUILaunched:)]) {
        [delegate DLGMemUILaunched:view];
    }
}

+ (void)removeDLGMemUIView {
    DLGMemUIView *view = [DLGMemUIView instance];
    if (view.expanded) [view doCollapse];
    NSArray *gestures = view.gestureRecognizers;
    for (UIGestureRecognizer *gesture in gestures) {
        [view removeGestureRecognizer:gesture];
    }
    [view removeFromSuperview];
}


@end
