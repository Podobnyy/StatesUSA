//
//  FromImageToNameModel.m
//  States_USA
//
//  Created by Сергей Александрович on 19.11.2017.
//  Copyright © 2017 Sergey Podobnyy. All rights reserved.
//

#import "FromImageToNameModel.h"

@implementation FromImageToNameModel

+(NSMutableArray *)FITNData{
    NSMutableArray *result = [NSMutableArray new];
    NSString * path = [[NSBundle mainBundle] pathForResource:@"BaseStates" ofType:@"plist"]; // достаем плист
    NSArray *rawData = [NSArray arrayWithContentsOfFile:path]; // масив из плиста
    
    for (NSDictionary * obj in rawData) {
        FromImageToNameModel *model = [FromImageToNameModel new];
        
        model.number = obj[@"number"];
        model.nameStates = obj[@"nameStates"];
        model.nameStatesRU = obj[@"nameStatesRU"];
        model.imageStates = obj[@"imageStates"];
        model.FlagStates = obj[@"FlagStates"];
        model.CapitalName = obj[@"CapitalName"];
        
        [result addObject:model];
    }
    
    return result;
}

@end
