//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
//
// Parameters:
//
//   bool g_bUseSpecular;
//   float4 g_matDiffuse;
//   float g_matPower;
//   float4 g_matSpecular;
//   sampler2D g_samScene;
//   float4 g_vLightColor;
//
//
// Registers:
//
//   Name           Reg   Size
//   -------------- ----- ----
//   g_matDiffuse   c0       1
//   g_matSpecular  c1       1
//   g_matPower     c2       1
//   g_vLightColor  c3       1
//   g_bUseSpecular c4       1
//   g_samScene     s0       1
//

    ps_3_0
    def c5, 0, 0, 0, 0
    dcl_texcoord v0.xy
    dcl_texcoord1 v1.xyz
    dcl_texcoord2 v2.xyz
    dcl_texcoord3 v3.xyz
    dcl_texcoord4 v4.xyz
    dcl_texcoord5 v5.xyz
    dcl_texcoord6 v6.xyz
    dcl_2d s0
    dp3 r0.x, v1, v1
    rsq r0.x, r0.x
    mov r1.xyz, v1
    mad r0.yzw, r1.xxyz, r0.x, v3.xxyz
    nrm r2.xyz, r0.yzww
    dp3 r0.y, v2, r2
    max r1.w, r0.y, c5.x
    pow r0.y, r1.w, c2.x
    mad r2.xyz, r1, r0.x, v4
    nrm r3.xyz, r2
    dp3 r0.z, v2, r3
    max r1.w, r0.z, c5.x
    pow r0.z, r1.w, c2.x
    add r0.y, r0.z, r0.y
    mad r2.xyz, r1, r0.x, v5
    mad r0.xzw, r1.xyyz, r0.x, v6.xyyz
    nrm r1.xyz, r0.xzww
    dp3 r0.x, v2, r1
    max r1.x, r0.x, c5.x
    pow r0.x, r1.x, c2.x
    nrm r1.xyz, r2
    dp3 r0.z, v2, r1
    max r1.x, r0.z, c5.x
    pow r0.z, r1.x, c2.x
    add r0.y, r0.z, r0.y
    add r0.x, r0.x, r0.y
    mul r0.x, r0.x, c1.x
    mul r0.x, r0.x, c3.x
    mov r1.x, c5.x
    cmp r0.x, -c4.x, r1.x, r0.x
    mov r1.xyz, v2
    dp3 r0.y, r1, v3
    max r1.w, r0.y, c5.x
    dp3 r0.y, r1, v4
    max r2.x, r0.y, c5.x
    add r0.y, r1.w, r2.x
    dp3 r0.z, r1, v5
    max r1.w, r0.z, c5.x
    add r0.y, r0.y, r1.w
    dp3 r0.z, r1, v6
    max r1.x, r0.z, c5.x
    add r0.y, r0.y, r1.x
    texld r1, v0, s0
    mul r1, r1, c0
    mul r1, r0.y, r1
    mad oC0, r1, c3, r0.x

// approximately 62 instruction slots used (1 texture, 61 arithmetic)
