//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
// Parameters:
//
//   float3 LuminanceConv;
//   float2 TexelKernel[4];
//   sampler2D g_samSrcColor;
//
//
// Registers:
//
//   Name          Reg   Size
//   ------------- ----- ----
//   TexelKernel   c0       4
//   LuminanceConv c4       1
//   g_samSrcColor s0       1
//

    ps_2_0
    def c5, -0.5, 1.20000005, 0.5, 5
    dcl t0.xy
    dcl_2d s0
    add r0.xy, t0, c0
    add r1.xy, t0, c1
    add r2.xy, t0, c2
    add r3.xy, t0, c3
    texld r0, r0, s0
    texld r4, t0, s0
    texld r1, r1, s0
    texld r2, r2, s0
    texld r3, r3, s0
    add r0.xyz, -r0, r4
    abs r0.xyz, r0
    add r0.xyz, r0, c5.x
    mad r0.xyz, r0, c5.y, c5.z
    add r1.xyz, -r1, r4
    abs r1.xyz, r1
    add r1.xyz, r1, c5.x
    mad r0.xyz, r1, c5.y, r0
    add r0.xyz, r0, c5.z
    add r1.xyz, -r2, r4
    abs r1.xyz, r1
    add r1.xyz, r1, c5.x
    mad r0.xyz, r1, c5.y, r0
    add r0.xyz, r0, c5.z
    add r1.xyz, -r3, r4
    abs r1.xyz, r1
    add r1.xyz, r1, c5.x
    mad r0.xyz, r1, c5.y, r0
    add r0.xyz, r0, c5.z
    dp3_sat r0.x, c4, r0
    mul r0, r0.x, c5.w
    mov oC0, r0

// approximately 31 instruction slots used (5 texture, 26 arithmetic)
