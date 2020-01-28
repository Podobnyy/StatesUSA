//
//  FromImageToNameModel.h
//  States_USA
//
//  Created by Сергей Александрович on 19.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FromImageToNameModel : NSObject

@property (nonatomic, strong) NSString * number;
@property (nonatomic, strong) NSString * nameStates;
@property (nonatomic, strong) NSString * nameStatesRU;
@property (nonatomic, strong) NSString * imageStates;
@property (nonatomic, strong) NSString * FlagStates;
@property (nonatomic, strong) NSString * CapitalName;

+ (NSMutableArray *) FITNData;

@end
