/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridScale.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

#import "NGridConditionalFormattingRuleProtocol.h"

/**
 * The NGridScale protocol defines the interface used for mapping input values in ranges to constant values of any type.
 */
@protocol NGridScale <NSObject>

/**
 * Returns mapped object
 * @param value Input value.
 */
- (id<NGridConditionalFormattingRuleProtocol>)value:(NSObject *)value;

@end
