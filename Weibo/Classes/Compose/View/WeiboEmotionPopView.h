//
//  WeiboEmotionPopView.h
//  Weibo
//
//  Created by Yang Chao on 6/11/15.
//  Copyright © 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WeiboEmotion;
@interface WeiboEmotionPopView : UIView

+ (instancetype)popView;

@property (nonatomic, strong) WeiboEmotion *emotion;

@end
