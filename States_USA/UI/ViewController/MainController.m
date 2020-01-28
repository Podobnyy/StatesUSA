//
//  MainController.m
//  States_USA
//
//  Created by Сергей Александрович on 22.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import "MainController.h"

@interface MainController ()

@property (weak, nonatomic) IBOutlet UIView *viewMenuRed;

@end

@implementation MainController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    _viewMenuRed.layer.cornerRadius = _viewMenuRed.frame.size.height/2;
}

@end
