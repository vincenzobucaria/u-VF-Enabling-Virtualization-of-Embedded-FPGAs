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
* @file zupl_xmpu.c
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
#include "zupl_xmpu_sinit.h"
#include "xil_io.h"
#include "xil_assert.h"

/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/

/***************** Macros (Inline Functions) Definitions *********************/

/************************** Function Prototypes ******************************/

/************************** Variable Definitions *****************************/

/************************** Function Definitions *****************************/
/****************************************************************************/
/**
* Initializes the XMpuPl Instance Configuration
*
* @param	InstancePtr points to the XmpuPl Data Structure instance
*
* @param	ConfigPtr points to the XmpuPl_Config Data Structure in the
* 			XMpuPlInst_ConfigTable.
*
* @return	EffectiveAddr overrides the base address to accommodate virtual
* 			memory.
*
* @note		Status.
*
*****************************************************************************/
u32 XMpuPl_CfgInitialize(XmpuPl *InstancePtr, XmpuPl_Config *ConfigPtr,
	      	  	  u32 EffectiveAddr)
{
	u32 Status;

	/*
	 * Assert to validate input arguments.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);
	Xil_AssertNonvoid(ConfigPtr != NULL);

	/*
	 * Set some default values
	 */
	InstancePtr->Config.DeviceId = ConfigPtr->DeviceId;
	InstancePtr->Config.BaseAddress = EffectiveAddr;
	InstancePtr->Config.M_Axi_BaseAddress = ConfigPtr->M_Axi_BaseAddress;
	InstancePtr->Config.M_Axi_HighAddress = ConfigPtr->M_Axi_HighAddress;
	InstancePtr->Config.MaxRegions = ConfigPtr->MaxRegions;

	/*
	 * Indicate that the device has been configured.
	 */
	InstancePtr->IsReady = 0x11111111U;

	Status = XMpuPl_IsActive(InstancePtr);

	return Status;
}

/****************************************************************************/
/**
* Checks that the device has been configured.
*
* @param	InstancePtr points to the XmpuPl Data Structure instance
*
* @return	Status. 0U: Device is Active. 1U: Device has not been configured.
*
* @note
*
*****************************************************************************/
u32 XMpuPl_IsActive(XmpuPl *InstancePtr)
{
	u32 Status;

	/*
	 * Assert to validate input arguments.
	 */
	Xil_AssertNonvoid(InstancePtr != NULL);

	if (InstancePtr->IsReady == 0x11111111U) {
		Status = 0U;
	} else {
		Status = 1U;
	}
	return Status;
}

/****************************************************************************/
/**
* Configures a protected address region into the next available
*
* @param	InstancePtr points to the XmpuPl Data Structure instance
*
* @param	ConfigPtr points to the XmpuPl_Config Data Structure in the
* 			XMpuPlInst_ConfigTable.
*
* @param	EffectiveAddr overrides the base address to accommodate virtual
* 			memory.
*
* @return	Status.
*
* @note
*
*****************************************************************************/
u32 XMpuPl_AddRegion(XmpuPl *InstancePtr, u64 start, u32 size,
					 u32 masters, u32 config)
{
	u32 Status;
	u8 regions_max = (u8)(InstancePtr->Config.MaxRegions);
	u32 next_region = regions_max;
	u32 regions = InstReadReg(InstancePtr, XMPU_PL_REGIONS_OFFSET);;
	u32 start_addr = (u32)(start >> 8U);
	u32 end_addr = (start_addr + (size * 4U)-1U);
	u32 config_reg = (config | XMPU_PL_REGION_ENABLE);

	/* Search for next available region */
	for (u8 index = 0U; index < regions_max; index++) {
		if ((InstReadReg(InstancePtr, (index*0x10U + XMPU_PL_R00_CONFIG_OFFSET))
			& XMPU_PL_REGION_ENABLE) == 0U) {
			next_region = index;
			break;
		}
	}

	/* Assign available region */
	if ((next_region < regions_max) && (size <= 0x40000U) && (end_addr > start_addr)) {
		InstWriteReg(InstancePtr, (next_region*0x10U + \
					 XMPU_PL_R00_START_OFFSET), start_addr);
		InstWriteReg(InstancePtr, (next_region*0x10U + \
					 XMPU_PL_R00_END_OFFSET), end_addr);
		InstWriteReg(InstancePtr, (next_region*0x10U + \
					 XMPU_PL_R00_MASTERS_OFFSET), masters);
		InstWriteReg(InstancePtr, (next_region*0x10U + \
					 XMPU_PL_R00_CONFIG_OFFSET), config_reg);
		regions = InstReadReg(InstancePtr, XMPU_PL_REGIONS_OFFSET);
		if (regions > next_region) {
			Status = 0U;
		} else {
			Status = 1U;
		}
	} else {
		Status = 1U;
	}
	return Status;
}


/****************************************************************************/
/**
* Loads all region configuration data into instance
*
* @param	InstancePtr points to the XmpuPl Data Structure instance
*
* @return	Status.
*
* @note
*
*****************************************************************************/
u32 XMpuPl_GetConfig(XmpuPl *InstancePtr)
{
	if (InstancePtr==NULL) return 1U;
	u64 Address = {0U};

	InstancePtr->Regs.CTRL = InstReadReg(InstancePtr,  XMPU_PL_CTRL_OFFSET);
	InstancePtr->Regs.POISON = InstReadReg(InstancePtr, XMPU_PL_POISON_OFFSET);
	InstancePtr->Regs.IMR = InstReadReg(InstancePtr, XMPU_PL_IMR_OFFSET);
	InstancePtr->Regs.BYPASS = InstReadReg(InstancePtr, XMPU_PL_BYPASS_OFFSET);
	InstancePtr->Regs.REGIONS = InstReadReg(InstancePtr, XMPU_PL_REGIONS_OFFSET);
	for (int i=0; i<16; i++) {
		Address = (u64)(InstReadReg(InstancePtr, (i*0x10U + XMPU_PL_R00_START_OFFSET)));
		Address = (Address << 8U);
		InstancePtr->Regs.Region_Regs[i].Start = Address;
		Address = ((u64)(InstReadReg(InstancePtr, (i*0x10U + XMPU_PL_R00_END_OFFSET))) << 8U);
		if (Address != 0U) {
			Address |= 0xFFU;
		}
		InstancePtr->Regs.Region_Regs[i].End = Address;
		InstancePtr->Regs.Region_Regs[i].Masters =
				InstReadReg(InstancePtr, (i*0x10U + XMPU_PL_R00_MASTERS_OFFSET));
		InstancePtr->Regs.Region_Regs[i].Config =
				InstReadReg(InstancePtr, (i*0x10U + XMPU_PL_R00_CONFIG_OFFSET));
	}
	return 0U;
}

/** @} */
