//
//  AppDelegate.m
//  FUYIFinance
//
//  Created by youyou on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//  富宜财经

#import "AppDelegate.h"
#import "CHSocialService.h"
#import "UMSocialConfig.h"
#import "UMSocialControllerService.h"
#import "UPPaymentControl.h"
#import "UIViewController+HUD.h"



@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:100], NSForegroundColorAttributeName, [UIFont systemFontOfSize:15], NSFontAttributeName, nil]];
    self.DataSource = @[@{@"thumbimage":@"",@"title":@"",@"teachername":@"",@"price":@"",@"totoalprice":@""},@{@"thumbimage":@"",@"title":@"",@"teachername":@"",@"price":@"",@"totoalprice":@""}];
    
    [self changeToMain];
    [self configThirdLogin];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {//进入后台
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    UIApplication*   app = [UIApplication sharedApplication];
    __block    UIBackgroundTaskIdentifier bgTask;
    bgTask = [app beginBackgroundTaskWithExpirationHandler:^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    }];
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        dispatch_async(dispatch_get_main_queue(), ^{
            if (bgTask != UIBackgroundTaskInvalid)
            {
                bgTask = UIBackgroundTaskInvalid;
            }
        });
    });
    if (KGesturePsassword) {
        [[GestureHelper sharedGesture] startTime];
    }
}

- (void)applicationWillEnterForeground:(UIApplication *)application {//即将进入前台
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    if (KGesturePsassword){
        if (![[GestureHelper sharedGesture] isTimeOut]) {
            [[GestureHelper sharedGesture] endTime];
        }
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
      [CHSocialServiceCenter  applicationDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {//结束进程
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[Config Instance] saveTeminate];
}
- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation{
    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
        
        NSString *signData = data[@"data"];
        NSLog(@"验证的数据%@",signData);
        
        if ([code isEqualToString:@"success"]) {
            [[MyAPI sharedAPI] getUPPayInfoWithToken:KToken signinfo:signData result:^(BOOL sucess, NSString *msg) {
                if (sucess) {
                    [self.window.rootViewController showHint:@"充值成功"];
                }else{
                    [self.window.rootViewController showHint:@"充值失败"];
                }
            } errorResult:^(NSError *enginerError) {
                [self.window.rootViewController showHint:@"充值出错"];
            }];
      
        }else{
          [self.window.rootViewController showHint:@"充值失败"];
        }
     
    }];
    // [CHSocialServiceCenter handleOpenURL:url delegate:nil]
    return [CHSocialServiceCenter handleOpenURL:url delegate:nil];
}
//- (BOOL)application:(UIApplication *)app openURL:(NSURL *)url options:(NSDictionary<NSString *,id> *)options{
//    [[UPPaymentControl defaultControl] handlePaymentResult:url completeBlock:^(NSString *code, NSDictionary *data) {
//        
//        NSLog(@"签名数据%@",data);
//        NSLog(@"状态吗%@",code);
//        //发请求确认后台是否支付成功 来显示相应界面
//        NSString *signData = data[@"data"];
//        NSLog(@"验证的数据%@",signData);
//        
//    }];
//    return YES;
//}
#pragma mark - PrivateMethod
- (void)changeToMain{
    self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController = [self.mStorybord instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];
}
- (void)configThirdLogin{
    [CHSocialServiceCenter setUmengAppkey:@"57ce7020e0f55aa66a0030fc"];
    [[CHSocialServiceCenter shareInstance] configurationAppKey:nil AppIdentifier:@"wx6d891debc336b24d" secret:@"b170f4c7718470926acb509fb62c3529" redirectURL:nil sourceURL:@"http://www.baidu.com" type:CHSocialWeChat];
    [[CHSocialServiceCenter shareInstance] configurationAppKey:@"30d943072ae13df70819b342690c0c1f" AppIdentifier:@"101354010" secret:nil redirectURL:nil sourceURL:@"http://www.umeng.com/social" type:CHSocialQQ];
    [[CHSocialServiceCenter shareInstance] configurationAppKey:@"2299401221" AppIdentifier:@"1148538350" secret:@"ef97652eabb6cb4767e7b8b93fcbc5c1" redirectURL:@"http://sns.whalecloud.com/sina2/callback" sourceURL:@"http://www.umeng.com/social" type:CHSocialSina];
}
@end
