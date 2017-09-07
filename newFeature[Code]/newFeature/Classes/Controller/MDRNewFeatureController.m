//
//  MDRNewFeatureController.m
//  newFeature
//
//  Created by 刘春牢 on 16/5/14.
//  Copyright © 2016年 liuchunlao. All rights reserved.
//

#import "MDRNewFeatureController.h"
#import "Masonry.h"

@interface MDRNewFeatureController ()

/** 存放图片的集合 */
@property (nonatomic, strong) NSArray *imgsArr;

@end

@implementation MDRNewFeatureController {

    UIScrollView *_scrollView;

    NSArray *_imgViewArr;
    
    UIButton *_exButton;
    
}

- (void)viewDidLoad {
    [super viewDidLoad];

    self.view.backgroundColor = [UIColor lightGrayColor];

    // MARK: - 搭建界面
    [self setupUI];
    
    // MARK: - 设置约束
    [self setupConstraints];
    
}

#pragma mark - 切换窗口的根控制器
- (void)switchWindowRootVc {

    NSLog(@"切换窗口的根控制器");
    UIViewController *demoVc = [[UIViewController alloc] init];
    demoVc.view.backgroundColor = [UIColor yellowColor];
    [UIApplication sharedApplication].keyWindow.rootViewController = demoVc;
    
}

#pragma mark - 搭建界面
- (void)setupUI {
    
    // scrollView视图
    UIScrollView *scrollV = [[UIScrollView alloc] init];
    
    // 允许分页
    scrollV.pagingEnabled = YES;
    
    [self.view addSubview:scrollV];
    _scrollView = scrollV;
    
    // 四个图片框
    NSMutableArray *temp = [NSMutableArray array];
    
    for (int i = 0; i < 4; i++) {
        
        UIImageView *imgView = [[UIImageView alloc] init];
        
        imgView.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        imgView.image = self.imgsArr[i];
        
        [scrollV addSubview:imgView];
        [temp addObject:imgView];
        
        if (i == 3) {
            
            UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
            
            [btn setImage:[UIImage imageNamed:@"Guide.bundle/guideStart.png"] forState:UIControlStateNormal];
            
            [imgView addSubview:btn];
            
            imgView.userInteractionEnabled = YES;
            
            _exButton = btn;
            
            [_exButton addTarget:self action:@selector(switchWindowRootVc) forControlEvents:UIControlEventTouchUpInside];
        }
        
    }
    
    _imgViewArr = temp;
}

#pragma mark - 设置约束
- (void)setupConstraints {

    // MARK: -1.scrollView的约束
    [_scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
       
        // 与控制器视图等大
        make.top.left.bottom.right.mas_equalTo(self.view);
    }];
    
    // MARK: -2.四个图片框的约束
    // 四个图片框，水平摆放，最左侧为0，最右侧为0，间距为0
    [_imgViewArr mas_distributeViewsAlongAxis:MASAxisTypeHorizontal withFixedSpacing:0 leadSpacing:0 tailSpacing:0];
    
    [_imgViewArr mas_makeConstraints:^(MASConstraintMaker *make) {
       
        // 水平时，用这个
        make.top.bottom.mas_equalTo(_scrollView);   // 这四个子控件与scrollView的顶部及底部对齐
        make.width.height.mas_equalTo(_scrollView); // 这四个子控件的大小与scrollView的大小一致
        
        // 垂直时，用这个
//        make.left.right.mas_equalTo(_scrollView);   // 这四个子控件与scrollView的左边及右边对齐
//        make.width.height.mas_equalTo(_scrollView); // 这四个子控件与scrollView的大小一致
        
    }];
    
    
    // MARK: -3.立即体验按钮
    [_exButton mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.centerX.mas_equalTo([_imgViewArr lastObject]);                     // 在图片框中水平居中
        make.bottom.mas_equalTo([_imgViewArr lastObject]).with.offset(-100);    // 距离底部100
        make.size.mas_equalTo(_exButton.currentImage.size);                     // 与图片大小相等
        
    }];
    
}

#pragma mark - 存放图片的集合
- (NSArray *)imgsArr {

    if (_imgViewArr == nil) {
        _imgViewArr = @[
                        [UIImage imageNamed:@"Guide.bundle/guide1Background@2x.png"],
                        [UIImage imageNamed:@"Guide.bundle/guide2Background@2x.png"],
                        [UIImage imageNamed:@"Guide.bundle/guide3Background@2x.png"],
                        [UIImage imageNamed:@"Guide.bundle/guide4Background@2x.png"]
                        ];
    }
    return _imgViewArr;
    
}












@end
