//
//  SNProdetail360DegreeView.m
//  Test360DegreeView
//
//  Created by wYt on 17/2/22.
//  Copyright © 2017年 wyt. All rights reserved.
//

#import "SNProdetail360DegreeView.h"
#import <CoreMotion/CoreMotion.h>

#define kWidth  [UIScreen  mainScreen].bounds.size.width
#define kHeight  [UIScreen  mainScreen].bounds.size.height

@interface SNProdetail360DegreeView ()

@property (nonatomic ,strong) CMMotionManager * motionManager;

@property (nonatomic ,strong) UILabel * msgLabel;

@end


@implementation SNProdetail360DegreeView

- (instancetype)initWithFrame:(CGRect)frame picArray:(NSArray *)picArray {
    
    if (self = [super initWithFrame:frame]) {
        
        self.picArray = [NSMutableArray arrayWithArray:picArray];
        
        self.motionManager = [[CMMotionManager alloc] init];
        
        self.userInteractionEnabled = YES;
        
    }
    return self;
}


- (instancetype)initWithFrame:(CGRect)frame{
    
    if (self = [super initWithFrame:frame]) {
        
        self.userInteractionEnabled = YES;
        
        self.motionManager = [[CMMotionManager alloc] init];
    
    }
    return self;
}

- (void)updateDeviceMotionData{
    
    //确定旋转角度
   
    __block NSInteger angleMount = self.picArray.count/2;
    
    __weak typeof(self) weakSelf = self;
    
    if ([weakSelf.motionManager isDeviceMotionAvailable]) {
      
        weakSelf.motionManager.deviceMotionUpdateInterval = 1/2;
        
        NSOperationQueue * queue = [[NSOperationQueue alloc] init];
        
        [weakSelf.motionManager startDeviceMotionUpdatesToQueue:queue withHandler:^(CMDeviceMotion * _Nullable motion, NSError * _Nullable error) {
            
            NSInteger attitudeY = motion.attitude.roll/M_PI * 180 ; //Y轴角度
            
            if (attitudeY >= -angleMount && attitudeY <= angleMount)  {

                if (labs(weakSelf.current - angleMount - attitudeY) >= 1) {//角度改变大于1°时更改图片
                    
                    weakSelf.current = attitudeY + angleMount;
                    
                    if (weakSelf.current < weakSelf.picArray.count) {

                        [weakSelf performSelectorOnMainThread:@selector(setImage:) withObject: [weakSelf.picArray objectAtIndex:weakSelf.current] waitUntilDone:NO];

                    }
                }
            }
            
            else if (attitudeY <= -(180-angleMount) ) {
                
                if (labs(weakSelf.current + 180 + attitudeY - angleMount) >= 1) {
                    
                    weakSelf.current = angleMount -  (180 +attitudeY);
                    
                    if (weakSelf.current < weakSelf.picArray.count) {
                        
                        [weakSelf performSelectorOnMainThread:@selector(setImage:) withObject: [weakSelf.picArray objectAtIndex:weakSelf.current] waitUntilDone:NO];
                        
                    }
                }
            }
            
            else if(attitudeY >= 180-angleMount) {
                
                if (labs(weakSelf.current - angleMount - 180 + attitudeY) >=  1) {
                    
                    weakSelf.current = angleMount + (180 - attitudeY);
                    
                    if (weakSelf.current < weakSelf.picArray.count) {
                        
                        [weakSelf performSelectorOnMainThread:@selector(setImage:) withObject: [weakSelf.picArray objectAtIndex:weakSelf.current] waitUntilDone:NO];
                        
                    }
                }
            }
        }];
    }
}

- (void)stopUpDate{

    [self.motionManager stopDeviceMotionUpdates];
    
    self.motionManager = nil;
}

- (NSMutableArray *)picArray {
    
    if (nil == _picArray) {
        
        _picArray = [NSMutableArray array];
    }
    
    return _picArray;
}

@end
