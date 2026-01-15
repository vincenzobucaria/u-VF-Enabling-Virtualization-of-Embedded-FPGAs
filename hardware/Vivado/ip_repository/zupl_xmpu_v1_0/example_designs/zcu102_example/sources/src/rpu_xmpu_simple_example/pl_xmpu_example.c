/*
 * pl_xmpu_example.c: simple test application to configure the zupl_xmpu with
 * protected and un-protected address regions. Test those regions using reads
 * and writes from the RPU into PL BRAM Secure, Non-Secure, and shared memory
 * address locations.
 *
 */

/***************************** Include Files *********************************/
#include <stdio.h>
#include <stdbool.h>
#include <unistd.h>
#include "xil_printf.h"
#include "xil_io.h"
#include "xil_cache.h"
#include "xil_exception.h"
#include "xscugic.h"
#include "pl_xmpu_example.h"

/*************************** Function Prototypes ******************************/
static int 	SetupInterruptSystem(XScuGic *XicInstPtr);
void 		SAbort_DataAbortHandler(int);

static void readReg(char registerName[30], u32 registerAddress);
static void writeReg(char registerName[30], u32 registerAddress, u32 regVal);

void XMpuPl_IntrHandler(void * data);

/******************************** Variables ***********************************/
/* Flag for register test functions */
bool 		exceptionDetected = false;

/* Storage for interrupt data */
static u32 xmpu_intr = {0U};
static u32 xmpu_isr = {0U};
/*********************************  MAIN  *************************************/
int main(void)
{
	/* Generic Interrupt Controller Instance */
	XScuGic XicInst;

	/*
	 * XmpuPl Instance Array. Supports 1 or more zupl_xmpu cores.
	 */
	XmpuPl XMPU_PL_Inst[XMPU_PL_NUM_INST];

	/*
	 * Install the generic interrupt system. This configures the GIC and
	 * Exception Handlers
	 */
    SetupInterruptSystem(&XicInst);

    /*
     * Initialize all XMPU(s) in the PL. This design only contains one, but
     * this example supports multiple.
     */
    u32 Status;
    XmpuPl *InstancePtr;
    u8 XpmuPl_Id = {0U};
    for (XpmuPl_Id = 0U; XpmuPl_Id < XMPU_PL_NUM_INST; XpmuPl_Id++) {

    		/* Retrieve Base Address of XMPU Device */
    		XmpuPl_Config *ConfigPtr = XMpuPl_LookupConfig(XpmuPl_Id);

    		/* Assign XMPU Instance Pointer */
    		InstancePtr = &XMPU_PL_Inst[XpmuPl_Id];

    		/* Initialize XMPU_PL Instance */
    		Status = XMpuPl_CfgInitialize(InstancePtr, ConfigPtr,
    				ConfigPtr->BaseAddress);
    		if (Status!=0U) {
    			xil_printf("\n\rERROR: XMPU_PL %d "
    					   "Config Initialization Failed!\n\r", XpmuPl_Id);
    		}

    		/* Interrupt ID */
    		u16 IntrId = XMPU_PL_INTR_ID + XpmuPl_Id;

    		/* Assign Interrupt Handler for XMPU */
    		(void)XScuGic_Connect(
    				&XicInst,
    				IntrId,
    				(Xil_ExceptionHandler)XMpuPl_IntrHandler,
    				(void*)XMPU_PL_Inst);

    		/* Enable the interrupt for the device */
    		XScuGic_Enable(&XicInst, IntrId);
    }

    /*
     * Configure XMpuPL Inst 0
     */

	/* Assign XMPU Instance Pointer */
    XpmuPl_Id = 0U;
	InstancePtr = &XMPU_PL_Inst[XpmuPl_Id];

	/* Configure XMPU_PL CTRL Register */
	InstWriteReg(InstancePtr, XMPU_PL_CTRL_OFFSET, XMPU_CTRL_VAL);

	/* Select Masters to Bypass LOCK */
	InstWriteReg(InstancePtr, XMPU_PL_BYPASS_OFFSET, XMPU_LOCK_MASTERS);

	/* Lock XMPU Config Registers */
	InstWriteReg(InstancePtr, XMPU_PL_LOCK_OFFSET, 1U);

	/* Enable XMPU Interrupts */
	XMpuPl_EnableInterrupts(InstancePtr, XMPU_INT_EN);

	/* Add REGION 0 */
	Status = XMpuPl_AddRegion(InstancePtr,
						REGION_0_ADDR, 1U, REGION_0_MASTERS, REGION_0_CFG);
	if (Status != 0U) {
		xil_printf("\n\rXMPU Add Region 0 Failed!\n\r");
	}

	/* Add REGION 1 */
	Status = XMpuPl_AddRegion(InstancePtr,
						REGION_1_ADDR, 1U, REGION_1_MASTERS, REGION_1_CFG);
	if (Status != 0U) {
		xil_printf("\n\rXMPU Add Region 1 Failed!\n\r");
	}

	/* Update XMpuPl Instance */
	Status = XMpuPl_GetConfig(InstancePtr);
	if (Status != 0U) {
		xil_printf("\n\rXMPU Get Config Failed!\n\r");
	}


	/*
	 * Run Read/Write Test
	 */
	print("---Starting Fault Injection Test (Running on the RPU)---\n\n\r");
	print("   (S)=Secure, (NS)=Non-Secure, (ND)=Not-Defined\n\r");
	print("   Memories\n\r");
	print("   \tPL_BRAM_S_BASE         : BRAM Secure Memory Base Address in PL\n\r");
	print("   \tPL_BRAM_NS_SHARED_BASE : BRAM Un-Protected Memory Base Address accessible to ALL Sub-Systems\n\r");
	print("   \tPL_BRAM_NS_BASE        : BRAM Non-Secure Memory Base Address only accessible by Un-Secure Sub-Systems\n\r");

	print("   Peripherals\n\r");
	print("   \tPL_XMPU_S_LOCK         : Secure XMPU in PL\n\r");

	print("\n\n   Read/Write To Memories\n\r");

	print("\n\t Read/Write To PL(S) Memory\n\r");
		readReg("PL_BRAM_S_BASE", PL_BRAM_S_BASE);
		writeReg("PL_BRAM_S_BASE", PL_BRAM_S_BASE, 0xDEADBEEF);

	print("\n\t Read/Write To PL(NS) Memory\n\r");
		readReg("PL_BRAM_NS_SHARED_BASE", PL_BRAM_NS_SHARED_BASE);
		writeReg("PL_BRAM_NS_SHARED_BASE", PL_BRAM_NS_SHARED_BASE, 0xDEADBEEF);

		readReg("PL_BRAM_NS_BASE", PL_BRAM_NS_BASE);
		writeReg("PL_BRAM_NS_BASE", PL_BRAM_NS_BASE, 0xDEADBEEF);

	print("\n\n   Reading Sub-System Peripherals\n\r");

	print("\n\t PL Peripherals\n\r");
		// PL XMPU
		readReg("PL_XMPU_S_START", PL_XMPU_S_START);
		writeReg("PL_XMPU_S_START", PL_XMPU_S_START, 0x6FU);
		// PL GPIO
		readReg("PL_GPIO_NS_SHARED_START", PL_GPIO_NS_SHARED_START);

	print("\n\t Attempt Unlock PL XMPU \n\r");
		u32 xmpu_lock = Xil_In32(PL_XMPU_S_LOCK);
		xil_printf("\t\tRead PL_XMPU_S_LOCK \t0x%08X \n\r", xmpu_lock);
		xil_printf("\t\tWrite PL_XMPU_S_LOCK \t0x%08X \n\r", 0U);
		Xil_Out32(PL_XMPU_S_LOCK, 0U);
		xmpu_lock = Xil_In32(PL_XMPU_S_LOCK);
		xil_printf("\t\tRead PL_XMPU_S_LOCK \t0x%08X \n\r", xmpu_lock);

	xil_printf("\n\r\tXMPU PL Interrupts: %d \n\r", xmpu_intr);
	print("\n\n---Fault Injection Test Complete---\n\n\n\r");

	return 0;
}

/***************************** Interrupt Handler ******************************/
void XMpuPl_IntrHandler(void * data)
{

	/* Variables */
	u8  exit_loop = {0U};
	u32 reg_isr = {0U};
	XmpuPl *XMPU_PL_Ptr = (XmpuPl *)data;

	/* Search XMPU Instances for Interrupt Status */
	for (int i=0; i<XMPU_PL_NUM_INST; i++) {
		/* NULL Check */
		if (XMPU_PL_Ptr != NULL) {
			/* Get ISR Status */
			reg_isr = XMpuPl_GetInterruptStatus(XMPU_PL_Ptr);
			if (reg_isr!=0U) {

				/* Store event in static variable */
				xmpu_isr = reg_isr;
				xmpu_intr++;

				/* Clear ISR */
				XMpuPl_ClearInterruptStatus(XMPU_PL_Ptr, reg_isr);
				reg_isr = XMpuPl_GetInterruptStatus(XMPU_PL_Ptr);
				exit_loop = 1U;
			}
		} else {
			exit_loop = 1U;
			xil_printf("\n\rrXMPU_PL Handler: NULL Pointer! ");
		}
		/* Exit or Continue */
		if (exit_loop) {
			break;
		} else {
			XMPU_PL_Ptr++;
		}
	}

	if (reg_isr!=0U) {
		xil_printf("\n\rrXMPU_PL Handler: ISR Clear Failure! ");
		xil_printf("\n\rISR 0x%08X \n\r", reg_isr);
	}
}

/******************************** Functions ***********************************/
void readReg(char registerName[30], u32 registerAddress)
{
	u32 regVal;

	exceptionDetected = false;
		xil_printf("\t\t Reading %-30s ... ", registerName);
			regVal=Xil_In32(registerAddress);
			print(" ");
			usleep(DELAY_COUNT);
		print(exceptionDetected ? "FAILED!":"PASS!"); print("\n\r");
	exceptionDetected = false;
}

void writeReg(char registerName[30], u32 registerAddress, u32 regVal)
{
	exceptionDetected = false;
	xil_printf("\t\t Writing %-30s ... ", registerName);
			Xil_Out32(registerAddress, regVal);
			print(" ");
			usleep(DELAY_COUNT);
		print(exceptionDetected ? "FAILED!":"PASS!"); print("\n\r");
	exceptionDetected = false;
}

static int SetupInterruptSystem(XScuGic *XicInstPtr)
{
	/*
	 * Connect the general interrupt controller and interrupt handler
	 */

	/* Configure GIC */
	XScuGic_Config *ScuGicConfig;

	ScuGicConfig = XScuGic_LookupConfig(XPAR_SCUGIC_SINGLE_DEVICE_ID);
	if (ScuGicConfig == NULL) {
		xil_printf("\n\rXScuGic_LookupConfig Failed");
	}
	(void)XScuGic_CfgInitialize(XicInstPtr, ScuGicConfig,
			                   ScuGicConfig->CpuBaseAddress);

	/* Enable Exception Handlers */
	Xil_ExceptionRegisterHandler(
		XIL_EXCEPTION_ID_INT,
		(Xil_ExceptionHandler)XScuGic_InterruptHandler,
		(void *)XicInstPtr);
	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_DATA_ABORT_INT,
			(Xil_ExceptionHandler) SAbort_DataAbortHandler,
			XIL_EXCEPTION_ID_DATA_ABORT_INT);

	/* Enable interrupts in the ARM */
	Xil_ExceptionEnable();

	return 0;
}


void SAbort_DataAbortHandler(int Data)
{
	exceptionDetected = true;
	usleep(DELAY_COUNT);

	//update the return address to prevent returning to the same offending read transaction
	__asm__ __volatile ("mov r8, sp");       // copy the stack pointer to r8
	__asm__ __volatile ("add r8, #0x24");    // add 0x24 to my copy of the stack pointer
	__asm__ __volatile ("ldr r9, [r8]");     // copy the contents in memory where R8 is pointing to into r9
	__asm__ __volatile ("add r9, #0x4");     // add 0x4 to r9 (will increment pc to next address)
	__asm__ __volatile ("str r9, [r8]");     // load the value found r9 into the memory location pointed to by r8

	return ;
}

