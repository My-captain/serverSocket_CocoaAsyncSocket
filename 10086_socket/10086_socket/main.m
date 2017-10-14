//
//  main.m
//  10086_socket
//
//  Created by Mr.Robot on 2017/10/14.
//  Copyright © 2017年 Mr.Robot. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MRServiceListener.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MRServiceListener *serviceListener = [[MRServiceListener alloc] init];
        
        [serviceListener start];
        
        [[NSRunLoop mainRunLoop] run];
    }
    return 0;
}
