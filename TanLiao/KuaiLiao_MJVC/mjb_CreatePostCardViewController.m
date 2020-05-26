//
//  CreatePostCardViewController.m
//  SeeYou
//
//  Created by 唐蒙波 on 2018/4/2.
//  Copyright © 2018年 mac. All rights reserved.
//

#import "mjb_CreatePostCardViewController.h"

@interface mjb_CreatePostCardViewController ()

@end

@implementation mjb_CreatePostCardViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.cloudClient = [TanLiaoLiao_CloudClient getInstance];
    
    [self setTabBarHidden];
    self.titleLale.text = @"发布图片";
    UIButton * faBuButton = [[UIButton alloc] initWithFrame:CGRectMake(VIEW_WIDTH-60*BILI,0, 60*BILI, self.navView.frame.size.height-SafeAreaTopHeight)];
    [faBuButton addTarget:self action:@selector(faBuButtonClick) forControlEvents:UIControlEventTouchUpInside];
    [faBuButton setTitle:@"发布" forState:UIControlStateNormal];
    [faBuButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    faBuButton.titleLabel.font = [UIFont systemFontOfSize:15*BILI];
    [self.navView addSubview:faBuButton];
    
    self.mainScrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, self.navView.frame.origin.y+self.navView.frame.size.height, VIEW_WIDTH, VIEW_HEIGHT-(self.navView.frame.origin.y+self.navView.frame.size.height))];
    [self.view addSubview:self.mainScrollView];
    UITapGestureRecognizer * tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(bottomViewTap)];
    [self.mainScrollView addGestureRecognizer:tap];

    
    self.selectImageView = [[UIImageView alloc] initWithFrame:CGRectMake(10*BILI, 10*BILI, VIEW_WIDTH-20*BILI, VIEW_WIDTH-20*BILI)];
    self.selectImageView.image = [UIImage imageNamed:@"mjb_select_pic"];
    self.selectImageView.userInteractionEnabled = YES;
    self.selectImageView.contentMode = UIViewContentModeScaleAspectFit;
    self.selectImageView.autoresizingMask = UIViewAutoresizingNone;
    [self.mainScrollView addSubview:self.selectImageView];
    UITapGestureRecognizer * tap1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(selectImage)];
    [self.selectImageView addGestureRecognizer:tap1];

    UILabel * tipLable = [[UILabel alloc] initWithFrame:CGRectMake(10*BILI, self.selectImageView.frame.origin.y+self.selectImageView.frame.size.height+15*BILI, VIEW_WIDTH-20*BILI, 15*BILI)];
    tipLable.text = @"为照片添加描述:生动的描述跟漂亮的图片更配哦~";
    tipLable.textColor = [UIColor lightGrayColor];
    tipLable.font = [UIFont systemFontOfSize:12*BILI];
    [self.mainScrollView addSubview:tipLable];
    
    UIView * describleBottomView = [[UIView alloc] initWithFrame:CGRectMake(10*BILI, tipLable.frame.origin.y+tipLable.frame.size.height+10*BILI, VIEW_WIDTH-20*BILI, 80*BILI)];
    describleBottomView.backgroundColor = UIColorFromRGB(0xF4F4F4);
    describleBottomView.layer.masksToBounds = YES;
    describleBottomView.layer.cornerRadius = 8*BILI;
    [self.mainScrollView addSubview:describleBottomView];
    
    self.describleTextView = [[UITextView alloc] initWithFrame:CGRectMake(10*BILI, 10*BILI, describleBottomView.frame.size.width-20*BILI, describleBottomView.frame.size.height-20*BILI)];
    self.describleTextView.textColor = [UIColor blackColor];
    self.describleTextView.font = [UIFont systemFontOfSize:15*BILI];
    self.describleTextView.backgroundColor =  UIColorFromRGB(0xF4F4F4);
    [describleBottomView addSubview:self.describleTextView];
    
}
-(void)faBuButtonClick
{
    if (!self.selectedImage) {
        
        [TanLiao_Common showToastView:@"请选择要发布的照片" view:self.view];
        return;
    }
    if([TanLiao_Common isEmpty:self.describleTextView.text])
    {
        [TanLiao_Common showToastView:@"请为照片添加描述" view:self.view];
        return;
    }
    [self.describleTextView resignFirstResponder];
    
     [self showLoginLoadingView:@"正在提交..." view:nil];
    
    UIImage * uploadImage = [TanLiao_Common scaleToSize:self.selectedImage size:CGSizeMake(600, 600*(self.selectedImage.size.height/self.selectedImage.size.width))];
    
    NSData *data = UIImagePNGRepresentation(uploadImage);
    
    NSString *encodedImageStr = [data base64EncodedStringWithOptions:0];
    
    
    NSString *imageType = [TanLiao_Common contentTypeForImageData:data];
    
    [self.cloudClient uploadImage:@"8024"
                picBody_base64Str:encodedImageStr
                        picFormat:imageType
                             type:@"1"
                         delegate:self
                         selector:@selector(uploadSuccess:)
                    errorSelector:@selector(uploadError:)];
    
  
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [[NSNotificationCenter defaultCenter]
     addObserver:self
     selector:@selector(keyboardWillShow:)
     name:UIKeyboardWillShowNotification
     object:self.view.window];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide) name:UIKeyboardWillHideNotification object:nil];

}
-(void)bottomViewTap
{
    [self.describleTextView resignFirstResponder];
}
-(void)selectImage
{
    [self.describleTextView resignFirstResponder];
    UIActionSheet * actionSheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从手机相册选择", nil];
    actionSheet.actionSheetStyle = UIActionSheetStyleBlackTranslucent;
    
    [actionSheet showInView:self.view.window];

}
#pragma UIActionSheetDelegate
-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if(buttonIndex == 0)
    {
        //拍照
        [self showImagePicker:UIImagePickerControllerSourceTypeCamera];
        
        
    }
    else if (buttonIndex == 1)
    {
        //从相册选取
        
        [self showImagePicker:UIImagePickerControllerSourceTypePhotoLibrary];
    }
    else
    {
        
    }
}
- (void)showImagePicker:(UIImagePickerControllerSourceType)sourceType
{
    
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]) {
        self.imagePickerController = [[UIImagePickerController alloc] init] ;
        self.imagePickerController.delegate = self;
        self.imagePickerController.sourceType = sourceType;
        self.imagePickerController.allowsEditing = YES;
        
        [self presentModalViewController:self.imagePickerController animated:YES];
    } else {
        [TanLiao_Common showAlert:nil message:@"您的设备不支持此种方式上传照片"];
    }
}
#pragma mark - UIImagePickerControllerDelegate
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{   //判断是否设置头像
    UIImage *image = [info valueForKey:UIImagePickerControllerEditedImage];
    [self dismissModalViewControllerAnimated:YES];
    
    self.selectedImage = image;
    self.selectImageView.image =image;
    
}
-(void)uploadSuccess:(NSDictionary *)info
{
    NSString * url = [info objectForKey:@"url"];
    [self.cloudClient mjb_faBuPostCard:@"8125"
                                picUrl:url
                               content:self.describleTextView.text
                              delegate:self
                              selector:@selector(faBuSuccess:)
                         errorSelector:@selector(uploadError:)];
}
-(void)faBuSuccess:(NSDictionary *)info
{
     [self hideNewLoadingView];
    [TanLiao_Common showToastView:@"发布成功" view:self.view];
    [self performSelector:@selector(successPop) withObject:nil afterDelay:0.5];
}
-(void)successPop
{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)uploadError:(NSDictionary *)info
{
    [self hideNewLoadingView];
    [TanLiao_Common showToastView:[info objectForKey:@"message"] view:self.view];
}
#pragma mark--键盘弹出时的监听事件
- (void)keyboardWillShow:(NSNotification *) notification
{
    CGRect keyboardBounds;
    [[notification.userInfo valueForKey:UIKeyboardFrameEndUserInfoKey] getValue: &keyboardBounds];
    keyboardBounds = [self.view convertRect:keyboardBounds toView:nil];
    //键盘高度
    float keyboardHeight = keyboardBounds.size.height;
    
    [self.mainScrollView setContentOffset:CGPointMake(0, keyboardHeight)];
}
- (void)keyboardWillHide
{
     [self.mainScrollView setContentOffset:CGPointMake(0, 0)];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
