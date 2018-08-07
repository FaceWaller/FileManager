//
//  TxtViewController.m
//  FileManager
//
//  Created by Alan on 2018/8/7.
//  Copyright © 2018年 Alan. All rights reserved.
//

#import "TxtViewController.h"
#define kTOPHEIght ([[UIApplication sharedApplication] statusBarFrame].size.height + self.navigationController.navigationBar.frame.size.height)
#define kTEXTVIEWHEIGHT (kHeight - kTOPHEIght)
@interface TxtViewController ()<UITextViewDelegate>
@property(nonatomic,weak)UITextView * textView;
@end

@implementation TxtViewController

- (UITextView *)textView{
    if (!_textView) {
        UITextView * textView = [[UITextView alloc]init];
        [self.view addSubview:textView];
        textView.delegate = self;
        textView.userInteractionEnabled = YES;
        textView.editable = YES;
        textView.showsVerticalScrollIndicator = YES;
        textView.autoresizingMask = UIViewAutoresizingFlexibleHeight;
        self.textView = textView;
    }
    return _textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self addKeyboardCenter];
    [self setUpUI];
    [self initData];
  
}

- (void)addKeyboardCenter{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
     [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification{
    NSDictionary * userInfo = [notification userInfo];
    NSValue * value = [userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect keyBoardRect = [value CGRectValue];
    float height = keyBoardRect.size.height;
    self.textView.frame = CGRectMake(0, kTOPHEIght, kWidth, kTEXTVIEWHEIGHT-height);
}

- (void)keyboardWillHide:(NSNotification *)notification{
    self.textView.frame = CGRectMake(0, kTOPHEIght, kWidth, kTEXTVIEWHEIGHT);

}


- (void)setUpUI{
    self.automaticallyAdjustsScrollViewInsets = NO;

    self.view.backgroundColor = [UIColor whiteColor];
    self.textView.frame = CGRectMake(0, kTOPHEIght, kWidth, kTEXTVIEWHEIGHT);
}

- (void)initData{
    NSData * data = [NSData dataWithContentsOfURL:self.fileUrl];
    NSString * str = [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding];
    self.textView.text = str;
}


#pragma mark UITextViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    CGFloat currentOffsetY = scrollView.contentOffset.y;
    if(currentOffsetY < -60){
        [self.textView endEditing:YES];
    }
}


@end
