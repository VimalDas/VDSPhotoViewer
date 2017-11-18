//
//  ImageViewerAnimations.h
//  Pods
//
//  Created by Vimal Das on 27/10/17.
//
//

#import <UIKit/UIKit.h>

@interface VDSImageViewerAnimations : NSObject <UIScrollViewDelegate,UIPageViewControllerDataSource,UIGestureRecognizerDelegate>
{
    Boolean isZoomed;
    Boolean isViewing;
    Boolean sizeChanged;
    CGSize screenSize;
    CGPoint originalImageViewCenter;
    CGPoint screenCenter;
    CGPoint storePoint;
    CGRect cellRect;
    CGFloat calculatedImageViewPoint;
    CGFloat imageSize;
    UITapGestureRecognizer *singleTap;
    UITapGestureRecognizer *doubleTap;
    UIPanGestureRecognizer *panGesture;
    UITableView *tableview;
    UIImageView *originalImageView;
    UIImageView *animatedImageView;
    UIView *mainView;
    NSInteger tag;
    UIView *panView;
    UIViewController *mainViewController;
    UIScrollView *mainViewControllerScrollView;
    UIImageView *mainViewControllerImageView;
    UIPageViewController *pageViewController;
    UIScrollView *pageViewControllerScrollView;
}
@property (strong,nonatomic) NSArray *imageArray;
-(void)setupViews:(UIImageView *)imgView view:(UIViewController *)viewController;
@property(nonatomic,assign) NSInteger pageIndex;
@end
