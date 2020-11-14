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
//       float foobaz;                  // Offset:    8
//       int foobuz[8];                 // Offset:   12
//       float binary_decompiler_array_size_calculation_looks_sketchy;// Offset:   44
//       int2 really[3];                // Offset:   48
//       float sketchy;                 // Offset:   72
//       float3 did[5];                 // Offset:   76
//       float i;                       // Offset:  136
//       float4 mention[7];             // Offset:  140
//       float how_sketchy;             // Offset:  252
//
//   } $Element;                        // Offset:    0 Size:   256
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
dcl_resource_structured t111, 256
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
ld_structured_indexable(structured_buffer, stride=256)(mixed,mixed,mixed,mixed) r0.yzw, v0.x, l(0), t111.xxyz
add r0.x, r0.y, r0.x
utof r0.y, r0.z
add r0.x, r0.y, r0.x
add r0.x, r0.w, r0.x
ld_structured_indexable(structured_buffer, stride=256)(mixed,mixed,mixed,mixed) r0.yz, v0.x, l(40), t111.xxyx
itof r0.y, r0.y
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
ld_structured_indexable(structured_buffer, stride=256)(mixed,mixed,mixed,mixed) r0.yz, v0.x, l(68), t111.xxyx
itof r0.y, r0.y
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
ld_structured_indexable(structured_buffer, stride=256)(mixed,mixed,mixed,mixed) r0.yz, v0.x, l(132), t111.xxyx
add r0.x, r0.y, r0.x
add r0.x, r0.z, r0.x
ld_structured_indexable(structured_buffer, stride=256)(mixed,mixed,mixed,mixed) r0.yz, v0.x, l(248), t111.xxyx
add r0.x, r0.y, r0.x
add o0.xyzw, r0.zzzz, r0.xxxx
ret 
// Approximately 38 instruction slots used