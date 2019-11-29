//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer cbCS
// {
//
//   uint4 g_param;                     // Offset:    0 Size:    16
//
// }
//
// Resource bind info for Input
// {
//
//   float $Element;                    // Offset:    0 Size:     4
//
// }
//
// Resource bind info for Result
// {
//
//   float $Element;                    // Offset:    0 Size:     4
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// Input                             texture  struct         r/o             t0      1 
// Result                                UAV  struct         r/w             u0      1 
// cbCS                              cbuffer      NA          NA            cb0      1 
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
cs_5_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB0[1], immediateIndexed
dcl_resource_structured t0, 4
dcl_uav_structured u0, 4
dcl_input vThreadIDInGroupFlattened
dcl_input vThreadGroupID.x
dcl_input vThreadID.x
dcl_temps 2
dcl_tgsm_structured g0, 4, 128
dcl_thread_group 128, 1, 1
ult r0.x, vThreadID.x, cb0[0].x
if_nz r0.x
  ld_structured_indexable(structured_buffer, stride=4)(mixed,mixed,mixed,mixed) r0.x, vThreadID.x, l(0), t0.xxxx
else 
  mov r0.x, l(0)
endif 
store_structured g0.x, vThreadIDInGroupFlattened.x, l(0), r0.x
sync_g_t
ult r0.xyzw, vThreadIDInGroupFlattened.xxxx, l(64, 32, 16, 8)
if_nz r0.x
  iadd r0.x, vThreadIDInGroupFlattened.x, l(64)
  ld_structured r0.x, r0.x, l(0), g0.xxxx
  ld_structured r1.x, vThreadIDInGroupFlattened.x, l(0), g0.xxxx
  add r0.x, r0.x, r1.x
  store_structured g0.x, vThreadIDInGroupFlattened.x, l(0), r0.x
endif 
sync_g_t
if_nz r0.y
  iadd r0.x, vThreadIDInGroupFlattened.x, l(32)
  ld_structured r0.x, r0.x, l(0), g0.xxxx
  ld_structured r0.y, vThreadIDInGroupFlattened.x, l(0), g0.xxxx
  add r0.x, r0.x, r0.y
  store_structured g0.x, vThreadIDInGroupFlattened.x, l(0), r0.x
endif 
sync_g_t
if_nz r0.z
  iadd r0.x, vThreadIDInGroupFlattened.x, l(16)
  ld_structured r0.x, r0.x, l(0), g0.xxxx
  ld_structured r0.y, vThreadIDInGroupFlattened.x, l(0), g0.xxxx
  add r0.x, r0.x, r0.y
  store_structured g0.x, vThreadIDInGroupFlattened.x, l(0), r0.x
endif 
sync_g_t
if_nz r0.w
  iadd r0.x, vThreadIDInGroupFlattened.x, l(8)
  ld_structured r0.x, r0.x, l(0), g0.xxxx
  ld_structured r0.y, vThreadIDInGroupFlattened.x, l(0), g0.xxxx
  add r0.x, r0.x, r0.y
  store_structured g0.x, vThreadIDInGroupFlattened.x, l(0), r0.x
endif 
sync_g_t
ult r0.xyz, vThreadIDInGroupFlattened.xxxx, l(4, 2, 1, 0)
if_nz r0.x
  iadd r0.x, vThreadIDInGroupFlattened.x, l(4)
  ld_structured r0.x, r0.x, l(0), g0.xxxx
  ld_structured r0.w, vThreadIDInGroupFlattened.x, l(0), g0.xxxx
  add r0.x, r0.x, r0.w
  store_structured g0.x, vThreadIDInGroupFlattened.x, l(0), r0.x
endif 
sync_g_t
if_nz r0.y
  iadd r0.x, vThreadIDInGroupFlattened.x, l(2)
  ld_structured r0.x, r0.x, l(0), g0.xxxx
  ld_structured r0.y, vThreadIDInGroupFlattened.x, l(0), g0.xxxx
  add r0.x, r0.x, r0.y
  store_structured g0.x, vThreadIDInGroupFlattened.x, l(0), r0.x
endif 
sync_g_t
if_nz r0.z
  ld_structured r0.x, l(1), l(0), g0.xxxx
  ld_structured r0.y, l(0), l(0), g0.xxxx
  add r0.x, r0.x, r0.y
  store_structured g0.x, l(0), l(0), r0.x
endif 
if_z vThreadIDInGroupFlattened.x
  ld_structured r0.x, l(0), l(0), g0.xxxx
  store_structured u0.x, vThreadGroupID.x, l(0), r0.x
endif 
ret 
// Approximately 69 instruction slots used
