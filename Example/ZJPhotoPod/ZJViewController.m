//
//  ZJViewController.m
//  ZJPhotoPod
//
//  Created by zhujin001032 on 03/15/2016.
//  Copyright (c) 2016 zhujin001032. All rights reserved.
//

#import "ZJViewController.h"
#import <ZJPhotoPod/ZJPhoto.h>
@interface ZJViewController ()<ZJTakePhotoActionSheetDelegate>
{
    ZJTakePhotoActionSheet *ac;
}
@end

@implementation ZJViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIButton *showButton = [UIButton buttonWithType:UIButtonTypeCustom];
    showButton.frame =CGRectMake(100, 100, 100, 50);
    showButton.backgroundColor = [UIColor grayColor];
    [showButton addTarget:self action:@selector(selectedImage:) forControlEvents:UIControlEventTouchUpInside];
    [showButton setTitle:@"拍照/相册" forState:UIControlStateNormal];
    [self.view addSubview: showButton];
}

- (void)selectedImage:(UIButton *)sender
{
    if ( !ac) {
        ac = [[ZJTakePhotoActionSheet alloc] init];
        ac.takePhotoDelegate = self;
        ac.owner = self;
        ac.allowEdit = YES;
        ac.maxNumber = 3;
    }
    [ac showInView:self.view];
    
}
- (void)takePhotoActionSheet:(ZJTakePhotoActionSheet *)actionSheet didSelectedImageAtPath:(NSString *)path;
{
    
}

- (void)takePhotoActionSheet:(ZJTakePhotoActionSheet *)actionSheet didSelectedImagesPath:(NSMutableArray *)arrPaths
{
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
