//
// Generated by Microsoft (R) HLSL Shader Compiler 10.1
    ps_3_0
    def c0, -1, -0, 1, 0
    dcl_texcoord v0.w
    add r0.x, c0.x, v0.w
    cmp r0, -r0_abs.x, c0.x, c0.y
    texkill r0
    mov oC0, c0.z

// approximately 4 instruction slots used