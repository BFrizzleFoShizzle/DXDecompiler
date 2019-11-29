//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer $Globals
// {
//
//   float4 diffuse;                    // Offset:    0 Size:    16
//
// }
//
// cbuffer transformsA
// {
//
//   float4x4 modelview;                // Offset:    0 Size:    64
//   int unusedTestA;                   // Offset:   64 Size:     4 [unused]
//
// }
//
// cbuffer transformsB
// {
//
//   int unusedTestB;                   // Offset:    0 Size:     4 [unused]
//   float4x4 projection;               // Offset:   16 Size:    64
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// $Globals                          cbuffer      NA          NA            cb0      1 
// transformsA                       cbuffer      NA          NA            cb1      1 
// transformsB                       cbuffer      NA          NA            cb2      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// POSITION                 0   xyzw        0     NONE   float   xyzw
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_Position              0   xyzw        0      POS   float   xyzw
// COLOR                    0   xyzw        1     NONE   float   xyzw
//
vs_4_0
dcl_constantbuffer CB0[1], immediateIndexed
dcl_constantbuffer CB1[4], immediateIndexed
dcl_constantbuffer CB2[5], immediateIndexed
dcl_input v0.xyzw
dcl_output_siv o0.xyzw, position
dcl_output o1.xyzw
dcl_temps 1
mul r0.xyzw, cb1[0].xyzw, cb2[1].xyzw
dp4 o0.x, v0.xyzw, r0.xyzw
mul r0.xyzw, cb1[1].xyzw, cb2[2].xyzw
dp4 o0.y, v0.xyzw, r0.xyzw
mul r0.xyzw, cb1[2].xyzw, cb2[3].xyzw
dp4 o0.z, v0.xyzw, r0.xyzw
mul r0.xyzw, cb1[3].xyzw, cb2[4].xyzw
dp4 o0.w, v0.xyzw, r0.xyzw
mov o1.xyzw, cb0[0].xyzw
ret 
// Approximately 10 instruction slots used
