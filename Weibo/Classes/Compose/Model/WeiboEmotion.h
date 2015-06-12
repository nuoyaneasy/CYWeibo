//
//  WeiboEmotion.h
//  Weibo
//
//  Created by Yang Chao on 6/9/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WeiboEmotion : NSObject

/** 表情的文字描述 */
@property (nonatomic, copy) NSString *chs;
/** 表情的图片名 */
@property (nonatomic, copy) NSString *png;
/** emoji 16进制编码 */
@property (nonatomic, copy) NSString *code;

//应该把16进制编码转成Emoji的字符

@end
