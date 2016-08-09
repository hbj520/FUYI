//
//  AppDelegate.m
//  FUYIFinance
//
//  Created by youyou on 16/6/6.
//  Copyright © 2016年 youyou. All rights reserved.
//  富宜财经

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
                                                           [UIColor colorWithRed:90/255.0 green:90/255.0 blue:90/255.0 alpha:100], NSForegroundColorAttributeName, [UIFont systemFontOfSize:15], NSFontAttributeName, nil]];
    self.DataSource = @[@{@"thumbimage":@"",@"title":@"",@"teachername":@"",@"price":@"",@"totoalprice":@""},@{@"thumbimage":@"",@"title":@"",@"teachername":@"",@"price":@"",@"totoalprice":@""}];
    
    [self changeToMain];
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {//进入后台
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
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
}

- (void)applicationWillTerminate:(UIApplication *)application {//结束进程
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    [[Config Instance] saveTeminate];
}
#pragma mark - PrivateMethod
- (void)changeToMain{
    self.mStorybord = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    self.window.rootViewController = [self.mStorybord instantiateViewControllerWithIdentifier:@"HomeTabBarVC"];

}

@end
