//
//  XHThumbnailAnnotation.m
//  XHThumbnailAnnotation
//
//  Created by 曾 宪华 on 14-1-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "XHThumbnailAnnotation.h"

@implementation XHThumbnailAnnotation

- (instancetype)initWithThumbnail:(XHThumbnail *)thumbnail {
    self = [super init];
    if (self) {
        _coordinate = thumbnail.coordinate;
        _thumbnail = thumbnail;
    }
    
    return self;
}

- (void)updateThumbnail:(XHThumbnail *)thumbnail aniamtion:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.33f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _coordinate = thumbnail.coordinate;
        } completion:NULL];
    } else {
        _coordinate = thumbnail.coordinate;
    }
    
}

@end
