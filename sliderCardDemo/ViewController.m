//
//  ViewController.m
//  sliderCardDemo
//
//  Created by rockfintech on 2020/11/27.
//
#define appWidth CGRectGetWidth([[UIScreen mainScreen] bounds])
#define appHight CGRectGetHeight([[UIScreen mainScreen] bounds])
#import "ViewController.h"
#import "XLCardSwitch.h"
@interface ViewController ()<XLCardSwitchDelegate>
//卡片式滑动
@property (nonatomic, strong) XLCardSwitch *cardSwitch;

@property (nonatomic, strong) UIImageView *imageView;

@property (nonatomic, strong) NSMutableArray *models;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //上半部分的卡片滑动
    [self addImageView];
    [self addCardSwitch];
    [self buildData];
}
- (void)addImageView {
    self.imageView = [[UIImageView alloc] init];
    [self.view addSubview:self.imageView];
    self.imageView.frame = CGRectMake(0, 0, appWidth-30, 200);
    //毛玻璃效果
    UIBlurEffect* effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView* effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = self.view.bounds;
    [self.imageView addSubview:effectView];
    self.imageView.backgroundColor = [UIColor redColor];
}

- (void)addCardSwitch {
    //初始化
    self.cardSwitch = [[XLCardSwitch alloc] initWithFrame: CGRectMake(0, 70, appWidth, 220)];
 
    //设置代理方法
    self.cardSwitch.delegate = self;
    //分页切换
    self.cardSwitch.pagingEnabled = false;
    [self.view addSubview:self.cardSwitch];
}

- (void)buildData {
    //初始化数据源
    
    self.models = [NSMutableArray new];
    
    for (int i = 1 ; i<6; i++) {
        NSMutableDictionary * dic = [[NSMutableDictionary alloc]init];
        [dic setObject:@"3" forKey:@"title"];
        [dic setObject: [NSString stringWithFormat:@"%d",i] forKey:@"imageName"];
        XLCardModel *model = [[XLCardModel alloc] init];
        [model setValuesForKeysWithDictionary:dic];
        [self.models addObject:model];
    }
    
    
    //设置卡片数据源
    self.cardSwitch.models = self.models;
    
    //更新背景图
    [self configImageViewOfIndex:self.cardSwitch.selectedIndex];
}

//开关分页效果
- (void)segMethod:(UISegmentedControl *)seg {
    switch (seg.selectedSegmentIndex) {
        case 0:
            self.cardSwitch.pagingEnabled = false;
            break;
        case 1:
            self.cardSwitch.pagingEnabled = true;
            break;
        default:
            break;
    }
}

#pragma mark -
#pragma mark CardSwitchDelegate
- (void)cardSwitchDidClickAtIndex:(NSInteger)index {
    NSLog(@"点击了：%zd",index);
    [self configImageViewOfIndex:index];
}

- (void)cardSwitchDidScrollToIndex:(NSInteger)index {
    NSLog(@"滚动到了击了：%zd",index);
    [self configImageViewOfIndex:index];
}

#pragma mark -
#pragma mark 更新imageView
- (void)configImageViewOfIndex:(NSInteger)index {
    //更新背景图
    XLCardModel *model = self.models[index];
    self.imageView.image = [UIImage imageNamed:model.imageName];
}

#pragma mark -
#pragma mark 手动切换方法
- (void)switchPrevious {
    NSInteger index = self.cardSwitch.selectedIndex - 1;
    index = index < 0 ? 0 : index;
    [self.cardSwitch switchToIndex:index animated:true];
}

- (void)switchNext {
    NSInteger index = self.cardSwitch.selectedIndex + 1;
    index = index > self.models.count - 1 ? self.models.count - 1 : index;
    [self.cardSwitch switchToIndex:index animated:true];
}

@end
