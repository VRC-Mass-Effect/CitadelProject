// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "KorroShaders/LD_Surfaces"
{
	Properties
	{
		_Mask("Mask", 2D) = "white" {}
		_BaseColor("Base Color", Color) = (1,1,1,1)
		_Color1("Color 1", Color) = (1,1,1,1)
		_Color2("Color 2", Color) = (1,1,1,1)
		_SpecularColor("Specular Color", Color) = (0.5019608,0.5019608,0.5019608,1)
		_Gloss("Gloss", Range( 0 , 1)) = 1
		[Normal]_Norm("Norm", 2D) = "bump" {}
		_Emmissive("Emmissive", 2D) = "white" {}
		[Toggle]_EmissiveType("Emissive Type", Float) = 0
		[HDR]_EmmissiveColor("Emmissive Color", Color) = (0,0,0,0)
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IsEmissive" = "true"  }
		Cull Back
		CGPROGRAM
		#pragma target 3.0
		#pragma surface surf StandardSpecular keepalpha addshadow fullforwardshadows 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform sampler2D _Norm;
		uniform float4 _Norm_ST;
		uniform float4 _BaseColor;
		uniform float4 _Color1;
		uniform sampler2D _Mask;
		uniform float4 _Mask_ST;
		uniform float4 _Color2;
		uniform float _EmissiveType;
		uniform sampler2D _Emmissive;
		uniform float4 _Emmissive_ST;
		uniform float4 _EmmissiveColor;
		uniform float4 _SpecularColor;
		uniform float _Gloss;

		void surf( Input i , inout SurfaceOutputStandardSpecular o )
		{
			float2 uv_Norm = i.uv_texcoord * _Norm_ST.xy + _Norm_ST.zw;
			o.Normal = UnpackNormal( tex2D( _Norm, uv_Norm ) );
			float2 uv_Mask = i.uv_texcoord * _Mask_ST.xy + _Mask_ST.zw;
			float4 tex2DNode2 = tex2D( _Mask, uv_Mask );
			float4 lerpResult16 = lerp( _BaseColor , _Color1 , tex2DNode2.g);
			float4 lerpResult20 = lerp( lerpResult16 , _Color2 , tex2DNode2.b);
			o.Albedo = lerpResult20.rgb;
			float2 uv_Emmissive = i.uv_texcoord * _Emmissive_ST.xy + _Emmissive_ST.zw;
			float4 tex2DNode11 = tex2D( _Emmissive, uv_Emmissive );
			o.Emission = ( lerp(tex2DNode11.r,tex2DNode11.g,_EmissiveType) * _EmmissiveColor ).rgb;
			o.Specular = ( tex2DNode2.r * _SpecularColor ).rgb;
			o.Smoothness = _Gloss;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=14001
1927;-84;1266;988;1566.729;500.35;1.668604;True;True
Node;AmplifyShaderEditor.SamplerNode;2;-931.762,-435.4148;Float;True;Property;_Mask;Mask;0;0;Assets/Mass Effect/Environments/Citadel/Textures/LD_Hardsurfaces_Sheet01.tga;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;11;-917.0179,699.5698;Float;True;Property;_Emmissive;Emmissive;7;0;Assets/Mass Effect/Environments/Citadel/Textures/LD_Hardsurfaces_Sheet01_Emis.tga;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;17;-842.2947,-83.6637;Float;False;Property;_Color1;Color 1;2;0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;10;-842.9512,-247.7516;Float;False;Property;_BaseColor;Base Color;1;0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ToggleSwitchNode;15;-617.9373,695.05;Float;False;Property;_EmissiveType;Emissive Type;8;0;0;2;0;FLOAT;0.0;False;1;FLOAT;0.0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;13;-818.874,891.608;Float;False;Property;_EmmissiveColor;Emmissive Color;9;1;[HDR];0,0,0,0;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;6;-856.2886,249.2899;Float;False;Property;_SpecularColor;Specular Color;4;0;0.5019608,0.5019608,0.5019608,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ColorNode;18;-840.8125,83.0524;Float;False;Property;_Color2;Color 2;3;0;1,1,1,1;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;16;-542.8793,-309.7181;Float;False;3;0;COLOR;0.0;False;1;COLOR;0.0,0,0,0;False;2;FLOAT;0.0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;12;-335.874,731.6082;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.SamplerNode;3;-915.8768,501.3517;Float;True;Property;_Norm;Norm;6;1;[Normal];Assets/Mass Effect/Environments/Citadel/Textures/LD_Hardsurfaces_Norm.tga;True;0;True;bump;Auto;True;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0.0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1.0;False;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;5;-901.2886,422.2897;Float;False;Property;_Gloss;Gloss;5;0;1;0;1;0;1;FLOAT;0
Node;AmplifyShaderEditor.LerpOp;20;-370.7954,-223.8294;Float;False;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0,0,0,0;False;1;COLOR;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;-328.8127,47.87353;Float;False;2;2;0;FLOAT;0.0;False;1;COLOR;0;False;1;COLOR;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;0,0;Float;False;True;2;Float;ASEMaterialInspector;0;0;StandardSpecular;KorroShaders/LD_Surfaces;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Back;0;0;False;0;0;Opaque;0.5;True;True;0;False;Opaque;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;False;0;255;255;0;0;0;0;0;0;0;0;False;2;15;10;25;False;0.5;True;0;Zero;Zero;0;Zero;Zero;OFF;OFF;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;0;0;False;0;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT3;0,0,0;False;4;FLOAT;0.0;False;5;FLOAT;0.0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0.0;False;9;FLOAT;0.0;False;10;FLOAT;0.0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;11;1
WireConnection;15;1;11;2
WireConnection;16;0;10;0
WireConnection;16;1;17;0
WireConnection;16;2;2;2
WireConnection;12;0;15;0
WireConnection;12;1;13;0
WireConnection;20;0;16;0
WireConnection;20;1;18;0
WireConnection;20;2;2;3
WireConnection;4;0;2;1
WireConnection;4;1;6;0
WireConnection;0;0;20;0
WireConnection;0;1;3;0
WireConnection;0;2;12;0
WireConnection;0;3;4;0
WireConnection;0;4;5;0
ASEEND*/
//CHKSM=FAD2F4562DC294A70998F01F482650B02D0AB724