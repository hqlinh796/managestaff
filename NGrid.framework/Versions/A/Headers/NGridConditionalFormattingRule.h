/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridConditionalFormattingRule.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import "NGridConditionalFormattingRuleProtocol.h"

/**
 * Options to specify rule type.
 */
typedef NS_ENUM(NSInteger, NGridConditionalFormattingRuleType) {
    /**
     * Rule settings have no type and are not used.
     */
    NGridConditionalFormattingRuleTypeNone,
    
    /**
     *  Format the cells with the values equal to the value of rule settings.
     */
    NGridConditionalFormattingRuleTypeEqual,
    
    /**
     * Format the cells with the values not equal to the value of rule settings.
     */
    NGridConditionalFormattingRuleTypeNotEqual,
    
    /**
     * Format the cells with the values greater than the value of rule settings.
     */
    NGridConditionalFormattingRuleTypeGreater,
    
    /**
     * Format the cells with the values less than the value of rule settings.
     */
    NGridConditionalFormattingRuleTypeLess,
    
    /**
     * Format the cells with the values greater or equal to the value of rule settings.
     */
    NGridConditionalFormattingRuleTypeGreaterOrEqual,
    
    /**
     * Format the cells with the values less or equal to the value of rule settings.
     */
    NGridConditionalFormattingRuleTypeLessOrEqual,
    
    /**
     * Format the cells with the values in the interval between first and second rule settings values.
     */
    NGridConditionalFormattingRuleTypeBetween,
    
    /**
     * Format the cells with the values less than the first rule value and greater than the second one.
     */
    NGridConditionalFormattingRuleTypeLessOrGreater,
        
    /**
     * Format the cells with the values containing the rule settings value.
     */
    NGridConditionalFormattingRuleTypeContain,
    
    /**
     * Format cells with the suffix equal to the rule settings value.
     */
    NGridConditionalFormattingRuleTypeSuffix,
    
    /**
     * Format cells with the prefix equal to the rule settings value.
     */
    NGridConditionalFormattingRuleTypePrefix,
    /**
     * Format the cells without the values containing the rule settings value.
     */
    NGridConditionalFormattingRuleTypeNotContain,
    
    /**
     * Format cells without the suffix equal to the rule settings value.
     */
    NGridConditionalFormattingRuleTypeNotSuffix,
    
    /**
     * Format cells without the prefix equal to the rule settings value.
     */
    NGridConditionalFormattingRuleTypeNotPrefix,
};

/**
 * The NGridConditionalFormattingRule class describes conditional formatting rule settings.
 */
@interface NGridConditionalFormattingRule : NSObject <NGridConditionalFormattingRuleProtocol>

/**
 * Type of the rule.
 */
@property (assign) NGridConditionalFormattingRuleType ruleType;

/**
 * First value.
 */
@property (retain) NSObject *valueA;

/**
 * Second value.
 */
@property (retain) NSObject *valueB;

/**
 * A Boolean value that determines whether the case insensitive compare function should be used to compare strings.
 */
@property (assign) BOOL caseInsensitive;


@end
