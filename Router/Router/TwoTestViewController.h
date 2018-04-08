//
//  TwoTestViewController.h
//  Router
//
//  Created by Wolonge on 2018/4/8.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import <UIKit/UIKit.h>


typedef void(^EnterBlock)(NSString *feedBack);


@interface TwoTestViewController : UIViewController


@property (nonatomic,copy) NSString *theLog;

@property (nonatomic,copy) EnterBlock block;









@end
