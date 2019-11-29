//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
// Buffer Definitions: 
//
// cbuffer cbSimulationConstants
// {
//
//   uint g_iNumParticles;              // Offset:    0 Size:     4 [unused]
//   float g_fTimeStep;                 // Offset:    4 Size:     4 [unused]
//   float g_fSmoothlen;                // Offset:    8 Size:     4
//   float g_fPressureStiffness;        // Offset:   12 Size:     4
//   float g_fRestDensity;              // Offset:   16 Size:     4
//   float g_fDensityCoef;              // Offset:   20 Size:     4 [unused]
//   float g_fGradPressureCoef;         // Offset:   24 Size:     4
//   float g_fLapViscosityCoef;         // Offset:   28 Size:     4
//   float g_fWallStiffness;            // Offset:   32 Size:     4 [unused]
//   float4 g_vGravity;                 // Offset:   48 Size:    16 [unused]
//   float4 g_vGridDim;                 // Offset:   64 Size:    16
//   float3 g_vPlanes[4];               // Offset:   80 Size:    60 [unused]
//
// }
//
// Resource bind info for ParticlesRO
// {
//
//   struct Particle
//   {
//       
//       float2 position;               // Offset:    0
//       float2 velocity;               // Offset:    8
//
//   } $Element;                        // Offset:    0 Size:    16
//
// }
//
// Resource bind info for ParticlesDensityRO
// {
//
//   struct ParticleDensity
//   {
//       
//       float density;                 // Offset:    0
//
//   } $Element;                        // Offset:    0 Size:     4
//
// }
//
// Resource bind info for GridIndicesRO
// {
//
//   uint2 $Element;                    // Offset:    0 Size:     8
//
// }
//
// Resource bind info for ParticlesForcesRW
// {
//
//   struct ParticleForces
//   {
//       
//       float2 acceleration;           // Offset:    0
//
//   } $Element;                        // Offset:    0 Size:     8
//
// }
//
//
// Resource Bindings:
//
// Name                                 Type  Format         Dim      HLSL Bind  Count
// ------------------------------ ---------- ------- ----------- -------------- ------
// ParticlesRO                       texture  struct         r/o             t0      1 
// ParticlesDensityRO                texture  struct         r/o             t1      1 
// GridIndicesRO                     texture  struct         r/o             t4      1 
// ParticlesForcesRW                     UAV  struct         r/w             u0      1 
// cbSimulationConstants             cbuffer      NA          NA            cb0      1 
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
dcl_constantbuffer CB0[5], immediateIndexed
dcl_resource_structured t0, 16
dcl_resource_structured t1, 4
dcl_resource_structured t4, 8
dcl_uav_structured u0, 8
dcl_input vThreadID.x
dcl_temps 9
dcl_thread_group 256, 1, 1
ld_structured_indexable(structured_buffer, stride=16)(mixed,mixed,mixed,mixed) r0.xyzw, vThreadID.x, l(0), t0.xyzw
ld_structured_indexable(structured_buffer, stride=4)(mixed,mixed,mixed,mixed) r1.x, vThreadID.x, l(0), t1.xxxx
div r1.y, r1.x, cb0[1].x
mul r1.z, r1.y, r1.y
mad r1.y, r1.y, r1.z, l(-1.000000)
max r1.y, r1.y, l(0.000000)
mul r1.y, r1.y, cb0[0].w
mul r1.z, cb0[0].z, cb0[0].z
mad r2.xyzw, r0.yyxx, cb0[4].yyxx, cb0[4].wwzz
max r2.xyzw, r2.xyzw, l(0.000000, 0.000000, 0.000000, 0.000000)
min r2.xyzw, r2.xyzw, l(255.000000, 255.000000, 255.000000, 255.000000)
ftoi r2.xyzw, r2.xyzw
iadd r2.xyzw, r2.xyzw, l(-1, 1, -1, 1)
imax r2.xz, r2.xxzx, l(0, 0, 0, 0)
imin r2.yw, r2.yyyw, l(0, 255, 0, 255)
mov r3.xy, l(0,0,0,0)
mov r1.w, r2.x
loop 
  ilt r3.z, r2.y, r1.w
  breakc_nz r3.z
  ishl r3.z, r1.w, l(8)
  mov r4.xy, r3.xyxx
  mov r3.w, r2.z
  loop 
    ilt r4.z, r2.w, r3.w
    breakc_nz r4.z
    iadd r4.z, r3.w, r3.z
    ld_structured_indexable(structured_buffer, stride=8)(mixed,mixed,mixed,mixed) r4.zw, r4.z, l(0), t4.xxxy
    mov r5.xy, r4.xyxx
    mov r5.z, r4.z
    loop 
      uge r5.w, r5.z, r4.w
      breakc_nz r5.w
      ld_structured_indexable(structured_buffer, stride=16)(mixed,mixed,mixed,mixed) r6.xyzw, r5.z, l(0), t0.xyzw
      add r6.xyzw, -r0.xyzw, r6.xyzw
      dp2 r5.w, r6.xyxx, r6.xyxx
      lt r7.x, r5.w, r1.z
      ine r7.y, r5.z, vThreadID.x
      and r7.x, r7.y, r7.x
      ld_structured_indexable(structured_buffer, stride=4)(mixed,mixed,mixed,mixed) r7.y, r5.z, l(0), t1.xxxx
      div r7.z, r7.y, cb0[1].x
      mul r7.w, r7.z, r7.z
      mad r7.z, r7.z, r7.w, l(-1.000000)
      max r7.z, r7.z, l(0.000000)
      sqrt r5.w, r5.w
      mad r7.z, cb0[0].w, r7.z, r1.y
      mul r7.z, r7.z, cb0[1].z
      mul r7.z, r7.z, l(0.500000)
      div r7.z, r7.z, r7.y
      add r7.w, -r5.w, cb0[0].z
      mul r8.x, r7.w, r7.w
      mul r7.z, r7.z, r8.x
      div r5.w, r7.z, r5.w
      mad r6.xy, r5.wwww, r6.xyxx, r5.xyxx
      div r5.w, cb0[1].w, r7.y
      mul r5.w, r7.w, r5.w
      mad r6.xy, r5.wwww, r6.zwzz, r6.xyxx
      movc r5.xy, r7.xxxx, r6.xyxx, r5.xyxx
      iadd r5.z, r5.z, l(1)
    endloop 
    mov r4.xy, r5.xyxx
    iadd r3.w, r3.w, l(1)
  endloop 
  mov r3.xy, r4.xyxx
  iadd r1.w, r1.w, l(1)
endloop 
div r0.xy, r3.xyxx, r1.xxxx
store_structured u0.xy, vThreadID.x, l(0), r0.xyxx
ret 
// Approximately 69 instruction slots used
