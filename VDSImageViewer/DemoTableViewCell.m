//
//  DemoTableViewCell.m
//  VDSImageViewer
//
//  Created by Vimal Das on 18/11/17.
//  Copyright © 2017 Vimal Das. All rights reserved.
//

#import "DemoTableViewCell.h"

@implementation DemoTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];

    _imageVw.layer.cornerRadius = 50;
    _imageVw.layer.masksToBounds = YES;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
