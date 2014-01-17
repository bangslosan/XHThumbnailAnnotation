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

- (void)updateThumbnail:(XHThumbnail *)thumbnail animated:(BOOL)animated {
    if (animated) {
        [UIView animateWithDuration:0.33f delay:0 options:UIViewAnimationOptionCurveEaseInOut animations:^{
            _coordinate = thumbnail.coordinate;
        } completion:NULL];
    } else {
        _coordinate = thumbnail.coordinate;
    }
    
    if (_thumbnailAnnotationView) {
        _thumbnailAnnotationView.coordinate = self.coordinate;
        _thumbnailAnnotationView.userNameLabel.text = thumbnail.thumbnailUser.userName;
        _thumbnailAnnotationView.distanceLabel.text = thumbnail.thumbnailUser.distance;
        if (thumbnail.thumbnailUser.avatarImage) {
            _thumbnailAnnotationView.avatarImageView.image = thumbnail.thumbnailUser.avatarImage;
        } else if (thumbnail.thumbnailUser.avartarImageUrl) {
            // 通过URL下载，然后缓存到thumbnailUser里面去
        }
        _thumbnailAnnotationView.disclosureBlock = thumbnail.disclosureBlock;
    }
}

#pragma mark - MKAnnotation delegate

- (MKAnnotationView *)annotationViewInMap:(MKMapView *)mapView {
    if (!_thumbnailAnnotationView) {
        _thumbnailAnnotationView = (XHThumbnailAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:@"JPSThumbnailAnnotationView"];
        if (!_thumbnailAnnotationView) _thumbnailAnnotationView = [[XHThumbnailAnnotationView alloc] initWithAnnotation:self];
    } else {
        _thumbnailAnnotationView.annotation = self;
    }
    [self updateThumbnail:_thumbnail animated:NO];
    return _thumbnailAnnotationView;
}

@end
