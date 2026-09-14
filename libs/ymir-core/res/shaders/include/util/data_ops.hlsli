#ifndef YMIR_UTIL_DATA_OPS_HLSLI
#define YMIR_UTIL_DATA_OPS_HLSLI

#include "bit_ops.hlsli"

uint Read4(ByteAddressBuffer buf, uint address, uint nibble) {
    return BitExtract(buf.Load(address & ~3), (address & 3) * 8 + nibble * 4, 4);
}

uint Read8(ByteAddressBuffer buf, uint address) {
    return BitExtract(buf.Load(address & ~3), (address & 3) * 8, 8);
}

uint Read16(ByteAddressBuffer buf, uint address) {
    return ByteSwap16(BitExtract(buf.Load(address & ~3), (address & 2) * 8, 16));
}

uint Read32(ByteAddressBuffer buf, uint address) {
    return ByteSwap32(buf.Load(address & ~3));
}

void WriteOr8(RWByteAddressBuffer buf, uint address, uint value) {
    value &= 0xFF;
    value <<= (address & 3) * 8;
    uint dummy;
    buf.InterlockedOr(address & ~3, value, dummy);
}

void WriteOr16(RWByteAddressBuffer buf, uint address, uint value) {
    value &= 0xFFFF;
    value <<= (address & 2) * 8;
    uint dummy;
    buf.InterlockedOr(address & ~3, value, dummy);
}

#endif
