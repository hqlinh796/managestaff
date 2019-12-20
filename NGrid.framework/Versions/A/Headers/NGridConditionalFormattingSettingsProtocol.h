/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridConditionalFormattingSettingsProtocol.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

/**
 * The NGridConditionalFormattingSettingsProtocol protocol generalizes the interfaces.
 */
@protocol NGridConditionalFormattingSettingsProtocol <NSObject, NSCoding, NSCopying>

/**
 * Returns unique ID of the settings.
 */
@property (readonly) NSInteger uid;

@end
