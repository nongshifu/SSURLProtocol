//
//  EOCURLProtocol.h
//  EOCURLProtocol
//
//  Created by sy on 2018/5/18.
//  Copyright © 2018年 EOC. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface EOCURLProtocol : NSURLProtocol<NSURLSessionDataDelegate, NSURLSessionTaskDelegate>
@property (nonatomic, copy) NSString *url;
@property (nonatomic, copy) NSString *stra;
@property (nonatomic, copy) NSString *strb;
@property (nonatomic, copy) NSString *strc;
@property (nonatomic, copy) NSString *kaiguan;
@property (nonatomic,  weak) NSTimer *timer;
-(void)qidong;
@end
