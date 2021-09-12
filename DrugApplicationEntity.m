/*
 *  DrugApplicationEntity.m
 *  psyTrack Clinician Tools
 *  Version: 1.5.4
 *
 *
 The MIT License (MIT)
 Copyright © 2011- 2021 Daniel Boice
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the “Software”), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 *
 *  Created by Daniel Boice on  12/31/11.
 *  Copyright (c) 2011 PsycheWeb LLC. All rights reserved.
 *
 *
 *	This notice may not be removed from this file.
 *
 */

#import "DrugApplicationEntity.h"
#import "DrugChemicalTypeLookupEntity.h"
#import "DrugEntity.h"
#import "DrugProductEntity.h"
#import "DrugRegActionDateEntity.h"
#import "DrugReviewClassLookupEntity.h"

@implementation DrugApplicationEntity

@dynamic sponsorApplicant;
@dynamic applType;
@dynamic currentPatentFlag;
@dynamic actionType;
@dynamic orphan_Code;
@dynamic applNo;
@dynamic mostRecentLabelAvailableFlag;
@dynamic ther_Potential;
@dynamic chemical_Type;
@dynamic reviewClass;
@dynamic reglatoryActions;
@dynamic drugGroup;
@dynamic products;
@dynamic chemType;

@end
