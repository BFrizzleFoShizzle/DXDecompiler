//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Note: shader requires additional functionality:
//       64 UAV slots
//       Typed UAV Load Additional Formats
//
//
// Buffer Definitions: 
//
// cbuffer cbuffer1
// {
//
//   float4 cValue;                     // Offset:    0 Size:    16
//
// }
//
// tbuffer tbuffer1
// {
//
//   float4 tValue;                     // Offset:    0 Size:    16
//
// }
//
// cbuffer cbuffer2
// {
//
//   struct bar
//   {
//       
//       float foofoo;                  // Offset:    0
//       uint foobar;                   // Offset:    4
//       
//       struct bar::<unnamed>
//       {
//           
//           float foo;                 // Offset:   16
//           float bar;                 // Offset:   20
//
//       } inner_struct_1;              // Offset:   16
//       
//       struct bar::<unnamed>
//       {
//           
//           float baz;                 // Offset:   32
//           float bug;                 // Offset:   36
//           
//           struct inner_test
//           {
//               
//               float4 sValue1[2];     // Offset:   48
//               float3x4 sValue2[2];   // Offset:   80
//               float4x3 sValue3[2];   // Offset:  208
//               float4 sValue4[2];     // Offset:  304
//
//           } inner_struct_3[2];       // Offset:   48
//
//       } inner_struct_2[2];           // Offset:   32
//       float foobaz;                  // Offset: 1216
//       int foobuz[8];                 // Offset: 1232
//       float binary_decompiler_array_size_calculation_looks_sketchy;// Offset: 1348
//       int2 really[3];                // Offset: 1360
//       float sketchy;                 // Offset: 1400
//       float3 did[5];                 // Offset: 1408
//       float i;                       // Offset: 1484
//       float4 mention[7];             // Offset: 1488
//       float how_sketchy;             // Offset: 1600
//       float4x3 matCM43;              // Offset: 1616
//       float3x4 matCM34;              // Offset: 1664
//       row_major float4x3 matRM43;    // Offset: 1728
//       row_major float3x4 matRM34;    // Offset: 1792
//       float val;                     // Offset: 1840
//
//   } structVal1[2];                   // Offset:    0 Size:  3700
//   float dummy;                       // Offset: 3700 Size:     4 [unused]
//   
//   struct bar
//   {
//       
//       float foofoo;                  // Offset: 3712
//       uint foobar;                   // Offset: 3716
//       
//       struct bar::<unnamed>
//       {
//           
//           float foo;                 // Offset: 3728
//           float bar;                 // Offset: 3732
//
//       } inner_struct_1;              // Offset: 3728
//       
//       struct bar::<unnamed>
//       {
//           
//           float baz;                 // Offset: 3744
//           float bug;                 // Offset: 3748
//           
//           struct inner_test
//           {
//               
//               float4 sValue1[2];     // Offset: 3760
//               float3x4 sValue2[2];   // Offset: 3792
//               float4x3 sValue3[2];   // Offset: 3920
//               float4 sValue4[2];     // Offset: 4016
//
//           } inner_struct_3[2];       // Offset: 3760
//
//       } inner_struct_2[2];           // Offset: 3744
//       float foobaz;                  // Offset: 4928
//       int foobuz[8];                 // Offset: 4944
//       float binary_decompiler_array_size_calculation_looks_sketchy;// Offset: 5060
//       int2 really[3];                // Offset: 5072
//       float sketchy;                 // Offset: 5112
//       float3 did[5];                 // Offset: 5120
//       float i;                       // Offset: 5196
//       float4 mention[7];             // Offset: 5200
//       float how_sketchy;             // Offset: 5312
//       float4x3 matCM43;              // Offset: 5328
//       float3x4 matCM34;              // Offset: 5376
//       row_major float4x3 matRM43;    // Offset: 5440
//       row_major float3x4 matRM34;    // Offset: 5504
//       float val;                     // Offset: 5552
//
//   } structVal2;                      // Offset: 3712 Size:  1844
//   
//   struct <unnamed>
//   {
//       
//       float val1;                    // Offset: 5568
//       float val2;                    // Offset: 5572
//
//   } anonStruct1;                     // Offset: 5568 Size:     8
//   
//   struct <unnamed>
//   {
//       
//       float2 val1;                   // Offset: 5584
//       float2 val2;                   // Offset: 5592
//
//   } anonStruct2;                     // Offset: 5584 Size:    16
//
// }
//
// cbuffer cbuffer3
// {
//
//   float4x3 testCM43;                 // Offset:    0 Size:    48
//
// }
//
// cbuffer cbuffer4
// {
//
//   float3x4 testCM34;                 // Offset:    0 Size:    60
//
// }
//
// cbuffer cbuffer5
// {
//
//   row_major float4x3 testRM43;       // Offset:    0 Size:    60
//
// }
//
// cbuffer cbuffer6
// {
//
//   row_major float3x4 testRM34;       // Offset:    0 Size:    48
//
// }
//
// cbuffer matrices
// {
//
//   row_major float1x1 matRM11;        // Offset:    0 Size:     4
//   row_major float1x2 matRM12;        // Offset:    4 Size:     8 [unused]
//   row_major float1x3 matRM13;        // Offset:   16 Size:    12 [unused]
//   row_major float1x4 matRM14;        // Offset:   32 Size:    16 [unused]
//   row_major float2x1 matRM21;        // Offset:   48 Size:    20 [unused]
//   row_major float2x2 matRM22;        // Offset:   80 Size:    24 [unused]
//   row_major float2x3 matRM23;        // Offset:  112 Size:    28 [unused]
//   row_major float2x4 matRM24;        // Offset:  144 Size:    32 [unused]
//   row_major float3x1 matRM31;        // Offset:  176 Size:    36 [unused]
//   row_major float3x2 matRM32;        // Offset:  224 Size:    40 [unused]
//   row_major float3x3 matRM33;        // Offset:  272 Size:    44 [unused]
//   row_major float3x4 matRM34;        // Offset:  320 Size:    48 [unused]
//   row_major float4x1 matRM41;        // Offset:  368 Size:    52 [unused]
//   row_major float4x2 matRM42;        // Offset:  432 Size:    56 [unused]
//   row_major float4x3 matRM43;        // Offset:  496 Size:    60 [unused]
//   row_major float4x4 matRM44;        // Offset:  560 Size:    64 [unused]
//   float1x1 matCM11;                  // Offset:  624 Size:     4 [unused]
//   float1x2 matCM12;                  // Offset:  640 Size:    20 [unused]
//   float1x3 matCM13;                  // Offset:  672 Size:    36 [unused]
//   float1x4 matCM14;                  // Offset:  720 Size:    52 [unused]
//   float2x1 matCM21;                  // Offset:  772 Size:     8 [unused]
//   float2x2 matCM22;                  // Offset:  784 Size:    24 [unused]
//   float2x3 matCM23;                  // Offset:  816 Size:    40 [unused]
//   float2x4 matCM24;                  // Offset:  864 Size:    56 [unused]
//   float3x1 matCM31;                  // Offset:  928 Size:    12 [unused]
//   float3x2 matCM32;                  // Offset:  944 Size:    28 [unused]
//   float3x3 matCM33;                  // Offset:  976 Size:    44 [unused]
//   float3x4 matCM34;                  // Offset: 1024 Size:    60 [unused]
//   float4x1 matCM41;                  // Offset: 1088 Size:    16 [unused]
//   float4x2 matCM42;                  // Offset: 1104 Size:    32 [unused]
//   float4x3 matCM43;                  // Offset: 1136 Size:    48 [unused]
//   float4x4 matCM44;                  // Offset: 1184 Size:    64 [unused]
//
// }
//
// Resource bind info for tex9
// {
//
//   struct foo
//   {
//       
//       float4 sValue1;                // Offset:    0
//       float4 sValue2;                // Offset:   16
//
//   } $Element;                        // Offset:    0 Size:    32
//
// }
//
// Resource bind info for uav1
// {
//
//   struct foo
//   {
//       
//       float4 sValue1;                // Offset:    0
//       float4 sValue2;                // Offset:   16
//
//   } $Element;                        // Offset:    0 Size:    32
//
// }
//
// Resource bind info for uav2
// {
//
//   struct foo
//   {
//       
//       float4 sValue1;                // Offset:    0
//       float4 sValue2;                // Offset:   16
//
//   } $Element;                        // Offset:    0 Size:    32
//
// }
//
// Resource bind info for uav5
// {
//
//   struct foo
//   {
//       
//       float4 sValue1;                // Offset:    0
//       float4 sValue2;                // Offset:   16
//
//   } $Element;                        // Offset:    0 Size:    32
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      ID      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- ------- -------------- ------
// samp0                             sampler      NA          NA      S0             s0      1 
// samp1                           sampler_c      NA          NA      S1             s1      1 
// tex0                              texture  float4         buf      T0             t0      1 
// tex1                              texture  float4          1d      T1             t1      1 
// tex2                              texture  float4     1darray      T2             t2      1 
// tex3                              texture  float4          2d      T3             t3      1 
// tex4                              texture  float4     2darray      T4             t4      1 
// tex5                              texture  float4          3d      T5             t5      1 
// tex6                              texture  float4        cube      T6             t6      1 
// tex7                              texture  float4   cubearray      T7             t7      1 
// tex8                              texture    byte         r/o      T8             t8      1 
// tex9                              texture  struct         r/o      T9             t9      1 
// tex10                             texture   float       2dMS4     T10            t10      1 
// tex11                             texture   float  2darrayMS4     T11            t11      1 
// tbuffer1                          tbuffer      NA          NA     T12            t12      1 
// uav1                                  UAV  struct      append      U0             u1      1 
// uav2                                  UAV  struct     consume      U1             u2      1 
// uav3                                  UAV  float4         buf      U2             u3      1 
// uav4                                  UAV    byte         r/w      U3             u4      1 
// uav5                                  UAV  struct         r/w      U4             u5      1 
// uav6                                  UAV  float4          1d      U5             u6      1 
// uav7                                  UAV  float4     1darray      U6             u7      1 
// uav8                                  UAV  float4          2d      U7             u8      1 
// uav9                                  UAV  float4     2darray      U8             u9      1 
// uav10                                 UAV  float4          3d      U9            u10      1 
// cbuffer1                          cbuffer      NA          NA     CB0            cb0      1 
// cbuffer2                          cbuffer      NA          NA     CB1            cb1      1 
// cbuffer3                          cbuffer      NA          NA     CB2            cb2      1 
// cbuffer4                          cbuffer      NA          NA     CB3            cb3      1 
// cbuffer5                          cbuffer      NA          NA     CB4            cb4      1 
// cbuffer6                          cbuffer      NA          NA     CB5            cb5      1 
// matrices                          cbuffer      NA          NA     CB6            cb6      1 
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
ps_5_1
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[0:0][1], immediateIndexed, space=0
dcl_constantbuffer CB1[1:1][350], immediateIndexed, space=0
dcl_constantbuffer CB2[2:2][3], immediateIndexed, space=0
dcl_constantbuffer CB3[3:3][4], immediateIndexed, space=0
dcl_constantbuffer CB4[4:4][4], immediateIndexed, space=0
dcl_constantbuffer CB5[5:5][3], immediateIndexed, space=0
dcl_constantbuffer CB6[6:6][1], immediateIndexed, space=0
dcl_sampler S0[0:0], mode_default, space=0
dcl_sampler S1[1:1], mode_comparison, space=0
dcl_resource_buffer (float,float,float,float) T0[0:0], space=0
dcl_resource_texture1d (float,float,float,float) T1[1:1], space=0
dcl_resource_texture1darray (float,float,float,float) T2[2:2], space=0
dcl_resource_texture2d (float,float,float,float) T3[3:3], space=0
dcl_resource_texture2darray (float,float,float,float) T4[4:4], space=0
dcl_resource_texture3d (float,float,float,float) T5[5:5], space=0
dcl_resource_texturecube (float,float,float,float) T6[6:6], space=0
dcl_resource_texturecubearray (float,float,float,float) T7[7:7], space=0
dcl_resource_raw T8[8:8], space=0
dcl_resource_structured T9[9:9], 32, space=0
dcl_resource_texture2dms(4) (float,float,float,float) T10[10:10], space=0
dcl_resource_texture2dmsarray(4) (float,float,float,float) T11[11:11], space=0
dcl_resource_buffer (mixed,mixed,mixed,mixed) T12[12:12], space=0
dcl_uav_structured U0[1:1], 32, space=0
dcl_uav_structured U1[2:2], 32, space=0
dcl_uav_typed_buffer (float,float,float,float) U2[3:3], space=0
dcl_uav_raw U3[4:4], space=0
dcl_uav_structured U4[5:5], 32, space=0
dcl_uav_typed_texture1d (float,float,float,float) U5[6:6], space=0
dcl_uav_typed_texture1darray (float,float,float,float) U6[7:7], space=0
dcl_uav_typed_texture2d (float,float,float,float) U7[8:8], space=0
dcl_uav_typed_texture2darray (float,float,float,float) U8[9:9], space=0
dcl_uav_typed_texture3d (float,float,float,float) U9[10:10], space=0
dcl_input_ps constant v0.x
dcl_output o0.xyzw
dcl_temps 4
ld r0.xyzw, l(0, 0, 0, 0), T12[12].xyzw
add r0.xyzw, r0.xyzw, CB0[0][0].xyzw
add r0.xyzw, r0.xyzw, CB1[1][19].xyzw
add r0.xyzw, r0.xyzw, CB1[1][191].xyzw
add r0.x, r0.x, CB1[1][296].z
add r1.y, r0.y, CB1[1][297].z
add r0.y, r0.z, CB1[1][298].z
add r0.z, r0.w, CB1[1][299].z
add r1.x, r0.x, CB1[1][348].y
add r0.xw, r1.xxxy, CB1[1][349].zzzw
add r0.x, r0.x, CB2[2][0].w
add r0.w, r0.w, CB2[2][1].w
add r0.y, r0.y, CB2[2][2].w
add r1.x, r0.x, CB3[3][0].z
add r1.y, r0.w, CB3[3][1].z
add r1.z, r0.y, CB3[3][2].z
add r0.w, r0.z, CB3[3][3].z
add r0.xyz, r1.xyzx, CB4[4][3].xyzx
add r0.xyzw, r0.xyzw, CB5[5][2].xyzw
add r0.xyzw, r0.xyzw, CB6[6][0].xxxx
itof r1.x, v0.x
sample r2.xyzw, r1.xxxx, T3[3].xyzw, S0[0]
add r0.xyzw, r0.xyzw, r2.xyzw
sample_c r1.y, r1.xxxx, T3[3].xxxx, S1[1], l(0.500000)
add r0.xyzw, r0.xyzw, r1.yyyy
ld r2.xyzw, v0.xxxx, T0[0].xyzw
add r0.xyzw, r0.xyzw, r2.xyzw
ld r2.xyzw, v0.xxxx, T1[1].xyzw
add r0.xyzw, r0.xyzw, r2.xyzw
ld r2.xyzw, v0.xxxx, T2[2].xyzw
add r0.xyzw, r0.xyzw, r2.xyzw
ld r2.xyzw, v0.xxxx, T3[3].xyzw
add r0.xyzw, r0.xyzw, r2.xyzw
ld r2.xyzw, v0.xxxx, T4[4].xyzw
add r0.xyzw, r0.xyzw, r2.xyzw
ld r2.xyzw, v0.xxxx, T5[5].xyzw
add r0.xyzw, r0.xyzw, r2.xyzw
sample r2.xyzw, r1.xxxx, T6[6].xyzw, S0[0]
add r0.xyzw, r0.xyzw, r2.xyzw
sample r1.xyzw, r1.xxxx, T7[7].xyzw, S0[0]
add r0.xyzw, r0.xyzw, r1.xyzw
ld_raw r1.x, v0.x, T8[8].xxxx
utof r1.x, r1.x
add r0.xyzw, r0.xyzw, r1.xxxx
ld_structured r1.xyzw, v0.x, l(16), T9[9].xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
mov r1.x, v0.x
mov r1.z, l(0)
ldms r1.y, r1.xxzz, T10[10].yxzw, v0.x
add r0.xyzw, r0.xyzw, r1.yyyy
ldms r1.x, r1.xxxz, T11[11].xyzw, v0.x
add r0.xyzw, r0.xyzw, r1.xxxx
imm_atomic_consume r1.x, U1[2]
ld_structured r2.x, r1.x, l(0), U1[2].xxxx
ld_structured r2.y, r1.x, l(4), U1[2].xxxx
ld_structured r2.z, r1.x, l(8), U1[2].xxxx
ld_structured r2.w, r1.x, l(12), U1[2].xxxx
ld_structured r3.x, r1.x, l(16), U1[2].xxxx
ld_structured r3.y, r1.x, l(20), U1[2].xxxx
ld_structured r3.z, r1.x, l(24), U1[2].xxxx
ld_structured r3.w, r1.x, l(28), U1[2].xxxx
add r0.xyzw, r0.xyzw, r2.xyzw
add r1.xyzw, r0.xyzw, r2.xyzw
imm_atomic_alloc r2.x, U0[1]
store_structured U0[1].xyzw, r2.x, l(0), r1.xyzw
store_structured U0[1].xyzw, r2.x, l(16), r3.xyzw
ld_uav_typed r1.xyzw, v0.xxxx, U2[3].xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
ld_raw r1.x, v0.x, U3[4].xxxx
utof r1.x, r1.x
add r0.xyzw, r0.xyzw, r1.xxxx
ld_structured r1.xyzw, v0.x, l(16), U4[5].xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
ld_uav_typed r1.xyzw, v0.xxxx, U5[6].xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
ld_uav_typed r1.xyzw, v0.xxxx, U6[7].xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
ld_uav_typed r1.xyzw, v0.xxxx, U7[8].xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
ld_uav_typed r1.xyzw, v0.xxxx, U8[9].xyzw
add r0.xyzw, r0.xyzw, r1.xyzw
ld_uav_typed r1.xyzw, v0.xxxx, U9[10].xyzw
add o0.xyzw, r0.xyzw, r1.xyzw
ret 
// Approximately 84 instruction slots used
