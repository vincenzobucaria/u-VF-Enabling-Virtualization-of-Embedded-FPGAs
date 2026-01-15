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

> ⚠️ **Work in Progress**: This repository contains the complete software stack for μ-VF. Hardware components include pre-built bitstreams for ZCU102, Vivado TCL scripts, and base IP libraries for replicating the system. For detailed information on the architecture and implementation, please refer to the [Master's thesis](docs/MasterThesis_VB) and [published paper](https://doi.org/10.1145/3771581). Comprehensive setup guides will be added soon.

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



