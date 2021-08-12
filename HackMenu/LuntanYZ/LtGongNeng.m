#import <WebKit/WebKit.h>
#import "LtShengMing.h"
#import <CaptainHook/CaptainHook.h>
#import <UIKit/UIKit.h>
#import <Cycript/Cycript.h>

#import "SCLAlertView.h"
#import "LtShengMing.h"


//构建功能详细代码
//匹配关键词

static NSString *MUFENGKEY  =   @"MUFENG";
@interface JD : UIViewController<WKNavigationDelegate>
@end
@implementation JD
static JD *jd = nil;
+ (JD *)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        if (jd == nil) {
            jd = [[self alloc] init];
        }
    });
    return jd;
}
- (void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation
{
    
    NSString *doc = @"document.body.outerHTML";
    [webView evaluateJavaScript:doc
              completionHandler:^(id _Nullable htmlStr, NSError * _Nullable error)
    {
                  if (error)
                  {
                      NSLog(@"JSError:%@",error);
                  }
                  NSLog(@"html:%@",htmlStr);
        if ([(NSString *)htmlStr containsString:@"欢迎注册登陆"])
        {
            [webView removeFromSuperview];
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert addTimerToButtonIndex:0 reverse:YES];
            [alert addButton:@"登陆" actionBlock:^{
                
                [NSObject denglu];
                
            }];
            [alert addButton:@"注册" actionBlock:^{
                
                [NSObject zhuche];
                
            }];
            [alert showWaiting:@"登陆提示" subTitle:@"您没登入\n请先/注册/登陆\n购买VIP即可" closeButtonTitle:nil duration:4];
        }
        
        if ([(NSString *)htmlStr containsString:@"状态普通"])
        {
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert addTimerToButtonIndex:0 reverse:YES];
            [webView removeFromSuperview];
            
            NSRange name1 = [htmlStr rangeOfString:@"66166"];
            NSRange name2 = [htmlStr rangeOfString:@"99199"];
            NSRange name = NSMakeRange(name1.location + name1.length, name2.location - name1.location - name1.length);
            NSString *member = [htmlStr substringWithRange:name];
            [alert addButton:@"购买VIP会员"  actionBlock:^{
                [NSObject goumai];
            }];
            [alert addButton:@"退出游戏"  actionBlock:^{
                exit(0);
            }];
                                                        
                                                    
            [alert showInfo:member subTitle:@"您不是VIP用请先购买" closeButtonTitle:nil duration:10];
        }
        
        
        if ([(NSString *)htmlStr containsString:@"尊敬的VIP用户"])
        {
            [webView removeFromSuperview];
            
            SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
            [alert addTimerToButtonIndex:0 reverse:YES];
            NSRange vip1 = [htmlStr rangeOfString:@"44144"];
            NSRange vip2 = [htmlStr rangeOfString:@"55155"];
            NSRange range = NSMakeRange(vip1.location + vip1.length, vip2.location - vip1.location - vip1.length);
            NSString *vipday = [htmlStr substringWithRange:range];
            NSRange name1 = [htmlStr rangeOfString:@"66166"];
            NSRange name2 = [htmlStr rangeOfString:@"99199"];
            NSRange name = NSMakeRange(name1.location + name1.length, name2.location - name1.location - name1.length);
            NSString *member = [htmlStr substringWithRange:name];

            
            [alert addButton:@"开始游戏" actionBlock:^{
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [NSObject shebei];
                });
               
            }];
            [alert addButton:@"购买/续费" actionBlock:^{
                [NSObject goumai];
            }];
            [alert showSuccess:member subTitle:vipday closeButtonTitle:nil duration:5];
                 
          }
        if ([(NSString *)htmlStr containsString:htmlStr])//设备检查
        {
           if ([htmlStr containsString:@"本机"]) {
                if ([htmlStr containsString:@"其他设备"])
                {
                    SCLAlertView *alert =[[SCLAlertView alloc] initWithNewWindow];
                    [alert addTimerToButtonIndex:0 reverse:YES];
                    
                    [alert showWarning:nil title:@"登陆设备过多" subTitle:@"请往下翻动\n除本机外 其他设备退出\n登陆太多设备禁封论坛VIP后果自负" closeButtonTitle:@"知道" duration:5];
                }
                else {
                    NSRange vip1 = [htmlStr rangeOfString:@"44144"];
                    NSRange vip2 = [htmlStr rangeOfString:@"55155"];
                    NSRange range = NSMakeRange(vip1.location + vip1.length, vip2.location - vip1.location - vip1.length);
                    NSString *vipday = [htmlStr substringWithRange:range];
                    SCLAlertView *alert =[[SCLAlertView alloc]initWithNewWindow];
                    [alert addTimerToButtonIndex:0 reverse:YES];
                    [alert addButton:@"开始游戏" actionBlock:^{
                        [webView removeFromSuperview];
                       
                    }];
                    [alert showNotice:@"设备验证成功" subTitle:vipday closeButtonTitle:nil duration:3];
//                    [NSObject dingshi];
                    
                    
                   
                }
                
            }
            
        }
        
    }] ;

}




/**清除缓存和cookie*/

- (void)cleanCacheAndCookie{
    
    //清除cookies
    
    NSHTTPCookie *cookie;
    
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    
    for (cookie in [storage cookies]){
        
        [storage deleteCookie:cookie];
        
    }
    
    //清除UIWebView的缓存
    
    [[NSURLCache sharedURLCache] removeAllCachedResponses];
    
    NSURLCache * cache = [NSURLCache sharedURLCache];
    
    [cache removeAllCachedResponses];
    
    [cache setDiskCapacity:0];
    
    [cache setMemoryCapacity:0];
    
}
  


@end
@implementation NSObject (hook)
- (BOOL)shouye
{
    UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
    WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
    webView.navigationDelegate  =   [JD sharedInstance];
   
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/"]]];
    [window addSubview:webView];
    return 0;
}

- (BOOL)shebei
{
    UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
    WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
    webView.navigationDelegate  =   [JD sharedInstance];
   
    [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/index.php?/settings/devices/"]]];
    [window addSubview:webView];
    return 0;
    
}

- (BOOL)denglu
{
    
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
           UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
           WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
           webView.navigationDelegate  =   [JD sharedInstance];
          
           [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/index.php?/login/"]]];
           [window addSubview:webView];
           
           
           
       });
      
    return 0;
    
}
- (BOOL)zhuche
{
    
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
           UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
           WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
           webView.navigationDelegate  =   [JD sharedInstance];
          
           [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/index.php?/register/"]]];
           [window addSubview:webView];
       });
    return 0;
    
}
- (BOOL)goumai
{
    
       dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
           
           UIWindow    *window =   [[UIApplication sharedApplication] keyWindow];
           WKWebView   *webView    =   [[WKWebView alloc] initWithFrame:window.bounds];
           webView.navigationDelegate  =   [JD sharedInstance];
          
           [webView loadRequest:[[NSURLRequest alloc] initWithURL:[NSURL URLWithString:@"https://iosgods.cn/index.php?/clients/credit/"]]];
           [window addSubview:webView];
       });
    return 0;
    
}
- (BOOL)dingshi
{
//    
//    //每隔一分钟执行一次打印
//    // GCD定时器
//    static dispatch_source_t _timer;
//    //设置时间间隔
//    NSTimeInterval period = 10.f;
//    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
//    _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//    dispatch_source_set_timer(_timer, dispatch_walltime(NULL, 0), period * NSEC_PER_SEC, 0);
//    // 事件回调
//    dispatch_source_set_event_handler(_timer, ^{
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSLog(@"验证设备");
//            NSString *requestStr = @"https://iosgods.cn/index.php?/settings/devices/";
//            NSString *htmlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:requestStr] encoding:NSUTF8StringEncoding error:nil];
//            if ([(NSString *)htmlStr containsString:htmlStr])
//            {
//               if ([htmlStr containsString:@"本机"]) {
//                    if ([htmlStr containsString:@"其他设备"])
//                    {
//                        SCLAlertView *alert =[[SCLAlertView alloc] initWithNewWindow];
//                        [alert addTimerToButtonIndex:0 reverse:YES];
//                        [alert addButton:@"退出游戏" actionBlock:^{
//                            exit(0);
//                        }];
//                        
//                        [alert showWarning:nil title:@"强制下线" subTitle:@"您的账号在其他地方登入\n强制退出游戏\n一天超过3次强制下线\n禁封VIP账户" closeButtonTitle:@"知道" duration:5];
//                        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//                            
//                            exit(0);
//                        });
//                        
//                       
//                    }
//                    else {
//                        
//                        
//                       
//                    }
//                    
//                }
//                
//            }
//            
//            
//            
//            
//            //网络请求 doSomeThing...
//        });
//    });
//        
//    // 开启定时器
//    dispatch_resume(_timer);
//        
//    // 关闭定时器
//    // dispatch_source_cancel(_timer);
//    return 0;
}




@end
