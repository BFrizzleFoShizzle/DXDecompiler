//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Note: shader requires additional functionality:
//       PS Output Stencil Ref
//       PS Inner Coverage
//       Typed UAV Load Additional Formats
//       Raster Ordered UAVs
//
//
// Buffer Definitions: 
//
// cbuffer myData
// {
//
//   struct Data
//   {
//       
//       uint index;                    // Offset:    0
//       float4 color;                  // Offset:   16
//
//   } myData;                          // Offset:    0 Size:    32
//
// }
//
// cbuffer myMoreData
// {
//
//   struct MoreData
//   {
//       
//       float4x4 xform;                // Offset:    0
//
//   } myMoreData;                      // Offset:    0 Size:    64
//
// }
//
// cbuffer myStuff
// {
//
//   struct Stuff
//   {
//       
//       float2 factor;                 // Offset:    0
//       uint drawID;                   // Offset:    8
//
//   } myStuff;                         // Offset:    0 Size:    12
//
// }
//
// cbuffer myStuff2
// {
//
//   struct Stuff
//   {
//       
//       float2 factor;                 // Offset:    0
//       uint drawID;                   // Offset:    8
//
//   } myStuff2;                        // Offset:    0 Size:    12
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      ID      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- ------- -------------- ------
// samp0                             sampler      NA          NA      S0             s0      1 
// samp1                             sampler      NA          NA      S1      s0,space2      5 
// samp2                             sampler      NA          NA      S2     s10,space2 unbounded 
// foo                               texture  float4          2d      T0             t2      5 
// bar                               texture  float4         buf      T1             t7      1 
// terrain                           texture  float4          2d      T2             t8 unbounded 
// misc                              texture  float4          2d      T3      t0,space1 unbounded 
// misc2                             texture  float4          2d      T4      t0,space3     10 
// uav0                                  UAV   float         buf      U0             u0      1 
// uav1                                  UAV   unorm         buf      U1             u1      1 
// uav2                                  UAV   snorm         buf      U2             u2      1 
// dataLog                               UAV  float4         buf      U3      u1,space2      1 
// rov1                                  UAV  float4          2d      U4      u3,space2      5 
// myData                            cbuffer      NA          NA     CB0            cb0      4 
// myMoreData                        cbuffer      NA          NA     CB1            cb5      1 
// myStuff                           cbuffer      NA          NA     CB2     cb2,space3 4294967295 
// myStuff2                          cbuffer      NA          NA     CB3     cb3,space4     24 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// INDEX                    0   x           0     NONE    uint   x   
// POSITION                 0   xy          1     NONE   float   xy  
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_TARGET                0   xyzw        0   TARGET   float   xyzw
// SV_STENCILREF            0    N/A    oStencilRef STENCILREF    uint    YES
//
ps_5_1
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[0:3][2], dynamicIndexed, space=0
dcl_constantbuffer CB1[5:5][3], immediateIndexed, space=0
dcl_constantbuffer CB2[2:*][1], dynamicIndexed, space=3
dcl_constantbuffer CB3[3:26][1], immediateIndexed, space=4
dcl_sampler S0[0:0], mode_default, space=0
dcl_sampler S1[0:4], mode_default, space=2
dcl_sampler S2[10:*], mode_default, space=2
dcl_resource_texture2d (float,float,float,float) T0[2:6], space=0
dcl_resource_buffer (float,float,float,float) T1[7:7], space=0
dcl_resource_texture2d (float,float,float,float) T2[8:*], space=0
dcl_resource_texture2d (float,float,float,float) T3[0:*], space=1
dcl_resource_texture2d (float,float,float,float) T4[0:9], space=3
dcl_uav_typed_buffer (float,float,float,float) U0[0:0], space=0
dcl_uav_typed_buffer (unorm,unorm,unorm,unorm) U1[1:1], space=0
dcl_uav_typed_buffer (snorm,snorm,snorm,snorm) U2[2:2], space=0
dcl_uav_typed_buffer (float,float,float,float) U3[1:1], space=2
dcl_uav_typed_texture2d_rov (float,float,float,float) U4[3:7], space=2
dcl_input_ps constant v0.x
dcl_input_ps linear v1.xy
dcl_input vInnerCoverage
dcl_output o0.xyzw
dcl_output oStencilRef
dcl_temps 3
ld_uav_typed r0.xyzw, v0.xxxx, U3[1].xyzw
ld_uav_typed r1.x, v0.xxxx, U0[0].xyzw
add r0.xyzw, r0.xyzw, r1.xxxx
ld_uav_typed r1.x, v0.xxxx, U1[1].xyzw
add r0.xyzw, r0.xyzw, r1.xxxx
ld_uav_typed r1.x, v0.xxxx, U2[2].xyzw
add r0.xyzw, r0.xyzw, r1.xxxx
ld_uav_typed r1.xyzw, v0.xxxx, U4[5].xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
mov r1.x, v0.x
ld_uav_typed r2.xyzw, v0.xxxx, U4[r1.x + 3].xyzw
add r0.xyzw, r0.xyzw, r2.xyzw
add r0.xyzw, r0.xyzw, CB0[3][1].xyzw
add r0.xyzw, r0.xyzw, CB0[r1.x + 0][1].xyzw
add r0.xyzw, r0.xyzw, CB1[5][2].xxxx
add r1.yz, r0.xxyx, CB2[84][0].xxyx
imad r1.w, v0.x, l(24), l(8)
iadd r1.w, r1.w, l(2)
add r1.yz, r1.yyzy, CB2[r1.w + 2][0].xxyx
add r0.xy, r1.yzyy, CB3[13][0].xyxx
sample r2.xyzw, v1.xyxx, T0[3].xyzw, S0[0]
add r0.xyzw, r0.xyzw, r2.xyzw
sample r2.xyzw, v1.xyxx, T0[r1.x + 2].xyzw, S1[r1.x + 0]
add r0.xyzw, r0.xyzw, r2.xyzw
ld r2.xyzw, v0.xxxx, T1[7].xyzw
add r0.xyzw, r0.xyzw, r2.xyzw
sample r2.xyzw, v1.xyxx, T2[9].xyzw, S1[5]
add r0.xyzw, r0.xyzw, r2.xyzw
sample r2.xyzw, v1.xyxx, T2[r1.x + 8].xyzw, S2[r1.x + 10]
add r0.xyzw, r0.xyzw, r2.xyzw
sample r2.xyzw, v1.xyxx, T3[r1.x + 0].xyzw, S2[15]
add r0.xyzw, r0.xyzw, r2.xyzw
sample r1.xyzw, v1.xyxx, T4[r1.x + 0].xyzw, S0[0]
add o0.xyzw, r0.xyzw, r1.xyzw
mov oStencilRef, vInnerCoverage.x
ret 
// Approximately 36 instruction slots used
