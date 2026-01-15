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
* @file zupl_xmpu_selftest.c
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
/***************************** Include Files *******************************/
#include "zupl_xmpu.h"
#include "xparameters.h"
#include "stdio.h"
#include "xil_io.h"
#include "xstatus.h"

/************************** Constant Definitions ***************************/

/************************** Function Definitions ***************************/
/**
 *
 * Run a self-test on the driver/device. Note this may be a destructive test if
 * resets of the device are performed.
 *
 * If the hardware system is not built correctly, this function may never
 * return to the caller.
 *
 * @param   baseaddr_p is the base address of the ZUP_XMPU_PL instance to be
 * 			worked on.
 *
 * @return
 *
 *    - OU   if all self-test code passed
 *    - 1U   if any self-test code failed
 *
 *
 */
u32 XMpuPL_SelfTest(XmpuPl *InstancePtr)
{
	u32 Status;
	u32 Data_Init;
	u32 Data;

	Xil_AssertNonvoid(InstancePtr != NULL);

	/*
	 * Store current value of register
	 */
	Data_Init = InstReadReg(InstancePtr, XMPU_PL_POISON_OFFSET);

	/*
	 * Write new value to register
	 */
	InstWriteReg(InstancePtr, XMPU_PL_POISON_OFFSET, 0xDEADBEEFU);

	/*
	 * Verify new register value
	 */
	Data = InstReadReg(InstancePtr, XMPU_PL_POISON_OFFSET);

	if ( Data != 0xDEADBEEFU )
	{
		Status = 1U;

	} else {

		/*
		 * Restore initial register value
		 */
		InstWriteReg(InstancePtr, XMPU_PL_POISON_OFFSET, Data_Init);
		Status = 0U;
	}

	/*
	 * Register test completed
	 */
	return Status;
}
/** @} */

