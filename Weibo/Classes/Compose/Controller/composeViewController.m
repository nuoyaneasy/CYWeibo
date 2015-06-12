//
//  composeViewController.m
//  Weibo
//
//  Created by Yang Chao on 6/6/15.
//  Copyright (c) 2015 Self. All rights reserved.
//

#import "ComposeViewController.h"
#import "MultilineTextView.h"
#import "WeiboAccountTool.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "WeiboComposeToolbar.h"
#import "WeiboComposePhotosView.h"
#import "WeiboEmotionKeyboard.h"
#import "WeiboEmotion.h"

@interface ComposeViewController () <UITextViewDelegate, WeiboComposeToolbarDelegate, UINavigationControllerDelegate, UIImagePickerControllerDelegate>

@property (nonatomic, weak) MultilineTextView *textView;
@property (nonatomic, weak) WeiboComposeToolbar *toolBar;
@property (nonatomic, weak) WeiboComposePhotosView *photosView;
@property (nonatomic, strong) WeiboEmotionKeyboard *emotionKeyboard;
@end

@implementation ComposeViewController
#pragma mark - 懒加载 

- (WeiboEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[WeiboEmotionKeyboard alloc] init];
    }
    return _emotionKeyboard;
}

#pragma mark - 系统方法

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    [self setupNav];
    
    [self setupTextView];
    
    [self setupToolbar];
    
    [self setupPhotosView];
    
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self.textView becomeFirstResponder];

}

- (void)dealloc
{
    [CYNotificationCenter removeObserver:self];
}

#pragma mark - 视图初始化


- (void)setupNav
{
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    self.navigationItem.rightBarButtonItem.enabled = NO;

    NSString *name = [WeiboAccountTool account].name;
    NSString *prefix = @"发微博";
    if (name) {
        UILabel *titleView = [[UILabel alloc] init];
        titleView.width = 200;
        titleView.height = 100;
        titleView.textAlignment = NSTextAlignmentCenter;
        //自动换行
        titleView.numberOfLines = 0;
        titleView.y = 50;
        
        NSString *str = [NSString stringWithFormat:@"%@\n%@",prefix, name];
        
        //创建一个带有属性的字符串
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:str];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:16] range:[str rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:12] range:[str rangeOfString:name]];
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}

- (void)setupTextView
{
    MultilineTextView *textView = [[MultilineTextView alloc] init];
    textView.placeholder = @"分享你的新鲜事...";
    //垂直方向永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.font = [UIFont systemFontOfSize:15];
    textView.frame = self.view.bounds;
    [self.view addSubview:textView];
    self.textView = textView;
    
    //监听通知
    [CYNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    [CYNotificationCenter addObserver:self selector:@selector(emotionDidSelect:) name:WeiboEmotionDidSelectNotification object:nil];
    
    //键盘通知
    //键盘位置和尺寸发生改变，发出通知
    //UIKeyboardWillChangeFrameNotification
    //UIKeyboardDidChangeFrameNotification
    //显示或者隐藏，发出通知
    //UIKeyboardWillHideNotification
    //UIKeyboardWillShowNotification
    [CYNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
}

- (void)setupToolbar
{
    //inputView 设置键盘
   // self.textView.inputView = [UIButton buttonWithType:UIButtonTypeContactAdd];
    //设置键盘工具栏
    WeiboComposeToolbar *toolBar = [[WeiboComposeToolbar alloc] init];
    toolBar.height = 48;
    toolBar.width = self.view.width;
    toolBar.y = self.view.height - toolBar.height;
    [self.view addSubview:toolBar];
    toolBar.delegate = self;
    self.toolBar = toolBar;
}

/**
 *  添加献策
 *
 *  @return <#return value description#>
 */

- (void)setupPhotosView
{
    WeiboComposePhotosView *photosView = [[WeiboComposePhotosView alloc] init];
    photosView.width = self.view.width;
    photosView.height = self.view.height; //随便一个高度
    photosView.y = 100;
    [self.textView addSubview:photosView];
    self.photosView = photosView;
}

#pragma mark 监听方法

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)send
{
    if (self.photosView.photos.count) {
        [self sendWithImage];
    } else {
        [self sendWithoutImage];
    }
    [self dismissViewControllerAnimated:YES completion:nil];

}

- (void)sendWithImage
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WeiboAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) { //拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);  //5M以内的图片
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test1.jpg" mimeType:@"iamge/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    
    //4. 请求发送完毕就dismiss
}

- (void)sendWithoutImage
{
    //1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    //2. 拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [WeiboAccountTool account].access_token;
    params[@"status"] = self.textView.text;
    
    //3.发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:params success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
        CYLog(@"%@",error);
    }];
    
    //4. 请求发送完毕就dismiss
}

- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

/**
 *  键盘发生改变时，调用这个方法
 *
 *  @param notification <#notification description#>
 */

- (void)keyboardWillChangeFrame:(NSNotification *)notification
{
    //这个字典里，都是NSValue，不是NSRect或者NSPoint之类的对象
//    {name = UIKeyboardWillChangeFrameNotification; userInfo = {
//        UIKeyboardFrameBeginUserInfoKey = NSRect: {{0, 409}, {375, 258}},
//        UIKeyboardCenterEndUserInfoKey = NSPoint: {187.5, 796},
//        UIKeyboardBoundsUserInfoKey = NSRect: {{0, 0}, {375, 258}},
          //键盘出现时候的frame
//        UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 667}, {375, 258}},
//        UIKeyboardAnimationDurationUserInfoKey = 0.25,
//        UIKeyboardCenterBeginUserInfoKey = NSPoint: {187.5, 538},
//        UIKeyboardAnimationCurveUserInfoKey = 7
//    }}
    NSDictionary *userInfo = notification.userInfo;
    //动画持续时间
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    //键盘的frame
    CGRect keyboardF = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    [UIView animateWithDuration:duration animations:^{
        self.toolBar.y = keyboardF.origin.y - self.toolBar.height;
        CYLog(@"%@",NSStringFromCGRect(self.toolBar.frame ));
    }];
}

- (void)emotionDidSelect:(NSNotification *)notification
{
    WeiboEmotion *emotion =  notification.userInfo[SelectEmotionKey];
    
    if (emotion.code) {
        //insertText
        [self.textView insertText:emotion.code];
    } else if (emotion.png) {
        NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] init];
        //拼接之前的文字和图片
        [attr appendAttributedString:self.textView.attributedText];
        
        //加载图片
        NSTextAttachment *attach = [[NSTextAttachment alloc] init];
        attach.image = [UIImage imageNamed:emotion.png];
        CGFloat attchWH = self.textView.font.lineHeight;
        attach.bounds = CGRectMake(0, 0, attchWH, attchWH);
        NSAttributedString *imageString = [NSAttributedString attributedStringWithAttachment:attach];
        
        //拼接图片
        [attr appendAttributedString:imageString];
        
        //设置字体
        [attr addAttribute:NSFontAttributeName value:self.textView.font range:NSMakeRange(0, attr.length)];
        
        self.textView.attributedText =attr;
        
    }
}

#pragma mark - UITextViewDelegate


- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}
#pragma mark - WeiboComposeToolbarDelegate
//
//- (void)composeToolbar:(WeiboComposeToolbar *)composeToolbar didClickButton:(WeiboComposeToolbarType)buttonType
//{
//    NSLog(@"123");
//
//    switch (buttonType) {
//        case WeiboComposeToolbarTypeCamera: //拍照
//            CYLog(@"123");
//            [self openCamera];
//            break;
//            
//        default:
//            break;
//    }
//}
- (void)composeToolbar:(WeiboComposeToolbar *)toolbar didClickButton:(WeiboComposeToolbarType)buttonType
{
    switch (buttonType) {
        case WeiboComposeToolbarTypeCamera: // 拍照
            [self openCamera];
            break;
            
        case WeiboComposeToolbarTypePicture: // 相册
            [self openAlbum];
            break;
            
        case WeiboComposeToolbarTypeMention: // @
            //HWLog(@"--- @");
            break;
            
        case WeiboComposeToolbarTypeTrend: // #
            //HWLog(@"--- #");
            break;
            
        case WeiboComposeToolbarTypeEmotion: // 表情\键盘
            [self switchKeyboard];
            break;
    }
}

#pragma mark - toolBar 其他方法

- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}

- (void)openAlbum
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

- (void)switchKeyboard //切换键盘
{
    if (self.textView.inputView == nil) {
        WeiboEmotionKeyboard *emotionKb = [[WeiboEmotionKeyboard alloc] init];
        emotionKb.width = self.view.width;
        emotionKb.height = 216;
        self.textView.inputView = emotionKb;
        
        //显示键盘图标
    } else { //切换为系统自带键盘
        self.textView.inputView = nil;
        //显示表情图标
    }
    //退出键盘
    [self.view endEditing:YES];
    //[self.view.window endEditing:YES];
    //弹出键盘
    //[self.textView becomeFirstResponder];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self.textView becomeFirstResponder];
    });
}

- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    [self presentViewController:ipc animated:YES completion:nil];
}

#pragma mark - UIImagePickerControllerDelegate
/**
 *  从pickerController选择完毕后（拍照完毕或者选择相册完毕）
 *
 *  @param picker <#picker description#>
 *  @param info   <#info description#>
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];//pickerController默认不会隐藏，所以需要在代理里面来隐藏
    //通过info这个字典，拿到这个key，可以获取其中包含的image
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    //添加图片到photosView中
    [self.photosView addPhoto:image];
}

@end
