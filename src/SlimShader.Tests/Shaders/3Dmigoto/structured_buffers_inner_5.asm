//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// Resource bind info for struct_buf_1
// {
//
//   struct foo
//   {
//       
//       float foo;                     // Offset:    0
//       uint bar;                      // Offset:    4
//       float baz;                     // Offset:    8
//       int buz;                       // Offset:   12
//       float4 f4;                     // Offset:   16
//       float4 g4;                     // Offset:   32
//       float oopsie;                  // Offset:   48
//       float4 m4;                     // Offset:   52
//       float4 n4;                     // Offset:   68
//
//   } $Element;                        // Offset:    0 Size:    84
//
// }
//
// Resource bind info for struct_buf_2
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
//           float foo;                 // Offset:    8
//           float bar;                 // Offset:   12
//
//       } inner_struct_1;              // Offset:    8
//       
//       struct bar::<unnamed>
//       {
//           
//           float baz;                 // Offset:   16
//           float bug;                 // Offset:   20
//           
//           struct foo
//           {
//               
//               float foo;             // Offset:   24
//               uint bar;              // Offset:   28
//               float baz;             // Offset:   32
//               int buz;               // Offset:   36
//               float4 f4;             // Offset:   40
//               float4 g4;             // Offset:   56
//               float oopsie;          // Offset:   72
//               float4 m4;             // Offset:   76
//               float4 n4;             // Offset:   92
//
//           } inner_struct_3;          // Offset:   24
//
//       } inner_struct_2[2];           // Offset:   16
//       float foobaz;                  // Offset:  200
//       int foobuz[8];                 // Offset:  204
//       float binary_decompiler_array_size_calculation_looks_sketchy;// Offset:  236
//       int2 really[3];                // Offset:  240
//       float sketchy;                 // Offset:  264
//       float3 did[5];                 // Offset:  268
//       float i;                       // Offset:  328
//       float4 mention[7];             // Offset:  332
//       float how_sketchy;             // Offset:  444
//
//   } $Element;                        // Offset:    0 Size:   448
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// struct_buf_1                      texture  struct         r/o           t110      1 
// struct_buf_2                      texture  struct         r/o           t111      1 
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// TEXCOORD                 0   x           0     NONE    uint   x   
// TEXCOORD                 1   x           1     NONE   float       
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
dcl_resource_structured t110, 84
dcl_resource_structured t111, 448
dcl_input_ps constant v0.x
dcl_output o0.xyzw
dcl_temps 3
ld_structured_indexable(structured_buffer, stride=84)(mixed,mixed,mixed,mixed) r0.x, l(2), l(4), t110.xxxx
utof r0.x, r0.x
ld_structured_indexable(structured_buffer, stride=84)(mixed,mixed,mixed,mixed) r0.y, l(0), l(0), t110.xxxx
add r0.x, r0.x, r0.y
ld_structured_indexable(structured_buffer, stride=84)(mixed,mixed,mixed,mixed) r0.y, l(1), l(8), t110.xxxx
add r0.x, r0.y, r0.x
ld_structured_indexable(structured_buffer, stride=84)(mixed,mixed,mixed,mixed) r0.y, l(3), l(12), t110.xxxx
itof r0.y, r0.y
add r0.x, r0.y, r0.x
iadd r0.yz, v0.xxxx, l(0, 1, 2, 0)
ld_structured_indexable(structured_buffer, stride=84)(mixed,mixed,mixed,mixed) r1.xyzw, r0.y, l(16), t110.xyzw
ld_structured_indexable(structured_buffer, stride=84)(mixed,mixed,mixed,mixed) r2.xyzw, r0.z, l(32), t110.xyzw
dp4 r0.w, r1.xyzw, r2.xyzw
add r0.x, r0.w, r0.x
ld_structured_indexable(structured_buffer, stride=84)(mixed,mixed,mixed,mixed) r1.xyzw, r0.y, l(52), t110.xyzw
ld_structured_indexable(structured_buffer, stride=84)(mixed,mixed,mixed,mixed) r2.xyzw, r0.z, l(68), t110.xyzw
dp4 r0.y, r1.xyzw, r2.xyzw
add r0.x, r0.y, r0.x
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r1.xyzw, v0.x, l(0), t111.xyzw
add r0.x, r0.x, r1.x
utof r0.y, r1.y
add r0.x, r0.y, r0.x
add r0.x, r1.z, r0.x
add r0.x, r1.w, r0.x
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.y, v0.x, l(16), t111.xxxx
add r0.x, r0.y, r0.x
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.y, v0.x, l(112), t111.xxxx
add r0.x, r0.y, r0.x
imad r0.y, v0.x, l(92), l(36)
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.y, v0.x, r0.y, t111.xxxx
itof r0.y, r0.y
add r0.x, r0.y, r0.x
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.y, v0.x, l(200), t111.xxxx
add r0.x, r0.y, r0.x
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.yz, v0.x, l(232), t111.xxyx
itof r0.y, r0.y
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.yz, v0.x, l(260), t111.xxyx
itof r0.y, r0.y
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.yz, v0.x, l(324), t111.xxyx
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.yz, v0.x, l(440), t111.xxyx
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
ishl r0.y, v0.x, l(2)
iadd r0.y, r0.y, l(204)
ld_structured_indexable(structured_buffer, stride=448)(mixed,mixed,mixed,mixed) r0.y, v0.x, r0.y, t111.xxxx
itof r0.y, r0.y
add o0.xyzw, r0.yyyy, r0.xxxx
ret 
// Approximately 54 instruction slots used
