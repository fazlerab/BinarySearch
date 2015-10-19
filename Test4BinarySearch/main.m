//
//  main.m
//  Test4BinarySearch
//
//  Created by Fazle Rab on 10/16/15.
//  Copyright © 2015 Fazle Rab. All rights reserved.
//

#import <Foundation/Foundation.h>

NSArray* readFile() {
    // Load files from user's Document's directory
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    
    NSString *fileName = @"Test4BinarySearch/assorted-breakfast.txt";
    NSString *file = [docPath stringByAppendingPathComponent:fileName];
    
    NSError *error;
    NSString *text = [NSString stringWithContentsOfFile:file encoding:NSUTF8StringEncoding error:&error];
    
    if (!error) {
        return [text componentsSeparatedByString:@"\n"];
    }
    else {
        NSLog(@"Error: %@", error.localizedDescription);
    }

    return nil;
}

NSUInteger binarySearch(NSArray *lines, NSString *searchString) {
    NSUInteger lower = 0;
    NSUInteger upper = lines.count;
    NSUInteger middle = -1;
    
    NSString *line;
    NSComparisonResult result;
    
    int step = 0;
    
    while(lower != (upper - 1)) {
        ++step;
        
        middle = lower + (upper - lower) / 2;
        
        line = lines[middle];
        result = [searchString compare:line];
        
        if (result == NSOrderedAscending) {  //The left operand is smaller than the right operand.
            upper = middle;
        }
        else if (result == NSOrderedDescending) { //The left operand is greater than the right operand.
            lower = middle + 1;
        }
        else if (result == NSOrderedSame) {
            break;
        }
    }
    
    NSLog(@"Step taken: %d", step);
    return middle;
}


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray *lines = readFile();
        NSLog(@"Text length=%lu", lines.count);
        
        NSString *searchStr = @"Whoa! Mr. Trout!\"";
        NSUInteger index = binarySearch(lines, searchStr);
        NSLog(@"The pharase'%@' found at line %lu.", searchStr, index);
    }
    
    return 0;
}
