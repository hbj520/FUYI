//
//  ModifyHeadView.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/11.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void (^PhotoLibraryBlock) ();
typedef void (^TakePhotoBlock) ();

@interface ModifyHeadView : UIView

@property (weak, nonatomic) IBOutlet UIView *backView;

@property (weak, nonatomic) IBOutlet UIButton *LibraryBtn;
@property (weak, nonatomic) IBOutlet UIButton *TakePhotoBtn;
-(void)createUI;
@property (nonatomic,copy) PhotoLibraryBlock LibraryBlock;
@property (nonatomic,copy) TakePhotoBlock TakeBlock;

@end
