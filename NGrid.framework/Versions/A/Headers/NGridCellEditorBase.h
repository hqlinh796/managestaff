/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellEditorBase.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import <UIKit/UIKit.h>

#import "NGridCellStyle.h"

/**
 * The NGridCellEditorBase class defines interface for cell editors.
 * You must inherit your editor from this class.
 */
@interface NGridCellEditorBase : UIView

/**
 * The value used by the editor.
 */
@property (nonatomic, retain) NSObject *value;

@end
