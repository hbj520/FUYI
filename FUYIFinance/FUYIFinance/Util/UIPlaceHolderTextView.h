//
//  UIPlaceHolderTextView.h
//  Note
//
//  Created by Razi on 13-1-22.
//  Copyright (c) 2013年 Razi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIPlaceHolderTextView : UITextView{
    NSString *placeholder;
    UIColor *placeholderColor;
    
@private UILabel *placeHolderLabel;
}
@property (nonatomic, retain)UILabel *placeHolderLabel;
@property (nonatomic, retain)NSString *placeholder;
@property (nonatomic, retain)UIColor *placeholderColor;

-(void)textChanged:(NSNotification *)notification;

@end
