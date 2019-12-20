/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridConditionalFormattingType.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

/**
 * Conditional formatting options that are used to specify the type of conditional formatting.
 */
typedef NS_ENUM(NSInteger, NGridConditionalFormattingType) {
    /**
     * No type.
     */
    NGridConditionalFormattingTypeNone,
    
    /**
     * The option specifies that conditional formatting uses colors.
     */
    NGridConditionalFormattingTypeSpecificColors,
    
    /**
     * The option specifies that conditional formatting uses font colors.
     */
    NGridConditionalFormattingTypeSpecificFontColors,
    
    /**
     * The option specifies that conditional formatting uses icons.
     */
    NGridConditionalFormattingTypeSpecificIcons
};
