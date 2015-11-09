//
//  UIImageView+Network.h
//  iHelp
//
//  Created by Kevin Lin on 11/5/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImageView (Network)

@property (nonatomic, strong) NSURL *imageURL;

-(void)loadImageFromURL:(NSURL *)url placeholderImage:(UIImage *)placeholder cachingKey:(NSString *)key;

@end
