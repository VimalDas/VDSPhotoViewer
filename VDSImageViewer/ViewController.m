//
//  ViewController.m
//  VDSImageViewer
//
//  Created by Vimal Das on 18/11/17.
//  Copyright © 2017 Vimal Das. All rights reserved.
//

#import "ViewController.h"
#import "DemoTableViewCell.h"
#import "VDSImageViewerAnimations.h"

@interface ViewController ()
{
    NSArray *imageArray;
    NSArray *messageArray;
}
@property (strong,nonatomic) VDSImageViewerAnimations *obj;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    imageArray = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    messageArray = [[NSArray alloc]initWithObjects:@"click the image to view the image in VDSImageViewer",@"double tap in VDSImageViewer to zoom",@"double tap again to resize",@"swipe left or right to view the other images", @"swipe down to dismiss VDSImageViewer", nil];
    
    
    _obj = [[VDSImageViewerAnimations alloc]init];
    _obj.imageArray = imageArray;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return imageArray.count;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    DemoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"demo"];
    cell.imageVw.image = [UIImage imageNamed:imageArray[indexPath.row]];
    cell.lbl.text = messageArray[indexPath.row];
    
    cell.imageVw.tag = indexPath.row;
    [_obj setupViews:cell.imageVw view:self];
    
    return cell;
    
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 155;
}

@end
