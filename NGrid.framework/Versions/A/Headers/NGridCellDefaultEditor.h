/**
 * This file is a part of NGrid Framework
 * http://www.nchart3d.com
 *
 * File: NGridCellDefaultEditor.h
 * Version: 1.1.33
 *
 * Copyright (C) 2015 Nulana LTD. All Rights Reserved.
 */

#import "NGridCellEditorBase.h"
#import "NGridCell.h"

/**
 * The NGridCellDefaultEditor class is a simple editor class with text field.
 */
@interface NGridCellDefaultEditor : NGridCellEditorBase <UITextFieldDelegate>

/**
 * The text field used to edit value.
 */
@property (readonly) UITextField *textField;

/**
 * Adapts appearance of editor to cell style.
 * @param cell Cell related to the editor.
 */
- (void)adaptToCell:(NGridCell *)cell;

@end
