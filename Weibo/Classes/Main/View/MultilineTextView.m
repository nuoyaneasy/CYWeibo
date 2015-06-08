//
//  MultilineTextView.m
//  Weibo
//
//  Created by Yang Chao on 6/7/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "MultilineTextView.h"

@implementation MultilineTextView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        //当UItextView的文字发生改变时，UITextView自己会发出一个UITextViewTextDidChangeNotification通知
        [CYNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:self];
        
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    
    //每次调用，会将之前的擦掉
    
    if ([self hasText]) return;
    
    //文字属性
    NSString *str = self.placeholder;
    NSMutableDictionary *attrs = [NSMutableDictionary dictionary];
    attrs[NSFontAttributeName] = self.font;
    attrs[NSForegroundColorAttributeName] = self.placeholderColor ? self.placeholderColor : [UIColor grayColor];
    
    //画文字
   // [str drawAtPoint:CGPointMake(5, 8) withAttributes:attrs];
    CGFloat x = 5;
    CGFloat y = 8;
    CGFloat width = rect.size.width - 2 * x;
    CGFloat height = rect.size.height - 2 * y;
    CGRect placeholderRect = CGRectMake(x, y, width, height);
    [str drawInRect:placeholderRect withAttributes:attrs];
    
}

- (void)textDidChange
{
    [self setNeedsDisplay]; //重绘
}

- (void)setPlaceholder:(NSString *)placeholder
{
    _placeholder = [placeholder copy];
    [self setNeedsDisplay];
}

- (void)setPlaceholderColor:(UIColor *)placeholderColor
{
    _placeholderColor = placeholderColor;
    [self setNeedsDisplay];
}

//- (void)setText:(NSString *)text
//{
//    [super setText:text];
//    [self setNeedsDisplay];
//}
//
//- (void)setFont:(UIFont *)font
//{
//    [super setFont:font];
//    [self setNeedsDisplay];
//}
@end

