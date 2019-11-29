//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer cbConstant
// {
//
//   float3 vLightDir;                  // Offset:    0 Size:    12
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// samLinear                         sampler      NA          NA             s0      1 
// g_txDiffuse                       texture  float4          2d             t0      1 
// cbConstant                        cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_POSITION              0   xyzw        0      POS   float       
// TEXCOORD                 0   xyz         1     NONE   float   xyz 
// TEXCOORD                 1   xy          2     NONE   float   xy  
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_Target                0   xyzw        0   TARGET   float   xyzw
//
ps_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[1], immediateIndexed
dcl_sampler s0, mode_default
dcl_resource_texture2d (float,float,float,float) t0
dcl_input_ps linear v1.xyz
dcl_input_ps linear v2.xy
dcl_output o0.xyzw
dcl_temps 1
dp3_sat r0.x, v1.xyzx, cb0[0].xyzx
sample_indexable(texture2d)(float,float,float,float) r0.yzw, v2.xyxx, t0.wxyz, s0
mul o0.xyz, r0.xxxx, r0.yzwy
mov o0.w, l(1.000000)
ret 
// Approximately 5 instruction slots used
