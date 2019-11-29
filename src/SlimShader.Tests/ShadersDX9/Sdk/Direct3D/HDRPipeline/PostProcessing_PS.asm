//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
// Parameters:
//
//   float VBloomOffsets[9];
//   float VBloomWeights[9];
//   sampler2D tex0;
//
//
// Registers:
//
//   Name          Reg   Size
//   ------------- ----- ----
//   VBloomWeights c0       9
//   VBloomOffsets c9       9
//   tex0          s0       1
//

    ps_3_0
    def c18, 1, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_2d s0
    add r0.w, c10.x, v0.y
    mov r0.xz, v0.x
    texld r1, r0.zwzw, s0
    mul r1.xyz, r1, c1.x
    add r0.y, c9.x, v0.y
    texld r0, r0, s0
    mad r0.xyz, r0, c0.x, r1
    add r1.y, c11.x, v0.y
    mov r1.xz, v0.x
    texld r2, r1, s0
    mad r0.xyz, r2, c2.x, r0
    add r1.w, c12.x, v0.y
    texld r1, r1.zwzw, s0
    mad r0.xyz, r1, c3.x, r0
    add r1.y, c13.x, v0.y
    mov r1.xz, v0.x
    texld r2, r1, s0
    mad r0.xyz, r2, c4.x, r0
    add r1.w, c14.x, v0.y
    texld r1, r1.zwzw, s0
    mad r0.xyz, r1, c5.x, r0
    add r1.y, c15.x, v0.y
    mov r1.xz, v0.x
    texld r2, r1, s0
    mad r0.xyz, r2, c6.x, r0
    add r1.w, c16.x, v0.y
    texld r1, r1.zwzw, s0
    mad r0.xyz, r1, c7.x, r0
    mov r1.x, v0.x
    add r1.y, c17.x, v0.y
    texld r1, r1, s0
    mad oC0.xyz, r1, c8.x, r0
    mov oC0.w, c18.x

// approximately 33 instruction slots used (9 texture, 24 arithmetic)
