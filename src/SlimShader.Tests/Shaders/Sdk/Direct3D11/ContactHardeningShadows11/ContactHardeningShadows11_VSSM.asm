//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer cbConstants
// {
//
//   float4x4 g_f4x4WorldViewProjection;// Offset:    0 Size:    64 [unused]
//   float4x4 g_f4x4WorldViewProjLight; // Offset:   64 Size:    64
//   float4 g_vShadowMapDimensions;     // Offset:  128 Size:    16 [unused]
//   float4 g_f4LightDir;               // Offset:  144 Size:    16 [unused]
//   float g_fSunWidth;                 // Offset:  160 Size:     4 [unused]
//   float3 g_f3Padding;                // Offset:  164 Size:    12 [unused]
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// cbConstants                       cbuffer      NA          NA            cb0      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// POSITION                 0   xyz         0     NONE   float   xyz 
// NORMAL                   0   xyz         1     NONE   float       
// TEXTURE                  0   xy          2     NONE   float   xy  
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_Position              0   xyzw        0      POS   float   xyzw
// COLOR                    0   xyzw        1     NONE   float   xyzw
// TEXTURE                  0   xy          2     NONE   float   xy  
// TEXTURE                  1   xyzw        3     NONE   float       
//
vs_4_0
dcl_constantbuffer CB0[8], immediateIndexed
dcl_input v0.xyz
dcl_input v2.xy
dcl_output_siv o0.xyzw, position
dcl_output o1.xyzw
dcl_output o2.xy
dcl_temps 1
mov r0.xyz, v0.xyzx
mov r0.w, l(1.000000)
dp4 o0.x, r0.xyzw, cb0[4].xyzw
dp4 o0.y, r0.xyzw, cb0[5].xyzw
dp4 o0.z, r0.xyzw, cb0[6].xyzw
dp4 o0.w, r0.xyzw, cb0[7].xyzw
mov o1.xyzw, l(0,0,0,0)
mov o2.xy, v2.xyxx
ret 
// Approximately 9 instruction slots used
