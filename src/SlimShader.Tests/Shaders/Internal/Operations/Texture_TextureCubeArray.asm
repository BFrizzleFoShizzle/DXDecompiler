//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Note: shader requires additional functionality:
//       Tiled resources
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// samp0                             sampler      NA          NA             s0      1 
// samp1                           sampler_c      NA          NA             s1      1 
// tex                               texture  float4   cubearray             t8      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// POSITION                 0   x           0     NONE     int   x   
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_Target                0   xyzw        0   TARGET   float   xyzw
//
ps_5_0
dcl_globalFlags refactoringAllowed | skipOptimization
dcl_sampler s0, mode_default
dcl_sampler s1, mode_comparison
dcl_resource_texturecubearray (float,float,float,float) t8
dcl_input_ps constant v0.x
dcl_output o0.xyzw
dcl_temps 8
itof r0.xyzw, l(0, 0, 0, 0)
itof r1.xyzw, v0.xxxx
itof r2.x, v0.x
mov r2.y, v0.x
itof r2.z, v0.x
itof r2.w, v0.x
itof r3.xyzw, v0.xxxx
itof r4.xyzw, v0.xxxx
itof r5.x, v0.x
itof r5.yzw, v0.xxxx
lod r6.x, r5.yzwy, t8.x, s0
add r0.xyzw, r0.xyzw, r6.xxxx
lod r5.y, r5.yzwy, t8.y, s0
add r0.xyzw, r0.xyzw, r5.yyyy
gather4_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s0.x
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s0.x
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s0.x
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s0.x
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s0.y
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s0.y
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s0.z
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s0.z
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s0.w
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s0.w
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s1.x, r2.x
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s1.x, r2.x
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s1.x, r2.x
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s1.x, r2.x
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s1.y, r2.x
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s1.y, r2.x
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s1.z, r2.x
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s1.z, r2.x
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s1.w, r2.x
add r0.xyzw, r0.xyzw, r6.xyzw
gather4_c_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s1.w, r2.x
check_access_fully_mapped r5.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r5.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
resinfo_indexable(texturecubearray)(float,float,float,float)_uint r6.xyzw, r2.y, t8.xyzw
mov r6.x, r6.x
mov r6.y, r6.y
mov r6.z, r6.z
mov r6.w, r6.w
utof r7.xyzw, r6.xxxx
add r0.xyzw, r0.xyzw, r7.xyzw
utof r7.xyzw, r6.yyyy
add r0.xyzw, r0.xyzw, r7.xyzw
utof r7.xyzw, r6.zzzz
add r0.xyzw, r0.xyzw, r7.xyzw
utof r6.xyzw, r6.wwww
add r0.xyzw, r0.xyzw, r6.xyzw
sample_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s0
add r0.xyzw, r0.xyzw, r6.xyzw
sample_cl_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, null, r1.xyzw, t8.xyzw, s0, r2.z
add r0.xyzw, r0.xyzw, r6.xyzw
sample_cl_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s0, r2.z
check_access_fully_mapped r2.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r2.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
sample_b_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s0, r2.w
add r0.xyzw, r0.xyzw, r6.xyzw
sample_b_cl_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, null, r1.xyzw, t8.xyzw, s0, r2.w, r2.z
add r0.xyzw, r0.xyzw, r6.xyzw
sample_b_cl_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r7.x, r1.xyzw, t8.xyzw, s0, r2.w, r2.z
check_access_fully_mapped r2.y, r7.x
add r0.xyzw, r0.xyzw, r6.xyzw
and r6.xyzw, r2.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
sample_c_indexable(texturecubearray)(float,float,float,float) r2.y, r1.xyzw, t8.xxxx, s1, r2.x
add r0.xyzw, r0.xyzw, r2.yyyy
sample_c_cl_s_indexable(texturecubearray)(float,float,float,float) r6.x, null, r1.xyzw, t8.xxxx, s1, r2.x, r2.z
add r0.xyzw, r0.xyzw, r6.xxxx
sample_c_cl_s_indexable(texturecubearray)(float,float,float,float) r6.x, r7.x, r1.xyzw, t8.xxxx, s1, r2.x, r2.z
check_access_fully_mapped r2.y, r7.x
add r0.xyzw, r0.xyzw, r6.xxxx
and r6.xyzw, r2.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
sample_c_lz_indexable(texturecubearray)(float,float,float,float) r2.y, r1.xyzw, t8.xxxx, s1, r2.x
add r0.xyzw, r0.xyzw, r2.yyyy
sample_c_lz_indexable(texturecubearray)(float,float,float,float) r2.y, r1.xyzw, t8.xxxx, s1, r2.x
add r0.xyzw, r0.xyzw, r2.yyyy
sample_c_lz_s_indexable(texturecubearray)(float,float,float,float) r2.x, r6.x, r1.xyzw, t8.xxxx, s1, r2.x
check_access_fully_mapped r2.y, r6.x
add r0.xyzw, r0.xyzw, r2.xxxx
and r6.xyzw, r2.yyyy, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r6.xyzw
sample_d_indexable(texturecubearray)(float,float,float,float) r6.xyzw, r1.xyzw, t8.xyzw, s0, r3.xyww, r4.xyww
add r0.xyzw, r0.xyzw, r6.xyzw
sample_d_cl_s_indexable(texturecubearray)(float,float,float,float) r6.xyzw, null, r1.xyzw, t8.xyzw, s0, r3.xyww, r4.xyww, r2.z
add r0.xyzw, r0.xyzw, r6.xyzw
sample_d_cl_s_indexable(texturecubearray)(float,float,float,float) r2.xyzw, r3.x, r1.xyzw, t8.xyzw, s0, r3.xyzw, r4.xyzw, r2.z
check_access_fully_mapped r3.x, r3.x
add r0.xyzw, r0.xyzw, r2.xyzw
and r2.xyzw, r3.xxxx, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r2.xyzw
sample_l_indexable(texturecubearray)(float,float,float,float) r2.xyzw, r1.xyzw, t8.xyzw, s0, r5.x
add r0.xyzw, r0.xyzw, r2.xyzw
sample_l_s_indexable(texturecubearray)(float,float,float,float) r1.xyzw, r2.x, r1.xyzw, t8.xyzw, s0, r5.x
check_access_fully_mapped r2.x, r2.x
add r0.xyzw, r0.xyzw, r1.xyzw
and r1.xyzw, r2.xxxx, l(0x3f800000, 0x3f800000, 0x3f800000, 0x3f800000)
add r0.xyzw, r0.xyzw, r1.xyzw
mov o0.xyzw, r0.xyzw
ret 
// Approximately 151 instruction slots used
