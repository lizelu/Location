//
//  LocationManager.h
//  定位
//
//  Created by 李泽鲁 on 14-10-9.
//  Copyright (c) 2014年 Mrli. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <MapKit/MapKit.h>

//定义一个Block来传出经纬度
typedef void (^LocationBlock) (CLLocationCoordinate2D coordinate);



//要实现MapView的协议
@interface LocationManager : NSObject<MKMapViewDelegate>


//获取组件单例的方法
+(LocationManager *)shareLocation;


//经纬度的回调接口
-(void)setCurrentLocationBlock:(LocationBlock)block;


//开启和关闭定位
//启动MapView
-(void) startLocation;
-(void) stopLocation;

@end
