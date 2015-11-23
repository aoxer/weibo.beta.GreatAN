//
//  ANComposeViewController.m
//  大安微博
//
//  Created by a on 15/11/15.
//  Copyright (c) 2015年 YongChaoAn. All rights reserved.
//

#import "ANComposeViewController.h"
#import "ANAccountTool.h"
#import "ANEmotionTextView.h"
#import "AFNetworking.h"
#import "MBProgressHUD+MJ.h"
#import "ANComposeToolbar.h"
#import "ANComposePhotosView.h"
#import "ANEmotionKeyboard.h" 
#import "ANEmotions.h"

@interface ANComposeViewController () <UITextViewDelegate, ANComposeToolbarDelegate,UINavigationControllerDelegate, UIImagePickerControllerDelegate>
/**
 *  输入文本框
 */
@property ( nonatomic, weak)ANEmotionTextView *textView;
/**
 *  输入工具条
 */
@property (nonatomic, weak)ANComposeToolbar *inputToolbar;
/**
 *  相册 (存放拍照或者选好的图片)
 */
@property (nonatomic, weak)ANComposePhotosView *photosView;
/**
 *  表情相册
 */
@property (nonatomic, strong)ANEmotionKeyboard *emotionKeyboard;



@property (nonatomic, assign) BOOL switchingKeyboard;

@end

@implementation ANComposeViewController

#pragma mark 懒加载
/**
 *  懒加载
 */
- (ANEmotionKeyboard *)emotionKeyboard
{
    if (!_emotionKeyboard) {
        self.emotionKeyboard = [[ANEmotionKeyboard alloc] init];
        
        self.emotionKeyboard.height = 216;
        self.emotionKeyboard.width = ANScreenWidth;
    }
    return _emotionKeyboard;
}

#pragma mark 系统方法
- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    // 设置导航栏
    [self setupNav];
    
    // 添加输入控件
    [self setupTextView];
    
    // 添加键盘工具条
    [self setupInputToolbar];

    
    // 添加相册到textView
    [self setupPhotosView];
}
#pragma mark 生命周期方法
- (void)viewDidAppear:(BOOL)animated
{
    // 成为第一响应者 弹出键盘
    [self.textView becomeFirstResponder];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];    
    self.navigationItem.rightBarButtonItem.enabled = NO;

}

- (void)viewWillDisappear:(BOOL)animated
{
    [self.view endEditing:YES];
}
- (void)dealloc
{
    [ANNotificationCenter removeObserver:self];
    [ANNotificationCenter removeObserver:self];
    [ANNotificationCenter removeObserver:self];
    [ANNotificationCenter removeObserver:self];
}

#pragma mark 初始化方法

/**
 *  添加相册到textView
 */
- (void)setupPhotosView
{
    ANComposePhotosView *photosView = [[ANComposePhotosView alloc] init];
    
    [self.textView addSubview:photosView];
    
    self.photosView = photosView;
}

/**
 *  设置键盘工具条
 */
- (void)setupInputToolbar
{
    ANComposeToolbar *inputToolbar = [[ANComposeToolbar alloc] init];
    inputToolbar.y = self.view.height - inputToolbar.height;
    inputToolbar.delegate = self;
    
    [self.view addSubview:inputToolbar];
    
    self.inputToolbar = inputToolbar;
}



/**
 *  设置输入框
 */
- (void)setupTextView
{
    // 这个控制器中,textView的contentInset.top默认会等于64
    ANEmotionTextView *textView = [[ANEmotionTextView alloc] initWithFrame:self.view.bounds];
    // 垂直方向永远可以拖拽
    textView.alwaysBounceVertical = YES;
    textView.placeholder = @"有什么新鲜事";
    textView.font = [UIFont systemFontOfSize:15];
    textView.delegate = self;
    
    [self.view addSubview:textView];
    self.textView = textView;
    
    
    
    // 监听文字改变的通知
    [ANNotificationCenter addObserver:self selector:@selector(textDidChange) name:UITextViewTextDidChangeNotification object:textView];
    
    // 监听键盘改变frame的通知
    [ANNotificationCenter addObserver:self selector:@selector(keyboardWillChangeFrame:) name:UIKeyboardWillChangeFrameNotification object:nil];
    
    // 监听表情被点击的通知
    [ANNotificationCenter addObserver:self selector:@selector(emotionDidSelected:) name:ANEmotionDidSelectNotification object:nil];
    
    // 监听删除按钮被点击的通知
    [ANNotificationCenter addObserver:self selector:@selector(emotionDelBtnClick) name:ANEmotionDidClickDeleteButtonNotification object:nil];
    
}

/**
 *  设置导航栏
 */
- (void)setupNav
{ 
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleDone target:self action:@selector(cancel)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"发送" style:UIBarButtonItemStyleDone target:self action:@selector(send)];
    UILabel *titleView = [[UILabel alloc] init];
    titleView.width = 200;
    titleView.height = 44;
    titleView.numberOfLines = 0;
    titleView.textAlignment = NSTextAlignmentCenter;
    
    NSString *prefix = @"发微博";
    NSString *name = [ANAccountTool account].name;
    
    if (name) {
        NSString *titleStr = [NSString stringWithFormat:@"%@\n%@", prefix, name];
        
        // 创建一个带有属性的字符串 比如颜色小户型, 字体属性等文字属性
        NSMutableAttributedString *attrStr = [[NSMutableAttributedString alloc] initWithString:titleStr];
        // 设置属性
        [attrStr addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:15] range:[titleStr rangeOfString:prefix]];
        [attrStr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13] range:[titleStr rangeOfString:name]];
        [attrStr addAttribute:NSStrokeWidthAttributeName value:@1 range:[titleStr rangeOfString:name]];
        
        // 添加附件 图片等
        //    NSTextAttachment *attchment = [[NSTextAttachment alloc] init];
        //    attchment.image = [UIImage imageNamed:@"avatar_vip"];
        //    NSAttributedString *imgStr = [NSAttributedString attributedStringWithAttachment:attchment];
        //    [attrStr appendAttributedString:imgStr];
        
        titleView.attributedText = attrStr;
        self.navigationItem.titleView = titleView;
    } else {
        self.title = prefix;
    }
}
#pragma mark 监听方法

/**
 *  点击删除表情按钮
 */
- (void)emotionDelBtnClick
{
    [self.textView deleteBackward];
}

/**
 *  键盘的位置发生改变
 */
- (void)emotionDidSelected:(NSNotification *)notification
{
   ANEmotions *emotions = notification.userInfo[ANSelectEmotionKey];

    [self.textView insertEmotion:emotions];
}

/**
 *  键盘的位置发生改变
 */
- (void)keyboardWillChangeFrame:(NSNotification *)notificaiton
{
    if (self.switchingKeyboard) return;
    /*
     ANLog(@"%@",notificaiton.userInfo);
     // 键盘弹出后的frame
     UIKeyboardFrameEndUserInfoKey = NSRect: {{0, 352}, {320, 216}},
     // 键盘弹出\隐藏所耗费的时间
     UIKeyboardAnimationDurationUserInfoKey = 0.25,
     // 键盘弹出\隐藏动画的执行节奏（先快后慢，匀速）
     UIKeyboardAnimationCurveUserInfoKey = 7

     */
    
    NSDictionary *userInfo = notificaiton.userInfo;
    CGRect keyboardFrame = [userInfo[UIKeyboardFrameEndUserInfoKey] CGRectValue];
    double duration = [userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue];
    [UIView animateWithDuration:duration animations:^{
        
        if (keyboardFrame.origin.y > self.view.height) {
            self.inputToolbar.y = self.view.height - self.inputToolbar.height;
        } else {
            self.inputToolbar.y = keyboardFrame.origin.y - self.inputToolbar.height;
        }
    }];
}
/**
 *  点击取消按钮
 */
- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  点击发送按钮
 */
- (void)send
{
    if (self.photosView.photos.count) {// 有图片
        [self sendWithImage];
        
    } else { // 无图片
        [self sendWithoutImage];
    }
    
}


/**
 *  发送有图片的微博
 */
- (void)sendWithImage
{
    /* https://upload.api.weibo.com/2/statuses/upload.json
     access_token	ture	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     status         true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     pic            true	binary	要上传的图片，仅支持JPEG、GIF、PNG格式，图片大小小于5M。
     */
    // 1.请求管理者
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    // 2.拼接请求参数
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    params[@"access_token"] = [ANAccountTool account].access_token;
    params[@"status"] = self.textView.fullText;
    
    // 3.发送请求
    [mgr POST:@"https://upload.api.weibo.com/2/statuses/upload.json" parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData> formData) {
        // 拼接文件数据
        UIImage *image = [self.photosView.photos firstObject];
        NSData *data = UIImageJPEGRepresentation(image, 1.0);
        // name:请求参数  fileName:随便写 mineType image/jpeg 为固定格式
        [formData appendPartWithFileData:data name:@"pic" fileName:@"test.jpg" mimeType:@"image/jpeg"];
    } success:^(AFHTTPRequestOperation *operation, NSDictionary *responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
}

/**
 *  发送没有图片的微博
 */
- (void)sendWithoutImage
{
    /* https://api.weibo.com/2/statuses/update.json
     access_token	false	string	采用OAuth授权方式为必填参数，其他授权方式不需要此参数，OAuth授权后获得。
     status	true	string	要发布的微博文本内容，必须做URLencode，内容不超过140个汉字。
     
     */
    AFHTTPRequestOperationManager *mgr = [AFHTTPRequestOperationManager manager];
    
    NSMutableDictionary *parameters = [NSMutableDictionary dictionary];
    parameters[@"access_token"] = [ANAccountTool account].access_token;
    parameters[@"status"] = self.textView.fullText;
    
    // 发送请求
    [mgr POST:@"https://api.weibo.com/2/statuses/update.json" parameters:parameters success:^(AFHTTPRequestOperation *operation, id responseObject) {
        [MBProgressHUD showSuccess:@"发送成功"];
    } failure:^(AFHTTPRequestOperation *operation, NSError *error) {
        [MBProgressHUD showError:@"发送失败"];
    }];
    // dismiss
    [self dismissViewControllerAnimated:YES completion:nil];
}

/**
 *  文字发生改变调用
 */
- (void)textDidChange
{
    self.navigationItem.rightBarButtonItem.enabled = self.textView.hasText;
}

#pragma mark UITextViewDelegate
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.view endEditing:YES];
}

#pragma mark ANComposeToolbarDelegate
- (void)composeToolbar:(ANComposeToolbar *)toolbar didClickButton:(ANComposeToolbarButtonType)buttonType
{
    switch (buttonType) {
        case ANComposeToolbarButtonTypeCamera: // 相机
            [self openCamera];
            break;
            
        case ANComposeToolbarButtonTypePicture: // 图片
            [self openAlbum];
            break;
            
        case ANComposeToolbarButtonTypeMention: // @
            ANLog(@"@");
            break;
            
        case ANComposeToolbarButtonTypeTrend:   // #
            ANLog(@"#");
            break;
            
        case ANComposeToolbarButtonTypeEmotion: // 表情\键盘
            
            [self switchKeyboard];
            
            break;
            
    }
}

#pragma mark 其他方法
/**
 *  切换键盘
 */
- (void)switchKeyboard
{
    if (self.textView.inputView == nil) { // 切换为自定义表情键盘
        
        self.textView.inputView = self.emotionKeyboard;
        
        // 显示键盘按钮
        self.inputToolbar.showKeyboardBtn = YES;
        
    } else { // 切换为系统自带键盘
        self.textView.inputView = nil;
        
        // 显示表情按钮
        self.inputToolbar.showKeyboardBtn = NO;
    }
    // 开始切换键盘,
    self.switchingKeyboard = YES;
    
    // 退出键盘
    [self.textView endEditing:YES];
     
    // 结束切换键盘
    self.switchingKeyboard = NO;
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        // 弹出键盘
        [self.textView becomeFirstResponder];
        
    });
}
/**
 *  打开相机
 */
- (void)openCamera
{
    [self openImagePickerController:UIImagePickerControllerSourceTypeCamera];
}


/**
 *  打开相册
 */
- (void)openAlbum
{
    [self openImagePickerController:UIImagePickerControllerSourceTypePhotoLibrary];
}

/**
 *  打开图片选择控制器
 */
- (void)openImagePickerController:(UIImagePickerControllerSourceType)type
{
    if (![UIImagePickerController isSourceTypeAvailable:type]) return;
    UIImagePickerController *ipc = [[UIImagePickerController alloc] init];
    ipc.sourceType = type;
    ipc.delegate = self;
    
    [self presentViewController:ipc animated:YES completion:nil];
    
}

#pragma mark UIImagePickerControllerDelegate
/**
 *  从imagePickerController选择完图片后就调用, 拍照完毕或者选择相册完毕
 */
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    // info中包含了选择的图片
    UIImage *image = info[UIImagePickerControllerOriginalImage];
    
    [self.photosView addPhoto:image];
}


 

@end
