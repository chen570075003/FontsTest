//
//  UIFont+FontChanger.m
//  FontTest
//
//  Created by DL on 2021/12/3.
//

#import "UIFont+FontChanger.h"
#import <objc/runtime.h>

@implementation UIFont (FontChanger)

+ (void)load {
    [super load];
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Method old = class_getClassMethod([self class], @selector(fontWithName:size:));
        Method new = class_getClassMethod([self class], @selector(changer_FontOfSize:));
        
        method_exchangeImplementations(old, new);
    });
    
}

+ (UIFont *)changer_FontOfSize:(CGFloat)size {
    UIFont *font = [UIFont fontWithName:@"" size:size];
    if (!font) return [self changer_FontOfSize:size];
    return  font;
}

@end
