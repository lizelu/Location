//
//  ViewController.m
//  定位
//
//  Created by 李泽鲁 on 14-10-9.
//  Copyright (c) 2014年 Mrli. All rights reserved.
//

#import "ViewController.h"
#import "LocationManager.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *myLabel;

@property (strong, nonatomic) LocationManager *locationManager;

//坐标
@property (assign, nonatomic) CLLocationCoordinate2D coordinate;

//MKMapView
@property (strong, nonatomic) IBOutlet MKMapView *myMkMapView;


@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //获取组件的单例
    self.locationManager = [LocationManager shareLocation];
    
	// Do any additional setup after loading the view, typically from a nib.
}


- (IBAction)tapButton:(id)sender {
    
    [self.locationManager startLocation];
    __block __weak ViewController *copy_self = self;
    
    [self.locationManager setCurrentLocationBlock:^(CLLocationCoordinate2D coordinate) {
        
        [copy_self mapPoint:coordinate];
        
    }];
}


//关闭定位
- (IBAction)tapStop:(id)sender {
    [self.locationManager stopLocation];
}


-(void) mapPoint:(CLLocationCoordinate2D) coordinate
{
    NSString *labelString = [NSString stringWithFormat:@"经度：%lf,维度：%lf",coordinate.longitude, coordinate.latitude];
    self.myLabel.text = labelString;
    
    //获取经纬度
    self.coordinate = coordinate;
    
    MKCoordinateSpan span;
    span.latitudeDelta=0.5;
    span.longitudeDelta=0.5;
    MKCoordinateRegion region={coordinate ,span};
    
    [self.myMkMapView setRegion:region];
    self.myMkMapView.showsUserLocation = YES;
    
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
