/******************************************************************************
*
* Copyright (C) 2014-2020 Xilinx, Inc.  All rights reserved.
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL
* XILINX  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
* WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF
* OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
* SOFTWARE.
*
* Except as contained in this notice, the name of the Xilinx shall not be used
* in advertising or otherwise to promote the sale, use or other dealings in
* this Software without prior written authorization from Xilinx.
*
******************************************************************************/
/*****************************************************************************/
/**
*
* @file zupl_xmpu_sinit.c
* @addtogroup zupl_xmpu_v1_0
* @{
* @details
*
* XMPU_PL is an AXI based memory and peripheral protection unit soft core for
* the PL.
*
* <pre>
* MODIFICATION HISTORY:
*
* Ver   Who     Date     Changes
* ----- ------  -------- ------------------------------------------------------
* 1.0   chc     x/xx/20  First release
* </pre>
*
******************************************************************************/


/***************************** Include Files *********************************/
#include "zupl_xmpu.h"
#include "xparameters.h"

/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/
extern XmpuPl_Config XMpuPlInst_ConfigTable[XMPU_PL_NUM_MAX];

/*****************************************************************************/
/**
*
* Looks up the device configuration based on the unique device ID. A table
* contains the configuration info for each device in the system.
*
* @param	DeviceId contains the unique ID of the device
*
* @return
*
* A pointer to the configuration found or NULL if the specified device ID was
* not found. See zupl_xmpu.h for the definition of XmpuPl_Config.
*
* @note		None.
*
******************************************************************************/
XmpuPl_Config *XMpuPl_LookupConfig(u16 DeviceId)
{
	XmpuPl_Config *CfgPtr = NULL;
	u32 Index;
	const u32 Limit = (XPAR_ZUPL_XMPU_NUM_INSTANCES < XMPU_PL_NUM_MAX)? \
			XPAR_ZUPL_XMPU_NUM_INSTANCES : XMPU_PL_NUM_MAX;
	for (Index = 0U; Index < Limit; Index++) {
		if (XMpuPlInst_ConfigTable[Index].DeviceId == DeviceId) {
			CfgPtr = &XMpuPlInst_ConfigTable[Index];
			break;
		}
	}

	return (XmpuPl_Config *)CfgPtr;
}
/** @} */
