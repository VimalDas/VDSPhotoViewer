
//
//  ImageViewerAnimations.m
//  Pods
//
//  Created by Vimal Das on 27/10/17.
//
//

#import "VDSImageViewerAnimations.h"
#import "VDSContentViewController.h"

@implementation VDSImageViewerAnimations

-(void)setupViews:(UIImageView *)imgView view:(UIViewController *)viewController {
    isViewing = NO;
    sizeChanged = NO;
    isZoomed = NO;
    mainViewController = viewController;
    mainView = viewController.view;
    imgView.userInteractionEnabled = YES;
    screenCenter = CGPointMake([[UIScreen mainScreen] bounds].size.width/2, [[UIScreen mainScreen] bounds].size.height/2);
    screenSize = CGSizeMake([[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.height);
    [self addSingleTapGesture:imgView];
    
}

-(VDSContentViewController *)viewControllerAtIndex:(NSInteger)index {
    if (_imageArray.count == 0) {
        return [[VDSContentViewController alloc]init];
    }
    VDSContentViewController *vc = [[VDSContentViewController alloc]init];
    vc.pageIndex = index;
    vc.createdScrollView = [[UIScrollView alloc]init];
    vc.createdImageView = [[UIImageView alloc]init];
    vc.createdImageView.image = [UIImage imageNamed:_imageArray[index]];
    vc.panView = [[UIView alloc]init];
   // vc.createdImageView.userInteractionEnabled = YES;
    vc.panView.userInteractionEnabled = YES;
    if (mainViewControllerImageView == nil) {
        mainViewControllerImageView = vc.createdImageView;
    }
    if (mainViewControllerScrollView == nil) {
        mainViewControllerScrollView = vc.createdScrollView;
    }
    if (panView == nil) {
        panView = vc.panView;
    }
    [self addPanGesture:vc.panView];
//    [self addPanGesture:vc.createdImageView];
    return vc;
}

-(void)addSingleTapGesture:(UIImageView *)imgView {
    singleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(singleTapAction:)];
    singleTap.numberOfTapsRequired = 1;
    [imgView addGestureRecognizer: singleTap];
}

-(UIImageView *)createAnimatedImageView {
    UIImageView *imageView = [[UIImageView alloc]init];
    imageView.userInteractionEnabled = YES;
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    imageView.image = originalImageView.image;
    return imageView;
}

-(void)addDoubleTapGesture:(UIScrollView *)doubleTapView {
    doubleTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(doubleTapAction:)];
    doubleTap.numberOfTapsRequired = 2;
    [doubleTapView addGestureRecognizer: doubleTap];
}
-(void)addPanGesture:(UIView *)panview {
    panGesture = [[UIPanGestureRecognizer alloc]initWithTarget:self action:@selector(panAction:)];
    [panview addGestureRecognizer: panGesture];
}
-(void)panAction:(UIPanGestureRecognizer *)sender {
    if (!isZoomed) {
        if (sender.state == UIGestureRecognizerStateBegan || sender.state == UIGestureRecognizerStateChanged) {
            CGPoint pan = [sender translationInView:panView];
            [mainViewControllerImageView setCenter:CGPointMake(mainViewControllerImageView.center.x, mainViewControllerImageView.center.y + pan.y)];
            panView.center = mainViewControllerImageView.center;
            [sender setTranslation:CGPointZero inView:panView];
            
            if (mainViewControllerImageView.center.y > screenCenter.y + 50 || mainViewControllerImageView.center.y < screenCenter.y - 50) {
                if (!sizeChanged) {
                    storePoint = mainViewControllerImageView.center;
                    [UIView animateWithDuration:0.3 animations:^{
                        animatedImageView.image = mainViewControllerImageView.image;
                        mainViewControllerImageView.frame = CGRectMake(0, 0, mainViewControllerImageView.frame.size.width/2, mainViewControllerImageView.frame.size.height/2);
                        animatedImageView.frame = mainViewControllerImageView.frame;
                        mainViewControllerImageView.center = CGPointMake(screenCenter.x, storePoint.y);
                        animatedImageView.center = mainViewControllerImageView.center;
                        panView.center = mainViewControllerImageView.center;
                    }];
                    sizeChanged = YES;
                }
            }

        }else {
            if (mainViewControllerImageView.center.y > screenCenter.y + 100 || mainViewControllerImageView.center.y < screenCenter.y - 100) {
                [panView removeFromSuperview];
                [mainViewControllerImageView removeFromSuperview];
                [mainViewControllerScrollView removeFromSuperview];
                panView = nil;
                mainViewControllerImageView = nil;
                mainViewControllerScrollView = nil;
                CATransition* transition = [CATransition animation];
                transition.duration = 0.3;
                transition.type = kCATransitionReveal;
                transition.subtype = kCATransitionFromBottom;
                [pageViewController.view.window.layer addAnimation:transition forKey:kCATransition];
                [pageViewController dismissViewControllerAnimated:YES completion:nil];
                [self animateBackToNormal];
            } else {
                [UIView animateWithDuration:0.3 animations:^{
                    mainViewControllerImageView.frame = CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height);
                    animatedImageView.frame = mainViewControllerImageView.frame;
                    mainViewControllerImageView.center = mainViewControllerScrollView.center;
                    animatedImageView.center = mainViewControllerImageView.center;
                    panView.center = mainViewControllerImageView.center;
                }];
                sizeChanged = NO;
            }

        }
    }
}
-(void)animateBackToNormal{
    [UIView animateWithDuration:0.3 animations:^{
        mainViewControllerImageView.alpha = 0;
        animatedImageView.frame = originalImageView.frame;
        animatedImageView.center = originalImageViewCenter;
    } completion:^(BOOL finished) {
        [animatedImageView removeFromSuperview];
    
    }];
    sizeChanged = NO;
    isViewing = NO;
    isZoomed = NO;
}

-(void)singleTapAction:(UITapGestureRecognizer*)sender {
    if (!isViewing) {
        NSLog(@" tapped");
        for (UIView *view in mainView.subviews) {
            if ([view isKindOfClass:[UITableView class]]) {
                tableview = (UITableView *)view;
            }
            cellRect = tableview.visibleCells.firstObject.frame;
        }
        originalImageView = (UIImageView *)sender.view;
        tag = originalImageView.tag;
        calculatedImageViewPoint = cellRect.size.height * tag - tableview.contentOffset.y + tableview.frame.origin.y;
        animatedImageView = [self createAnimatedImageView];
        animatedImageView.image = originalImageView.image;
        animatedImageView.frame = CGRectMake(originalImageView.frame.origin.x, calculatedImageViewPoint, originalImageView.frame.size.width, originalImageView.frame.size.height);
        originalImageViewCenter = animatedImageView.center;
        [mainView addSubview: animatedImageView];
        [mainView bringSubviewToFront:animatedImageView];
        [UIView animateWithDuration:0.3 animations:^{
            animatedImageView.frame = CGRectMake(0, 0, mainView.frame.size.width, mainView.frame.size.height);
            animatedImageView.center = screenCenter;
        } completion:^(BOOL finished) {
            [self setupPageViewController];
        }];
        isViewing = YES;
    }
    
}

-(void)setupPageViewController {
    pageViewController = [[UIPageViewController alloc]initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    [pageViewController setDataSource:self];
    pageViewControllerScrollView = (UIScrollView *)pageViewController.view.subviews[0];
    [self addDoubleTapGesture:pageViewControllerScrollView];
    [self restartAction];
    CATransition* transition = [CATransition animation];
    transition.duration = 0.3;
    transition.type = kCATransitionFade;
    transition.subtype = kCATransitionFromBottom;
    [mainViewController.view.window.layer addAnimation:transition forKey:kCATransition];
        [mainViewController presentViewController:pageViewController animated:NO completion:^{
            
        }];

}
-(void)restartAction {
    [pageViewController setViewControllers:[NSArray arrayWithObject:[self viewControllerAtIndex:tag]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:^(BOOL finished) {
        
    }];
}

-(void)doubleTapAction:(UITapGestureRecognizer *)sender {
    NSLog(@"double tapped");
    isZoomed = !isZoomed;
    
    if (isZoomed) {
        mainViewControllerScrollView.minimumZoomScale = 1;
        mainViewControllerScrollView.maximumZoomScale = 5;
        [mainViewControllerScrollView setZoomScale:2 animated:YES];
        mainViewControllerScrollView.contentSize = mainViewControllerImageView.frame.size;
        mainViewControllerImageView.frame = CGRectMake(0, 0, mainViewControllerImageView.frame.size.width, mainViewControllerImageView.frame.size.height);
        animatedImageView.frame = CGRectMake(0, 0, animatedImageView.frame.size.width, animatedImageView.frame.size.height);
    } else {
        mainViewControllerScrollView.minimumZoomScale = 1;
        mainViewControllerScrollView.maximumZoomScale = 1;
        [mainViewControllerScrollView setZoomScale:1 animated:YES];
        [UIView animateWithDuration:0.3 animations:^{
            animatedImageView.center = screenCenter;
        }];
    }
}

// MARK:- UIPageViewController dataSource methods.
-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    VDSContentViewController *vc = (VDSContentViewController *)viewController;
    NSInteger index = vc.pageIndex;
    _pageIndex = index;
    panView = vc.panView;
    mainViewControllerImageView = vc.createdImageView;
    mainViewControllerScrollView = vc.createdScrollView;
    NSLog(@"pageViewController index %ld",(long)index);
    if (index == NSNotFound) {
        return nil;
    }
    index++;
    if (index == _imageArray.count) {
        return nil;
    }
    if (isZoomed) {
        isZoomed = !isZoomed;
    }
    
    return [self viewControllerAtIndex:index];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    VDSContentViewController *vc = (VDSContentViewController *)viewController;
    NSInteger index = vc.pageIndex;
    mainViewControllerImageView = vc.createdImageView;
    mainViewControllerScrollView = vc.createdScrollView;
    panView = vc.panView;
    _pageIndex = index;
     NSLog(@"pageViewController index %ld",(long)index);
    if (index == NSNotFound || index == 0) {
        return nil;
    }
    index--;
    if (isZoomed) {
        isZoomed = !isZoomed;
    }
    return [self viewControllerAtIndex:index];
}

@end
