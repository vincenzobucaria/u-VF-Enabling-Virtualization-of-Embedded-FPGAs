/******************************************************************************
*
* Copyright (C) 2009 - 2014 Xilinx, Inc.  All rights reserved.
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

/*
 * rpuFaultInjection.c: simple test application injecting isolation faults
 * using reads and writes from the RPU into RPU/APU Secure and Non-Secure memory
 * address locations
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
#include "rpuFaultInjection.h"


/*************************** Function Prototypes ******************************/
static int 	SetupInterruptSystem(void);
void 		SAbort_DataAbortHandler(int);

static void readReg(char registerName[30], u32 registerAddress);
static void writeReg(char registerName[30], u32 registerAddress, u32 regVal);


/******************************** Variables ***********************************/
bool 		exceptionDetected = false;



/*********************************  MAIN  *************************************/
int main()
{
    SetupInterruptSystem();

    // Disable caches here for demonstration purposes.  If enabled all write violations look like read violations
    // due to the cache read before a write transaction.
    Xil_DCacheDisable();
    Xil_ICacheDisable();

	print("---Starting Fault Injection Test (Running on the RPU)---\n\n\r");
	print("   (S)=Secure, (NS)=Non-Secure, (ND)=Not-Defined\n\r");

	print("   Memories\n\r");
	print("   \tRPU_OCM_S_BASE                : OCM Secure Memory Base Address in RPU Sub-System\n\r");
	print("   \tRPU_OCM_NS_SHARED_BASE        : OCM Non-Secure Memory Base Address in both RPU and APU Sub-Systems\n\r");
	print("   \tRPU_ATCM_S_BASE               : R5 TCM Bank A Secure Memory Base Address in RPU Sub-System\n\r");
	print("   \tRPU_DDR_LOW_S_BASE            : DDR Secure Memory Base Address in RPU Sub-System\n\r");
	print("   \tRPU_DDR_LOW_NS_SHARED_BASE    : DDR Non-Secure Memory Base Address in both RPU and APU Sub-Systems\n\r");
	print("   \tAPU_OCM_NS_SHARED_BASE        : OCM Non-Secure Memory Base Address in both APU and RPU Sub-Systems\n\r");
	print("   \tAPU_DDR_LOW_NS_BASE           : DDR Non-Secure Memory Base Address in APU Sub-System\n\r");
	print("   \tAPU_DDR_LOW_NS_SHARED_BASE    : DDR Non-Secure Memory Base Address in Both APU and RPU Sub-Systems\n\r");
	print("   \tUNDEFINED_DDR_MEMORY_BASE     : Memory Base Address Not Defined in Any Sub-System\n\r");
	/* Added for PL XMPU Testing */
	print("   \tPL_BRAM_S_BASE                : BRAM Secure Memory Base Address in PL\n\r");
	print("   \tPL_BRAM_NS_SHARED_BASE        : BRAM Un-Protected Memory Base Address accessible to ALL Sub-Systems\n\r");
	print("   \tPL_BRAM_NS_BASE               : BRAM Non-Secure Memory Base Address only accessible by Un-Secure Sub-Systems\n\r");

	print("   Peripherals\n\r");
	print("   \tAPU_UART0_NS_START            : Non-Secure UART0 in APU Sub-System\n\r");
	print("   \tAPU_SWDT0_NS_START            : Non-Secure UART0 in APU Sub-System\n\r");
	print("   \tAPU_TTC0_NS_START             : Non-Secure UART0 in APU Sub-System\n\r");
	print("   \tAPU_UART0_NS_START            : Non-Secure UART0 in APU Sub-System\n\r");
	print("   \tSHARED_GPIO_NS_START          : Shared Non-Secure GPIO\n\r");
	/* Added for PL XMPU Testing */
	print("   \tPL_GPIO_NS_SHARED_START       : Shared Non-Secure GPIO in PL\n\r");

	print("   \tRPU_UART1_S_START             : Secure UART1 in RPU Sub-System\n\r");
	print("   \tRPU_SWDT1_S_START             : Secure SWDT1 in RPU Sub-System\n\r");
	print("   \tRPU_TTC1_S_START              : Secure TTC1 in RPU Sub-System\n\r");
	print("   \tRPU_I2C1_S_START              : Secure I2C1 in RPU Sub-System\n\r");
	/* Added for PL XMPU Testing */
	print("   \tPL_XMPU_S_START               : Secure XMPU in PL\n\r");



// Memory Checks (Read / Modify / Write / Read)

	print("\n\n   Read/Write Of Various Memories\n\r");

		//RPU -> RPU
		print("\n\t Read/Write To RPU(S) Memory\n\r");
		    readReg("RPU_OCM_S_BASE", RPU_OCM_S_BASE);
		    writeReg("RPU_OCM_S_BASE", RPU_OCM_S_BASE, 0xDEADBEEF);

			readReg("RPU_DDR_LOW_S_BASE", RPU_DDR_LOW_S_BASE);
			writeReg("RPU_DDR_LOW_S_BASE", RPU_DDR_LOW_S_BASE, 0xDEADBEEF);

			readReg("RPU_ATCM_S_BASE", RPU_ATCM_S_BASE);
			//writeReg("RPU_ATCM_S_BASE", RPU_ATCM_S_BASE, 0xDEADBEEF);
			print("\t\t Writing RPU_ATCM_S_BASE\t\t...  Skipped to avoid memory collision!\n\r");

		print("\n\t Read/Write Of RPU(NS) Memory\n\r");
			readReg("RPU_OCM_NS_SHARED_BASE", RPU_OCM_NS_SHARED_BASE);
			writeReg("RPU_OCM_NS_SHARED_BASE", RPU_OCM_NS_SHARED_BASE, 0xDEADBEEF);

			readReg("RPU_DDR_LOW_NS_SHARED_BASE", RPU_DDR_LOW_NS_SHARED_BASE);
			writeReg("RPU_DDR_LOW_NS_SHARED_BASE", RPU_DDR_LOW_NS_SHARED_BASE, 0xDEADBEEF);

		//RPU -> APU
		print("\n\t Read/Write Of APU(S) Memory\n\r");
			print("\t\t---This combination does not exist\n\r");
			print("\t\t---APU has no secure memory\n\r");

		print("\n\t Read/Write Of APU(NS)\n\r");
		    readReg("APU_OCM_NS_SHARED_BASE", APU_OCM_NS_SHARED_BASE);
			writeReg("APU_OCM_NS_SHARED_BASE", APU_OCM_NS_SHARED_BASE, 0xDEADBEEF);

			readReg("APU_DDR_LOW_NS_BASE", APU_DDR_LOW_NS_BASE + RPU_SPLIT_VIEW_TCM_ALIAS_ADDR_OFFSET);
			writeReg("APU_DDR_LOW_NS_BASE", APU_DDR_LOW_NS_BASE + RPU_SPLIT_VIEW_TCM_ALIAS_ADDR_OFFSET, 0xDEADBEEF);

			readReg("APU_DDR_LOW_NS_SHARED_BASE", APU_DDR_LOW_NS_SHARED_BASE);
			writeReg("APU_DDR_LOW_NS_SHARED_BASE", APU_DDR_LOW_NS_SHARED_BASE, 0xDEADBEEF);

		//RPU -> Undefined Memory Region
		print("\n\t Read/Write Of ND Memory\n\r");
			readReg("UNDEFINED_DDR_MEMORY_BASE", UNDEFINED_DDR_MEMORY_BASE);
			writeReg("UNDEFINED_DDR_MEMORY_BASE", UNDEFINED_DDR_MEMORY_BASE, 0xDEADBEEF);

		/********************* Added for PL XMPU Testing *********************/
		//RPU -> PL
		print("\n\t Read/Write To PL(S) Memory\n\r");
			readReg("PL_BRAM_S_BASE", PL_BRAM_S_BASE);
			writeReg("PL_BRAM_S_BASE", PL_BRAM_S_BASE, 0xDEADBEEF);

		print("\n\t Read/Write To PL(NS) Memory\n\r");
			readReg("PL_BRAM_NS_SHARED_BASE", PL_BRAM_NS_SHARED_BASE);
			writeReg("PL_BRAM_NS_SHARED_BASE", PL_BRAM_NS_SHARED_BASE, 0xDEADBEEF);

			readReg("PL_BRAM_NS_BASE", PL_BRAM_NS_BASE);
			writeReg("PL_BRAM_NS_BASE", PL_BRAM_NS_BASE, 0xDEADBEEF);

		/*********************************************************************/


		print("\n\n   Reading Sub-System Peripherals\n\r");

			print("\n\t APU Peripherals\n\r");
				// UART0
				readReg("APU_UART0_NS_START", APU_UART0_NS_START);
				// SWDT0
				readReg("APU_SWDT0_NS_START", APU_SWDT0_NS_START);
			    // TTC0
			    readReg("APU_TTC0_NS_START", APU_TTC0_NS_START);

			print("\n\t RPU Peripherals\n\r");
			    // UART1
				readReg("RPU_UART1_S_START", RPU_UART1_S_START);
			    // SWDT1
				readReg("RPU_SWDT1_S_START", RPU_SWDT1_S_START);
			    // TTC1
				readReg("RPU_TTC1_S_START", RPU_TTC1_S_START);
			    // I2C1
				readReg("RPU_I2C1_S_START", RPU_I2C1_S_START);

			print("\n\t Shared Peripherals\n\r");
				// GPIO
				readReg("SHARED_GPIO_NS_START", SHARED_GPIO_NS_START);

		/********************* Added for PL XMPU Testing *********************/
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
		/*********************************************************************/
	print("\n\n---Fault Injection Test Complete---\n\n\n\r");

// Done

    return 0;
}


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
	usleep(DELAY_COUNT);
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
	usleep(DELAY_COUNT);
}

static int SetupInterruptSystem(void)
{
	//Connect the interrupt controller interrupt handler to the hardware
	//interrupt handling logic in the ARM processor.

	Xil_ExceptionRegisterHandler(XIL_EXCEPTION_ID_DATA_ABORT_INT,
			(Xil_ExceptionHandler) SAbort_DataAbortHandler,
			XIL_EXCEPTION_ID_DATA_ABORT_INT);

	//Enable interrupts in the ARM
	Xil_ExceptionEnable();

	return 0;
}


void SAbort_DataAbortHandler(int Data)
{
	exceptionDetected = true;

	//update the return address to prevent returning to the same offending read transaction
	__asm__ __volatile ("mov r8, sp");       // copy the stack pointer to r8
	__asm__ __volatile ("add r8, #0x24");    // add 0x24 to my copy of the stack pointer
	__asm__ __volatile ("ldr r9, [r8]");     // copy the contents in memory where R8 is pointing to into r9
	__asm__ __volatile ("add r9, #0x4");     // add 0x4 to r9 (will increment pc to next address)
	__asm__ __volatile ("str r9, [r8]");     // load the value found r9 into the memory location pointed to by r8

	return ;
}





