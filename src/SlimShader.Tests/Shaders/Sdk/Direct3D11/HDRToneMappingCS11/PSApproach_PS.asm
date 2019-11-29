//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// PointSampler                      sampler      NA          NA             s0      1 
// s0                                texture  float4          2d             t0      1 
// s1                                texture  float4          2d             t1      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_POSITION              0   xyzw        0      POS   float       
// TEXCOORD                 0   xy          1     NONE   float   xy  
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_TARGET                0   xyzw        0   TARGET   float   xyzw
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_resource_texture2d (float,float,float,float) t1
dcl_input_ps linear v1.xy
dcl_output o0.xyzw
dcl_temps 3
sample_indexable(texture2d)(float,float,float,float) r0.xyz, v1.xyxx, t0.xyzw, s0
add r0.xyz, r0.xyzx, l(-0.500000, -0.500000, -0.500000, 0.000000)
max r0.xyz, r0.xyzx, l(0.000000, 0.000000, 0.000000, 0.000000)
sample_indexable(texture2d)(float,float,float,float) r0.w, l(0.000000, 0.000000, 0.000000, 0.000000), t1.yzwx, s0
add r0.w, r0.w, l(0.001000)
div r0.w, l(0.720000), r0.w
mul r0.xyz, r0.wwww, r0.xyzx
mad r1.xyz, r0.xyzx, l(0.666667, 0.666667, 0.666667, 0.000000), l(1.000000, 1.000000, 1.000000, 0.000000)
mul r2.xyz, r0.xyzx, r1.xyzx
mad r0.xyz, r0.xyzx, r1.xyzx, l(1.000000, 1.000000, 1.000000, 0.000000)
div o0.xyz, r2.xyzx, r0.xyzx
mov o0.w, l(1.000000)
ret 
// Approximately 13 instruction slots used
