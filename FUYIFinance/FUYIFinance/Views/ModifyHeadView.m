//
//  ModifyHeadView.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/11.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "ModifyHeadView.h"

@implementation ModifyHeadView

- (void)awakeFromNib
{
 //self.frame  = CGRectMake(0, 0, ScreenWidth - 36, 160);

}

- (void)createUI
{
    CGRect framenew = self.backView.frame;
    framenew.size.width = ScreenWidth - 36;
    self.backView.frame = framenew;
    
    CGRect framenew1 = self.LibraryBtn.frame;
    framenew1.size.width = ScreenWidth - 36;
    self.LibraryBtn.frame = framenew1;
    [self.LibraryBtn addTarget:self action:@selector(photolibraryselect:) forControlEvents:UIControlEventTouchUpInside];
    CGRect framenew2 = self.TakePhotoBtn.frame;
    framenew2.size.width = ScreenWidth - 36;
    self.TakePhotoBtn.frame = framenew2;
    [self.TakePhotoBtn addTarget:self action:@selector(takephotoselect:) forControlEvents:UIControlEventTouchUpInside];
}

- (void)photolibraryselect:(UIButton*)sender
{
    if(self.LibraryBlock){
        self.LibraryBlock();
    }
}

- (void)takephotoselect:(UIButton*)sender
{
    if(self.TakeBlock){
        self.TakeBlock();
    }
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key
{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
