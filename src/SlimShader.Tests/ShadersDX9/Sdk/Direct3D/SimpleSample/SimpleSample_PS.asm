//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
// Parameters:
//
//   sampler2D MeshTextureSampler;
//
//
// Registers:
//
//   Name               Reg   Size
//   ------------------ ----- ----
//   MeshTextureSampler s0       1
//

    ps_2_0
    dcl v0
    dcl t0.xy
    dcl_2d s0
    texld r0, t0, s0
    mul r0, r0, v0
    mov oC0, r0

// approximately 3 instruction slots used (1 texture, 2 arithmetic)
