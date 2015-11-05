//
//  UIImageView+Network.m
//  iHelp
//
//  Created by Kevin Lin on 11/5/15.
//  Copyright © 2015 IHP. All rights reserved.
//

#import "UIImageView+Network.h"
#import "FTWCache.h"
#import <objc/runtime.h>

static char URL_KEY;

@implementation UIImageView (Network)

@dynamic imageURL;

-(void)loadImageFromURL:(NSURL *)url placeholderImage:(UIImage *)placeholder cachingKey:(NSString *)key{
 
    self.imageURL = url;
    self.image = placeholder;
    
    NSData *cachedData = [FTWCache objectForKey:key];
    if (cachedData) {
        self.imageURL = nil;
        self.image = [UIImage imageWithData:cachedData];
        return;
    }
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
    dispatch_async(queue, ^{
        NSData *data = [NSData dataWithContentsOfURL:url];
        UIImage *imageFromData = [UIImage imageWithData:data];
        [FTWCache setObject:data forKey:key];
        if (imageFromData) {
            if ([self.imageURL.absoluteString isEqualToString:url.absoluteString]) {
                dispatch_sync(dispatch_get_main_queue(), ^{
                    self.image = imageFromData;
                });
            }else{
                NSLog(@"Not the same image!");
            }
        }
        self.imageURL = nil;
    });
    
}

-(void)setImageURL:(NSURL *)imageURL{
    objc_setAssociatedObject(self, &URL_KEY, imageURL, OBJC_ASSOCIATION_COPY);
}

-(NSURL *)imageURL{
    return objc_getAssociatedObject(self, &URL_KEY);
}

@end
