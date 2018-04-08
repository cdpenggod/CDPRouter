//
//  ViewController.m
//  Router
//
//  Created by CDP on 2018/4/4.
//  Copyright © 2018年 CDP. All rights reserved.
//

#import "ViewController.h"


#import "CDPRouter.h" //引入.h头文件<---------

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    /****************************************************************************************************************
    //首先在CDPRouterMap的plist里面将所要映射的route写好，然后在CDPPushRouter或者CDPActionRouter里面将调用的实例方法写好，就可以直接调用了
    //CDPPushRouter和CDPActionRouter是我自己简单分的router，里面结构都一样，只不过分类管理个人感觉更舒服
    //如果想自定义，可以参考已有的PushRouter和ActionRouter结构自己修改创建新的router，然后将CDPRouterMap和CDPRouter里的映射关系写好就行
    ****************************************************************************************************************/
    
    //以下为应用示例
    self.automaticallyAdjustsScrollViewInsets=NO;
    self.view.backgroundColor=[UIColor whiteColor];

    for (NSInteger i=0;i<3;i++) {
        NSString *title=@"";
        SEL click = NULL;
        switch (i) {
            case 0:
                title=@"oneTest";
                click=@selector(topClick);
                break;
            case 1:
                title=@"TwoTest";
                click=@selector(footClick);
                break;
            case 2:
                title=@"action";
                click=@selector(actionClick);
                break;
        }
        UIButton *button=[[UIButton alloc] initWithFrame:CGRectMake(100,100+80*i,100,50)];
        button.adjustsImageWhenHighlighted=NO;
        [button setTitle:title forState:UIControlStateNormal];
        [button setTintColor:[UIColor redColor]];
        button.titleLabel.font=[UIFont systemFontOfSize:15];
        button.backgroundColor=[UIColor blackColor];
        [button addTarget:self action:click forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:button];
    }
    
    UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(100,320,150,50)];
    label.text=@"查看控制器log信息";
    label.font=[UIFont systemFontOfSize:15];
    label.textColor=[UIColor blackColor];
    [self.view addSubview:label];
}
#pragma mark - 点击事件
-(void)topClick{
    [CDPRouter routeWithUrl:@"push/OneTestVC" paramsDic:@{@"firstLog":@"这是给oneTest传入的参数"}];
}
-(void)footClick{
    //这个示例的名字乱写的，为了说明映射效果，不过不推荐，最好用topClick里面那种命名，清晰点而且也不怕造成命名重复，保持唯一
    [CDPRouter routeWithUrl:@"push/TwoTestLalala" paramsDic:@{@"theLog":@"这是给twoTest传入的参数"} block:^(NSDictionary *dic) {
        NSLog(@"这是传入TwoTestVC的block执行");
        
        NSLog(@"这是block执行时，TwoTestVC传出的回调参数dic:%@",dic);
    }];
}
-(void)actionClick{
    [CDPRouter routeWithUrl:@"action/Alert" paramsDic:@{@"title":@"这是titletitle",
                                                        @"message":@"这是messagemessage"
                                                        }];
}


















- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
