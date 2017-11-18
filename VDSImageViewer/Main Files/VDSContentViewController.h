//
//  ContentViewController.h
//  ContactsSyncProject
//
//  Created by Vimal Das on 01/11/17.
//  Copyright © 2017 kawika. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface VDSContentViewController : UIViewController<UIScrollViewDelegate>
@property (nonatomic) NSInteger pageIndex;
@property (strong,nonatomic) UIImageView *createdImageView;
@property (strong,nonatomic) UIScrollView *createdScrollView;
@property (strong,nonatomic) UIView *panView;
@end
