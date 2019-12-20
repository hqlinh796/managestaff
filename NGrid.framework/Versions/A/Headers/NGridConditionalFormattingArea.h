/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridConditionalFormattingArea.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

/**
 * Conditional formatting options options that are used to specify the area with conditional formatting.
 */
typedef NS_ENUM(NSInteger, NGridConditionalFormattingArea) {
    /**
     * No conditional formatting.
     */
    NGridConditionalFormattingAreaNone,
    
	/**
	* Use values of the entire table.
	*/
    NGridConditionalFormattingAreaEntireTable,

	/**
	* Use values by columns.
	*/
    NGridConditionalFormattingAreaColumns,

	/**
	* Use values by rows.
	*/
    NGridConditionalFormattingAreaRows
};
