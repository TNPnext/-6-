//
//  UIImage+gif.m
//  WPsdInternal
//
//  Created by Kings Yan on 2016/12/23.
//  Copyright © 2016年 wapushidai. All rights reserved.
//

#import "UIImage+gif.h"
#import <ImageIO/ImageIO.h>

@implementation UIImage (gif)

- (UIImage *)fetchFirst
{
    NSData *data = UIImagePNGRepresentation(self);
    CGImageSourceRef gifSource = CGImageSourceCreateWithData((CFDataRef)data, NULL);
    UIImage *image;
    CGImageRef imageRef = CGImageSourceCreateImageAtIndex(gifSource, 0, NULL);
    image = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return image;
}

@end
