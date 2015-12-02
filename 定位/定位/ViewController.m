//
//  ViewController.m
//  定位
//
//  Created by mac on 15/12/2.
//  Copyright © 2015年 hm. All rights reserved.
//

#import "ViewController.h"
#import <corelocation/CoreLocation.h>


@interface ViewController () <CLLocationManagerDelegate>

@property (nonatomic, strong) CLLocationManager *locationManager;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  // 导入CoreLocation
    // 1. 创建CLLocationManager管理器
    self.locationManager = [[CLLocationManager alloc] init];
    // 2. 请求授权,配置plist
    if ([self.locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
        
        [self.locationManager requestWhenInUseAuthorization];
    }
    
    if ([self.locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
        
        [self.locationManager requestAlwaysAuthorization];
    }
    
    /// iOS 9.0 新特性
    if ([UIDevice currentDevice].systemVersion.floatValue >= 9.0) {
        self.locationManager.allowsBackgroundLocationUpdates = YES;
    }
    
    // 3. 设置代理
    self.locationManager.delegate = self;
    // 4. 开始定位
    [self.locationManager startUpdatingLocation];
    
    // 距离筛选器
    self.locationManager.distanceFilter = 10;
    
    // 设置精准度
    self.locationManager.desiredAccuracy = kCLLocationAccuracyKilometer;
    
    /// 比较两个位置之间的距离
    // 聊城
    CLLocation *location1 = [[CLLocation alloc]initWithLatitude:36.45 longitude:115.97];
    // 北京
    CLLocation *location2 = [[CLLocation alloc] initWithLatitude:40.2 longitude:116.2];
    
    CGFloat distance = [location2 distanceFromLocation:location1];

    NSLog(@"distamce: %f",distance / 1000);
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray<CLLocation *> *)locations{
    
    CLLocation *location = locations.firstObject;
    
    NSLog(@"latitede:%f,longtitude:%f",location.coordinate.latitude,location.coordinate.longitude);
   
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
