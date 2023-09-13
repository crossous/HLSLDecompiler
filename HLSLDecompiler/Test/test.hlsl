// ---- Created with 3Dmigoto v1.3.16 on Wed Sep 13 10:19:52 2023
RWTexture2DArray<float4> u0 : register(u0);

TextureCube<float4> t0 : register(t0);

SamplerState s0_s : register(s0);

cbuffer cb0 : register(b0)
{
  float4 cb0[1];
}




// 3Dmigoto declarations
#define cmp -


[numthreads(8, 8, 1)]
void main(
  uint3 vThreadID : SV_DispatchThreadID,
  uint3 vThreadGroupID : SV_GroupID,
)
{
  float4 r0;
  uint4 bitmask, uiDest;
  float4 fDest;

  r0.xy = (uint2)vThreadID.xy;
  r0.xy = float2(0.5,0.5) + r0.xy;
  r0.xy = r0.xy * cb0[0].xx + float2(-0.5,-0.5);
  r0.xz = r0.xy + r0.xy;
  switch (vThreadGroupID.z) {
    case 0 :    r0.yz = -r0.zx;
    r0.x = 1;
    break;
    case 1 :    r0.y = -1;
    r0.w = -r0.z;
    r0.xyz = r0.ywx;
    break;
    case 2 :    r0.y = 1;
    break;
    case 3 :    r0.xz = float2(1,-1) * r0.xz;
    r0.y = -1;
    break;
    case 4 :    r0.xy = float2(1,-1) * r0.xz;
    r0.z = 1;
    break;
    default :
    r0.xy = -r0.xz;
    r0.z = -1;
    break;
  }
  r0.w = dot(r0.xyz, r0.xyz);
  r0.w = rsqrt(r0.w);
  r0.xyz = r0.xyz * r0.www;
  r0.xyz = t0.SampleLevel(s0_s, r0.xyz, 0).xyz;
  u0[vThreadID.xyz].xyzw = r0.xyzx;
  return;
}