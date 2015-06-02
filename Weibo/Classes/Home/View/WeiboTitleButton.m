//
//  WeiboTitleButton.m
//  Weibo
//
//  Created by Yang Chao on 6/1/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "WeiboTitleButton.h"

@implementation WeiboTitleButton

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
        //set contentmode to center
        self.imageView.contentMode = UIViewContentModeCenter;
        
        //setup button
        [self setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:17];
        self.backgroundColor = [UIColor redColor];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_down"]forState:UIControlStateNormal];
        [self setImage:[UIImage imageNamed:@"navigationbar_arrow_up"] forState:UIControlStateSelected];

    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    //1. Ajust frame of titleLabel
    self.titleLabel.x = self.imageView.x;
    
    //2. Ajust frame of imageView
    self.imageView.x = CGRectGetMaxX(self.titleLabel.frame);
}

/**
 *  set frame after system set it
 *
 *  @return <#return value description#>
 */

- (void)setFrame:(CGRect)frame
{    
    [super setFrame:frame];
}

/**
 *  Whenever title or image has been set, call sizeToFit
 *
 *  @param title <#title description#>
 *  @param state <#state description#>
 */
- (void)setTitle:(NSString *)title forState:(UIControlState)state
{
    [super setTitle:title forState:state];
    [self sizeToFit];
}

- (void)setImage:(UIImage *)image forState:(UIControlState)state
{
    [super setImage:image forState:state];
    [self sizeToFit];
}

/**
 *  设置imageView的rect
 *
 *  @param contentRect <#contentRect description#>
 *
 *  @return <#return value description#>
 */
//- (CGRect)imageRectForContentRect:(CGRect)contentRect   //call self.imageView will cause endless loop in this method
//{
//    CGFloat x = 80;
//    CGFloat y = 0;
//    CGFloat width = 13;
//    CGFloat height = contentRect.size.height;
//    
//    return CGRectMake(x, y, width, height);
//}
//
///**
// *  设置titleLabel的rect
// *
// *  @param contentRect <#contentRect description#>
// *
// *  @return <#return value description#>
// */
//
//- (CGRect)titleRectForContentRect:(CGRect)contentRect //call self.titleLabel will cause endless loop in this method
//{
//    CGFloat x = 0;
//    CGFloat y = 0;
//    CGFloat width = 80;
//    CGFloat height = contentRect.size.height;
//
//    return CGRectMake(x, y, width, height);
//
//}



@end
