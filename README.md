# XHThumbnailAnnotation

XHThumbnailAnnotation is a simple mapkit annotation view for displaying images with clean design and animations. It is 100% programmatically drawn.

![XHThumbnailAnnotation in action](/Screenshots/XHThumbnailAnnotation.gif)

## Installation

### From CocoaPods

Add `pod 'XHThumbnailAnnotation'` to your Podfile.

### Manually

Copy the `XHThumbnailAnnotation` folder to your Xcode project and link the `MapKit`, `QuartzCore` and `CoreLocation` libraries.

## Usage

(see sample Xcode project in `/Demo`)

You add an `XHThumbnailAnnotation` just like any other `MKAnnotation`. The annotations take in a `XHThumbnail` object to display an image, title, subtitle at a specific coordinate. You can also set a block to be run when the disclosure button is tapped.

``` objc
XHThumbnailUser *empireUser = [[XHThumbnailUser alloc] init];
empireUser.avatarImage = [UIImage imageNamed:@"meicon.png"];
empireUser.userName = @"洛杉矶";
empireUser.distance = @"10000000米以内";
XHThumbnail *empire = [[XHThumbnail alloc] init];
empire.thumbnailUser = empireUser;
empire.coordinate = CLLocationCoordinate2DMake(33.979809, -118.219757);
empire.disclosureBlock = ^{ NSLog(@"添加的人物"); };
[_mapView addAnnotation:[[XHThumbnailAnnotation alloc] initWithThumbnail:empire]];
```

### Usage notes

Make sure the mapView implements the following 3 MKMapViewDelegate methods:

``` objc
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

```

## License

中文:      XHThumbnailAnnotation 是在MIT协议下使用的，可以在LICENSE文件里面找到相关的使用协议信息.

English:   XHThumbnailAnnotation is acailable under the MIT license, see the LICENSE file for more information.
