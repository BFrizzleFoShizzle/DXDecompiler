//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
// Parameters:
//
//   sampler2D g_samScene;
//   float4 rcpFrame;
//
//
// Registers:
//
//   Name         Reg   Size
//   ------------ ----- ----
//   rcpFrame     c0       1
//   g_samScene   s0       1
//

    ps_3_0
    def c1, 0, -1, 1, 1.9632107
    def c2, 0.125, -0.0416666679, 0.25, -0.25
    def c3, 1.33333337, 0.75, -0.5, 0.5
    def c4, 0, 0.111111112, 0, 0
    defi i0, 16, 0, 0, 0
    dcl_texcoord1 v0.xy
    dcl_2d s0
    mov r0.xyz, c1
    mad r1, c0.xyxy, r0.xyyx, v0.xyxy
    mul r2, r1.xyxx, c1.zzxx
    texldl r2, r2, s0
    mul r1, r1.zwxx, c1.zzxx
    texldl r1, r1, s0
    mul r3, c1.zzxx, v0.xyxx
    texldl r3, r3, s0
    mad r4, c0.xyxy, r0.zxxz, v0.xyxy
    mul r5, r4.xyxx, c1.zzxx
    texldl r5, r5, s0
    mul r4, r4.zwxx, c1.zzxx
    texldl r4, r4, s0
    mad r0.w, r2.y, c1.w, r2.x
    mad r1.w, r1.y, c1.w, r1.x
    mad r2.w, r3.y, c1.w, r3.x
    mad r3.w, r5.y, c1.w, r5.x
    mad r4.w, r4.y, c1.w, r4.x
    min r5.w, r1.w, r0.w
    min r6.x, r3.w, r4.w
    min r7.x, r6.x, r5.w
    min r5.w, r7.x, r2.w
    max r6.x, r0.w, r1.w
    max r6.y, r4.w, r3.w
    max r7.x, r6.x, r6.y
    max r6.x, r2.w, r7.x
    add r5.w, -r5.w, r6.x
    mul r6.x, r6.x, c2.x
    min r7.x, -r6.x, c2.y
    if_lt r5.w, -r7.x
    else
      add r1.xyz, r1, r2
      add r1.xyz, r3, r1
      add r1.xyz, r5, r1
      add r1.xyz, r4, r1
      add r2.x, r0.w, r1.w
      add r2.x, r3.w, r2.x
      add r2.x, r4.w, r2.x
      mad r2.x, r2.x, c2.z, -r2.w
      rcp r2.y, r5.w
      mad r2.x, r2_abs.x, r2.y, c2.w
      mul r2.y, r2.x, c3.x
      cmp r2.x, r2.x, r2.y, c1.x
      min r4.x, r2.x, c3.y
      add r5.xy, -c0, v0
      mov r5.zw, c1.x
      texldl r5, r5, s0
      mad r6, c0.xyxy, r0.zyyz, v0.xyxy
      mul r7, r6.xyxx, c1.zzxx
      texldl r7, r7, s0
      mul r6, r6.zwxx, c1.zzxx
      texldl r6, r6, s0
      add r8.xy, c0, v0
      mov r8.zw, c1.x
      texldl r8, r8, s0
      add r2.xyz, r5, r7
      add r2.xyz, r6, r2
      add r2.xyz, r8, r2
      add r1.xyz, r1, r2
      mul r1.xyz, r4.x, r1
      mad r0.y, r5.y, c1.w, r5.x
      mad r2.x, r7.y, c1.w, r7.x
      mad r2.y, r6.y, c1.w, r6.x
      mad r2.z, r8.y, c1.w, r8.x
      mul r4.y, r0.w, c3.z
      mad r4.y, r0.y, c2.z, r4.y
      mad r4.y, r2.x, c2.z, r4.y
      mul r4.z, r1.w, c3.z
      mad r5.x, r1.w, c3.w, -r2.w
      mul r5.y, r3.w, c3.z
      mad r5.x, r3.w, c3.w, r5.x
      add r4.y, r4_abs.y, r5_abs.x
      mul r5.x, r4.w, c3.z
      mad r5.x, r2.y, c2.z, r5.x
      mad r5.x, r2.z, c2.z, r5.x
      add r4.y, r4.y, r5_abs.x
      mad r0.y, r0.y, c2.z, r4.z
      mad r0.y, r2.y, c2.z, r0.y
      mad r2.y, r0.w, c3.w, -r2.w
      mad r2.y, r4.w, c3.w, r2.y
      add r0.y, r0_abs.y, r2_abs.y
      mad r2.x, r2.x, c2.z, r5.y
      mad r2.x, r2.z, c2.z, r2.x
      add r0.y, r0.y, r2_abs.x
      add r0.y, -r4.y, r0.y
      cmp r2.x, r0.y, -c0.y, -c0.x
      cmp r0.w, r0.y, r0.w, r1.w
      cmp r1.w, r0.y, r4.w, r3.w
      add r2.y, -r2.w, r0.w
      add r2.z, -r2.w, r1.w
      add r0.w, r2.w, r0.w
      mul r0.w, r0.w, c3.w
      add r1.w, r2.w, r1.w
      mul r1.w, r1.w, c3.w
      add r3.w, -r2_abs.z, r2_abs.y
      cmp r0.w, r3.w, r0.w, r1.w
      max r1.w, r2_abs.y, r2_abs.z
      cmp r2.x, r3.w, r2.x, -r2.x
      mul r2.y, r2.x, c3.w
      cmp r2.z, r0.y, c1.x, r2.y
      cmp r2.y, r0.y, r2.y, c1.x
      add r5.xy, r2.zyzw, v0
      mul r6, r0.zxxz, c0.xxxy
      cmp r0.xz, r0.y, r6.xyyw, r6.zyww
      add r2.yz, -r0.xxzw, r5.xxyw
      add r4.yz, r0.xxzw, r5.xxyw
      mov r5.xy, r2.yzzw
      mov r5.zw, r4.xyyz
      mov r3.w, r0.w
      mov r4.w, r0.w
      mov r6.xy, c1.x
      rep i0
        if_ne r6.x, -r6.x
          mov r6.z, r3.w
        else
          mul r7, r5.xyxx, c1.zzxx
          texldl r7, r7, s0
          mad r6.z, r7.y, c1.w, r7.x
        endif
        if_ne r6.y, -r6.y
          mov r6.w, r4.w
        else
          mul r7, r5.zwzz, c1.zzxx
          texldl r7, r7, s0
          mad r6.w, r7.y, c1.w, r7.x
        endif
        add r7.xy, -r0.w, r6.zwzw
        mad r7.x, r1.w, -c2.z, r7_abs.x
        cmp r7.x, r7.x, c1.z, c1.x
        mad r7.y, r1.w, -c2.z, r7_abs.y
        cmp r7.y, r7.y, c1.z, c1.x
        add r7.xy, r6, r7
        cmp r6.xy, -r7, c1.x, c1.z
        mul r7.z, r6.y, r6.x
        if_ne r7.z, -r7.z
          mov r3.w, r6.z
          mov r4.w, r6.w
          break_ne c1.z, -c1.z
        endif
        add r7.zw, -r0.xyxz, r5.xyxy
        cmp r5.xy, -r7.x, r7.zwzw, r5
        add r7.xz, r0, r5.zyww
        cmp r5.zw, -r7.y, r7.xyxz, r5
        mov r3.w, r6.z
        mov r4.w, r6.w
      endrep
      add r0.xz, -r5.xyyw, v0.xyyw
      cmp r0.x, r0.y, r0.x, r0.z
      add r2.yz, r5.xzww, -v0.xxyw
      cmp r0.z, r0.y, r2.y, r2.z
      add r1.w, -r0.z, r0.x
      cmp r1.w, r1.w, r4.w, r3.w
      add r2.y, -r0.w, r2.w
      cmp r2.y, r2.y, c1.x, c1.z
      add r0.w, -r0.w, r1.w
      cmp r0.w, r0.w, -c1.x, -c1.z
      add r0.w, r0.w, r2.y
      cmp r0.w, -r0_abs.w, c1.x, r2.x
      add r1.w, r0.x, r0.z
      min r2.x, r0.z, r0.x
      rcp r0.x, r1.w
      mad r0.x, r2.x, -r0.x, c3.w
      mul r0.x, r0.w, r0.x
      cmp r0.z, r0.y, c1.x, r0.x
      cmp r0.x, r0.y, r0.x, c1.x
      add r2.xy, r0.zxzw, v0
      mov r2.zw, c1.x
      texldl r0, r2, s0
      mad r1.xyz, r1, c4.y, r0
      mad r3.xyz, -r4.x, r0, r1
    endif
    mov oC0.xyz, r3
    mov oC0.w, c1.z

// approximately 198 instruction slots used (24 texture, 174 arithmetic)
