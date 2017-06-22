//
//  ViewController.m
//  SceneKit-09
//
//  Created by ShiWen on 2017/6/22.
//  Copyright © 2017年 ShiWen. All rights reserved.
//

#import "ViewController.h"

#import <SceneKit/SceneKit.h>

@interface ViewController ()

@property (nonatomic,strong) SCNView *mScnView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.view addSubview:self.mScnView];
    self.mScnView.scene = [SCNScene scene];
    
    
    [self addBox];

}
-(void)addBox{
    SCNCamera *camera = [SCNCamera camera];
    SCNNode *cameraNode = [ SCNNode node];
    cameraNode.camera = camera;
    cameraNode.position = SCNVector3Make(0, 0, 30);
    [self.mScnView.scene.rootNode addChildNode:cameraNode];
    
    SCNBox *box = [SCNBox boxWithWidth:8 height:8 length:8 chamferRadius:0];
    box.firstMaterial.diffuse.contents = [UIImage imageNamed:@"box2.jpg"];
    SCNNode *boxNode = [SCNNode nodeWithGeometry:box];
    boxNode.position = SCNVector3Make(0, 10, -80);
    [self.mScnView.scene.rootNode addChildNode:boxNode];
    
    
    //创建粒子系统
    SCNParticleSystem *particleSystem = [SCNParticleSystem particleSystemNamed:@"fire.scnp" inDirectory:nil];
    //创建节点 添加粒子系统
    SCNNode *particleSystemNode = [SCNNode node];
    [particleSystemNode addParticleSystem:particleSystem];
    particleSystemNode.position = SCNVector3Make(0, -1, 0);
    //将粒子节点添加至盒子
    [boxNode addChildNode:particleSystemNode];
    
    SCNAction *action = [SCNAction repeatActionForever:[SCNAction moveBy:SCNVector3Make(0, 0, 10) duration:1]];
    [boxNode runAction:action];
    
    cameraNode.constraints = @[[SCNLookAtConstraint lookAtConstraintWithTarget:boxNode]];
}
-(SCNView *)mScnView{
    if (!_mScnView) {
        _mScnView = [[SCNView alloc] initWithFrame:self.view.bounds];
        _mScnView.backgroundColor = [UIColor blackColor];
        _mScnView.allowsCameraControl = YES;
    }
    return _mScnView;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
