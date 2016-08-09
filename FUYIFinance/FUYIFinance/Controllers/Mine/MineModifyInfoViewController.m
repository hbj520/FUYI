//
//  MineModifyInfoViewController.m
//  FUYIFinance
//
//  Created by 张哲 on 16/7/21.
//  Copyright © 2016年 youyou. All rights reserved.
//

#import "MineModifyInfoViewController.h"
#import "UIViewController+HUD.h"
#import <SDWebImage/UIImageView+WebCache.h>
#import "ChangeHeadView.h"
#import "PersonalUserInfo.h"
#import "KGModal.h"
#import "Config.h"
#import "MyAPI.h"

@interface MineModifyInfoViewController ()<UIImagePickerControllerDelegate,UINavigationControllerDelegate,UIActionSheetDelegate>
{
    UIImagePickerController * _picker;
    NSString * imageUrl;
    PersonalUserInfo * userInfo;
}
@property (weak, nonatomic) IBOutlet UILabel *sexlabel;
@property (weak, nonatomic) IBOutlet UILabel *nickName;
@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UITextField *qqnum;

@property (weak, nonatomic) IBOutlet UITextField *emailnum;
@end

@implementation MineModifyInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initPickView];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeNickname:) name:@"returnnick" object:nil];
    imageUrl = [[Config Instance] getIcon];
    self.headImage.layer.cornerRadius = 24;
    self.headImage.layer.masksToBounds = YES;
    self.tableView.showsVerticalScrollIndicator = NO;
    [self loadData];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
#pragma mark - PrivateMethod
- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(KToken){
        NSString * imageurl = [[Config Instance] getIcon];
        [self.headImage sd_setImageWithURL:[NSURL URLWithString:imageurl] placeholderImage:[UIImage imageNamed:@"defaulticon"]];
    }
    self.navigationController.navigationBarHidden = NO;
}

//改变昵称
- (void)changeNickname:(NSNotification *)nick
{
    self.nickName.text = nick.userInfo[@"nickname"];
}

//加载数据
- (void)loadData
{
    [[MyAPI sharedAPI] PersonalDetailInfoWith:^(BOOL success, NSString *msg, id object) {
        userInfo = object;
        [self createUI];
    } errorResult:^(NSError *enginerError) {
        
    }];
}

//搭接面
- (void)createUI
{
    if(userInfo){
        self.nickName.text = userInfo.userName;
        if(userInfo.sex){
            self.sexlabel.text = userInfo.sex;
        }
        self.qqnum.text = userInfo.qqNum;
        self.emailnum.text = userInfo.email;
    }
}


- (void)initPickView
{
    _picker = [[UIImagePickerController alloc] init];
    _picker.delegate = self;
}


- (void)openCamera
{
    _picker.sourceType = UIImagePickerControllerSourceTypeCamera;
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void)openPhotoAlbun
{
    _picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_picker animated:YES completion:nil];
}

- (void)showModalView
{
   
    [[KGModal sharedInstance] setCloseButtonType:KGModalCloseButtonTypeNone];
    [KGModal sharedInstance].modalBackgroundColor = [UIColor whiteColor];
    
    ChangeHeadView * modifyView = [[[NSBundle mainBundle] loadNibNamed:@"ChangeHeadView" owner:self options:nil] lastObject];
    
    [[KGModal sharedInstance] showWithContentView:modifyView andAnimated:YES];
    
    modifyView.LibraryBlock = ^(){
        [self openPhotoAlbun];
        [[KGModal sharedInstance] hideAnimated:YES];
    };
    modifyView.TakeBlock = ^(){
        [self openCamera];
        [[KGModal sharedInstance] hideAnimated:YES];
    };
  
    
}


#pragma mark-UINavigationControllerDelegate & UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary<NSString *,id> *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage * image = info[UIImagePickerControllerOriginalImage];
  
    NSData * data = UIImageJPEGRepresentation(image, 0.1);
  
    [self showHudInView:self.view hint:@"上传图片中"];
    [[MyAPI sharedAPI] uploadImage:data result:^(BOOL sucess, NSString *msg) {
        if(sucess){
            imageUrl = msg;
            [self.headImage sd_setImageWithURL:[NSURL URLWithString:msg] placeholderImage:[UIImage imageNamed:@"defaulticon"]];
            [[Config Instance] saveIcon:msg];
            
            [self hideHud];
        }else{
            [self.headImage setImage:[UIImage imageNamed:@"defaulticon"]];
        }
    } errorResult:^(NSError *enginerError) {
       
    }];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



#pragma mark-UIActionSheetDelegate
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if(buttonIndex == 0){
        self.sexlabel.text = @"男";
    }else{
        self.sexlabel.text = @"女";
    }
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if(section == 0){
    return 6;
    }else{
        return 1;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    if(section == 0){
        return 15;
    }
    else{
        return 1;
        }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section == 0){
        if(indexPath.row == 0){
            return 64;
        }else if(indexPath.row == 5) {
            return ScreenHeight - 400;
        }else{
            return 54;
        }
    }else if (indexPath.section == 1){
        return 44;
    }
    return 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0){
        [self showModalView];
    }else if (indexPath.row == 1){
        [self performSegueWithIdentifier:@"nicknameSegue" sender:nil];
    }else if (indexPath.row == 2){
        UIActionSheet * sheetView = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"男",@"女", nil];
        [sheetView showInView:self.view];
    }else if (indexPath.row == 3){
        
    }else if (indexPath.row == 4){
        
    }else if (indexPath.row == 5){
        [self.qqnum resignFirstResponder];
        [self.emailnum resignFirstResponder];
    }
    else{
        
    }
}
- (IBAction)commit:(id)sender {
    [[NSNotificationCenter defaultCenter] postNotificationName:@"updateImage" object:nil userInfo:nil];
    [[MyAPI sharedAPI] PersonalInfoModifyWithParameters:self.nickName.text
                                               imgThumb:imageUrl
                                                  qqNum:self.qqnum.text
                                                    Sex:self.sexlabel.text
                                               emailNum:self.emailnum.text
                                                 result:^(BOOL sucess, NSString *msg) {
                                                     if(sucess){
                                                         [[Config Instance] saveUsername:self.nickName.text];
                                                         [self showHint:@"上传成功"];
                                                       
                                                     }else{
                                                         [self showHint:msg];
                                                     }
        
    } errorResult:^(NSError *enginerError) {
        
    }];
    
}

- (IBAction)back:(id)sender {
    self.navigationController.navigationBarHidden = YES;
    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"returnnick" object:nil];
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
