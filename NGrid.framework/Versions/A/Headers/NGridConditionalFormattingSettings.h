/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridConditionalFormattingSettings.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import "NGridConditionalFormattingArea.h"
#import "NGridConditionalFormattingType.h"
#import "NGridConditionalFormattingSettingsProtocol.h"

/**
 * The NGridConditionalFormattingSettings class describes conditional formatting settings.
 */
@interface NGridConditionalFormattingSettings : NSObject <NGridConditionalFormattingSettingsProtocol>

/**
 * Tag of the settings that you can use at your discretion.
 */
@property (assign) NSInteger tag;

/**
 * Area of the conditional formatting.
 */
@property (assign) NGridConditionalFormattingArea area;

/**
 * Type of the conditional formatting.
 */
@property (assign) NGridConditionalFormattingType type;

/**
 * The key of row which is used for conditional formatting instead of the cell row.
 */
@property (assign) NSInteger sourceRowKey;

/**
 * The key of column which is used for conditional formatting instead of the cell column.
 */
@property (assign) NSInteger sourceColumnKey;

/**
 * Items of the conditional formatting settings.
 *
 * <NGridProxyDataSourceImpl> supports conditional formatting with UIImage and UIColor items,
 * but you can override applyConditionalFormattingScaleObject:toCell: and use other item types.
 */
@property (retain) NSArray *items;

/**
 * A Boolean value that determines whether the user defined rules should be used to conditional formatting.
 */
@property (assign) BOOL useUserDefinedRules;

/**
 * User defined rules that are used to conditional formatting.
 */
@property (retain) NSArray *userDefinedRules;

@end
