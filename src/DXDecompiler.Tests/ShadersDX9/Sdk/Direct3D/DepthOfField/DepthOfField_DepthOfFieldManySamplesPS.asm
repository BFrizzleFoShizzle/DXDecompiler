//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
// Parameters:
//
//   float2 $KernelArray[12];
//   int $NumSamples;
//   sampler2D RenderTargetSampler;
//
//
// Registers:
//
//   Name                Reg   Size
//   ------------------- ----- ----
//   $KernelArray        c0      12
//   $NumSamples         c12      1
//   RenderTargetSampler s0       1
//

    ps_3_0
    def c13, 0, 1, 2, -0
    def c14, 3, 4, 5, 6
    def c15, 7, 8, 9, 10
    def c16, 11, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_2d s0
    mov r0.w, c14.y
    mov r1.w, c14.x
    mov r2.w, c13.z
    mov r3.xy, c13
    cmp r4.w, -c12.x, r3.x, r3.y
    add r3.y, r4.w, -c12.x
    add r3.zw, c0.xyxy, v0.xyxy
    texld r5, r3.zwzw, s0
    texld r6, v0, s0
    mul_sat r3.z, r5.w, r6.w
    lrp r7.xyz, r3.z, r5, r6
    cmp r4.xyz, -c12.x, r3.x, r7
    add r3.xz, c1.xyyw, v0.xyyw
    texld r5, r3.xzzw, s0
    mul_sat r3.x, r5.w, r6.w
    lrp r7.xyz, r3.x, r5, r6
    add r2.xyz, r4, r7
    cmp r2, r3.y, r4, r2
    add r3.xz, c2.xyyw, v0.xyyw
    texld r4, r3.xzzw, s0
    mul_sat r3.x, r4.w, r6.w
    lrp r5.xyz, r3.x, r4, r6
    add r1.xyz, r2, r5
    add r3.x, r2.w, -c12.x
    cmp r3.x, r3.x, -c13.x, -c13.y
    cmp r3.x, r3.y, c13.w, r3.x
    cmp r1, r3.x, r2, r1
    add r2.xy, c3, v0
    texld r2, r2, s0
    mul_sat r2.w, r2.w, r6.w
    lrp r3.yzw, r2.w, r2.xxyz, r6.xxyz
    add r0.xyz, r1, r3.yzww
    add r2.x, r1.w, -c12.x
    cmp r2.x, r2.x, c13.w, r3.x
    cmp r0, r2.x, r1, r0
    add r1.xy, c4, v0
    texld r1, r1, s0
    mul_sat r1.w, r1.w, r6.w
    lrp r2.yzw, r1.w, r1.xxyz, r6.xxyz
    add r1.xyz, r0, r2.yzww
    mov r1.w, c14.z
    add r2.y, r0.w, -c12.x
    cmp r2.x, r2.y, c13.w, r2.x
    cmp r0, r2.x, r0, r1
    add r1.xy, c5, v0
    texld r1, r1, s0
    mul_sat r1.w, r1.w, r6.w
    lrp r2.yzw, r1.w, r1.xxyz, r6.xxyz
    add r1.xyz, r0, r2.yzww
    add r2.y, r0.w, -c12.x
    cmp r2.x, r2.y, c13.w, r2.x
    mov r1.w, c14.w
    cmp r0, r2.x, r0, r1
    add r1.xy, c6, v0
    texld r1, r1, s0
    mul_sat r1.w, r1.w, r6.w
    lrp r2.yzw, r1.w, r1.xxyz, r6.xxyz
    add r1.xyz, r0, r2.yzww
    add r2.y, r0.w, -c12.x
    cmp r2.x, r2.y, c13.w, r2.x
    mov r1.w, c15.x
    cmp r0, r2.x, r0, r1
    add r1.xy, c7, v0
    texld r1, r1, s0
    mul_sat r1.w, r1.w, r6.w
    lrp r2.yzw, r1.w, r1.xxyz, r6.xxyz
    add r1.xyz, r0, r2.yzww
    add r2.y, r0.w, -c12.x
    cmp r2.x, r2.y, c13.w, r2.x
    mov r1.w, c15.y
    cmp r0, r2.x, r0, r1
    add r1.xy, c8, v0
    texld r1, r1, s0
    mul_sat r1.w, r1.w, r6.w
    lrp r2.yzw, r1.w, r1.xxyz, r6.xxyz
    add r1.xyz, r0, r2.yzww
    add r2.y, r0.w, -c12.x
    cmp r2.x, r2.y, c13.w, r2.x
    mov r1.w, c15.z
    cmp r0, r2.x, r0, r1
    add r1.xy, c9, v0
    texld r1, r1, s0
    mul_sat r1.w, r1.w, r6.w
    lrp r2.yzw, r1.w, r1.xxyz, r6.xxyz
    add r1.xyz, r0, r2.yzww
    add r2.y, r0.w, -c12.x
    cmp r2.x, r2.y, c13.w, r2.x
    mov r1.w, c15.w
    cmp r0, r2.x, r0, r1
    add r1.xy, c10, v0
    texld r1, r1, s0
    mul_sat r1.w, r1.w, r6.w
    lrp r2.yzw, r1.w, r1.xxyz, r6.xxyz
    add r1.xyz, r0, r2.yzww
    add r2.y, r0.w, -c12.x
    cmp r2.x, r2.y, c13.w, r2.x
    mov r1.w, c16.x
    cmp r0, r2.x, r0, r1
    add r1.xy, c11, v0
    texld r1, r1, s0
    mul_sat r1.w, r1.w, r6.w
    lrp r2.yzw, r1.w, r1.xxyz, r6.xxyz
    add r1.xyz, r0, r2.yzww
    add r0.w, r0.w, -c12.x
    cmp r0.w, r0.w, c13.w, r2.x
    cmp r0.xyz, r0.w, r0, r1
    rcp r0.w, c12.x
    mul oC0.xyz, r0.w, r0
    mov oC0.w, c13.y

// approximately 109 instruction slots used (13 texture, 96 arithmetic)