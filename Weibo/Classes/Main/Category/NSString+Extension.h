//
//  NSString+Extension.h
//  Weibo
//
//  Created by Yang Chao on 6/5/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Extension)
- (CGSize)sizeWithFont:(UIFont *)font;
- (CGSize)sizeWithFont:(UIFont *)font maxW:(CGFloat)maxW;
@end
