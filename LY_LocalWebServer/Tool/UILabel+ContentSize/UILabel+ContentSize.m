//
//  UILabel+ContentSize.m
//  仿朋友圈
//
//  Created by owen on 2017/2/21.
//  Copyright © 2017年 imac. All rights reserved.
//

#import "UILabel+ContentSize.h"

@implementation UILabel (ContentSize)

- (CGSize)contentSize:(NSString*)content {
    NSMutableParagraphStyle *style = [[NSMutableParagraphStyle alloc] init];
    [style setLineBreakMode:self.lineBreakMode];
    [style setAlignment:self.textAlignment];
    NSDictionary *dic = @{NSFontAttributeName : self.font, NSParagraphStyleAttributeName : style};
    CGSize size = [self.text boundingRectWithSize:CGSizeMake([UIScreen mainScreen].bounds.size.width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dic context:nil].size;
    return size;
}

@end
