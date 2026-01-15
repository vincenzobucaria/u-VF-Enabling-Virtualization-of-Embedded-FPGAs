/******************************************************************************
*
* Copyright (C) 2008 - 2014 Xilinx, Inc.  All rights reserved.
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
* Use of the Software is limited solely to applications:
* (a) running on a Xilinx device, or
* (b) that interact with a Xilinx device through a bus or interconnect.
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

/********************* Added for PL XMPU Testing *********************/
#include "xparameters.h"
#include "zupl_xmpu.h"

//PL Memory Base Address
#define PL_BRAM_S_BASE					XPAR_BRAM_0_BASEADDR
#define PL_BRAM_NS_SHARED_BASE			(XPAR_BRAM_0_BASEADDR + 0x400U)
#define PL_BRAM_NS_BASE					(XPAR_BRAM_0_BASEADDR + 0xC00U)

//PL Peripheral Start Addresses
#define PL_XMPU_S_START					XPAR_ZUPL_XMPU_0_S_AXI_XMPU_BASEADDR
#define PL_XMPU_S_LOCK					(PL_XMPU_S_START + XMPU_PL_LOCK_OFFSET)
#define PL_GPIO_NS_SHARED_START			XPAR_AXI_GPIO_0_BASEADDR
/**********************************************************************/

// Memory Base Addresses
#define APU_OCM_NS_SHARED_BASE		0xFFFF0000
#define APU_DDR_LOW_NS_BASE			0x00000000
#define APU_DDR_LOW_NS_SHARED_BASE	0x60000000

#define RPU_OCM_S_BASE				0xFFFC0000
#define RPU_OCM_NS_SHARED_BASE		0xFFFF0000
#define RPU_DDR_LOW_S_BASE			0x40000000
#define RPU_DDR_LOW_NS_SHARED_BASE	0x60000000
#define RPU_ATCM_S_BASE             0xFFE00000

#define UNDEFINED_DDR_MEMORY_BASE	0x60100000


// Peripheral Start Addresses
#define APU_UART0_NS_START			0xFF000000
#define APU_SWDT0_NS_START			0xFF150000
#define APU_TTC0_NS_START			0xFF110000

#define SHARED_GPIO_NS_START        0xFF0A0000

#define RPU_UART1_S_START			0xFF010000
#define RPU_SWDT1_S_START			0xFD4D0000
#define RPU_TTC1_S_START			0xFF120000
#define RPU_I2C1_S_START			0xFF030000

// Control and Status Register Start Addresses
#define RPU_CRF_ABP_S_START			0xFD1A0000
#define RPU_CRL_ABP_S_START			0xFF5E0000
#define RPU_RPU_S_START				0xFF9A0000
#define RPU_EFUSE_S_START			0xFFCC0000

#define DELAY_COUNT 				200000


//POISONCFG (DDRC) Register
#define POISONCFG 0xFD07036C

