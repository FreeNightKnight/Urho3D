// Make sampling macros also available for VS on D3D11
#define Sample2D(tex, uv) t##tex.Sample(s##tex, uv)
#define Sample2DProj(tex, uv) t##tex.Sample(s##tex, uv.xy / uv.w)
#define Sample2DLod0(tex, uv) t##tex.SampleLevel(s##tex, uv, 0.0)
#define SampleCube(tex, uv) t##tex.Sample(s##tex, uv)
#define SampleCubeLOD(tex, uv) t##tex.SampleLevel(s##tex, uv.xyz, uv.w)
#define SampleShadow(tex, uv) t##tex.SampleCmpLevelZero(s##tex, uv.xy, uv.z)

#ifdef COMPILEPS

// D3D11 textures and samplers

Texture2D tDiffMap : register(t0);
TextureCube tDiffCubeMap : register(t0);
Texture2D tAlbedoBuffer : register(t0);
Texture2D tNormalMap : register(t1);
Texture2D tNormalBuffer : register(t1);
Texture2D tSpecMap : register(t2);
Texture2D tRoughMetalFresnel : register(t2); //R: Roughness, G: Metal
Texture2D tEmissiveMap : register(t3);
Texture2D tEnvMap : register(t4);
Texture3D tVolumeMap : register(t5);
TextureCube tEnvCubeMap : register(t4);
Texture2D tLightRampMap : register(t8);
Texture2D tLightSpotMap : register(t9);
TextureCube tLightCubeMap : register(t9);
Texture2D tShadowMap : register(t10);
TextureCube tFaceSelectCubeMap : register(t11);
TextureCube tIndirectionCubeMap : register(t12);
Texture2D tDepthBuffer : register(t13);
Texture2D tLightBuffer : register(t14);
TextureCube tZoneCubeMap : register(t15);
Texture3D tZoneVolumeMap : register(t15);

SamplerState sDiffMap : register(s0);
SamplerState sDiffCubeMap : register(s0);
SamplerState sAlbedoBuffer : register(s0);
SamplerState sNormalMap : register(s1);
SamplerState sNormalBuffer : register(s1);
SamplerState sSpecMap : register(s2);
SamplerState sRoughMetalFresnel : register(s2); //R: Roughness, G: Metal
SamplerState sEmissiveMap : register(s3);
SamplerState sEnvMap : register(s4);
SamplerState sVolumeMap : register(s5);
SamplerState sEnvCubeMap : register(s4);
SamplerState sLightRampMap : register(s8);
SamplerState sLightSpotMap : register(s9);
SamplerState sLightCubeMap : register(s9);
#ifdef VSM_SHADOW
    SamplerState sShadowMap : register(s10);
#else
    SamplerComparisonState sShadowMap : register(s10);
#endif
SamplerState sFaceSelectCubeMap : register(s11);
SamplerState sIndirectionCubeMap : register(s12);
SamplerState sDepthBuffer : register(s13);
SamplerState sLightBuffer : register(s14);
SamplerState sZoneCubeMap : register(s15);
SamplerState sZoneVolumeMap : register(s15);

float3 DecodeNormal(float4 normalInput)
{
#ifdef PACKEDNORMAL
    float3 normal;
    normal.xy = normalInput.ag * 2.0 - 1.0;
    normal.z = sqrt(max(1.0 - dot(normal.xy, normal.xy), 0.0));
    return normal;
#else
    return normalInput.rgb * 2.0 - 1.0;
#endif
}

float ReconstructDepth(float hwDepth)
{
    return dot(float2(hwDepth, cDepthReconstruct.y / (hwDepth - cDepthReconstruct.x)), cDepthReconstruct.zw);
}

#endif
