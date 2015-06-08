//
//  WeiboComposePhotosView.h
//  Weibo
//
//  Created by Yang Chao on 6/8/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboComposePhotosView : UIView

- (void)addPhoto:(UIImage *)image;
@property (nonatomic, strong, readonly) NSMutableArray *photos;
@end
