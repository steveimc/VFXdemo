using UnityEngine;
using System.Collections;

public class TiblingMouseOver : MonoBehaviour 
{
        private Renderer[] rend;

        public GameObject highlighted;

        void Start()
        {
            rend = GetComponentsInChildren<Renderer>();        
        }

        void OnMouseOver()
        {
            TiblingHighlightOn();
            ObjectHighlightOn();
    
        }

        void OnMouseExit()
        {
            TiblingHighlightOff();
            ObjectHighlightOff();
        }

 
        private void ObjectHighlightOn()
        {

            highlighted.SetActive(true);
        }

        private void TiblingHighlightOn()
        {
            float thickness = 0.001f;

            foreach (Renderer r in rend)
            {
                Material[] mat = r.materials;

                foreach (Material m in mat)
                {

                    if (m.shader == Shader.Find("TiB/Glow Outline"))
                    {
                        m.SetFloat("_Outline", thickness);
                    }
                }

            }
        }

        private void ObjectHighlightOff()
        {
            highlighted.SetActive(false);
        }

        private void TiblingHighlightOff()
        {
            float thickness = 0f;

            foreach (Renderer r in rend)
            {
                Material[] mat = r.materials;

                foreach (Material m in mat)
                {

                    if (m.shader == Shader.Find("TiB/Glow Outline"))
                    {
                        m.SetFloat("_Outline", thickness);
                    }
                }

            }
        }

       

    /*
        protected void ChangeTeamColor(Color color)
        {
            foreach (Renderer r in rend)
            {
                Material[] mat = r.materials;

                foreach (Material m in mat)
                {

                    if (m.shader == Shader.Find("TiB/Glow Outline"))
                    {
                        m.SetColor("_ColorTint", color);
                        m.SetColor("_ColorOutline", color);
                    }
                }

            }
        }
    */
}
