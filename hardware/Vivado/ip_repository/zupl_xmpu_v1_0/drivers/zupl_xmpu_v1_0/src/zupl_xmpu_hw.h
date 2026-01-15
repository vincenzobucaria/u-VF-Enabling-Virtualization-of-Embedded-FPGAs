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
* @file xmpu_pl_hw.h
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

#ifndef SRC_ZUPL_XMPU_HW_H_
#define SRC_ZUPL_XMPU_HW_H_

#ifdef __cplusplus
extern "C" {
#endif

/************************** Constant Definitions *****************************/
/* REGISTER OFFSETS */
#define XMPU_PL_CTRL_OFFSET				  0x0U
#define XMPU_PL_ERRS1_OFFSET			  0x4U
#define XMPU_PL_ERRS2_OFFSET			  0x8U
#define XMPU_PL_POISON_OFFSET			  0xCU
#define XMPU_PL_ISR_OFFSET				 0x10U
#define XMPU_PL_IMR_OFFSET				 0x14U
#define XMPU_PL_IER_OFFSET				 0x18U
#define XMPU_PL_IDS_OFFSET				 0x1CU
#define XMPU_PL_LOCK_OFFSET				 0x20U
#define XMPU_PL_BYPASS_OFFSET			 0x24U
#define XMPU_PL_REGIONS_OFFSET			 0x28U
#define XMPU_PL_R00_START_OFFSET		0x100U
#define XMPU_PL_R00_END_OFFSET			0x104U
#define XMPU_PL_R00_MASTERS_OFFSET		0x108U
#define XMPU_PL_R00_CONFIG_OFFSET		0x10CU
#define XMPU_PL_R01_START_OFFSET		0x110U
#define XMPU_PL_R01_END_OFFSET			0x114U
#define XMPU_PL_R01_MASTERS_OFFSET		0x118U
#define XMPU_PL_R01_CONFIG_OFFSET		0x11CU
#define XMPU_PL_R02_START_OFFSET		0x120U
#define XMPU_PL_R02_END_OFFSET			0x124U
#define XMPU_PL_R02_MASTERS_OFFSET		0x128U
#define XMPU_PL_R02_CONFIG_OFFSET		0x12CU
#define XMPU_PL_R03_START_OFFSET		0x130U
#define XMPU_PL_R03_END_OFFSET			0x134U
#define XMPU_PL_R03_MASTERS_OFFSET		0x138U
#define XMPU_PL_R03_CONFIG_OFFSET		0x13CU
#define XMPU_PL_R04_START_OFFSET		0x140U
#define XMPU_PL_R04_END_OFFSET			0x144U
#define XMPU_PL_R04_MASTERS_OFFSET		0x148U
#define XMPU_PL_R04_CONFIG_OFFSET		0x14CU
#define XMPU_PL_R05_START_OFFSET		0x150U
#define XMPU_PL_R05_END_OFFSET			0x154U
#define XMPU_PL_R05_MASTERS_OFFSET		0x158U
#define XMPU_PL_R05_CONFIG_OFFSET		0x15CU
#define XMPU_PL_R06_START_OFFSET		0x160U
#define XMPU_PL_R06_END_OFFSET			0x164U
#define XMPU_PL_R06_MASTERS_OFFSET		0x168U
#define XMPU_PL_R06_CONFIG_OFFSET		0x16CU
#define XMPU_PL_R07_START_OFFSET		0x170U
#define XMPU_PL_R07_END_OFFSET			0x174U
#define XMPU_PL_R07_MASTERS_OFFSET		0x178U
#define XMPU_PL_R07_CONFIG_OFFSET		0x17CU
#define XMPU_PL_R08_START_OFFSET		0x180U
#define XMPU_PL_R08_END_OFFSET			0x184U
#define XMPU_PL_R08_MASTERS_OFFSET		0x188U
#define XMPU_PL_R08_CONFIG_OFFSET		0x18CU
#define XMPU_PL_R09_START_OFFSET		0x190U
#define XMPU_PL_R09_END_OFFSET			0x194U
#define XMPU_PL_R09_MASTERS_OFFSET		0x198U
#define XMPU_PL_R09_CONFIG_OFFSET		0x19CU
#define XMPU_PL_R10_START_OFFSET		0x1A0U
#define XMPU_PL_R10_END_OFFSET			0x1A4U
#define XMPU_PL_R10_MASTERS_OFFSET		0x1A8U
#define XMPU_PL_R10_CONFIG_OFFSET		0x1ACU
#define XMPU_PL_R11_START_OFFSET		0x1B0U
#define XMPU_PL_R11_END_OFFSET			0x1B4U
#define XMPU_PL_R11_MASTERS_OFFSET		0x1B8U
#define XMPU_PL_R11_CONFIG_OFFSET		0x1BCU
#define XMPU_PL_R12_START_OFFSET		0x1C0U
#define XMPU_PL_R12_END_OFFSET			0x1C4U
#define XMPU_PL_R12_MASTERS_OFFSET		0x1C8U
#define XMPU_PL_R12_CONFIG_OFFSET		0x1CCU
#define XMPU_PL_R13_START_OFFSET		0x1D0U
#define XMPU_PL_R13_END_OFFSET			0x1D4U
#define XMPU_PL_R13_MASTERS_OFFSET		0x1D8U
#define XMPU_PL_R13_CONFIG_OFFSET		0x1DCU
#define XMPU_PL_R14_START_OFFSET		0x1E0U
#define XMPU_PL_R14_END_OFFSET			0x1E4U
#define XMPU_PL_R14_MASTERS_OFFSET		0x1E8U
#define XMPU_PL_R14_CONFIG_OFFSET		0x1ECU
#define XMPU_PL_R15_START_OFFSET		0x1F0U
#define XMPU_PL_R15_END_OFFSET			0x1F4U
#define XMPU_PL_R15_MASTERS_OFFSET		0x1F8U
#define XMPU_PL_R15_CONFIG_OFFSET		0x1FCU

/* CONTROL REGISTER */
#define XMPU_PL_CTRL_DEFRD			0x00000001U
#define XMPU_PL_CTRL_DEFWR			0x00000002U
#define XMPU_PL_CTRL_PSNADDREN		0x00000004U
#define XMPU_PL_CTRL_PSNATTREN		0x00000008U
#define XMPU_PL_CTRL_EXTSINKEN		0x00000010U
#define XMPU_PL_CTRL_ARSP_OKA		0x00000000U
#define XMPU_PL_CTRL_ARSP_EXO		0x00000020U
#define XMPU_PL_CTRL_ARSP_SLV		0x00000040U
#define XMPU_PL_CTRL_ARSP_DEC		0x00000060U

#define XMPU_PL_CTRL_DEFRD_MSK		0x00000001U
#define XMPU_PL_CTRL_DEFWR_MSK		0x00000002U
#define XMPU_PL_CTRL_PSNADDREN_MSK	0x00000004U
#define XMPU_PL_CTRL_PSNATTREN_MSK	0x00000008U
#define XMPU_PL_CTRL_EXTSINKEN_MSK	0x00000010U
#define XMPU_PL_CTRL_ARSP_MSK		0x00000060U
#define XMPU_PL_CTRL_ADDRHIGH_MSK   0x00FF0000U
/* MASTERS */
#define XMPU_PL_MID_FPD_DMA_6_7  	(1U << 30U)
#define XMPU_PL_MID_FPD_DMA_4_5  	(1U << 29U)
#define XMPU_PL_MID_FPD_DMA_2_3  	(1U << 28U)
#define XMPU_PL_MID_FPD_DMA_0_1		(1U << 27U)
#define XMPU_PL_MID_DP_DMA_4_5  	(1U << 26U)
#define XMPU_PL_MID_DP_DMA_2_3  	(1U << 25U)
#define XMPU_PL_MID_DP_DMA_0_1		(1U << 24U)
#define XMPU_PL_MID_PCIE     		(1U << 23U)
#define XMPU_PL_MID_DAP_AXI  		(1U << 22U)
#define XMPU_PL_MID_GPU      		(1U << 21U)
#define XMPU_PL_MID_SATA1    		(1U << 20U)
#define XMPU_PL_MID_SATA0    		(1U << 19U)
#define XMPU_PL_MID_APU      		(1U << 18U)
#define XMPU_PL_MID_GEM3     		(1U << 17U)
#define XMPU_PL_MID_GEM2     		(1U << 16U)
#define XMPU_PL_MID_GEM1     		(1U << 15U)
#define XMPU_PL_MID_GEM0     		(1U << 14U)
#define XMPU_PL_MID_QSPI     		(1U << 13U)
#define XMPU_PL_MID_NAND     		(1U << 12U)
#define XMPU_PL_MID_SD1      		(1U << 11U)
#define XMPU_PL_MID_SD0      		(1U << 10U)
#define XMPU_PL_MID_LPD_DMA_6_7  	(1U <<  9U)
#define XMPU_PL_MID_LPD_DMA_4_5  	(1U <<  8U)
#define XMPU_PL_MID_LPD_DMA_2_3  	(1U <<  7U)
#define XMPU_PL_MID_LPD_DMA_0_1		(1U <<  6U)
#define XMPU_PL_MID_DAP_APB  		(1U <<  5U)
#define XMPU_PL_MID_USB1     		(1U <<  4U)
#define XMPU_PL_MID_USB0     		(1U <<  3U)
#define XMPU_PL_MID_PMU      		(1U <<  2U)
#define XMPU_PL_MID_RPU1     		(1U <<  1U)
#define XMPU_PL_MID_RPU0     		(1U <<  0U)

/* REGION CONFIGURATION */
#define XMPU_PL_REGION_ENABLE		0x00000001U
#define XMPU_PL_REGION_RD_ALLOW		0x00000002U
#define XMPU_PL_REGION_WR_ALLOW		0x00000004U
#define XMPU_PL_REGION_REGIONNS     0x00000008U
#define XMPU_PL_REGION_NSCHECK      0x00000010U
#define XMPU_PL_REGION_MIDDISABLE   0x00000020U    

/* INTERRUPTS */
#define XMPU_PL_IXR_RDVIO_MSK		0x00000002U /* RdPermVIO Interrupt */
#define XMPU_PL_IXR_WRVIO_MSK		0x00000004U /* WrPermVIO Interrupt */
#define XMPU_PL_IXR_SECVIO_MSK		0x00000008U /* SecurityVIO Interrupt */


#ifdef __cplusplus
}
#endif

#endif /* SRC_ZUPL_XMPU_HW_H_ */
/** @} */
