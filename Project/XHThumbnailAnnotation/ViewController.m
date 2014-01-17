//
//  ViewController.m
//  XHThumbnailAnnotation
//
//  Created by 曾 宪华 on 14-1-17.
//  Copyright (c) 2014年 曾宪华 开发团队(http://iyilunba.com ) 本人QQ:543413507 本人QQ群（142557668）. All rights reserved.
//

#import "ViewController.h"
#import "XHThumbnail.h"
#import "XHThumbnailAnnotation.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self _setupMapView];
}

- (void)_setupMapView {
    // Map View
    MKMapView *mapView = [[MKMapView alloc] initWithFrame:self.view.bounds];
    mapView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    mapView.delegate = self;
    [self.view addSubview:mapView];
    
    // Annotations
    [mapView addAnnotations:[self _generateAnnotations]];
}

- (NSArray *)_generateAnnotations {
    NSMutableArray *annotations = [[NSMutableArray alloc] initWithCapacity:3];
    
    // Empire State Building
    XHThumbnailUser *empireUser = [[XHThumbnailUser alloc] init];
    empireUser.avatarImage = [UIImage imageNamed:@"empire.jpg"];
    empireUser.userName = @"Jack";
    empireUser.distance = @"1000米以内";
    XHThumbnail *empire = [[XHThumbnail alloc] init];
    empire.thumbnailUser = empireUser;
    empire.coordinate = CLLocationCoordinate2DMake(40.75, -73.99);
    empire.disclosureBlock = ^{ NSLog(@"selected Empire"); };
    
    [annotations addObject:[[XHThumbnailAnnotation alloc] initWithThumbnail:empire]];
    
    // Apple HQ
    XHThumbnailUser *appleUser = [[XHThumbnailUser alloc] init];
    appleUser.avatarImage = [UIImage imageNamed:@"apple.jpg"];
    appleUser.userName = @"Apple HQ";
    appleUser.distance = @"2000米以内";
    XHThumbnail *apple = [[XHThumbnail alloc] init];
    apple.thumbnailUser = appleUser;
    apple.coordinate = CLLocationCoordinate2DMake(37.33, -122.03);
    apple.disclosureBlock = ^{ NSLog(@"selected Appple"); };
    
    [annotations addObject:[[XHThumbnailAnnotation alloc] initWithThumbnail:apple]];
    
    // Parliament of Canada
    XHThumbnailUser *ottawaUser = [[XHThumbnailUser alloc] init];
    ottawaUser.avatarImage = [UIImage imageNamed:@"ottawa.jpg"];
    ottawaUser.userName = @"Jack";
    ottawaUser.distance = @"1000米以内";
    XHThumbnail *ottawa = [[XHThumbnail alloc] init];
    ottawa.thumbnailUser = ottawaUser;
    ottawa.coordinate = CLLocationCoordinate2DMake(45.43, -75.70);
    ottawa.disclosureBlock = ^{ NSLog(@"selected Ottawa"); };
    
    [annotations addObject:[[XHThumbnailAnnotation alloc] initWithThumbnail:ottawa]];
    
    return annotations;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - MKMapViewDelegate

- (void)mapView:(MKMapView *)mapView didSelectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(XHThumbnailAnnotationViewDelegate)]) {
        [((NSObject<XHThumbnailAnnotationViewDelegate> *)view) didSelectAnnotationViewInMap:mapView];
    }
}

- (void)mapView:(MKMapView *)mapView didDeselectAnnotationView:(MKAnnotationView *)view {
    if ([view conformsToProtocol:@protocol(XHThumbnailAnnotationViewDelegate)]) {
        [((NSObject<XHThumbnailAnnotationViewDelegate> *)view) didDeselectAnnotationViewInMap:mapView];
    }
}

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation {
    if ([annotation conformsToProtocol:@protocol(XHThumbnailAnnotationDelegate)]) {
        return [((NSObject<XHThumbnailAnnotationDelegate> *)annotation) annotationViewInMap:mapView];
    }
    return nil;
}

@end
