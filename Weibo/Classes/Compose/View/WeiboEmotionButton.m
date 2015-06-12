//
//  WeiboEmotionButton.m
//  Weibo
//
//  Created by Yang Chao on 6/11/15.
//  Copyright © 2015 Self. All rights reserved.
//

#import "WeiboEmotionButton.h"
#import "WeiboEmotion.h"

@implementation WeiboEmotionButton

- (void)setEmotion:(WeiboEmotion *)emotion
{
    _emotion = emotion;
    
    if (emotion.png) {
        [self setImage:[UIImage imageNamed:emotion.png] forState:UIControlStateNormal];
    } 
    
}

- (id)initWithCoder:(NSCoder *)aDecoder
{
    if (self = [super initWithCoder:aDecoder]) {
        [self setup];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setup];
    }
    return self;
}

- (void)setup
{
    self.adjustsImageWhenHighlighted = NO;
}

- (void)awakeFromNib
{
    
}
@end
