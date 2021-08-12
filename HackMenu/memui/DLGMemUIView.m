
#import "DLGMemUIView.h"
#import "EOCURLProtocol.h"


@interface DLGMemUIView ()

@property (nonatomic) UIButton *btnConsole;
@property (nonatomic) UITapGestureRecognizer *tapGesture;

@property (nonatomic) CGRect rcCollapsedFrame;
@property (nonatomic) CGRect rcExpandedFrame;
@property (nonatomic) NSInteger selectedValueTypeIndex;
@property (nonatomic) NSInteger selectedComparisonIndex;


@end

@implementation DLGMemUIView

+ (instancetype)instance
{
    static DLGMemUIView *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[DLGMemUIView alloc] init];
    });
    return _instance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self initVars];
        [self initViews];
    }
    return self;
}

- (void)initVars {
    CGRect screenBounds = [UIScreen mainScreen].bounds;
    self.rcExpandedFrame = screenBounds;
    self.rcCollapsedFrame = CGRectMake(0, 0, 20, 20);

//    _expanded = NO;

    self.selectedValueTypeIndex = 2;
    self.selectedComparisonIndex = 2;
}

- (void)initViews {
    self.backgroundColor = [UIColor blackColor];
    self.clipsToBounds = YES;
    self.frame = self.rcCollapsedFrame;
    self.layer.cornerRadius = CGRectGetWidth(self.bounds) / 2;
    [self initConsoleButton];

}

- (void)initConsoleButton {
    UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
    button.translatesAutoresizingMaskIntoConstraints = NO;
//    [button setTitle:@"辅助" forState:UIControlStateNormal];
 
    [button setBackgroundImage:[UIImage imageWithData:[NSData dataWithContentsOfURL:[NSURL URLWithString:@"https://iosgods.cn/uploads/monthly_2021_01/no.png.13301dba752dc89d1151a92030f5d49b.png"]]] forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"AmericanTypewriter-Bold" size:12]];
    [button setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];//图标字体颜色
    [self addSubview:button];
    NSDictionary *views = NSDictionaryOfVariableBindings(button);
    NSArray *ch = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|[button]|"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self addConstraints:ch];
    NSArray *cv = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|[button]|"
                                                          options:0
                                                          metrics:nil
                                                            views:views];
    [self addConstraints:cv];
    [button addTarget:self action:@selector(onConsoleButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    self.btnConsole = button;
    
}
- (void)onConsoleButtonTapped:(id)sender {
    NSLog(@"被点击");
    [[EOCURLProtocol alloc] qidong];
    
}



@end
