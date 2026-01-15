/*
 * xpfw_pl_xmpu.c
 *
 */


/***************************** Include Files *********************************/
#include "xpfw_pl_xmpu.h"
#include "xpfw_debug.h"
#include "xilfpga.h"

/************************** Function Prototypes ******************************/
static u32 configureXMPU(XmpuPl *InstancePtr);


/************************** Variable Definitions *****************************/
static u8 XMpuPl_Initialized = {0U};
static XmpuPl XmpuInst;

struct XpuMasterID {
	u32 MasterID;
	u32 MasterIDLimit;
	char MasterName[11];
};

/* XPU master ID LUT to identify master which caused the violation */
static struct XpuMasterID XpuMasterIDLUT[] =
{
		{ 0x00U,  0x0FU,  "RPU0" },
		{ 0x10U,  0x1FU,  "RPU1" },
		{ 0x40U,  0x40U,  "PMU MB" },
		{ 0x50U,  0x50U,  "CSU MB" },
		{ 0x51U,  0x51U,  "CSU DMA" },
		{ 0x60U,  0x60U,  "USB0" },
		{ 0x61U,  0x61U,  "USB1" },
		{ 0x62U,  0x62U,  "DAP" },
		{ 0x68U,  0x6FU,  "ADMA" },
		{ 0x70U,  0x70U,  "SD0" },
		{ 0x71U,  0x71U,  "SD1" },
		{ 0x72U,  0x72U,  "NAND" },
		{ 0x73U,  0x73U,  "QSPI" },
		{ 0x74U,  0x74U,  "GEM0" },
		{ 0x75U,  0x75U,  "GEM1" },
		{ 0x76U,  0x76U,  "GEM2" },
		{ 0x77U,  0x77U,  "GEM3" },
		{ 0x80U,  0xBFU,  "APU" },
		{ 0xC0U,  0xC3U,  "SATA" },
		{ 0xC4U,  0xC4U,  "GPU" },
		{ 0xC5U,  0xC5U,  "CoreSight" },
		{ 0xD0U,  0xD0U,  "PCIe" },
		{ 0xE0U,  0xE7U,  "DPDMA" },
		{ 0xE8U,  0xEFU,  "GDMA" },
		{ 0x200U, 0x23FU, "AFI FM0" },
		{ 0x240U, 0x27FU, "AFI FM1" },
		{ 0x280U, 0x2BFU, "AFI FM2" },
		{ 0x2C0U, 0x2FFU, "AFI FM3" },
		{ 0x300U, 0x33FU, "AFI FM4" },
		{ 0x340U, 0x37FU, "AFI FM5" },
		{ 0x380U, 0x3BFU, "AFI FM LPD" },
};

/************************** Function Definitions *****************************/
/****************************************************************************/
/**
* Initializes the XMpuPl task that will run on the PMU via the scheduler
*
* @param	SchModPtr points to the Scheduler Module Data Structure instance
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XMpuPl_PmuTaskInit(const XPfw_Module_t *SchModPtr)
{
	/* schedule the XMpuPl task */
	if (XPfw_CoreScheduleTask(
	      SchModPtr, XMPUPL_TASK_INTERVAL, XMpuPl_PmuTask) != XST_SUCCESS) {
		xil_printf("Warning: XMpuPl_PmuTaskInit: Failed to schedule task\r\n");
	}
}

/****************************************************************************/
/**
* This is the XMpuPl Task.
*
* These tasks run every time the PIT1 counts down from the XMPUPL_TASK_INTERVAL
* and causes an interrupt.
*
* @param	None.
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XMpuPl_PmuTask(void)
{
	/* Initialize and Configure pl_xmpu */
	if (!XMpuPl_Initialized) {
		/* Check that PL configuration is done */
		if ((Xil_In32(CSU_PCAP_STATUS) & PCAP_STAT_DONE_EOS)
										== PCAP_STAT_DONE_EOS) {
			XPfw_Printf(DEBUG_DETAILED,
					"XMpuPl_PmuTask: Initializing PL XMPU\n\r");
			if (0U == configureXMPU(&XmpuInst)) {
				/* Set Initialized flag */
				XMpuPl_Initialized = 1U;
			}
		}
	}
}


/****************************************************************************/
/**
* This is the XMpuPl Task.
*
* These tasks run every time the PIT1 counts down from the XSECM_TASK_INTERVAL
* and causes an interrupt.
*
* @param	InstancePtr is an address pointer to the XmpuPl Instance.
*
* @return	Status.
*
* @note		None.
*
*****************************************************************************/
static u32 configureXMPU(XmpuPl *InstancePtr)
{
	u32 Status = {0U};

	/* Initialize XMPU_PL */
	XmpuPl_Config * XmpuPl_ConfigPtr = XMpuPl_LookupConfig(XMPU_DEVICE_ID);
	Status = XMpuPl_CfgInitialize(InstancePtr,
							XmpuPl_ConfigPtr, XmpuPl_ConfigPtr->BaseAddress);
	if (Status != 0U) {
		XPfw_Printf(DEBUG_ERROR,"\n\rXMPU Initialization Failed!\n\r");
	}

	/* Configure XMPU_PL */
	if (Status == 0U) {
		InstWriteReg(InstancePtr, XMPU_PL_CTRL_OFFSET, XMPU_CTRL);
		InstWriteReg(InstancePtr, XMPU_PL_BYPASS_OFFSET, XMPU_LOCK_MASTERS);
		InstWriteReg(InstancePtr, XMPU_PL_LOCK_OFFSET, 1U);

		/* Enable Interrupts */
		XMpuPl_EnableInterrupts(InstancePtr, XMPU_INT_EN);
	}

	/* Add REGION 0 */
	if (Status == 0U) {
		Status = XMpuPl_AddRegion(InstancePtr,
						REGION_0_ADDR, 1U, REGION_0_MASTERS, REGION_0_CFG);
		if (Status != 0U) {
			XPfw_Printf(DEBUG_ERROR,"\n\rXMPU Add Region 0 Failed!\n\r");
		}
	}

	/* Add REGION 1 */
	if (Status == 0U) {
		Status = XMpuPl_AddRegion(InstancePtr,
							REGION_1_ADDR, 1U, REGION_1_MASTERS, REGION_1_CFG);
		if (Status != 0U) {
			XPfw_Printf(DEBUG_ERROR,"\n\rXMPU Add Region 1 Failed!\n\r");
		}
	}

	/* Update XMpuPl Instance */
	if (Status == 0U) {
		Status = XMpuPl_GetConfig(InstancePtr);
		if (Status != 0U) {
			XPfw_Printf(DEBUG_ERROR,"\n\rXMPU Get Config Failed!\n\r");
		}
	}
	return Status;
}

/****************************************************************************/
/**
* Interrupt Handler called by the Error Manager Event Handler.
*
* @param	ErrorId. Error Manager Error ID Number
*
* @return	None.
*
* @note		None.
*
*****************************************************************************/
void XmpuPl_Interrupt_Handler(u8 ErrorId)
{
	XmpuPl *InstancePtr = &XmpuInst;

	/* Get Interrupt Status */
	u32 xmpu_isr = XMpuPl_GetInterruptStatus(InstancePtr);
	u8 write_err = (xmpu_isr & XMPU_PL_IXR_WRVIO_MSK);
	u8 read_err = (xmpu_isr & XMPU_PL_IXR_RDVIO_MSK);
	u32 xmpu_err1 = InstReadReg(InstancePtr, XMPU_PL_ERRS1_OFFSET);
	u32 xmpu_err2 = InstReadReg(InstancePtr, XMPU_PL_ERRS2_OFFSET);

	/* Display Violation */
	XPfw_Printf(DEBUG_DETAILED,
			"============================================================\r\n");
	XPfw_Printf(DEBUG_DETAILED,
			"EM: XMPU PL violation occurred (ErrorId: %d)\r\n", ErrorId);
	if (write_err != 0U) {
		XPfw_Printf(DEBUG_DETAILED,
				"EM: XMPU PL Write permission violation occurred\r\n");
	}
	if (read_err != 0U) {
		XPfw_Printf(DEBUG_DETAILED,
				"EM: XMPU PL Read permission violation occurred\r\n");
	}
	XPfw_Printf(DEBUG_DETAILED,
			"EM: Address of poisoned operation: 0x%X\r\n", xmpu_err1);

	/* Identify Master Device */
	u32 MasterID = xmpu_err2 & 0x3FFU;
	for(u32 MasterIdx = 0U; MasterIdx < ARRAYSIZE(XpuMasterIDLUT);
			++MasterIdx) {

		if ((MasterID >= XpuMasterIDLUT[MasterIdx].MasterID) &&
			  (MasterID <= XpuMasterIDLUT[MasterIdx].MasterIDLimit)) {

			XPfw_Printf(DEBUG_DETAILED,"EM: Master Device of poisoned "
					"operation: %s\r\n",
					XpuMasterIDLUT[MasterIdx].MasterName);
			break;
		}
	}

	XPfw_Printf(DEBUG_DETAILED,
			"============================================================\r\n");

	/* Clear Interrupt Status */
	XMpuPl_ClearInterruptStatus(InstancePtr, xmpu_isr);

}
