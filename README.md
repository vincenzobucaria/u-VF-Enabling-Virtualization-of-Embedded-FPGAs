# μ-VF: Enabling Virtualization of Embedded FPGAs

**A lightweight virtualization framework that enables multiple tenants to access dedicated virtual FPGA instances on embedded SoC-FPGAs.**

Published in *Proceedings of the ACM on Measurement and Analysis of Computing Systems* (December 2025)  
DOI: [10.1145/3771581](https://doi.org/10.1145/3771581)

## Overview

μ-VF addresses the fundamental challenge of multi-tenancy on embedded FPGAs operating autonomously at the network edge. Unlike existing approaches that target datacenter-class FPGAs with external orchestration, μ-VF embeds all virtualization logic entirely onboard the FPGA unit, eliminating the need for any off-chip infrastructure.

Each tenant receives a complete virtual FPGA (vFPGA) comprising:
- **Isolated container** on the Processing System (PS) for software execution
- **Dedicated fabric region (Lake)** in the Programmable Logic (PL) for custom accelerators  
- **Private GPIO pins** dynamically mapped through hardware virtualization

This abstraction provides users with the experience of owning a complete FPGA system while maint

### Features

- **Complete vFPGA abstraction**: Each tenant receives both containerized PS access and private PL regions (Lakes)
- **Hardware GPIO virtualization (ATLAS)**: Dynamic I/O mapping enabling concurrent, low-latency peripheral access
- **Fully on-device operation**: No external host servers or hypervisors required
- **Zero-copy memory access**: Custom kernel modules for efficient hardware communication


## Architecture

μ-VF implements a three-layer architecture where virtualization spans both Processing System (PS) and Programmable Logic (PL):

![μ-VF Architecture](docs/images/architecture_overview.png)


### Core Components

**Lakes**: Partially reconfigurable regions where tenants deploy custom accelerators. Each Lake provides:
- 32-bit AXI-Lite control interface for MMIO register access
- 128-bit AXI-Full data interface for high-throughput DDR transfers
- Tri-state virtual GPIO signals for peripheral interaction

**ATLAS** (Abstract Tenant-Led Access to Signals): Hardware-based GPIO virtualization enabling:
- Runtime remapping of virtual pins to physical pads
- Board-independent hardware designs
- Combinatorial signal paths preserving electrical characteristics
- 20ns reconfiguration latency

**Shore**: Static infrastructure providing:
- Per-Lake Memory Management Units (MMUs) for isolated DDR access
- Decouplers for safe partial reconfiguration
- AXI interconnect for PS-PL communication

**On-device Hypervisor**: Modular service architecture managing:
- Tenant authentication and resource allocation
- Lake deployment and partial reconfiguration
- Buffer allocation and MMU configuration
- GPIO mapping through ATLAS

## Getting Started

### Prerequisites

- **Hardware**: Xilinx Zynq UltraScale+ ZCU102 or compatible PYNQ board
- **Software**: PYNQ v2.7 or later
- **Tools**: Vivado Design Suite 2024.2 (for hardware development)
- **Container Runtime**: Docker support on PYNQ

## Installation

> ⚠️ **Work in Progress**: This repository contains the complete software stack for μ-VF. Hardware components include pre-built bitstreams for ZCU102, Vivado TCL scripts, and base IP libraries for replicating the system. For detailed information on the architecture and implementation, please refer to the [Master's thesis](docs/MasterThesis_VB.pdf) and [published paper](https://doi.org/10.1145/3771581). Comprehensive setup guides will be added soon.

### Quick Start
```bash
# Clone the repository
git clone https://github.com/vincenzobucaria/u-VF-Enabling-Virtualization-of-Embedded-FPGAs.git
cd u-vf
```

### What's Included

**Software Stack** ✅ (Complete):
- Multi-tenant hypervisor with PR zone management
- Client library (PYNQ-compatible API)
- Kernel modules for zero-copy memory access
- Container templates and examples

**Hardware Components** 🔧 (Bitstreams + Sources):
- Pre-built bitstreams for Xilinx ZCU102
- Vivado TCL scripts for project recreation
- Base IP library (Shore, ATLAS, Lake templates)
- Constraint files and floorplanning

**Coming Soon** 📋:
- Complete software deployment guide
- Step-by-step hardware synthesis tutorial
- Custom IP development guidelines

## Citation

If you use μ-VF in your research, please cite our paper:
```bibtex
@article{10.1145/3771581,
author = {Bucaria, Vincenzo Alessio and Longo, Francesco and Merlino, Giovanni and Restuccia, Francesco},
title = {µ-VF: Enabling Virtualization of Embedded FPGAs},
year = {2025},
issue_date = {December 2025},
publisher = {Association for Computing Machinery},
address = {New York, NY, USA},
volume = {9},
number = {3},
url = {https://doi.org/10.1145/3771581},
doi = {10.1145/3771581},
abstract = {Despite growing interest in virtualization of Field-Programmable Gate Arrays (FPGAs), existing approaches predominantly target datacenter-class FPGAs, which heavily rely on external (powerful) servers for hypervisor execution and resource management. This significantly limits their suitability for edge environments where autonomy, energy efficiency, and direct low-latency access to physical Input/Output (I/O) are critical. To address this goal, this paper introduces µ-VF, a lightweight virtualization framework specifically designed to enable robust multi-tenancy on embedded FPGAs operating autonomously at the network edge. µ-VF embeds all virtualization logic entirely onboard the FPGA unit, eliminating the need for any off-chip infrastructure and thus significantly reducing overall system power consumption. Each tenant operates within a secure and isolated container on the on-chip Processing System (PS), coupled with exclusive access to a dedicated Programmable Logic (PL) region. Additionally, µ-VF fully virtualizes external General-Purpose Input/Output (GPIO) directly within the PL fabric, thus enabling independent, concurrent and latency-sensitive access to shared peripherals. We have implemented a prototype of µ-VF with a Zynq UltraScale+ ZCU102 board with PL operating at 100 MHz. Experimental results demonstrate that the hardware virtualization layer utilizes less than 10\% of the FPGA's logic resources, with 85\% available for tenant applications compared to 50\% in prior work. Moreover, µ-VF adds 2.93\% to Memory-Mapped I/O (MMIO) access latency compared to native execution for single-tenant operation, increasing to 6.5\% with four concurrent tenants. Memory throughput measurements show 1.8\% overhead for write operations and negligible impact on read operations, with aggregate throughput 17.1\% higher than previous frameworks. Hardware-based GPIO remapping completes in 20 nanoseconds.},
journal = {Proc. ACM Meas. Anal. Comput. Syst.},
month = dec,
articleno = {66},
numpages = {26},
keywords = {containers, edge computing, fpga virtualization, hypervisor, i/o virtualization, iaas, iot, multi-tenancy, resource isolation, soc-fpga}
}

```

