//
//  WeiboEmotionPopView.m
//  Weibo
//
//  Created by Yang Chao on 6/11/15.
//  Copyright © 2015 Self. All rights reserved.
//

#import "WeiboEmotionPopView.h"
#import "WeiboEmotionButton.h"
@interface WeiboEmotionPopView ()

@property (weak, nonatomic) IBOutlet WeiboEmotionButton *emotionButton;


@end

@implementation WeiboEmotionPopView

+ (instancetype)popView
{
    return [[[NSBundle mainBundle] loadNibNamed:@"WeiboEmotionPopView" owner:nil options:nil] firstObject];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        //
    }
    return self;
}

- (void)setEmotion:(WeiboEmotion *)emotion
{
    _emotion = emotion;
    self.emotionButton.emotion = emotion;
    
}

@end
