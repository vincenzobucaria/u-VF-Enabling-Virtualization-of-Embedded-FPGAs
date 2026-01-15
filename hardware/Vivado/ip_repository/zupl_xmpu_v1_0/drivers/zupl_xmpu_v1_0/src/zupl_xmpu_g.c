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
* @file zupl_xmpu_g.c
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
#include "zupl_xmpu_sinit.h"
#include "zupl_xmpu.h"

/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/
XmpuPl_Config XMpuPlInst_ConfigTable[] =
{
	{
		XMPU_PL_0_DEVICE_ID,
		XMPU_PL_0_BASEADDR,
		XMPU_PL_0_M_BASEADDR,
		XMPU_PL_0_M_HIGHADDR,
		XMPU_PL_0_REGIONS_MAX,
	},
	{
		XMPU_PL_1_DEVICE_ID,
		XMPU_PL_1_BASEADDR,
		XMPU_PL_1_M_BASEADDR,
		XMPU_PL_1_M_HIGHADDR,
		XMPU_PL_1_REGIONS_MAX,
	},
	{
		XMPU_PL_2_DEVICE_ID,
		XMPU_PL_2_BASEADDR,
		XMPU_PL_2_M_BASEADDR,
		XMPU_PL_2_M_HIGHADDR,
		XMPU_PL_2_REGIONS_MAX,
	},
	{
		XMPU_PL_3_DEVICE_ID,
		XMPU_PL_3_BASEADDR,
		XMPU_PL_3_M_BASEADDR,
		XMPU_PL_3_M_HIGHADDR,
		XMPU_PL_3_REGIONS_MAX,
	},
	{
		XMPU_PL_4_DEVICE_ID,
		XMPU_PL_4_BASEADDR,
		XMPU_PL_4_M_BASEADDR,
		XMPU_PL_4_M_HIGHADDR,
		XMPU_PL_4_REGIONS_MAX,
	},
	{
		XMPU_PL_5_DEVICE_ID,
		XMPU_PL_5_BASEADDR,
		XMPU_PL_5_M_BASEADDR,
		XMPU_PL_5_M_HIGHADDR,
		XMPU_PL_5_REGIONS_MAX,
	},
	{
		XMPU_PL_6_DEVICE_ID,
		XMPU_PL_6_BASEADDR,
		XMPU_PL_6_M_BASEADDR,
		XMPU_PL_6_M_HIGHADDR,
		XMPU_PL_6_REGIONS_MAX,
	},
	{
		XMPU_PL_7_DEVICE_ID,
		XMPU_PL_7_BASEADDR,
		XMPU_PL_7_M_BASEADDR,
		XMPU_PL_7_M_HIGHADDR,
		XMPU_PL_7_REGIONS_MAX,
	},
	{
		XMPU_PL_8_DEVICE_ID,
		XMPU_PL_8_BASEADDR,
		XMPU_PL_8_M_BASEADDR,
		XMPU_PL_8_M_HIGHADDR,
		XMPU_PL_8_REGIONS_MAX,
	},
	{
		XMPU_PL_9_DEVICE_ID,
		XMPU_PL_9_BASEADDR,
		XMPU_PL_9_M_BASEADDR,
		XMPU_PL_9_M_HIGHADDR,
		XMPU_PL_9_REGIONS_MAX,
	},
	{
		XMPU_PL_10_DEVICE_ID,
		XMPU_PL_10_BASEADDR,
		XMPU_PL_10_M_BASEADDR,
		XMPU_PL_10_M_HIGHADDR,
		XMPU_PL_10_REGIONS_MAX,
	},
	{
		XMPU_PL_11_DEVICE_ID,
		XMPU_PL_11_BASEADDR,
		XMPU_PL_11_M_BASEADDR,
		XMPU_PL_11_M_HIGHADDR,
		XMPU_PL_11_REGIONS_MAX,
	},
	{
		XMPU_PL_12_DEVICE_ID,
		XMPU_PL_12_BASEADDR,
		XMPU_PL_12_M_BASEADDR,
		XMPU_PL_12_M_HIGHADDR,
		XMPU_PL_12_REGIONS_MAX,
	},
	{
		XMPU_PL_13_DEVICE_ID,
		XMPU_PL_13_BASEADDR,
		XMPU_PL_13_M_BASEADDR,
		XMPU_PL_13_M_HIGHADDR,
		XMPU_PL_13_REGIONS_MAX,
	},
	{
		XMPU_PL_14_DEVICE_ID,
		XMPU_PL_14_BASEADDR,
		XMPU_PL_14_M_BASEADDR,
		XMPU_PL_14_M_HIGHADDR,
		XMPU_PL_14_REGIONS_MAX,
	},
	{
		XMPU_PL_15_DEVICE_ID,
		XMPU_PL_15_BASEADDR,
		XMPU_PL_15_M_BASEADDR,
		XMPU_PL_15_M_HIGHADDR,
		XMPU_PL_15_REGIONS_MAX,
	},
};
/** @} */
