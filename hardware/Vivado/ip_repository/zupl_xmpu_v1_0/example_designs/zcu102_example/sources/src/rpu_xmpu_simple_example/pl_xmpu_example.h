/*
 * pl_xmpu_example.h
 *
 */

#ifndef SRC_PL_XMPU_EXAMPLE_H_
#define SRC_PL_XMPU_EXAMPLE_H_

/***************************** Include Files *********************************/
#include "xparameters.h"
#include "zupl_xmpu.h"

/************************** Constant Definitions *****************************/
//PL Memory Base Address
#define PL_BRAM_S_BASE				XPAR_BRAM_0_BASEADDR
#define PL_BRAM_NS_SHARED_BASE		(XPAR_BRAM_0_BASEADDR + 0x400U)
#define PL_BRAM_NS_BASE				(XPAR_BRAM_0_BASEADDR + 0xC00U)

//PL Peripheral Start Addresses
#define PL_XMPU_S_START				XPAR_ZUPL_XMPU_0_S_AXI_XMPU_BASEADDR
#define PL_XMPU_S_LOCK				(PL_XMPU_S_START + XMPU_PL_LOCK_OFFSET)
#define PL_GPIO_NS_SHARED_START		XPAR_AXI_GPIO_0_BASEADDR

//PL XMPU Parameters
#define XMPU_PL_NUM_INST			XPAR_ZUPL_XMPU_NUM_INSTANCES
#define XMPU_PL_INTR_ID 			XPAR_FABRIC_ZUPL_XMPU_0_IRQ_INTR
#define XMPU_CTRL_VAL				( XMPU_PL_CTRL_DEFRD 		\
									| XMPU_PL_CTRL_DEFWR 		\
									| XMPU_PL_CTRL_PSNATTREN 	\
									| XMPU_PL_CTRL_PSNADDREN	\
									| XMPU_PL_CTRL_ARSP_DEC)
#define XMPU_INT_EN					(XMPU_PL_IXR_WRVIO_MSK \
									| XMPU_PL_IXR_RDVIO_MSK)
#define XMPU_LOCK_MASTERS			( XMPU_PL_MID_PMU | XMPU_PL_MID_RPU0 )

#define REGION_0_ADDR 				PL_BRAM_S_BASE
#define REGION_0_MASTERS			( XMPU_PL_MID_RPU0 )
#define REGION_0_CFG				( XMPU_PL_REGION_WR_ALLOW \
									| XMPU_PL_REGION_RD_ALLOW \
									| XMPU_PL_REGION_ENABLE )

#define REGION_1_ADDR 				PL_BRAM_NS_BASE
#define REGION_1_MASTERS			( XMPU_PL_MID_APU )
#define REGION_1_CFG				( XMPU_PL_REGION_WR_ALLOW \
									| XMPU_PL_REGION_RD_ALLOW \
									| XMPU_PL_REGION_ENABLE )

//System Parameters
#define DELAY_COUNT 				    200000

#endif /* SRC_PL_XMPU_EXAMPLE_H_ */
