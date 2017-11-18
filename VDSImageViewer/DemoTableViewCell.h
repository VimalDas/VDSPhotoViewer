//
//  DemoTableViewCell.h
//  VDSImageViewer
//
//  Created by Vimal Das on 18/11/17.
//  Copyright © 2017 Vimal Das. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DemoTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *imageVw;
@property (weak, nonatomic) IBOutlet UILabel *lbl;

@end
