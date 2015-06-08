//
//  WeiboComposeToolbar.h
//  Weibo
//
//  Created by Yang Chao on 6/7/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
    WeiboComposeToolbarTypeCamera, //拍照
    WeiboComposeToolbarTypePicture,//相册
    WeiboComposeToolbarTypeMention,//@
    WeiboComposeToolbarTypeTrend,//潮流
    WeiboComposeToolbarTypeEmotion//表情
}WeiboComposeToolbarType;

@class WeiboComposeToolbar;
@protocol WeiboComposeToolbarDelegate <NSObject>

- (void)composeToolbar:(WeiboComposeToolbar *)composeToolbar didClickButton:(WeiboComposeToolbarType)type;

@end

@interface WeiboComposeToolbar : UIView

@property (nonatomic, weak) id <WeiboComposeToolbarDelegate>delegate;

@end
