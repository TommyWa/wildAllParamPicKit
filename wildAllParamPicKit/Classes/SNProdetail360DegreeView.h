//
//  SNProdetail360DegreeView.h
//  Test360DegreeView
//
//  Created by wYt on 17/2/22.
//  Copyright © 2017年 wyt. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SNProdetail360DegreeView : UIImageView

@property (nonatomic ,assign) NSInteger current;

@property (nonatomic ,assign) int increment;

@property (nonatomic ,assign) int numberOfImages;

@property (nonatomic ,strong) NSMutableArray * picArray;

- (instancetype)initWithFrame:(CGRect)frame picArray:(NSArray *)picArray;

- (void)updateDeviceMotionData;

- (void)stopUpDate;
@end
