//
//  XHThumbnailAnnotation.h
//  XHThumbnailAnnotation
//
//  Created by 曾 宪华 on 14-1-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>
#import "XHThumbnail.h"
#import "XHThumbnailAnnotationView.h"

@protocol XHThumbnailAnnotationDelegate <NSObject>

- (MKAnnotationView *)annotationViewInMap:(MKMapView *)mapView;

@end

@interface XHThumbnailAnnotation : NSObject <MKAnnotation, XHThumbnailAnnotationDelegate>

@property (nonatomic, strong) XHThumbnailAnnotationView *thumbnailAnnotationView;
@property (nonatomic, strong) XHThumbnail *thumbnail;
@property (nonatomic, readwrite) CLLocationCoordinate2D coordinate;

- (instancetype)initWithThumbnail:(XHThumbnail *)thumbnail;
- (void)updateThumbnail:(XHThumbnail *)thumbnail aniamtion:(BOOL)animated;

@end
