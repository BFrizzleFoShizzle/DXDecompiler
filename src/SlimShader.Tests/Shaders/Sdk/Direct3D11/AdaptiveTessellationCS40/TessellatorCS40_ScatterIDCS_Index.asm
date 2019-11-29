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
// Resource bind info for InputScanned
// {
//
//   uint2 $Element;                    // Offset:    0 Size:     8
//
// }
//
// Resource bind info for TriIDIndexIDOut
// {
//
//   uint2 $Element;                    // Offset:    0 Size:     8
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// InputScanned                      texture  struct         r/o             t0      1 
// TriIDIndexIDOut                       UAV  struct         r/w             u0      1 
// cbCS                              cbuffer      NA          NA            cb1      1 
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
cs_4_0
dcl_globalFlags refactoringAllowed
dcl_constantbuffer CB1[1], immediateIndexed
dcl_resource_structured t0, 8
dcl_uav_structured u0, 8
dcl_input vThreadID.x
dcl_temps 3
dcl_thread_group 128, 1, 1
ult r0.x, vThreadID.x, cb1[0].x
if_nz r0.x
  iadd r0.x, vThreadID.x, l(-1)
  ld_structured r0.x, r0.x, l(4), t0.xxxx
  ld_structured r1.x, vThreadID.x, l(4), t0.xxxx
  mov r2.x, vThreadID.x
  mov r0.y, r0.x
  loop 
    uge r0.z, r0.y, r1.x
    breakc_nz r0.z
    iadd r2.y, -r0.x, r0.y
    store_structured u0.xy, r0.y, l(0), r2.xyxx
    iadd r0.y, r0.y, l(1)
  endloop 
endif 
ret 
// Approximately 16 instruction slots used
