//
//  HomeTabbarViewController.m
//  FUYIFinance
//
//  Created by youyou on 16/6/14.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "HomeTabbarViewController.h"
#import "HexColor.h"
#import "MyShopViewController.h"
#import "MineTableViewController.h"

@interface HomeTabbarViewController ()<UITabBarControllerDelegate>
{
    NSArray *titleArrays;
    NSMutableArray *menusVCs;//tabbars的控制器
}
@property (nonatomic,strong) UIStoryboard *homePageSB;
@property (nonatomic,strong) UIStoryboard *blogSB;
@property (nonatomic,strong) UIStoryboard *collectionSB;
@property (nonatomic,strong) UIStoryboard *mineSB;
@property (nonatomic,assign) BOOL isteacher;
@end

@implementation HomeTabbarViewController
- (UIStoryboard *)homePageSB{
    if (!_homePageSB) {
        _homePageSB = [UIStoryboard storyboardWithName:@"HomePage" bundle:[NSBundle mainBundle]];
    }
    return _homePageSB;
}
- (UIStoryboard *)blogSB{
    if (!_blogSB) {
        _blogSB = [UIStoryboard storyboardWithName:@"Blog" bundle:[NSBundle mainBundle]];
    }
    return _blogSB;
}
- (UIStoryboard *)collectionSB{
    if (!_collectionSB) {
        _collectionSB = [UIStoryboard storyboardWithName:@"Collection" bundle:[NSBundle mainBundle]];
    }
   return _collectionSB;
}
- (UIStoryboard *)mineSB{
    if (!_mineSB) {
        _mineSB = [UIStoryboard storyboardWithName:@"Mine" bundle:[NSBundle mainBundle]];
    }
   return _mineSB;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(RecieveNoticeAct:) name:@"refreshView" object:nil];
    menusVCs = [NSMutableArray array];
    self.tabBar.tintColor = [UIColor colorWith8BitRed:232 green:59 blue:62]
    ;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"HomeTabbars" ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    NSError *error;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:&error];
    NSArray *array = dict[@"tabBarMenus"];
    for (NSDictionary *dic in array) {
        UITabBarItem *tabbarItem = [[UITabBarItem alloc] init];
        [tabbarItem setImage:[UIImage imageNamed:dic[@"image"]]];
        [tabbarItem setSelectedImage:[UIImage imageNamed:dic[@"select_image"]]];
        [tabbarItem setTitle:dic[@"title"]];
        SEL selector = NSSelectorFromString(dic[@"storybordId"]);
        IMP imp = [self methodForSelector:selector];
        UIStoryboard * (*func)(id,SEL) = (void *)imp;
        UIStoryboard *sb = func(self,selector);
        UIViewController *vc = [sb instantiateInitialViewController];
        if ([dic[@"title"] isEqualToString:@"个人中心"]) {
            UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
            NSString * IsTeacherOrNot = [[Config Instance] getisteacher];
            if ([IsTeacherOrNot isEqualToString:@"1"] ) {
                MyShopViewController *myshopVC = [storybord instantiateViewControllerWithIdentifier:@"teacherStorybordId"];
                UINavigationController *nav = (UINavigationController *)vc;
                UINavigationController *navVc = [nav initWithRootViewController:myshopVC];
                nav = navVc;
            }else{
                MineTableViewController *mineVC = [storybord instantiateViewControllerWithIdentifier:@"indivatualStorybordId"];
                UINavigationController *nav = (UINavigationController *)vc;
                UINavigationController *navVc = [nav initWithRootViewController:mineVC];
                nav = navVc;
            }
        }
        vc.tabBarItem = tabbarItem;
        [menusVCs addObject:vc];
    }
    self.viewControllers = menusVCs;
//    if (KGesturePsassword) {
//        [[GestureHelper sharedGesture] showGestureUnlockViewFromNowVC:menusVCs[0]];
//    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - TabbarDelegate
- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    
    if ([item.title isEqualToString:@"收藏"]) {
        if (!KToken) {
            [self LoginAct];
        }
    }else if ([item.title isEqualToString:@"博客"]){
        [[NSNotificationCenter defaultCenter] postNotificationName:@"loadrequest" object:nil];
    }
   
}

#pragma mark - PrivateMethod
- (void)LoginAct{
    UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
    UINavigationController *loginVC = [storybord instantiateViewControllerWithIdentifier:@"LoginStorybordId"];
    loginVC.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self.viewControllers[0] presentModalViewController:loginVC animated:YES];
}
- (void)RecieveNoticeAct:(NSNotification *)noti{
    NSNumber *isTech = noti.userInfo[@"isTech"];
    self.isteacher = isTech.boolValue;
    UINavigationController *vc = (UINavigationController *)self.viewControllers[3];
    [vc.viewControllers[0] removeFromParentViewController];
        UIStoryboard *storybord = [UIStoryboard storyboardWithName:@"Mine" bundle:nil];
        if (self.isteacher) {
            MyShopViewController *myshopVC = [storybord instantiateViewControllerWithIdentifier:@"teacherStorybordId"];
            UINavigationController *nav = (UINavigationController *)vc;
            UINavigationController *navVc = [nav initWithRootViewController:myshopVC];
            nav = navVc;
        }else{
            MineTableViewController *mineVC = [storybord instantiateViewControllerWithIdentifier:@"indivatualStorybordId"];
            UINavigationController *nav = (UINavigationController *)vc;
            UINavigationController *navVc = [nav initWithRootViewController:mineVC];
            nav = navVc;
        }
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"refreshView" object:nil];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
