//
//  LGDViewController.m
//  LiveGaming
//
//  Created by xy on 16/4/25.
//  Copyright © 2016年 zenghui. All rights reserved.
//

#import "LGDRTMPViewController.h"

#import "IJKMoviePlayerViewController.h"



@interface LGDRTMPViewController ()
@end

@implementation LGDRTMPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:@"http://devimages.apple.com.edgekey.net/streaming/examples/bipbop_4x3/bipbop_4x3_variant.m3u8"];
    //    NSString *scheme = [[url scheme] lowercaseString];
    
//    rtmp://192.168.57.54:1935/myapp
//    http://krtv.qiniudn.com/150522nextapp
    [IJKVideoViewController presentFromViewController:self withTitle:[NSString stringWithFormat:@"URL: %@", url] URL:url completion:^{
        //            [self.navigationController popViewControllerAnimated:NO];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



@end
