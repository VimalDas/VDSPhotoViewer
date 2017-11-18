//
//  ContentViewController.m
//  ContactsSyncProject
//
//  Created by Vimal Das on 01/11/17.
//  Copyright © 2017 kawika. All rights reserved.
//

#import "VDSContentViewController.h"

@interface VDSContentViewController ()

@end

@implementation VDSContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    // _createdImageView = [[UIImageView alloc]init];
//    _createdScrollView = [[UIScrollView alloc]init];
    _createdScrollView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:_createdScrollView];
    [_createdScrollView setDelegate:self];
    [[_createdScrollView.topAnchor constraintEqualToAnchor:self.view.topAnchor constant:0]setActive:YES];
    [[_createdScrollView.bottomAnchor constraintEqualToAnchor:self.view.bottomAnchor constant:0]setActive:YES];
    [[_createdScrollView.leftAnchor constraintEqualToAnchor:self.view.leftAnchor constant:0]setActive:YES];
    [[_createdScrollView.rightAnchor constraintEqualToAnchor:self.view.rightAnchor constant:0]setActive:YES];
    _createdImageView.translatesAutoresizingMaskIntoConstraints = NO;
    _createdImageView.contentMode = UIViewContentModeScaleAspectFit;
    [_createdScrollView addSubview:_createdImageView];
    [[_createdImageView.widthAnchor constraintEqualToConstant:self.view.frame.size.width]setActive: YES];
    [[_createdImageView.heightAnchor constraintEqualToConstant:self.view.frame.size.height]setActive: YES];
    [[_createdImageView.centerXAnchor constraintEqualToAnchor:_createdScrollView.centerXAnchor constant:0]setActive:YES];
    [[_createdImageView.centerYAnchor constraintEqualToAnchor:_createdScrollView.centerYAnchor constant:0]setActive:YES];
    [self.view addSubview:_panView];
    [self.view bringSubviewToFront:_panView];
    _panView.backgroundColor = [UIColor clearColor];
    _panView.translatesAutoresizingMaskIntoConstraints = NO;
    [[_panView.widthAnchor constraintEqualToConstant:50] setActive:YES];
    [[_panView.heightAnchor constraintEqualToConstant:100] setActive:YES];
    [[_panView.centerXAnchor constraintEqualToAnchor:_createdImageView.centerXAnchor constant:0]setActive:YES];
    [[_panView.centerYAnchor constraintEqualToAnchor:_createdImageView.centerYAnchor constant:0]setActive:YES];
}

-(void)viewWillAppear:(BOOL)animated{
    _createdScrollView.minimumZoomScale = 1;
    _createdScrollView.maximumZoomScale = 1;
    [_createdScrollView setZoomScale:1 animated:YES];
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

// MARK:- scrollView delegate methods.
-(UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView{
        return _createdImageView;
}

@end
