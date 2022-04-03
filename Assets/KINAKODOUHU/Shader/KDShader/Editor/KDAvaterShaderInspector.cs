//KDAvaterShadersInspector.cs for KDAvaterShaders v.1.1.00
//https://github.com/oki75/KDAvaterShaders          
         
using System;
using UnityEditor;
using UnityEngine;
using UnityEngine.Rendering;
using System.Collections;
using System.Linq;

namespace KD
{
    
    public class KDAvaterShadersInspector : ShaderGUI
    {
        public enum _KDS_Technique
        {
            MultiPassUnlit, NoOutline
        }

        public enum _CullMode
        {
            CullingOff, FrontCulling, BackCulling
        }
        public enum BlendMode
        {
        Opaque,
        Cutout,
        Transparent,
        StencilMack,
        StencilOut
        }

        //Button
        public GUILayoutOption[] shortButtonStyle = new GUILayoutOption[] { GUILayout.Width(130) };
        public GUILayoutOption[] middleButtonStyle = new GUILayoutOption[] { GUILayout.Width(130) };




        //setting

       static float _kdsVerX = 1;
       static float _kdsVerY = 1;
       static float _kdsVerZ = 00;

        static int _StencilRefReference_Setting;

        static bool _OriginalInspector = false;


        //Foldout
        static bool _Clipping_Foldout = false;
        static bool _StepAndFeather_Foldout = false;
        static bool _EyeLens_Foldout = false;
        static bool _NormalMap_Foldout = false;
        static bool _ParallaxMap_Foldout = false;
        static bool _HighColor_Foldout = true;
        static bool _RimLight_Foldout = true;
        static bool _MatCap_Foldout = true;
        static bool _Emissive_Foldout = true;
        static bool _Outline_Foldout = true;
        static bool _AdvancedSettings_Foldout = false;

        // -----------------------------------------------------
        //Change Shader
         static Shader KDAvaterShaders = Shader.Find("KDShader/KDAvaterShaders");
      
         static Shader KDAvaterShaders_NoOutline = Shader.Find("Hidden/KDShader/KDAvaterShaders_NoOutline");
         

        // -----------------------------------------------------
        //USE_UI
        #region Material Properties
        MaterialProperty clippingMask = null;
        MaterialProperty clipping_Level = null;
        MaterialProperty tweak_transparency = null;
        MaterialProperty Inverse_Clipping = null;
        MaterialProperty mainTex = null;
        MaterialProperty decalMap = null;
        MaterialProperty decal_Toggle = null;
        MaterialProperty baseColor = null;
        MaterialProperty firstShadeMap = null;
        MaterialProperty firstShadeColor = null;
        MaterialProperty fixShadeMap = null;
        MaterialProperty fixShadeColorMap = null;
        MaterialProperty fixShadeColor = null;
        MaterialProperty secondShadeMap = null;
        MaterialProperty secondShadeColor = null;  
        MaterialProperty EyeBase = null;
        MaterialProperty BlendAddEyeBase = null;
        MaterialProperty EyeHiAndLimbus = null;
        MaterialProperty EyeHi_Toggle = null;
        MaterialProperty EyeHi2_Blend = null;
        MaterialProperty EyeHiAndLimbusMirrorON = null;
        MaterialProperty LimbusColor = null;
        MaterialProperty EyeHiColor = null;
        MaterialProperty EyeHi2Color = null;
        MaterialProperty LimbusTilling = null;
        MaterialProperty Limbus_Scale =null;
        MaterialProperty LimbusOffsetX = null;
        MaterialProperty LimbusOffsetY = null;
        MaterialProperty LimbusAdjustMirror = null;
        MaterialProperty Limbus_BlurStep = null;
        MaterialProperty Limbus_BlurFeather = null;
        MaterialProperty EyeHiTilling = null;
        MaterialProperty EyeHi_Scale =null;
        MaterialProperty EyeHiOffsetX = null;
        MaterialProperty EyeHiOffsetY = null;
        MaterialProperty EyeHiAdjustMirror = null;
        MaterialProperty EyeHi_BlurStep = null;
        MaterialProperty EyeHi_BlurFeather = null;
        MaterialProperty EyeHi2Tilling = null;
        MaterialProperty EyeHi2_Scale =null;
        MaterialProperty EyeHi2OffsetX = null;
        MaterialProperty EyeHi2OffsetY = null;
        MaterialProperty EyeHi2AdjustMirror = null;
        MaterialProperty EyeHi2_BlurStep = null;
        MaterialProperty EyeHi2_BlurFeather = null;

        MaterialProperty normalMap = null;
        MaterialProperty detailMap = null;
        MaterialProperty bumpScale = null;
        MaterialProperty detailScale = null;
        MaterialProperty tweak_FixShadeMapLevel = null;
        
        //HighColorBlurShadow
        MaterialProperty HighColorBlurShadow = null;
        MaterialProperty BlurLevel = null;
        MaterialProperty Tweak_HighColorBlurShadowLevel = null;
        MaterialProperty use_BaseAs1st = null;
        MaterialProperty use_BaseAs2nd = null;
        MaterialProperty baseColor_Step = null;
        MaterialProperty baseShade_Feather = null;
        MaterialProperty shadeColor_Step = null;
        MaterialProperty first2nd_Shades_Feather = null;

        MaterialProperty RGB_mask = null;
//
        MaterialProperty parallax = null;
    
        MaterialProperty fixShadeParallax = null;
        MaterialProperty parallaxMap = null;
        MaterialProperty parallaxScale = null;
//HighColor
        MaterialProperty highColor = null;
        MaterialProperty AnisotropicMask = null;
        MaterialProperty aniso_offset = null;
        MaterialProperty Anisotropic_highlight_Toggle = null;
        MaterialProperty Anisotropic_TangentNormal_Toggle = null;

        MaterialProperty dubleHighColor_Toggle =null;
        MaterialProperty HighColor_Ratio =null;

        MaterialProperty HighColorHue = null;

        MaterialProperty HighColorSaturation = null;
        
       

        MaterialProperty shininess = null;
        MaterialProperty HighColorMask = null;
        MaterialProperty tweak_HighColorMaskLevel = null;

        MaterialProperty rimLightColor = null;
        MaterialProperty rimLight_Power = null;
        MaterialProperty tweak_RimLightMaskLevel = null;

        MaterialProperty matCap_Sampler = null;
        MaterialProperty matCapColor = null;
        MaterialProperty tweak_MatcapMaskLevel = null;

        MaterialProperty emissive_Tex = null;
        MaterialProperty emissive_Color = null;
        MaterialProperty tweak_MatcapEmission_Level = null;
        MaterialProperty outline_Width = null;
        MaterialProperty outline_Color = null;
        MaterialProperty outlineTex = null;
        MaterialProperty BlendShadowColor = null;
        MaterialProperty Is_LightColor_Outline = null;

        MaterialProperty unlit_Intensity = null;
        MaterialProperty offset_X_Axis_BLD = null;
        MaterialProperty offset_Y_Axis_BLD = null;
        MaterialProperty offset_Z_Axis_BLD = null;
        MaterialProperty CullMode = null;
        MaterialProperty AmbientMax = null;
        MaterialProperty AmbientMinimum = null;

        MaterialProperty renderMode = null;
        MaterialProperty KDASType =null;
       
        #endregion

        MaterialEditor m_MaterialEditor;     

        // -----------------------------------------------------

        //USE_UI
        public void FindProperties(MaterialProperty[] props)
        {
            //false=defaultOFF
            
            KDASType =           FindProperty("_KDASType",props, false);

            renderMode =         FindProperty("_RenderMode",props);

            clippingMask =       FindProperty("_ClippingMask", props, false);
            clipping_Level =     FindProperty("_Clipping_Level", props, false);
            tweak_transparency = FindProperty("_Tweak_transparency", props, false);
            Inverse_Clipping =   FindProperty("_Inverse_Clipping", props, false);

            decalMap =           FindProperty("_DecalMap", props);
            decal_Toggle =       FindProperty("_Decal_Toggle", props);
            mainTex =            FindProperty("_MainTex", props);
            baseColor =          FindProperty("_BaseColor", props);
            firstShadeMap =      FindProperty("_1st_ShadeMap", props);
            firstShadeColor =    FindProperty("_1st_ShadeColor", props);
            secondShadeMap =     FindProperty("_2nd_ShadeMap", props);
            secondShadeColor =   FindProperty("_2nd_ShadeColor", props);
            fixShadeMap =            FindProperty("_FixShadeMap", props);
            tweak_FixShadeMapLevel = FindProperty("_Tweak_FixShadeMapLevel", props);
            fixShadeColorMap =       FindProperty("_FixShadeColorMap", props);
            fixShadeColor =          FindProperty("_FixShadeColor", props);
            use_BaseAs1st =          FindProperty("_Use_BaseAs1st", props);
            use_BaseAs2nd =          FindProperty("_Use_BaseAs2nd", props);

            normalMap =          FindProperty("_NormalMap", props);
            bumpScale =          FindProperty("_BumpScale", props);
            detailMap =          FindProperty("_NormalMap2", props);
            detailScale =        FindProperty("_BumpScale2", props);

            baseColor_Step =          FindProperty("_BaseColor_Step", props);
            baseShade_Feather =       FindProperty("_BaseShade_Feather", props);
            shadeColor_Step =         FindProperty("_ShadeColor_Step", props);
            first2nd_Shades_Feather = FindProperty("_1st2nd_Shades_Feather", props);
           //EyeLens
            EyeBase =         FindProperty("_EyeBase", props);
            BlendAddEyeBase = FindProperty("_BlendAddEyeBase", props);
            EyeHiAndLimbus = FindProperty("_EyeHiAndLimbus", props);
            EyeHi_Toggle =   FindProperty("_EyeHi_Toggle", props);
            EyeHi2_Blend =   FindProperty("_EyeHi2_Blend", props);
            EyeHiAndLimbusMirrorON =FindProperty("_EyeHiAndLimbusMirrorON", props);
            LimbusColor =           FindProperty("_LimbusColor",props);
            EyeHiColor =            FindProperty("_EyeHiColor", props);
            EyeHi2Color =           FindProperty("_EyeHi2Color", props);
            LimbusTilling =         FindProperty("_LimbusTilling", props);
            Limbus_Scale =         FindProperty("_Limbus_Scale", props);
            LimbusOffsetX =         FindProperty("_LimbusOffsetX", props);
            LimbusOffsetY =         FindProperty("_LimbusOffsetY", props);
            LimbusAdjustMirror =         FindProperty("_LimbusAdjustMirror", props);
            Limbus_BlurStep =         FindProperty("_Limbus_BlurStep", props);
            Limbus_BlurFeather =         FindProperty("_Limbus_BlurFeather", props);
            EyeHiTilling =          FindProperty("_EyeHiTilling",props);
            EyeHi_Scale =          FindProperty("_EyeHi_Scale",props);
            EyeHiOffsetX =         FindProperty("_EyeHiOffsetX", props);
            EyeHiOffsetY =         FindProperty("_EyeHiOffsetY", props);
            EyeHiAdjustMirror =         FindProperty("_EyeHiAdjustMirror", props);
            EyeHi_BlurStep =            FindProperty("_EyeHi_BlurStep", props);
            EyeHi_BlurFeather =            FindProperty("_EyeHi_BlurFeather", props);
            EyeHi2Tilling =          FindProperty("_EyeHi2Tilling",props);
            EyeHi2_Scale =          FindProperty("_EyeHi2_Scale",props);
            EyeHi2OffsetX =         FindProperty("_EyeHi2OffsetX", props);
            EyeHi2OffsetY =         FindProperty("_EyeHi2OffsetY", props);
            EyeHi2AdjustMirror =         FindProperty("_EyeHi2AdjustMirror", props);
            EyeHi2_BlurStep =            FindProperty("_EyeHi2_BlurStep", props);
            EyeHi2_BlurFeather =            FindProperty("_EyeHi2_BlurFeather", props);
  
            RGB_mask = FindProperty("_RGB_mask", props);

            parallax =    FindProperty("_Parallax", props);
            fixShadeParallax =  FindProperty("_FixShadeParallax", props);
            parallaxMap =       FindProperty("_ParallaxMap", props);
            parallaxScale =     FindProperty("_ParallaxScale", props);
           //HighColor
            highColor =                         FindProperty("_HighColor", props);
            shininess =                   FindProperty("_Shininess", props);
            HighColorMask =                 FindProperty("_Set_HighColorMask", props);
            AnisotropicMask =                   FindProperty("_Set_AnisotropicMask", props);
            Anisotropic_highlight_Toggle =     FindProperty("_Anisotropic_highlight_Toggle", props);
            Anisotropic_TangentNormal_Toggle = FindProperty("_Anisotropic_TangentNormal_Toggle", props);
  
            dubleHighColor_Toggle =            FindProperty("_DubleHighColor_Toggle",props);
            aniso_offset =                      FindProperty("_aniso_offset", props);
            HighColorHue =                       FindProperty("_HighColorHue", props);
            HighColorSaturation =                FindProperty("_HighColorSaturation",props);
            HighColor_Ratio =                    FindProperty("_HighColor_Ratio",props);

            HighColorBlurShadow =                FindProperty("_HighColorBlurShadow",props);
            BlurLevel =                          FindProperty("_BlurLevel",props);
            Tweak_HighColorBlurShadowLevel =     FindProperty("_Tweak_HighColorBlurShadowLevel", props);
            tweak_HighColorMaskLevel =          FindProperty("_Tweak_HighColorMaskLevel", props);

            rimLightColor = FindProperty("_RimLightColor", props);
            rimLight_Power = FindProperty("_RimLight_Power", props);
            tweak_RimLightMaskLevel = FindProperty("_Tweak_RimLightMaskLevel", props);

            matCap_Sampler = FindProperty("_MatCap_Sampler", props);
            matCapColor = FindProperty("_MatCapColor", props);
            tweak_MatcapMaskLevel = FindProperty("_Tweak_MatcapMaskLevel", props);

            emissive_Tex = FindProperty("_Emissive_Tex", props);
            emissive_Color = FindProperty("_Emissive_Color", props);
            tweak_MatcapEmission_Level = FindProperty("_Tweak_Matcap_Emission_Level", props);

            outline_Width = FindProperty("_Outline_Width", props, false);
            outline_Color = FindProperty("_Outline_Color", props, false);
            outlineTex = FindProperty("_OutlineTex", props, false);
            BlendShadowColor = FindProperty("_BlendShadowColor", props, false);
            Is_LightColor_Outline = FindProperty("_Is_LightColor_Outline",props, false);

            unlit_Intensity = FindProperty("_Unlit_Intensity", props, false);
            offset_X_Axis_BLD = FindProperty("_Offset_X_Axis_BLD", props, false);
            offset_Y_Axis_BLD = FindProperty("_Offset_Y_Axis_BLD", props, false);
            offset_Z_Axis_BLD = FindProperty("_Offset_Z_Axis_BLD", props, false);
            CullMode = FindProperty("_CullMode", props);
            AmbientMax = FindProperty("_AmbientMax", props);
            AmbientMinimum = FindProperty("_AmbientMinimum", props);

           
        }
        // --------------------------------
        
        // --------------------------------
        //    static void Line()
        //{
        //    GUILayout.Box("", GUILayout.ExpandWidth(true), GUILayout.Height(1));
        //}

        static bool Foldout(bool display, string title)
        {
            var style = new GUIStyle("ShurikenModuleTitle");
            style.font = new GUIStyle(EditorStyles.boldLabel).font;
            style.border = new RectOffset(15, 7, 4, 4);
            style.fixedHeight = 22;
            style.contentOffset = new Vector2(20f, -2f);

            var rect = GUILayoutUtility.GetRect(16f, 22f, style);
            GUI.Box(rect, title, style);

            var e = Event.current;

            var toggleRect = new Rect(rect.x + 4f, rect.y + 2f, 13f, 13f);
            if (e.type == EventType.Repaint)
            {
                EditorStyles.foldout.Draw(toggleRect, false, false, display, false);
            }

            if (e.type == EventType.MouseDown && rect.Contains(e.mousePosition))
            {
                display = !display;
                e.Use();
            }

            return display;
        }
    

        // --------------------------------
        //USE_UI Text(Tex&color)
        private static class Styles
        {
            public static GUIContent EyeBaseText = new GUIContent("EyeBase", "EyeBase : Texture(sRGBA)");
            public static GUIContent decalMapText = new GUIContent("DecalMap", "DecalMap : Texture(sRGBA)");
            public static GUIContent baseColorText = new GUIContent("BaseMap", "Base Color : Texture(sRGB) × Color(RGB) Default:White");
            public static GUIContent firstShadeColorText = new GUIContent("1st ShadeMap", "1st ShadeColor : Texture(sRGB) × Color(RGB) Default:White");
            public static GUIContent secondShadeColorText = new GUIContent("2nd ShadeMap", "2nd ShadeColor : Texture(sRGB) × Color(RGB) Default:White");
            public static GUIContent fixShadeText = new GUIContent("FixShadeMap", "FixShade: Texture(Liner) ");
            public static GUIContent fixShadeColorText = new GUIContent("FixShadeColorMap", "FixShadeColor: Texture(sRGB) × Color(RGB) Default:White");
            public static GUIContent normalMapText = new GUIContent("NormalMap", "NormalMap : Texture(bump)");
            public static GUIContent normalMap2Text = new GUIContent("DetailMap", "DetailMap : Texture(bump)");
            public static GUIContent RGBmaskText = new GUIContent("RGBmask", "RGBmask:Texture(Liner)R= RimLight + G=Matcap + B=Outline Default:Black");
            public static GUIContent parallaxMapText = new GUIContent("ParallaxMap", "ParallaxMap:Texture(Liner)R= parallaxHight + G= parallaxMask + B=none Default:Black");
            public static GUIContent highColorMaskText = new GUIContent("HighColor Mask", "HighColor Mask : Texture(linear)× Color(RGB) Default:Black");
            public static GUIContent anisohilghtMaskText = new GUIContent("AnisoHigh Mask", "AnisoHigh Mask : Texture(linear)× Color(RGB) Default:Black");
            public static GUIContent rimLightMaskText = new GUIContent("RimLight Mask", "RimLight Mask : Texture(linear)");
            public static GUIContent matCapSamplerText = new GUIContent("MatCap Sampler", "MatCap Sampler : Texture(sRGB) × Color(HDR) Default:White");
            public static GUIContent matCapMaskText = new GUIContent("MatCap Mask", "MatCap Mask : Texture(linear)");
            public static GUIContent emissiveTexText = new GUIContent("Emissive", "Emissive : Texture(sRGB)× Color(HDR) Default:Black");
            public static GUIContent outlineSamplerText = new GUIContent("Outline Sampler", "Outline Sampler : Texture(linear)");
            public static GUIContent outlineTexText = new GUIContent("Outline tex", "Outline Tex : Texture(sRGB) Default:White");           
            public static GUIContent clippingMaskText = new GUIContent("Clipping Mask", "Clipping Mask : Texture(linear)");

        }
        // --------------------------------

        public override void OnGUI(MaterialEditor materialEditor, MaterialProperty[] props)
        {
            EditorGUIUtility.fieldWidth = 0;
            FindProperties(props);
            m_MaterialEditor = materialEditor;
            Material material = materialEditor.target as Material;



            //One line side by side button
            EditorGUILayout.BeginHorizontal();



            //Original/Custom GUI
            if (_OriginalInspector)
            {
                if (GUILayout.Button("Change CustomUI", middleButtonStyle))
                {
                    _OriginalInspector = false;

                }

                //Clear inherited layout
                EditorGUILayout.EndHorizontal();
                //OriginalGUI_ON
                m_MaterialEditor.PropertiesDefaultGUI(props);
                return;
            }
            if (GUILayout.Button("Show All properties", middleButtonStyle))
            {
                _OriginalInspector = true;

            }

            EditorGUILayout.EndHorizontal();

            EditorGUI.BeginChangeCheck();

            EditorGUILayout.Space();

            if (material.HasProperty("_ClippingMask"))
            {
                _Clipping_Foldout = Foldout(_Clipping_Foldout, "Clipping Settings");
                if (_Clipping_Foldout)
                {
                    EditorGUI.indentLevel++;
                    EditorGUILayout.Space();

                    if (material.HasProperty("_StencilRef"))
                    {
                        GUI_SetStencilNo(material);
                    }
                    GUI_SetClippingMask(material);
                    GUI_SetTransparencySetting(material);
                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.Space();
            }

            
               

            
        
            EditorGUILayout.Space();

        var blendMode = renderMode;
        var mode = (BlendMode) blendMode.floatValue;

        using (var scope = new EditorGUI.ChangeCheckScope())
        {
            mode = (BlendMode) EditorGUILayout.Popup("RenderMode", (int) mode, Enum.GetNames(typeof(BlendMode)));

            if (scope.changed)
            {
                blendMode.floatValue = (float) mode;
                foreach (UnityEngine.Object obj in blendMode.targets)
                {
                    SetBlendMode(obj as Material, mode);
                }
            }
        }
            
            
            
            
            
            
            // Main



            EditorGUILayout.LabelField("Main", EditorStyles.boldLabel);

            EditorGUILayout.BeginHorizontal();

            m_MaterialEditor.TexturePropertySingleLine(Styles.decalMapText, decalMap);


            if (material.GetFloat("_Decal_Toggle") == 0)
            {
                if (GUILayout.Button("No Decal", middleButtonStyle))
                {
                    material.SetFloat("_Decal_Toggle", 1);
                }
            }
            else
            {
                if (GUILayout.Button("Use Decal", middleButtonStyle))
                {
                    material.SetFloat("_Decal_Toggle", 0);
                }
            }
            GUILayout.Space(60);

            EditorGUILayout.EndHorizontal();




            m_MaterialEditor.TexturePropertySingleLine(Styles.baseColorText, mainTex, baseColor);

            EditorGUILayout.BeginHorizontal();

            m_MaterialEditor.TexturePropertySingleLine(Styles.firstShadeColorText, firstShadeMap, firstShadeColor);

            if (material.GetFloat("_Use_BaseAs1st") == 0)
            {
                if (GUILayout.Button("No Sharing", middleButtonStyle))
                {
                    material.SetFloat("_Use_BaseAs1st", 1);
                }
            }
            else
            {
                if (GUILayout.Button("Use BaseAs1st", middleButtonStyle))
                {
                    material.SetFloat("_Use_BaseAs1st", 0);
                }
            }
            GUILayout.Space(60);

            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            m_MaterialEditor.TexturePropertySingleLine(Styles.secondShadeColorText, secondShadeMap, secondShadeColor);

           

            if (material.GetFloat("_Use_BaseAs2nd") == 0)
            {
                if (GUILayout.Button("No Sharing", middleButtonStyle))
                {
                    material.SetFloat("_Use_BaseAs2nd", 1);
                }
            }
            else
            {
                if (GUILayout.Button("Use BaseAs2nd", middleButtonStyle))
                {
                    material.SetFloat("_Use_BaseAs2nd", 0);
                }
            }
            GUILayout.Space(60);

            EditorGUILayout.EndHorizontal();

            EditorGUILayout.LabelField("FixShade", EditorStyles.boldLabel);

             EditorGUILayout.BeginHorizontal();
             
             EditorGUILayout.PrefixLabel("HighColorBlurShadow");

             if (material.GetFloat("_HighColorBlurShadow") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_HighColorBlurShadow", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_HighColorBlurShadow", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();
                 
                 if (material.GetFloat("_HighColorBlurShadow") == 1)
                {
                    EditorGUI.indentLevel++;
                     m_MaterialEditor.RangeProperty(BlurLevel , "BlurLevel");
                     m_MaterialEditor.RangeProperty(Tweak_HighColorBlurShadowLevel ,"ShadowLevel");
                    EditorGUI.indentLevel--;
                }
               

               
           
            m_MaterialEditor.TexturePropertySingleLine(Styles.fixShadeText, fixShadeMap, tweak_FixShadeMapLevel);

            EditorGUILayout.BeginHorizontal();

            m_MaterialEditor.TexturePropertySingleLine(Styles.fixShadeColorText, fixShadeColorMap, fixShadeColor);

            if (material.GetFloat("_Use_BaseAsFix") == 0)
            {
                if (GUILayout.Button("No Sharing", middleButtonStyle))
                {
                    material.SetFloat("_Use_BaseAsFix", 1);
                }
            }
            else
            {
                if (GUILayout.Button("Use BaseAsFix", middleButtonStyle))
                {
                    material.SetFloat("_Use_BaseAsFix", 0);
                }
            }
            GUILayout.Space(60);

            EditorGUILayout.EndHorizontal();


            EditorGUILayout.LabelField("RGB Mask R= RimLight  G=Matcap  B=Outline", EditorStyles.boldLabel);

            m_MaterialEditor.TexturePropertySingleLine(Styles.RGBmaskText, RGB_mask);


            // NormalMap Settings
            _NormalMap_Foldout = Foldout(_NormalMap_Foldout, "NormalMap Settings");
            if (_NormalMap_Foldout)
            {
                
               
                m_MaterialEditor.TexturePropertySingleLine(Styles.normalMapText, normalMap, bumpScale);

                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel("Detail Blend");
               
                if (material.GetFloat("_DetailBlend") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_DetailBlend", 1);
                        material.EnableKeyword("_DETAILBLEND_ON");
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_DetailBlend", 0);
                        material.DisableKeyword("_DETAILBLEND_ON");

                    }
                }
                EditorGUILayout.EndHorizontal();
                 if (material.GetFloat("_DetailBlend") == 1)
            {
                m_MaterialEditor.TexturePropertySingleLine(Styles.normalMap2Text, detailMap, detailScale);
            }
                GUILayout.Label("NormalMap Effectiveness", EditorStyles.boldLabel);
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel("Shade Colors");
               
                if (material.GetFloat("_ShadeNormal") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_ShadeNormal", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_ShadeNormal", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel("HighColor");
               
                if (material.GetFloat("_Is_NormalMapToHighColor") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_Is_NormalMapToHighColor", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_Is_NormalMapToHighColor", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();

                EditorGUILayout.BeginHorizontal();

                EditorGUILayout.PrefixLabel("RimLight");

                
                if (material.GetFloat("_Is_NormalMapToRimLight") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_Is_NormalMapToRimLight", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_Is_NormalMapToRimLight", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();

               
                EditorGUILayout.Space();
            
        }

            EditorGUILayout.Space();

            _StepAndFeather_Foldout = Foldout(_StepAndFeather_Foldout, "Shading Step and Feather Settings");
            if (_StepAndFeather_Foldout)
            {
                EditorGUI.indentLevel++;
                m_MaterialEditor.RangeProperty(baseColor_Step, "BaseColor Step");
                m_MaterialEditor.RangeProperty(baseShade_Feather, "Base/Shade Feather");
                m_MaterialEditor.RangeProperty(shadeColor_Step, "ShadeColor Step");
                m_MaterialEditor.RangeProperty(first2nd_Shades_Feather, "1st/2nd_Shades Feather");
                EditorGUI.indentLevel--;
            }

            EditorGUILayout.Space();
//EyeLens
             _EyeLens_Foldout = Foldout(_EyeLens_Foldout, "Limbus and EyeHi Settings");
            if (_EyeLens_Foldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.Space();
                GUI_EyeLens(material);
                EditorGUI.indentLevel--;
            }

            EditorGUILayout.Space();

            _ParallaxMap_Foldout = Foldout(_ParallaxMap_Foldout, "Parallax Settings");
            if (_ParallaxMap_Foldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.Space();
                GUI_Parallax(material);
                EditorGUI.indentLevel--;
            }

            EditorGUILayout.Space();

            _HighColor_Foldout = Foldout(_HighColor_Foldout, "HighColor Settings");
            if (_HighColor_Foldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.Space();
                GUI_HighColor(material);
                EditorGUI.indentLevel--;
            }

            EditorGUILayout.Space();

            _RimLight_Foldout = Foldout(_RimLight_Foldout, "RimLight Settings");
            if (_RimLight_Foldout)
            {

                EditorGUI.indentLevel++;
                EditorGUILayout.Space();
                GUI_RimLight(material);
                EditorGUI.indentLevel--;
            }


            EditorGUILayout.Space();

            _MatCap_Foldout = Foldout(_MatCap_Foldout, "MatCap Settings");
            if (_MatCap_Foldout)
            {
                EditorGUI.indentLevel++;
                EditorGUILayout.Space();
                GUI_MatCap(material);
                EditorGUI.indentLevel--;
            }
            EditorGUILayout.Space();

            _Emissive_Foldout = Foldout(_Emissive_Foldout, "Emissive Settings");
            if (_Emissive_Foldout)
            {
                EditorGUI.indentLevel++;
                
                GUI_Emissive(material);
                EditorGUI.indentLevel--;
            }

            EditorGUILayout.Space();

          
            
                _Outline_Foldout = Foldout(_Outline_Foldout, "Outline Settings");
                if (_Outline_Foldout)
                {
                    EditorGUI.indentLevel++;
                    EditorGUILayout.Space();
                    GUI_Outline(material);
                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.Space();
            
            // Advanced Settings
            _AdvancedSettings_Foldout = Foldout(_AdvancedSettings_Foldout, "Advanced Settings");
            if (_AdvancedSettings_Foldout)
            {
                EditorGUILayout.BeginHorizontal();
             
                EditorGUI.indentLevel++;

                EditorGUILayout.PrefixLabel("Built-in Light Direction");

                if (material.GetFloat("_Is_BLD") == 0)
                {
                    if (GUILayout.Button("Off", middleButtonStyle))
                    {
                        material.SetFloat("_Is_BLD", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", middleButtonStyle))
                    {
                        material.SetFloat("_Is_BLD", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();
              
                if (material.GetFloat("_Is_BLD") == 1)
                {
                    GUILayout.Label("    Built-in Light Direction Settings");
                    EditorGUI.indentLevel++;
                    m_MaterialEditor.RangeProperty(offset_X_Axis_BLD, " Offset X-Axis");
                    m_MaterialEditor.RangeProperty(offset_Y_Axis_BLD, " Offset Y-Axis");
                    m_MaterialEditor.RangeProperty(offset_Z_Axis_BLD, " Offset Z-Axis");
                    EditorGUI.indentLevel--;
                }
                EditorGUILayout.Space();
                m_MaterialEditor.ShaderProperty(unlit_Intensity, "Unlit_Intensity");
                m_MaterialEditor.ShaderProperty(AmbientMax, "AmbientMix");
                m_MaterialEditor.ShaderProperty(AmbientMinimum, "AmbientMinimum");
                EditorGUILayout.Space();
                m_MaterialEditor.ShaderProperty(CullMode, "CullMode");
              

                EditorGUI.indentLevel--;
               
            }
            if (EditorGUI.EndChangeCheck())
            {
                m_MaterialEditor.PropertiesChanged();
            }

            EditorGUILayout.BeginHorizontal();
            GUILayout.FlexibleSpace();
        //Var
        
            GUILayout.Label("KD AvaterShaders"+" v."+_kdsVerX +"." + _kdsVerY+"."+_kdsVerZ  , EditorStyles.boldLabel);
            EditorGUILayout.EndHorizontal();

        }// End of OnGUI()

        //------------------------------------

        void GUI_SetStencilNo(Material material)
        {
            GUILayout.Label("For StencilRefMask or _StencilRefOut Shader", EditorStyles.boldLabel);
            _StencilRefReference_Setting = material.GetInt("_StencilRef");
            int _Current_StencilRefReference = _StencilRefReference_Setting;
            _Current_StencilRefReference = (int)EditorGUILayout.IntField("Stencil No.", _Current_StencilRefReference);
            if (_StencilRefReference_Setting != _Current_StencilRefReference)
            {
                material.SetInt("_StencilRef", _Current_StencilRefReference);
            }
        }

        void GUI_SetClippingMask(Material material)
        {
            GUILayout.Label("For _Clipping or _TransClipping Shader", EditorStyles.boldLabel);
            m_MaterialEditor.TexturePropertySingleLine(Styles.clippingMaskText, clippingMask);

            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel("Inverse Clipping Mask");
            
            if (material.GetFloat("_Inverse_Clipping") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_Inverse_Clipping", 1);
                }
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_Inverse_Clipping", 0);
                }
            }
            EditorGUILayout.EndHorizontal();

            m_MaterialEditor.RangeProperty(clipping_Level, "Clipping Level");
        }


        void GUI_SetTransparencySetting(Material material)
        {

            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel("Use DecalMap α as Clipping Mask");

            if (material.GetFloat("_Use_Decal_alpha") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_Use_Decal_alpha", 1);
                }
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_Use_Decal_alpha", 0);
                }
            }
            EditorGUILayout.EndHorizontal();

            GUILayout.Label("For _TransClipping Shader", EditorStyles.boldLabel);
            m_MaterialEditor.RangeProperty(tweak_transparency, "Transparency Level");

            
        }
//
         void GUI_EyeLens(Material material)
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel("EyeLens");

            if (material.GetFloat("_EyeHiAndLimbus") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_EyeHiAndLimbus", 1);
                    material.EnableKeyword("_EYEHIANDLIMBUS_ON");
                }
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_EyeHiAndLimbus", 0);
                     material.DisableKeyword("_EYEHIANDLIMBUS_ON");
                }
            }
            EditorGUILayout.EndHorizontal();
             
            

            if (material.GetFloat("_EyeHiAndLimbus") == 1)
            {

                EditorGUI.indentLevel++;
                EditorGUILayout.BeginHorizontal();

                m_MaterialEditor.TexturePropertySingleLine(Styles.EyeBaseText, EyeBase);

                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();

                EditorGUILayout.PrefixLabel("BlendAddEyeBase");

                if (material.GetFloat("_BlendAddEyeBase") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_BlendAddEyeBase", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_BlendAddEyeBase", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel("EyeHi");

                if (material.GetFloat("_EyeHi_Toggle") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_EyeHi_Toggle", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_EyeHi_Toggle", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();

                EditorGUILayout.PrefixLabel("EyeHi2_Blend");

                if (material.GetFloat("_EyeHi2_Blend") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_EyeHi2_Blend", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_EyeHi2_Blend", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();
                EditorGUILayout.BeginHorizontal();

                EditorGUILayout.PrefixLabel("EyeHiAndLimbusMirrorON");

                if (material.GetFloat("_EyeHiAndLimbusMirrorON") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_EyeHiAndLimbusMirrorON", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_EyeHiAndLimbusMirrorON", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();

                m_MaterialEditor.ColorProperty(LimbusColor, "LimbusColor");
                m_MaterialEditor.ColorProperty(EyeHiColor, "EyeHiColor");
                m_MaterialEditor.ColorProperty(EyeHi2Color, "EyeHi2Color");
                m_MaterialEditor.VectorProperty(LimbusTilling, "LimbusTilling");
                m_MaterialEditor.RangeProperty(Limbus_Scale, "Limbus_Scale");
                m_MaterialEditor.RangeProperty(LimbusOffsetX, "LimbusOffsetX");
                m_MaterialEditor.RangeProperty(LimbusOffsetY, "LimbusOffsetY");
                m_MaterialEditor.RangeProperty(LimbusAdjustMirror, "LimbusAdjustMirror");
                m_MaterialEditor.RangeProperty(Limbus_BlurStep, "Limbus_BlurStep");
                m_MaterialEditor.RangeProperty(Limbus_BlurFeather, "Limbus_BlurFeather");

                m_MaterialEditor.VectorProperty(EyeHiTilling, "EyeHiTilling");
                m_MaterialEditor.RangeProperty(EyeHi_Scale, "EyeHi_Scale");
                m_MaterialEditor.RangeProperty(EyeHiOffsetX, "EyeHiOffsetX");
                m_MaterialEditor.RangeProperty(EyeHiOffsetY, "EyeHiOffsetY");
                m_MaterialEditor.RangeProperty(EyeHiAdjustMirror, "EyeHiAdjustMirror");
                m_MaterialEditor.RangeProperty(EyeHi_BlurStep, "EyeHi_BlurStep");
                m_MaterialEditor.RangeProperty(EyeHi_BlurFeather, "EyeHi_BlurFeather");

                m_MaterialEditor.VectorProperty(EyeHi2Tilling, "EyeHi2Tilling");
                m_MaterialEditor.RangeProperty(EyeHi2_Scale, "EyeHi2_Scale");
                m_MaterialEditor.RangeProperty(EyeHi2OffsetX, "EyeHi2OffsetX");
                m_MaterialEditor.RangeProperty(EyeHi2OffsetY, "EyeHi2OffsetY");
                m_MaterialEditor.RangeProperty(EyeHi2AdjustMirror, "EyeHi2AdjustMirror");
                m_MaterialEditor.RangeProperty(EyeHi2_BlurStep, "EyeHi2_BlurStep");
                m_MaterialEditor.RangeProperty(EyeHi2_BlurFeather, "EyeHi2_BlurFeather");


                EditorGUI.indentLevel--;
            }
            EditorGUILayout.Space();
        }
        
        void GUI_Parallax(Material material)
        {
            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel("Parallax");

            if (material.GetFloat("_Parallax") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_Parallax", 1); 
                    material.EnableKeyword("_PARALLAX_ON");

                }
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_Parallax", 0);
                    material.DisableKeyword("_PARALLAX_ON");
                }
            }
            EditorGUILayout.EndHorizontal();

            if (material.GetFloat("_Parallax") == 1)
            {

                EditorGUI.indentLevel++;

                m_MaterialEditor.TexturePropertySingleLine(Styles.parallaxMapText, parallaxMap);

                EditorGUILayout.BeginHorizontal();

                EditorGUILayout.PrefixLabel("Fix Shade Parallax");

                if (material.GetFloat("_FixShadeParallax") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_FixShadeParallax", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_FixShadeParallax", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();

                m_MaterialEditor.RangeProperty(parallaxScale, "Parallax Scale");
                EditorGUI.indentLevel--;
            }
            EditorGUILayout.Space();
        }


        void GUI_HighColor(Material material)
        {
            GUILayout.Label("    HighColor Mask", EditorStyles.boldLabel);

            EditorGUI.indentLevel++;

            m_MaterialEditor.TexturePropertySingleLine(Styles.highColorMaskText, HighColorMask, highColor);

            EditorGUILayout.BeginHorizontal();

            EditorGUILayout.PrefixLabel("Anisotropic HighLight");


            if (material.GetFloat("_Anisotropic_highlight_Toggle") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_Anisotropic_highlight_Toggle", 1);
                }
                EditorGUILayout.EndHorizontal();
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_Anisotropic_highlight_Toggle", 0);
                }
                EditorGUILayout.EndHorizontal();

                m_MaterialEditor.TexturePropertySingleLine(Styles.anisohilghtMaskText, AnisotropicMask);

                EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel("Tangent Normal");

                if (material.GetFloat("_Anisotropic_TangentNormal_Toggle") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_Anisotropic_TangentNormal_Toggle", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_Anisotropic_TangentNormal_Toggle", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();

            m_MaterialEditor.RangeProperty(aniso_offset, "Offset");
            

                EditorGUI.indentLevel--;
            }
            EditorGUILayout.Space();

            EditorGUILayout.BeginHorizontal();
                EditorGUILayout.PrefixLabel("DubleHighColor");

                if (material.GetFloat("_DubleHighColor_Toggle") == 0)
                {
                    if (GUILayout.Button("Off", shortButtonStyle))
                    {
                        material.SetFloat("_DubleHighColor_Toggle", 1);
                    }
                }
                else
                {
                    if (GUILayout.Button("Active", shortButtonStyle))
                    {
                        material.SetFloat("_DubleHighColor_Toggle", 0);
                    }
                }
                EditorGUILayout.EndHorizontal();
            m_MaterialEditor.RangeProperty(HighColorHue,"Hue");
            m_MaterialEditor.RangeProperty(HighColorSaturation,"Saturation"); 
            m_MaterialEditor.RangeProperty(HighColor_Ratio, "HighColor Ratio");  
            m_MaterialEditor.RangeProperty(tweak_HighColorMaskLevel, "HighColor Mask Level");
            m_MaterialEditor.RangeProperty(shininess, "Shininess");
        }

        void GUI_RimLight(Material material)
        {
            GUILayout.Label("    RimLight Settings", EditorStyles.boldLabel);
            m_MaterialEditor.ColorProperty(rimLightColor, "RimLight Color");
            m_MaterialEditor.RangeProperty(rimLight_Power, "RimLight Power");

                   
                    EditorGUILayout.BeginHorizontal();

                    EditorGUILayout.PrefixLabel("LightDirection Mask");

            if (material.GetFloat("_LightDirection_MaskOn") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_LightDirection_MaskOn", 1);
                }

            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_LightDirection_MaskOn", 0);
                }
            }
                
                    EditorGUILayout.EndHorizontal();


                    EditorGUILayout.Space();
            GUILayout.Label("    RimLight Mask", EditorStyles.boldLabel);
            m_MaterialEditor.RangeProperty(tweak_RimLightMaskLevel, "RimLight Mask Level");


                   
            EditorGUI.indentLevel--;
            EditorGUILayout.Space();
        }
               

        void GUI_MatCap(Material material)
        {
           

           
                GUILayout.Label("    MatCap Settings", EditorStyles.boldLabel);
                m_MaterialEditor.TexturePropertySingleLine(Styles.matCapSamplerText, matCap_Sampler, matCapColor);
                EditorGUI.indentLevel++;
                m_MaterialEditor.TextureScaleOffsetProperty(matCap_Sampler);

                EditorGUILayout.Space();


                GUILayout.Label("    MatCap Mask", EditorStyles.boldLabel);
                m_MaterialEditor.RangeProperty(tweak_MatcapMaskLevel, "MatCap Mask Level");
                m_MaterialEditor.RangeProperty(tweak_MatcapEmission_Level, "MatCap Emission Level");

                EditorGUI.indentLevel++;
            


               
           

            
        }
        void GUI_Emissive(Material material)
        {
            GUILayout.Label("   Emissive", EditorStyles.boldLabel);           
            EditorGUILayout.Space();
            m_MaterialEditor.TexturePropertySingleLine(Styles.emissiveTexText, emissive_Tex, emissive_Color);
            m_MaterialEditor.TextureScaleOffsetProperty(emissive_Tex);
            
        }
            
        

        void GUI_Outline(Material material)
        {

            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel("Outline");

            if (material.GetFloat("_KDASType") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_KDASType", 1); 
                    m_MaterialEditor.SetShader(KDAvaterShaders);

                }
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_KDASType", 0);
                    m_MaterialEditor.SetShader(KDAvaterShaders_NoOutline);
                    
                    
                }
            }
            EditorGUILayout.EndHorizontal();

            if (material.GetFloat("_KDASType") == 1)
            {

            m_MaterialEditor.FloatProperty(outline_Width, "Outline Width");
            m_MaterialEditor.ColorProperty(outline_Color, "Outline Color");

            EditorGUILayout.BeginHorizontal();

            EditorGUILayout.PrefixLabel("BlendShadow to Outline");
           
            if (material.GetFloat("_BlendShadowColor") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_BlendShadowColor", 1);
                }
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_BlendShadowColor", 0);
                }
            }
            EditorGUILayout.EndHorizontal();
             EditorGUILayout.BeginHorizontal();

            EditorGUILayout.PrefixLabel("LightColor to Outline");
           
            if (material.GetFloat("_Is_LightColor_Outline") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_Is_LightColor_Outline", 1);
                }
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_Is_LightColor_Outline", 0);
                }
            }
            EditorGUILayout.EndHorizontal();

            EditorGUILayout.BeginHorizontal();
            EditorGUILayout.PrefixLabel("Use Outline Texture");


            if (material.GetFloat("_OutlineTexToggle") == 0)
            {
                if (GUILayout.Button("Off", shortButtonStyle))
                {
                    material.SetFloat("_OutlineTexToggle", 1);
                }
                EditorGUILayout.EndHorizontal();
            }
            else
            {
                if (GUILayout.Button("Active", shortButtonStyle))
                {
                    material.SetFloat("_OutlineTexToggle", 0);
                }
                EditorGUILayout.EndHorizontal();
                m_MaterialEditor.TexturePropertySingleLine(Styles.outlineTexText, outlineTex);
            }
            }


        }

         //renderMode
        public static void SetBlendMode(Material material, BlendMode renderMode)
    {        
        switch (renderMode)
        {
            case BlendMode.Opaque:
                material.SetOverrideTag("RenderType", "");
                material.SetInt("_SrcBlend", (int) UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_DstBlend", (int) UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_ZWrite", 1);

                material.DisableKeyword("_ALPHATEST_ON");
                material.DisableKeyword("_ALPHABLEND_ON");
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");

                material.EnableKeyword("_IS_CLIPPING_OFF");
                material.DisableKeyword("_IS_CLIPPING_MODE");
                material.DisableKeyword("_IS_CLIPPING_TRANSMODE");    

                material.DisableKeyword("_IS_OUTLINE_CLIPPING_YES");
                material.EnableKeyword("_IS_OUTLINE_CLIPPING_NO");     

                 material.SetFloat("_StencilComp", 8);  //Always
                material.SetFloat("_StencilPassOp", 0);  //keep
                material.SetFloat("_StencilZFailOp", 0); //Keep        

                material.renderQueue = -1;
                break;

            case BlendMode.Cutout:
                material.SetOverrideTag("RenderType", "TransparentCutout");
                material.SetInt("_SrcBlend", (int) UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_DstBlend", (int) UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_ZWrite", 1);

                material.EnableKeyword("_ALPHATEST_ON");
                material.DisableKeyword("_ALPHABLEND_ON");
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");

                material.DisableKeyword("_IS_CLIPPING_OFF");
                material.EnableKeyword("_IS_CLIPPING_MODE");
                material.DisableKeyword("_IS_CLIPPING_TRANSMODE");
                
             
                material.EnableKeyword("_IS_OUTLINE_CLIPPING_YES");
                material.DisableKeyword("_IS_OUTLINE_CLIPPING_NO");
                 
                material.SetFloat("_StencilComp", 8);  //Always
                material.SetFloat("_StencilPassOp", 0);  //keep
                material.SetFloat("_StencilZFailOp", 0); //Keep  
                

                material.renderQueue = 2450;
                break;

            case BlendMode.Transparent:
                material.SetOverrideTag("RenderType", "Transparent");
                material.SetInt("_SrcBlend", (int) UnityEngine.Rendering.BlendMode.SrcAlpha);
                material.SetInt("_DstBlend", (int) UnityEngine.Rendering.BlendMode.OneMinusSrcAlpha);
                material.SetInt("_ZWrite", 0);

                material.DisableKeyword("_ALPHATEST_ON");
                material.EnableKeyword("_ALPHABLEND_ON");
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");

                material.DisableKeyword("_IS_CLIPPING_OFF");
                material.DisableKeyword("_IS_CLIPPING_MODE");
                material.EnableKeyword("_IS_CLIPPING_TRANSMODE");

                material.EnableKeyword("_IS_OUTLINE_CLIPPING_YES");
                material.DisableKeyword("_IS_OUTLINE_CLIPPING_NO");

                material.SetFloat("_StencilComp", 8);  //Always
                material.SetFloat("_StencilPassOp", 0);  //keep
                material.SetFloat("_StencilZFailOp", 0); //Keep     

                material.renderQueue = 3000;
                break;

            case BlendMode.StencilMack:
            
                material.SetOverrideTag("RenderType", "");
                material.SetInt("_SrcBlend", (int) UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_DstBlend", (int) UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_ZWrite", 1);

                material.DisableKeyword("_ALPHATEST_ON");
                material.DisableKeyword("_ALPHABLEND_ON");
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");

                material.EnableKeyword("_IS_CLIPPING_OFF");
                material.DisableKeyword("_IS_CLIPPING_MODE");
                material.DisableKeyword("_IS_CLIPPING_TRANSMODE");    

                material.DisableKeyword("_IS_OUTLINE_CLIPPING_YES");
                material.EnableKeyword("_IS_OUTLINE_CLIPPING_NO");     
                
                material.SetFloat("_StencilComp", 8);  //Always
                material.SetFloat("_StencilPassOp", 2);  //Replace
                material.SetFloat("_StencilZFailOp", 0); //Keep     

                material.renderQueue = -1;
                break;

            case BlendMode.StencilOut:
            
                material.SetOverrideTag("RenderType", "TransparentCutout");
                material.SetInt("_SrcBlend", (int) UnityEngine.Rendering.BlendMode.One);
                material.SetInt("_DstBlend", (int) UnityEngine.Rendering.BlendMode.Zero);
                material.SetInt("_ZWrite", 1);

                material.EnableKeyword("_ALPHATEST_ON");
                material.DisableKeyword("_ALPHABLEND_ON");
                material.DisableKeyword("_ALPHAPREMULTIPLY_ON");

                material.DisableKeyword("_IS_CLIPPING_OFF");
                material.EnableKeyword("_IS_CLIPPING_MODE");
                material.DisableKeyword("_IS_CLIPPING_TRANSMODE");
                
             
                material.EnableKeyword("_IS_OUTLINE_CLIPPING_YES");
                material.DisableKeyword("_IS_OUTLINE_CLIPPING_NO"); 
                
                material.SetFloat("_StencilComp", 6);  //NotEqual
                material.SetFloat("_StencilPassOp", 0);  //keep
                material.SetFloat("_StencilZFailOp", 0); //Keep     

                material.renderQueue = 2450;
                break;
           
                
              default:
                throw new ArgumentOutOfRangeException("RenderMode", renderMode, null);   
      
            
        }
    }
         public override void AssignNewShaderToMaterial(Material material, Shader oldShader, Shader newShader)
    {
        base.AssignNewShaderToMaterial(material, oldShader, newShader);

        if(oldShader != newShader)
        {
              if (oldShader == null )
            {
                  // Material BlendMode resetting
                 SetBlendMode(material, (BlendMode) material.GetFloat("_RenderMode"));
                 return;
            }
             if( oldShader.name == "KDShader/KDAvaterShaders" || 
                 oldShader.name == "KDShader/KDAvaterShaders_Outline" )
            {
                return;
            }
        }

    }
    

    } //End of KDAvaterShadersInspector
}//End of namespace KD