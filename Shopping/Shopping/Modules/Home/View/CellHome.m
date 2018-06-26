//
//  CellHome.m
//  Shopping
//
//  Created by simple on 2018/6/26.
//  Copyright © 2018年 simple. All rights reserved.
//

#import "CellHome.h"

@implementation CellHome


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        _ivImg = [[UIImageView alloc]initWithFrame:CGRectZero];
        _ivImg.image = [UIImage imageNamed:@""];
        _ivImg.userInteractionEnabled = YES;
        [self addSubview:_ivImg];
        
        _lbTitle = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbTitle.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbTitle.textColor = RGB(0, 0, 0);
        [self addSubview:_lbTitle];
        
        _lbContent = [[UILabel alloc]initWithFrame:CGRectZero];
        _lbContent.font = [UIFont systemFontOfSize:14*RATIO_WIDHT320];
        _lbContent.textColor = RGB(0, 0, 0);
        _lbContent.numberOfLines = 2;
        [self addSubview:_lbContent];
    }
    return self;
}

- (void)updateData{
    
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGRect r = self.ivImg.frame;
    r.origin.x = 10*RATIO_WIDHT320;
    r.origin.y = 0;
    r.size.width = 100*RATIO_WIDHT320;
    r.size.height = r.size.width;
    self.ivImg.frame = r;
    
    CGFloat w = DEVICEWIDTH - 20*RATIO_WIDHT320 - self.ivImg.right;
    CGSize size = [self.lbTitle sizeThatFits:CGSizeMake(w, MAXFLOAT)];
    r = self.lbTitle.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = 10*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = w;
    self.lbTitle.frame = r;
    
    size = [self.lbContent sizeThatFits:CGSizeMake(w, MAXFLOAT)];
    r = self.lbContent.frame;
    r.origin.x = self.ivImg.right + 10*RATIO_WIDHT320;
    r.origin.y = self.lbTitle.bottom +  10*RATIO_WIDHT320;
    r.size.height = size.height;
    r.size.width = w;
    self.lbContent.frame = r;
}

+ (CGFloat)calHeight{
    return 120*RATIO_WIDHT320;
}

@end
