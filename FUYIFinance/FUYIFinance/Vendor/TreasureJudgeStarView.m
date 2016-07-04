//
//  TreasureJudgeStarView.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/4.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "TreasureJudgeStarView.h"

@implementation TreasureJudgeStarView

- (id)initWithFrame:(CGRect)frame withStarLevel:(float)level
{
    self = [super initWithFrame:frame];
    if (self) {
        [self configWithStarLevel:level];
    }
    return self;

}

- (void)configWithStarLevel:(float)levels
{
    UIImageView * darkImageView = [[UIImageView alloc] initWithFrame:self.bounds];
   // darkImageView.contentMode = UIViewContentModeLeft;
    darkImageView.image  = [UIImage imageNamed:@"stardark"];
    
    float radtio = levels/5;
    int count = (int)radtio;
    if(radtio - count>0){
        radtio = count + 0.5;
    }else{
        radtio = count;
    }
    UIImageView * starImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width*radtio,self.frame.size.height)];
   // starImageView.contentMode = UIViewContentModeLeft;
   
    UIImage * oldImage = [UIImage imageNamed:@"starlight"];
    CGImageRef sourceImageRef = [oldImage CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef,CGRectMake(0, 0, self.frame.size.width*radtio, self.frame.size.height));
    
    UIImage * newImage = [UIImage imageWithCGImage:newImageRef];
    
    
    starImageView.image = newImage;

    
    starImageView.clipsToBounds = YES;
    
    [self addSubview:darkImageView];
    [self addSubview:starImageView];
    
    
    
}

- (UIImage *)imageFromImage:(UIImage *)image inRect:(CGRect)rect {
    CGImageRef sourceImageRef = [image CGImage];
    CGImageRef newImageRef = CGImageCreateWithImageInRect(sourceImageRef, rect);
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    return newImage;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
