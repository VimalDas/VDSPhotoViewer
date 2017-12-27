# VDSPhotoViewer

<a href="https://imgflip.com/gif/21qzr9"><img src="https://i.imgflip.com/21qzr9.gif" title="made at imgflip.com"/></a>


to use the image viewer

1. import VDSImageViewer.h to your class

2. create an object for imageViewer
      eg:   VDSImageViewerAnimations *obj;
  
  
  
3. allocate and initialize it.
      eg:  
      obj = [[VDSImageViewerAnimations alloc]init];
      
      obj.imageArray = arrayOfImages;  
      
      // create an array of image name as strings eg: arrayOfImages = [[NSArray alloc]initWithObjects:@"1",@"2",@"3",@"4",@"5", nil];
    
    
    
    
4. in tableview or collectionview, cell for row at index path, add
    
    [obj setupViews:cell.imageView view:self];
      cell.imageView.tag = indexPath.row; 
      
      // to the image view you are using to display the image, give the tag as indexpath.row.
    
     
    thats it. enjoy!!
    
