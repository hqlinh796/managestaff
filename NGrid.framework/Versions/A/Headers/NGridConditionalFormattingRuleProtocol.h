/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridConditionalFormattingRuleProtocol.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * Conditional formatting rule options that are used to specify the type of conditional formatting.
 */
typedef NS_ENUM(NSInteger, NGridConditionalFormattingRuleItemType) {
    /**
     * No type.
     */
    NGridConditionalFormattingRuleItemTypeNone,
    
    /**
     * The option specifies that conditional formatting item is background color.
     */
    NGridConditionalFormattingRuleItemTypeColor,
    
    /**
     * The option specifies that conditional formatting item is font color.
     */
    NGridConditionalFormattingRuleItemTypeFontColor,
    
    /**
     * The option specifies that conditional formatting item is UIImage.
     */
    NGridConditionalFormattingRuleItemTypeIcon
};

/**
 * The NGridConditionalFormattingRuleProtocol protocol generalizes the interface.
 */
@protocol NGridConditionalFormattingRuleProtocol <NSObject>

/**
 * Type of the conditional formatting item.
 */
@property (assign) NGridConditionalFormattingRuleItemType itemType;

/**
 * Item that are used to format cells.
 */
@property (retain) NSObject *item;

/**
 * Returns a Boolean value that indicates whether a given value is present in the rule.
 * @param value Input value.
 */
- (BOOL)testValue:(id)value;

@end
