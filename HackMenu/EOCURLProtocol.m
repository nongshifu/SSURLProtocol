//
//  EOCURLProtocol.m
//  EOCURLProtocol
//
//  Created by sy on 2018/5/18.
//  Copyright © 2018年 EOC. All rights reserved.
//

#import "EOCURLProtocol.h"
#import <UIKit/UIKit.h>
#import "SCLAlertView.h"
@implementation EOCURLProtocol
static NSString *const kProtocolHandledKey = @"kProtocolHandledKey";

-(void)qidong{
    
    SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
    [alert addTimerToButtonIndex:0 reverse:YES];
    [alert addButton:@"自定义拦截" actionBlock:^{
        SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
        [alert addTimerToButtonIndex:0 reverse:YES];
        SCLTextView *textF =   [alert addTextField:@"要拦截域名(可部分不重复即可)" setDefaultText:nil];
        SCLTextView *textF2 =   [alert addTextField:@"请输入查找字段" setDefaultText:nil];
        SCLTextView *textF3 =   [alert addTextField:@"请输入查找到后替换的字段" setDefaultText:nil];
        [alert addButton:@"确定添加写入规则" actionBlock:^{
            _kaiguan=@"开启";
            [self xiekaiguan];
            _stra =textF.text;
            _strb =textF2.text;
            _strc =textF3.text;
            if (_strb.length<2) {
                _strb=@"http";
            }
            if (_strc.length<2) {
                _strc=@"ppp";
            }
            if (_stra.length<3) {
                SCLAlertView *alert = [[SCLAlertView alloc] initWithNewWindow];
                [alert addTimerToButtonIndex:0 reverse:YES];
                
                 [alert showInfo:@"错误"  subTitle:@"请填写完整第一个选项\n如果后面两个选项留空\n则直接拦截第一个选项不放行"  closeButtonTitle:@"取消" duration:0];
            }else{
                _url= [NSString stringWithFormat:@"%@|%@|%@",_stra,_strb,_strc];
                [self xietxt];
            }
            
            
        }];
        [alert showSuccess:@"写入配置"  subTitle:@"每条规则三个条件英文|符号隔开\n如：kf.qq.com|qq|88\n最后应用内访问 kf.qq.com\n会跳转到 kf.88.com"  closeButtonTitle:@"取消" duration:0];
        
    }];
    [alert addButton:@"开启默认配置拦截" actionBlock:^{
        _kaiguan=@"开启";
        [self xiekaiguan];
        
    }];
    [alert addButton:@"关闭拦截" actionBlock:^{
        _kaiguan=@"关闭";
        [self xiekaiguan];
        
    }];
    [alert addButton:@"清空配置" actionBlock:^{
        _kaiguan=@"关闭";
        [self xiekaiguan];
        [self qingchu];
    }];
       
    
    [alert showSuccess:@"代理转发"  subTitle:@"感谢使用本插件"  closeButtonTitle:@"取消" duration:0];
}

-(void)deleteFile {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"配置.txt"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        
        return ;
        
    }else {
        

        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];

        if (blDele) {

        NSLog(@"6666666666配置被删除");
            
        }else {
            
            
        }
        
    }

}
- (void)qingchu{
    
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            //先删除文件
            [self deleteFile];
            //写空文件
            //获取沙盒路径
            NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            //获取文件路径
            NSString *theFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"配置.txt"];
            //创建文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //如果文件不存在 创建文件
            if(![fileManager fileExistsAtPath:theFilePath]){
                NSString *str = @"";
                [str writeToFile:theFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:theFilePath];
            [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
            NSData* stringData  = [[NSString stringWithFormat:@""] dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:stringData]; //追加写入数据
            [fileHandle closeFile];
            NSLog(@"6666666666配置被情况");
            
        
        }
    });
    
  
}
-(void)jiazai{
    [NSURLProtocol registerClass:[EOCURLProtocol class]];
    NSLog(@"6666666666监听开始加载");
}

//写文件txt
- (void)xietxt{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            //获取沙盒路径
            NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            //获取文件路径
            NSString *theFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"配置.txt"];
            //创建文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //如果文件不存在 创建文件
            if(![fileManager fileExistsAtPath:theFilePath]){
                NSString *str = @"";
                [str writeToFile:theFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            NSLog(@"66666666所写内容=%@",_url);
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:theFilePath];
            [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
            NSData* stringData  = [[NSString stringWithFormat:@"%@\n",_url] dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:stringData]; //追加写入数据
            [fileHandle closeFile];
            
        
        }
    });
    [self jiazai];
  
}
- (void)xiekaiguan{
    dispatch_async(dispatch_get_global_queue(0, 0), ^{
        @synchronized (self) {
            [self sanchukaiguan];
            //获取沙盒路径
            NSArray *paths  = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask,YES);
            //获取文件路径
            NSString *theFilePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:@"开关.txt"];
            //创建文件管理器
            NSFileManager *fileManager = [NSFileManager defaultManager];
            //如果文件不存在 创建文件
            if(![fileManager fileExistsAtPath:theFilePath]){
                NSString *str = _kaiguan;
                [str writeToFile:theFilePath atomically:YES encoding:NSUTF8StringEncoding error:nil];
            }
            NSLog(@"66666666AA写开关=%@",_kaiguan);
            NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:theFilePath];
            [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
            NSData* stringData  = [[NSString stringWithFormat:@"%@",_kaiguan] dataUsingEncoding:NSUTF8StringEncoding];
            [fileHandle writeData:stringData]; //追加写入数据
            [fileHandle closeFile];
            
        
        }
    });
    [self jiazai];
  
}
-(void)sanchukaiguan {
    NSFileManager* fileManager=[NSFileManager defaultManager];
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    //文件名
    NSString *uniquePath=[[paths objectAtIndex:0] stringByAppendingPathComponent:@"开关.txt"];
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        
        return ;
        
    }else {
        

        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];

        if (blDele) {

            
        }else {
            
            
        }
        
    }

}
/* YES是重定向，NO 不修改 */
+ (BOOL)canInitWithRequest:(NSURLRequest *)request{
    
    if ([NSURLProtocol propertyForKey:kProtocolHandledKey inRequest:request] ) {
        return NO;
    }
    
    // 不是网络请求，不处理
    if (![request.URL.scheme isEqualToString:@"http"] &&
        ![request.URL.scheme isEqualToString:@"https"]) {
        return NO;
    }
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    // 拼接要写入文件的路径
     NSString *path = [documentsPath stringByAppendingPathComponent:@"开关.txt"];
    // 从路径中读取字符串
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    if ([str containsString:@"关闭"]) {
       NSLog(@"666666666CC开关状态%@", str);
       return NO;
    }else{
        NSLog(@"666666666DD开关状态%@", str);
        // 读字符串
        // 获取路径
        NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsPath = [documentsPathArr lastObject];
        // 拼接要写入文件的路径
         NSString *path = [documentsPath stringByAppendingPathComponent:@"配置.txt"];
        // 从路径中读取字符串
        NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
        NSLog(@"666666666UUUU读取文字%@", str);
        NSArray *array = [str componentsSeparatedByString:@"\n"]; //字符串按照【分隔成数组
        NSLog(@"666666666EEE开启中 规则数量%ld", array.count);
        if (array.count>1) {
            
            for (int i=0; i<array.count-1; i++) {
                NSArray *array2 = [array[i] componentsSeparatedByString:@"|"]; //字符串按照【分隔成数组
                if ([request.URL.absoluteString containsString:array2[0]]) {
                    NSLog(@"666666666 包含关键字拦截");
                    return YES;
                }
                NSLog(@"6666666666 ============%@",array2[0]);
            }
           
        }else{
            NSLog(@"66666666666VVVV空的");
            return NO;
            
        }
    }
    
   
    // 拦截所有
    return YES;
}

// 2 修改request
//canonical 规范
+ (NSURLRequest*)canonicalRequestForRequest:(NSURLRequest *)request{
    
     NSMutableURLRequest *mutableReqeust = [request mutableCopy];
       // 设置已处理标志
       [NSURLProtocol setProperty:@(YES)
                           forKey:kProtocolHandledKey
                        inRequest:mutableReqeust];
    
    return mutableReqeust;
//    NSLog(@"666666666%@",mutableReqeust.URL);
}

//3 重新启动
- (void)startLoading{
    
    [self reloadNet];
}

//用本地数据
- (void)loadLocalData{
    
}
//拦截后重新发送
- (void)reloadNet{
    // 读字符串
    // 获取路径
    NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsPath = [documentsPathArr lastObject];
    // 拼接要写入文件的路径
     NSString *path = [documentsPath stringByAppendingPathComponent:@"开关.txt"];
    // 从路径中读取字符串
    NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //开关关闭就不处理
    if([str containsString:@"关闭"]){
        NSMutableURLRequest *newRequest = [self.request mutableCopy];
        newRequest.URL = newRequest.URL;
        NSLog(@"666666666开关关闭 请求地址%@",newRequest.URL.absoluteURL);
        NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
        NSURLSessionTask *task = [session dataTaskWithRequest:newRequest];
        [task resume];
    }else{
        NSArray *documentsPathArr = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
           NSString *documentsPath = [documentsPathArr lastObject];
           // 拼接要写入文件的路径
            NSString *path = [documentsPath stringByAppendingPathComponent:@"配置.txt"];
           // 从路径中读取字符串
           NSString *str = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
           NSLog(@"666666666YYY读取到配置");
        NSArray *array = [str componentsSeparatedByString:@"\n"]; //字符串按照【分隔成数组
        if (array.count>1) {
            for (int i=0; i<array.count-1; i++) {
                NSArray *array2 = [array[i] componentsSeparatedByString:@"|"]; //字符串按照【分隔成数组
                NSMutableURLRequest *newRequest = [self.request mutableCopy];
                NSString *domain = newRequest.URL.absoluteString;
                if ([domain containsString:array2[0]]) {
                    //将错误的baidu.com 改成 svr.tuliu.com
                    NSString *urlstr = newRequest.URL.absoluteString;
                    urlstr = [urlstr stringByReplacingOccurrencesOfString:array2[1] withString:array2[2]];
                    newRequest.URL = [NSURL URLWithString:urlstr];
                    NSLog(@"666666666开启开关打印请求%@",newRequest);
                    NSURLSession *session = [NSURLSession sessionWithConfiguration:[NSURLSessionConfiguration defaultSessionConfiguration] delegate:self delegateQueue:nil];
                    NSURLSessionTask *task = [session dataTaskWithRequest:newRequest];
                    [task resume];
                }
            }
        }else{
            NSLog(@"666666666TTT空的");
            return;
            
        }
    }
    

    
    
    
    
}

// 4 结束

- (void)stopLoading{
    
    
}

#pragma mark - 代理方法

- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveResponse:(NSURLResponse *)response completionHandler:(void (^)(NSURLSessionResponseDisposition))completionHandler
{
    completionHandler(NSURLSessionResponseAllow);
    //第一步
    [self.client URLProtocol:self didReceiveResponse:[NSURLResponse new] cacheStoragePolicy:NSURLCacheStorageNotAllowed];
}


- (void)URLSession:(NSURLSession *)session dataTask:(NSURLSessionDataTask *)dataTask didReceiveData:(NSData *)data
{
    //最前面加123456
//    NSMutableData *eocdata = [@"123456" dataUsingEncoding:NSUTF8StringEncoding].mutableCopy;
//    [eocdata appendData:data];
//    [self.client URLProtocol:self didLoadData:eocdata];
    
    //第二步
    [self.client URLProtocol:self didLoadData:data];
}


- (void)URLSession:(NSURLSession *)session task:(NSURLSessionTask *)task didCompleteWithError:(NSError *)error
{
    //第三步
    [self.client URLProtocolDidFinishLoading:self];
}
- (NSTimer *)timer{
    NSLog(@"rrrr开始循环");
    
    if (!_timer) {
        _timer = [NSTimer scheduledTimerWithTimeInterval:2 repeats:YES block:^(NSTimer * _Nonnull timer) {
//
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
//                //请求的url
//                NSString *requestStr = @"http://kf.qq.com/";
//                NSString *htmlStr = [NSString stringWithContentsOfURL:[NSURL URLWithString:requestStr] encoding:NSUTF8StringEncoding error:nil];
//                NSLog(@"666666666666call back the data is :%ld",htmlStr.length);
//
//            });
        }];
    }
    return _timer;
}

@end
