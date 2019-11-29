//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
//
//
// Input signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_Position              0   xyzw        0      POS   float       
// SV_PrimitiveID           0    N/A   primID   PRIMID    uint    YES
//
//
// Output signature:
//
// Name                 Index   Mask Register SysValue  Format   Used
// -------------------- ----- ------ -------- -------- ------- ------
// SV_Position              0   xyzw        0      POS   float   xyzw
// TEXCOORD                 0   xyzw        1     NONE   float   xyzw
// SV_ClipDistance          0   x           2  CLIPDST   float   x   
// SV_CullDistance          0    y          2  CULLDST   float    y  
// SV_IsFrontFace           0   x           3    FFACE    uint   x   
// SV_RenderTargetArrayIndex     0    y          3  RTINDEX    uint    y  
// SV_ViewportArrayIndex     0     z         3  VPINDEX    uint     z 
//
gs_5_0
dcl_globalFlags refactoringAllowed
dcl_input_siv v[3][0].xyzw, position
dcl_input vGSInstanceID
dcl_input vPrim
dcl_temps 1
dcl_inputprimitive triangle 
dcl_stream m0
dcl_outputtopology trianglestrip 
dcl_output_siv o0.xyzw, position
dcl_output o1.xyzw
dcl_output_siv o2.x, clip_distance
dcl_output_siv o2.y, cull_distance
dcl_output_sgv o3.x, is_front_face
dcl_output_siv o3.y, rendertarget_array_index
dcl_output_siv o3.z, viewport_array_index
dcl_maxout 3
mov o0.xyzw, l(0,0,0,0)
utof r0.x, vGSInstanceID.x
utof r0.y, vPrim
add r0.x, r0.y, r0.x
mov o1.xyzw, r0.xxxx
mov o2.x, l(0)
mov o2.y, l(0)
mov o3.x, l(0)
mov o3.y, l(0)
mov o3.z, l(0)
emit_stream m0
ret 
// Approximately 12 instruction slots used
