//
//  MyAddressTextTableViewCell.h
//  FUYIFinance
//
//  Created by 张哲 on 16/7/13.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyAddressTextTableViewCell : UITableViewCell<UITextViewDelegate>
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *label1;

@end
