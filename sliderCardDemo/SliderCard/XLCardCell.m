//
//  Card.m
//  CardSwitchDemo
//
//  Created by Apple on 2016/11/9.
//  Copyright © 2016年 Apple. All rights reserved.
//
#define random(r, g, b, a) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:(a)/255.0]

#define randomColor random(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#import "XLCardCell.h"
#import "XLCardModel.h"

@interface XLCardCell ()

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) UILabel *textLabel;

@end

@implementation XLCardCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self buildUI];
    }
    return self;
}

- (void)buildUI {
    self.layer.cornerRadius = 10.0f;
    self.layer.masksToBounds = true;
    self.backgroundColor = randomColor;
    
    CGFloat imageViewHeight = 150;
    self.imageView = [[UIImageView alloc]init];
    self.imageView.contentMode = UIViewContentModeScaleAspectFit;
    self.imageView.layer.masksToBounds = true;
    [self.contentView addSubview:self.imageView];
//    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.centerX.equalTo(self.contentView);
//        make.size.mas_equalTo(CGSizeMake(180, imageViewHeight));
//    }];
    self.imageView.frame = CGRectMake((self.contentView.frame.size.width-120)/2, 15, 120, imageViewHeight);
    self.imageView.backgroundColor = [UIColor redColor];
    
}

- (void)setModel:(XLCardModel *)model {
    self.imageView.image = [UIImage imageNamed:model.imageName];
//    self.textLabel.text = model.title;
}

@end
