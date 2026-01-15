import logging
import mmap
import numpy as np
import os
import sys
#

class MMIO:
    """MMIO virtuale basato su /dev/uioX, compatibile con pynq.MMIO"""

    def __init__(self, uio_path, length):
        """Inizializza VirtualMMIO
        
        Args:
            uio_path (str): percorso al device UIO (es. "/dev/uio5")
            length (int): lunghezza della regione in byte (multiplo di 4)
        """
        if length % 4 != 0:
            raise ValueError("Length must be a multiple of 4")

        self.uio_path = uio_path
        self.length = length
        self.fd = os.open(uio_path, os.O_RDWR | os.O_SYNC)

        self.mmap = mmap.mmap(
            self.fd, length, mmap.MAP_SHARED,
            mmap.PROT_READ | mmap.PROT_WRITE)

        self.array = np.frombuffer(self.mmap, dtype=np.uint32)

    def read(self, offset=0, length=4, word_order='little'):
        """Leggi un valore da offset con lunghezza in byte (1, 2, 4, 8)"""
        if length not in [1, 2, 4, 8]:
            raise ValueError("Supported lengths: 1, 2, 4, 8 bytes.")
        if offset < 0 or offset + length > self.length:
            raise ValueError("Offset fuori dal range.")
        if length == 8 and word_order not in ['big', 'little']:
            raise ValueError("Word order must be 'big' or 'little'.")
        if offset % 4 != 0:
            raise MemoryError("Unaligned read: offset must be multiple of 4.")

        idx = offset >> 2
        lsb = int(self.array[idx])
        if length == 8:
            msb = int(self.array[idx + 1])
            return ((msb << 32) + lsb) if word_order == 'little' else ((lsb << 32) + msb)
        else:
            return lsb & ((1 << (8 * length)) - 1)

    def write(self, offset, data):
        """Scrive un valore (int o bytes) a offset"""
        if offset < 0 or offset >= self.length:
            raise ValueError("Offset fuori dal range.")
        if offset % 4 != 0:
            raise MemoryError("Unaligned write: offset must be multiple of 4.")

        idx = offset >> 2
        if isinstance(data, int):
            self.array[idx] = np.uint32(data)
        elif isinstance(data, bytes):
            if len(data) % 4 != 0:
                raise MemoryError("Data length must be multiple of 4.")
            words = np.frombuffer(data, dtype=np.uint32)
            self.array[idx:idx + len(words)] = words
        else:
            raise ValueError("Data must be int or bytes.")

    def close(self):
        self.mmap.close()
        os.close(self.fd)

    def __del__(self):
        try:
            self.close()
        except Exception:
            pass