//
//  OneTestViewController.m
//  Router
//
//  Created by CDP on 2018/4/8.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "OneTestViewController.h"

@interface OneTestViewController ()

@end

@implementation OneTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //log输出传入的参数
    NSLog(@"~~OneTestVC~~log输出传入的参数firstLog:%@",_firstLog);
    
    
    
    self.view.backgroundColor=[UIColor whiteColor];
    
    UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(100,100,100,50)];
    button.adjustsImageWhenHighlighted=NO;
    [button setTitle:@"cancel" forState:UIControlStateNormal];
    [button setTintColor:[UIColor redColor]];
    button.titleLabel.font=[UIFont systemFontOfSize:15];
    button.backgroundColor=[UIColor blackColor];
    [button addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
    
}
-(void)dealloc{
    NSLog(@"OneTestVC释放dealloc");
}
#pragma mark - 点击事件
-(void)click{
    [self dismissViewControllerAnimated:YES completion:nil];
}






- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
