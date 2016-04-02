//
//  ViewController.m
//  Demo1_KeyFrameAnimation
//
//  Created by  江苏 on 16/3/6.
//  Copyright © 2016年 jiangsu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *iamgeView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //设置imageView的圆角
    self.iamgeView.layer.cornerRadius=2;
    //打开蒙版，让圆角显现
    self.iamgeView.layer.masksToBounds=YES;
}
-(void)createPath:(UIBezierPath*)path{
    [path moveToPoint:self.iamgeView.center];
    CGPoint targetPoint=CGPointMake(self.view.bounds.size.width-self.iamgeView.frame.size.width/2, self.view.bounds.size.height-self.iamgeView.frame.size.height/2);
    CGPoint controlPonit1=CGPointMake(self.view.bounds.size.width-self.iamgeView.frame.size.width/2, self.iamgeView.center.y);
    CGPoint controlPoint2=CGPointMake(self.iamgeView.center.x, self.view.bounds.size.height-self.iamgeView.frame.size.height/2);
    [path addCurveToPoint:targetPoint controlPoint1:controlPonit1 controlPoint2:controlPoint2];
}
- (IBAction)start:(id)sender {
    //创建动画对象，指定动画中改变的是CALayer的哪一个属性
    CAKeyframeAnimation* moveAnimation=[CAKeyframeAnimation animationWithKeyPath:@"position"];
    //修改动画对象的相关属性
    UIBezierPath* path=[UIBezierPath bezierPath];
    [self createPath:path];
    moveAnimation.path=path.CGPath;
    //moveAnimation.duration=3;
    //moveAnimation.removedOnCompletion=YES;//动画结束后删除动画对象
    moveAnimation.delegate=self;
    //将动画加入到需要执行的层对象上去
    //[self.iamgeView.layer addAnimation:moveAnimation forKey:nil];
    CABasicAnimation* scaleAnimation=[CABasicAnimation animationWithKeyPath:@"transform"];
    //scaleAnimation.duration=3;
    scaleAnimation.fromValue=[NSValue valueWithCATransform3D:CATransform3DIdentity];
    scaleAnimation.toValue=[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.1, 0.1, 1.0)];
    //scaleAnimation.removedOnCompletion=YES;
    //[self.iamgeView.layer addAnimation:scaleAnimation forKey:nil];
    //透明度从1.0变成0.0
    CABasicAnimation* opacityAnimation=[CABasicAnimation animationWithKeyPath:@"opacity"];
    //opacityAnimation.duration=3;
    //NSNumber *form=[NSNumber numberWithFloat:1.0];//@1.0相当于转换NSNumber
    opacityAnimation.fromValue=@1.0;
    opacityAnimation.toValue=@0.0;
    //opacityAnimation.removedOnCompletion=YES;
    //[self.iamgeView.layer addAnimation:opacityAnimation forKey:nil];
    //旋转动画
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue=[NSValue valueWithCATransform3D:self.iamgeView.layer.transform];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(self.iamgeView.layer.transform, 2*M_PI, 0, 0, 1.0)];
    //animation.duration=3.0;
    //animation.removedOnCompletion=YES;
    //[self.iamgeView.layer addAnimation:animation forKey:nil];
    //将四个动画合成一个动画
    CAAnimationGroup* group=[CAAnimationGroup animation];
    group.animations=@[moveAnimation,scaleAnimation,opacityAnimation,animation];
    group.duration=2.0;
    group.delegate=self;
    group.removedOnCompletion=YES;
    [self.iamgeView.layer addAnimation:group forKey:nil];
}
-(void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag{
    self.iamgeView.layer.transform=CATransform3DRotate(self.iamgeView.layer.transform, M_PI, 1.0, 1.0, 1.0);
}
- (IBAction)rotationX:(UIButton *)sender {
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue=[NSValue valueWithCATransform3D:self.iamgeView.layer.transform];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(self.iamgeView.layer.transform, M_PI, 1.0, 0, 0)];
    animation.duration=3.0;
    animation.removedOnCompletion=YES;
    [self.iamgeView.layer addAnimation:animation forKey:nil];
}
- (IBAction)rotationY:(UIButton *)sender {
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue=[NSValue valueWithCATransform3D:self.iamgeView.layer.transform];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(self.iamgeView.layer.transform, M_PI, 0, 1.0, 0)];
    animation.duration=3.0;
    animation.removedOnCompletion=YES;
    [self.iamgeView.layer addAnimation:animation forKey:nil];
}
- (IBAction)rotationZ:(UIButton *)sender {
    CABasicAnimation *animation=[CABasicAnimation animationWithKeyPath:@"transform"];
    animation.fromValue=[NSValue valueWithCATransform3D:self.iamgeView.layer.transform];
    animation.toValue=[NSValue valueWithCATransform3D:CATransform3DRotate(self.iamgeView.layer.transform, M_PI, 0, 0, 1.0)];
    animation.duration=3.0;
    animation.removedOnCompletion=YES;
    [self.iamgeView.layer addAnimation:animation forKey:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
