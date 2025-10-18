// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "Kronal/Color Adjust" {
Properties {
	_MainTex ("Base (RGB)", Rect) = "white" {}
	_InBlack ("Black", Range(0.0, 1.0)) = 0.0
	_InWhite ("White", Range(0.0, 1.0)) = 0.33
	_InGamma ("Gamma", Range(0.0, 5.0)) = 0.75
}

SubShader {
	Pass {
		ZTest Always Cull Off ZWrite Off
		Fog { Mode off }

CGPROGRAM
	/*
	_OutBlack ("Output Level: Black", Range(0.0, 1.0)) = 0.0
	_OutWhite ("Output Level: White", Range(0.0, 1.0)) = 1.0
	*/

#pragma vertex vert
#pragma fragment frag
#pragma fragmentoption ARB_precision_hint_fastest 
#include "UnityCG.cginc"

uniform sampler2D _MainTex;
uniform float _InBlack;
uniform float _InGamma;
uniform float _InWhite;
/*
uniform float _OutBlack;
uniform float _OutWhite;
*/

struct uvinfo {
	float4 pos : POSITION;
	float2 uv : TEXCOORD0;
};

uvinfo vert( appdata_img v )
{
	uvinfo i;
	i.pos = UnityObjectToClipPos (v.vertex);
	i.uv = MultiplyUV( UNITY_MATRIX_TEXTURE0, v.texcoord );
	return i;
}

/*
inline half3 rgb2hsv(half4 c)
{
    //float4 K = float4(0.0, -1.0 / 3.0, 2.0 / 3.0, -1.0);
    half4 K = half4(0.0, -0.33333333, 0.66666667, -1.0);
    half4 p = lerp(half4(c.bg, K.wz), half4(c.gb, K.xy), step(c.b, c.g));
    half4 q = lerp(half4(p.xyw, c.r), half4(c.r, p.yzx), step(p.x, c.r));

    float d = q.x - min(q.w, q.y);
    float e = 1.0e-10;
    return half3(abs(q.z + (q.w - q.y) / (6.0 * d + e)), d / (q.x + e), q.x);
}

inline half3 hsv2rgb(half3 c)
{
    //float4 K = float4(1.0, 2.0 / 3.0, 1.0 / 3.0, 3.0);
    half4 K = half4(1.0, 0.66666667, 0.33333333, 3.0);
    half3 p = abs(frac(c.xxx + K.xyz) * 6.0 - K.www);
    return c.z * lerp(K.xxx, saturate(p - K.xxx), c.y);
}
*/

half4 frag (uvinfo i) : COLOR
{
	half4 original = tex2D(_MainTex, i.uv);
	float dIn = (_InWhite - _InBlack);
	return half4(
		pow((original.r - _InBlack) / dIn, _InGamma),
		pow((original.g - _InBlack) / dIn, _InGamma),
		pow((original.b - _InBlack) / dIn, _InGamma),
		original.a) /** (_OutWhite - _OutBlack) + _OutBlack*/;
}
ENDCG
		}
	}
	Fallback off
}
