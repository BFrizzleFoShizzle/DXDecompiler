//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer cb
// {
//
//   row_major float4x4 g_matWVP;       // Offset:    0 Size:    64
//   float2 g_tess_edge_length_scale;   // Offset:   64 Size:     8
//   int num_triangles;                 // Offset:   72 Size:     4
//   float dummy;                       // Offset:   76 Size:     4 [unused]
//
// }
//
// Resource bind info for EdgeFactorBufOut
// {
//
//   float4 $Element;                   // Offset:    0 Size:    16
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// InputVertices                     texture  float4         buf             t0      1 
// EdgeFactorBufOut                      UAV  struct         r/w             u0      1 
// cb                                cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// no Input
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// no Output
cs_4_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[5], immediateIndexed
dcl_resource_buffer (float,float,float,float) t0
dcl_uav_structured u0, 16
dcl_input vThreadID.x
dcl_temps 10
dcl_thread_group 128, 1, 1
ult r0.x, vThreadID.x, cb0[4].z
if_nz r0.x
  imul null, r0.x, vThreadID.x, l(3)
  ld r0.xyzw, r0.xxxx, t0.xyzw
  mul r1.xyzw, r0.yyyy, cb0[1].xyzw
  mad r1.xyzw, r0.xxxx, cb0[0].xyzw, r1.xyzw
  mad r1.xyzw, r0.zzzz, cb0[2].xyzw, r1.xyzw
  mad r0.xyzw, r0.wwww, cb0[3].xyzw, r1.xyzw
  imad r1.xy, vThreadID.xxxx, l(3, 3, 0, 0), l(1, 2, 0, 0)
  ld r2.xyzw, r1.xxxx, t0.xyzw
  mul r3.xyzw, r2.yyyy, cb0[1].xyzw
  mad r3.xyzw, r2.xxxx, cb0[0].xyzw, r3.xyzw
  mad r3.xyzw, r2.zzzz, cb0[2].xyzw, r3.xyzw
  mad r2.xyzw, r2.wwww, cb0[3].xyzw, r3.xyzw
  ld r1.xyzw, r1.yyyy, t0.xyzw
  mul r3.xyzw, r1.yyyy, cb0[1].xyzw
  mad r3.xyzw, r1.xxxx, cb0[0].xyzw, r3.xyzw
  mad r3.xyzw, r1.zzzz, cb0[2].xyzw, r3.xyzw
  mad r1.xyzw, r1.wwww, cb0[3].xyzw, r3.xyzw
  div r0.xyz, r0.xyzx, r0.wwww
  div r2.xyz, r2.xyzx, r2.wwww
  div r1.xyz, r1.xyzx, r1.wwww
  add r3.xyz, r0.xyzx, l(-0.000000, -0.000000, -0.500000, 0.000000)
  add r4.xyz, r2.xyzx, l(-0.000000, -0.000000, -0.500000, 0.000000)
  add r5.xyz, r1.xyzx, l(-0.000000, -0.000000, -0.500000, 0.000000)
  add r6.xyz, -r3.zxyz, r4.zxyz
  mul r0.zw, r3.zzzz, r6.zzzy
  mad r0.z, r6.x, r3.y, -r0.z
  mul r7.xyz, r5.zzxz, r6.zyzz
  mad r1.z, r6.x, r5.y, -r7.x
  min r1.w, r0.z, r1.z
  max r0.z, r0.z, r1.z
  dp2 r1.z, |r6.xzxx|, l(1.020000, 0.520000, 0.000000, 0.000000)
  lt r1.w, r1.w, r1.z
  lt r0.z, -r1.z, r0.z
  and r0.z, r0.z, r1.w
  mad r0.w, -r6.x, r3.x, r0.w
  mad r1.z, -r6.x, r5.x, r7.y
  min r1.w, r0.w, r1.z
  max r0.w, r0.w, r1.z
  dp2 r1.z, |r6.xyxx|, l(1.020000, 0.520000, 0.000000, 0.000000)
  lt r1.w, r1.w, r1.z
  lt r0.w, -r1.z, r0.w
  and r0.w, r0.w, r1.w
  not r0.zw, r0.zzzw
  or r0.z, r0.w, r0.z
  mul r0.w, r4.y, r6.y
  mad r0.w, r6.z, r4.x, -r0.w
  mad r1.z, -r6.y, r5.y, r7.z
  min r1.w, r0.w, r1.z
  max r0.w, r0.w, r1.z
  dp2 r1.z, |r6.zyzz|, l(1.020000, 1.020000, 0.000000, 0.000000)
  lt r1.w, r1.w, r1.z
  lt r0.w, -r1.z, r0.w
  and r0.w, r0.w, r1.w
  not r0.w, r0.w
  or r0.z, r0.w, r0.z
  if_z r0.z
    add r7.xyz, -r4.yzxy, r5.yzxy
    mul r8.xyz, r3.zzxz, r7.xzxx
    mad r0.z, r7.y, r3.y, -r8.x
    mul r1.zw, r5.zzzz, r7.xxxz
    mad r0.w, r7.y, r5.y, -r1.z
    min r1.z, r0.w, r0.z
    max r0.z, r0.w, r0.z
    dp2 r0.w, |r7.yxyy|, l(1.020000, 0.520000, 0.000000, 0.000000)
    lt r1.z, r1.z, r0.w
    lt r0.z, -r0.w, r0.z
    and r0.z, r0.z, r1.z
    mad r0.w, -r7.y, r3.x, r8.y
    mad r1.z, -r7.y, r5.x, r1.w
    min r1.w, r0.w, r1.z
    max r0.w, r0.w, r1.z
    dp2 r1.z, |r7.yzyy|, l(1.020000, 0.520000, 0.000000, 0.000000)
    lt r1.w, r1.w, r1.z
    lt r0.w, -r1.z, r0.w
    and r0.w, r0.w, r1.w
    not r0.zw, r0.zzzw
    or r0.z, r0.w, r0.z
    mad r0.w, -r7.z, r3.y, r8.z
    mul r1.z, r4.y, r7.z
    mad r1.z, r7.x, r4.x, -r1.z
    min r1.w, r0.w, r1.z
    max r0.w, r0.w, r1.z
    dp2 r1.z, |r7.xzxx|, l(1.020000, 1.020000, 0.000000, 0.000000)
    lt r1.w, r1.w, r1.z
    lt r0.w, -r1.z, r0.w
    and r0.w, r0.w, r1.w
    not r0.w, r0.w
    or r0.z, r0.w, r0.z
    if_z r0.z
      add r8.xyzw, r3.zyxy, -r5.zyxy
      mul r0.zw, r3.zzzz, r8.wwwz
      mad r0.z, r8.x, r3.y, -r0.z
      mul r9.xyz, r4.zzxz, r8.yzwy
      mad r1.z, r8.x, r4.y, -r9.x
      min r1.w, r0.z, r1.z
      max r0.z, r0.z, r1.z
      dp2 r1.z, |r8.xwxx|, l(1.020000, 0.520000, 0.000000, 0.000000)
      lt r1.w, r1.w, r1.z
      lt r0.z, -r1.z, r0.z
      and r0.z, r0.z, r1.w
      mad r0.w, -r8.x, r3.x, r0.w
      mad r1.z, -r8.x, r4.x, r9.y
      min r1.w, r0.w, r1.z
      max r0.w, r0.w, r1.z
      dp2 r1.z, |r8.xzxx|, l(1.020000, 0.520000, 0.000000, 0.000000)
      lt r1.w, r1.w, r1.z
      lt r0.w, -r1.z, r0.w
      and r0.w, r0.w, r1.w
      not r0.zw, r0.zzzw
      or r0.z, r0.w, r0.z
      mad r0.w, -r8.z, r4.y, r9.z
      mul r1.z, r5.y, r8.z
      mad r1.z, r8.w, r5.x, -r1.z
      min r1.w, r0.w, r1.z
      max r0.w, r0.w, r1.z
      dp2 r1.z, |r8.wzww|, l(1.020000, 1.020000, 0.000000, 0.000000)
      lt r1.w, r1.w, r1.z
      lt r0.w, -r1.z, r0.w
      and r0.w, r0.w, r1.w
      not r0.w, r0.w
      or r0.z, r0.w, r0.z
      if_z r0.z
        min r8.xyz, r3.xyzx, r4.xyzx
        min r8.xyz, r5.xyzx, r8.xyzx
        max r4.xyz, r3.xyzx, r4.xyzx
        max r4.xyz, r5.xyzx, r4.xyzx
        lt r5.xyz, l(1.020000, 1.020000, 0.520000, 0.000000), r8.xyzx
        lt r4.xyz, r4.xyzx, l(-1.020000, -1.020000, -0.520000, 0.000000)
        or r4.xyz, r4.xyzx, r5.xyzx
        or r0.z, r4.y, r4.x
        or r0.z, r4.z, r0.z
        if_z r0.z
          mul r4.xyz, r6.xyzx, r7.xyzx
          mad r4.xyz, r6.zxyz, r7.yzxy, -r4.xyzx
          dp3 r0.z, r4.xyzx, r3.xyzx
          lt r3.xyz, l(0.000000, 0.000000, 0.000000, 0.000000), r4.xyzx
          movc r5.xyzw, r3.xxyy, l(-1.020000,1.020000,-1.020000,1.020000), l(1.020000,-1.020000,1.020000,-1.020000)
          movc r3.xz, r3.zzzz, l(-0.520000,0,0.520000,0), l(0.520000,0,-0.520000,0)
          mov r3.yw, r5.xxxz
          dp3 r0.w, r4.zxyz, r3.xywx
          add r0.w, -r0.z, r0.w
          ge r0.w, l(0.000000), r0.w
          mov r3.xy, r5.ywyy
          dp3 r1.z, r4.xyzx, r3.xyzx
          add r0.z, -r0.z, r1.z
          lt r0.z, r0.z, l(0.000000)
          ieq r0.z, r0.z, l(0)
          and r0.z, r0.z, r0.w
        else 
          mov r0.z, l(0)
        endif 
      else 
        mov r0.z, l(0)
      endif 
    else 
      mov r0.z, l(0)
    endif 
  else 
    mov r0.z, l(0)
  endif 
  add r1.zw, r0.xxxy, -r1.xxxy
  mul r1.zw, r1.zzzw, cb0[4].xxxy
  dp2 r0.w, r1.zwzz, r1.zwzz
  add r0.xy, -r0.xyxx, r2.xyxx
  mul r0.xy, r0.xyxx, cb0[4].xyxx
  dp2 r0.x, r0.xyxx, r0.xyxx
  sqrt r3.xy, r0.wxww
  add r0.xy, -r2.xyxx, r1.xyxx
  mul r0.xy, r0.xyxx, cb0[4].xyxx
  dp2 r0.x, r0.xyxx, r0.xyxx
  sqrt r3.z, r0.x
  min r0.x, r3.y, r3.x
  min r3.w, r3.z, r0.x
  min r1.xyzw, r3.xyzw, l(9.000000, 9.000000, 9.000000, 9.000000)
  and r0.xyzw, r0.zzzz, r1.xyzw
  store_structured u0.xyzw, vThreadID.x, l(0), r0.xyzw
endif 
ret 
// Approximately 180 instruction slots used
