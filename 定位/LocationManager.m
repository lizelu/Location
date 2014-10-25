//
//  LocationManager.m
//  定位
//
//  Created by 李泽鲁 on 14-10-9.
//  Copyright (c) 2014年 Mrli. All rights reserved.
//

#import "LocationManager.h"

@interface LocationManager()
@property (nonatomic, strong) LocationBlock locationBlock;

@property (nonatomic, strong) MKMapView *mapView;

//经纬度结构体
@property (nonatomic, assign) CLLocationCoordinate2D locationCoordinate;

@end


@implementation LocationManager

//获取组件单例
+(LocationManager *)shareLocation
{
    static LocationManager *shareSingleton = nil;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shareSingleton = [[LocationManager alloc] init];
    });
    
    return shareSingleton;
    
}

//在初始化组件的时候启动定位
- (instancetype)init
{
    self = [super init];
    if (self) {
        [self startLocation];
    }
    return self;
}


//设置接收的block
-(void)setCurrentLocationBlock:(LocationBlock)block
{
     [self startLocation];
    self.locationBlock = block;
}


//启动MapView
-(void) startLocation
{
    //如果没分配内存的话分配内存
    if (_mapView == nil)
    {
        self.mapView = [[MKMapView alloc] init];
    }
    
    //设置委托回调
    self.mapView.delegate = self;
    self.mapView.showsUserLocation = YES;
}

//关闭MapView
-(void) stopLocation
{
    if (self.mapView != nil) {
        self.mapView.showsUserLocation = NO;
        self.mapView = nil;
    }
}


//实现协议中的方法获取坐标
-(void)mapView:(MKMapView *)mapView didUpdateUserLocation:(MKUserLocation *)userLocation
{
    //获取location
    CLLocation *location = userLocation.location;
    
    //通过location获取经纬度
    CLLocationCoordinate2D coordinate = location.coordinate;
    
    //把block块传入到block中
    self.locationBlock(coordinate);
}

//关闭MapView
-(void)mapView:(MKMapView *)mapView didFailToLocateUserWithError:(NSError *)error
{
    [self stopLocation];
}




@end
