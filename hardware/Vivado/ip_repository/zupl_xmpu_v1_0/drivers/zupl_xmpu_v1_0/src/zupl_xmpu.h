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
* @file zupl_xmpu.h
* @addtogroup zupl_xmpu_v1_0
* @{
* @details
*
* XMPU_PL is an AXI based memory and peripheral protection unit soft core for 
* the PL.
*
*
* <b>Initialization & Configuration</b>
*
* The device driver enables higher layer software (e.g., an application) to
* communicate to the XMPU_PL core.
*
* XMpuPl_CfgInitialize() API is used to initialize the XMPU_PL core.
* The user needs to first call the XMpuPl_LookupConfig() API which returns
* the Configuration structure pointer which is passed as a parameter to the
* XMpuPl_CfgInitialize() API.
*
*
* <b> Virtual Memory </b>
*
* This driver supports Virtual Memory. The RTOS is responsible for calculating
* the correct device base address in Virtual Memory space.
*
* <b> Threads </b>
*
* This driver is not thread safe. Any needs for threads or thread mutual
* exclusion must be satisfied by the layer above this driver.
*
* <b> Asserts </b>
*
* Asserts are used within all Xilinx drivers to enforce constraints on argument
* values. Asserts can be turned off on a system-wide basis by defining, at
* compile time, the NDEBUG identifier. By default, asserts are turned on and it
* is recommended that users leave asserts on during development.
*
* <b> Building the driver </b>
*
* The XMpuPl driver is composed of several source files. This allows the user
* to build and link only those parts of the driver that are necessary.
*
* This header file contains identifiers and register-level driver functions (or
* macros), range macros, structure typedefs that can be used to access the
* Xilinx XMPU_PL core instance.
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

#ifndef SRC_XUPL_XMPU_H_
#define SRC_XUPL_XMPU_H_


#ifdef __cplusplus
extern "C" {
#endif

/***************************** Include Files *********************************/
#include "xparameters.h"
#include "zupl_xmpu_hw.h"
#include "zupl_xmpu_sinit.h"
#include "xstatus.h"

/************************** Constant Definitions *****************************/

/**************************** Type Definitions *******************************/
typedef struct {
	u16 DeviceId;	  /**< Unique ID for device */
	u32 BaseAddress;  /**< Base address for device */
	u32 M_Axi_BaseAddress; /**< Base Address for Protected Master */
	u32 M_Axi_HighAddress; /**< Base Address for Protected Master */
	u32 MaxRegions;   /**< Maximum allowed Regions for device */
} XmpuPl_Config;

typedef struct {
	u64 Start;
	u64 End;
	u32 Masters;
	u32 Config;
} XmpuPl_Regions;

typedef struct {
	u32 CTRL;
	u32 POISON;
	u32 IMR;
	u32 LOCK;
	u32 BYPASS;
	u32 REGIONS;
	XmpuPl_Regions Region_Regs[16U];
} XmpuPl_Regs;

typedef struct {
	XmpuPl_Config Config;	/**< Configuration structure */
	XmpuPl_Regs Regs;
	u32 IsReady;		/**< Device is initialized and ready */
} XmpuPl;

/***************** Macros (Inline Functions) Definitions *********************/

/*
 * Internal helper macros
 */
#define InstReadReg(InstancePtr, RegOffset) \
    (Xil_In32(((InstancePtr)->Config.BaseAddress) + (u32)(RegOffset)))

#define InstWriteReg(InstancePtr, RegOffset, Data) \
    (Xil_Out32(((InstancePtr)->Config.BaseAddress) + (u32)(RegOffset), (u32)(Data)))

/*****************************************************************************/
/**
*
* This function enables the interrupts.
*
* @param	InstancePtr is a pointer to the XMpuPl instance.
* @param	InterruptMask defines which interrupt should be enabled.
*		Constants are defined in zupl_xmpu_hw.h as XMPU_PL_IXR_*.
*		This is a bit mask, all set bits will be enabled, cleared bits
*		will not be enabled.
*
* @return	None.
*
* @note
* C-style signature:
*	void XMpuPl_EnableInterrupts(XMpuPl *InstancePtr, u32 InterruptMask)
*
******************************************************************************/
#define XMpuPl_EnableInterrupts(InstancePtr, InterruptMask)		\
		InstWriteReg((InstancePtr), XMPU_PL_IER_OFFSET,		\
		(InstReadReg((InstancePtr), XMPU_PL_IER_OFFSET) |	\
		 (InterruptMask)))

/*****************************************************************************/
/**
*
* This function disables the interrupts.
*
* @param	InstancePtr is a pointer to the XMpuPl instance.
* @param	InterruptMask defines which interrupt should be disabled.
*		Constants are defined in zupl_xmpu_hw.h as XMPU_PL_IXR_*.
*		This is a bit mask, all set bits will be disabled, cleared bits
*		will not be disabled.
*
* @return	None.
*
* @note
* C-style signature:
*	void XMpuPl_DisableInterrupts(XMpuPl *InstancePtr, u32 InterruptMask)
*
******************************************************************************/
#define XMpuPl_DisableInterrupts(InstancePtr, InterruptMask) \
		InstWriteReg((InstancePtr), XMPU_PL_IDS_OFFSET,	\
		(~InstReadReg((InstancePtr), XMPU_PL_IMR_OFFSET) &	\
		 (InterruptMask)))

/*****************************************************************************/
/**
*
* This function reads the interrupt status.
*
* @param	InstancePtr is a pointer to the XMpuPl instance.
*
* @return	None.
*
* @note		C-style signature:
*		u32 XMpuPl_GetInterruptStatus(XMpuPl *InstancePtr)
*
******************************************************************************/
#define XMpuPl_GetInterruptStatus(InstancePtr)	 \
		InstReadReg((InstancePtr), XMPU_PL_ISR_OFFSET)

/*****************************************************************************/
/**
*
* This function clears the interrupt status.
*
* @param	InstancePtr is a pointer to the XMpuPl instance.
* @param	InterruptMask defines which interrupt should be cleared.
*		Constants are defined in zupl_xmpu_hw.h as XMPU_PL_IXR_*.
*		Only bits set in the InterruptMask will be cleared. Bits set in the ISR
*		remain set until cleared.
*
* @return	None.
*
* @note
* C-style signature:
*	void XMpuPl_ClearInterruptStatus(XMpuPl *InstancePtr, u32 InterruptMask)
*
******************************************************************************/
#define XMpuPl_ClearInterruptStatus(InstancePtr, InterruptMask) \
		InstWriteReg((InstancePtr), XMPU_PL_ISR_OFFSET, (InterruptMask))


/************************** Function Prototypes ******************************/
/*
 * Configuration Lookup function in zupl_xmpu_sinit.c
 */
XmpuPl_Config *XMpuPl_LookupConfig(u16 DeviceId);

/*
 * Initialization and driver functions in zupl_xmpu.c
 */
u32 XMpuPl_CfgInitialize(XmpuPl *InstancePtr, XmpuPl_Config *ConfigPtr,
                         u32 EffectiveAddr);
u32 XMpuPl_IsActive(XmpuPl *InstancePtr);
u32 XMpuPl_AddRegion(XmpuPl *InstancePtr, u64 start, u32 size, u32 masters, u32 config);
u32 XMpuPl_GetConfig(XmpuPl *InstancePtr);

/*
 * SelfTest function in zupl_xmpu_selftest.c
 */
u32 XMpuPL_SelfTest(XmpuPl *InstancePtr);

#ifdef __cplusplus
}
#endif

#endif /* SRC_XUPL_XMPU_H_ */
/** @} */
