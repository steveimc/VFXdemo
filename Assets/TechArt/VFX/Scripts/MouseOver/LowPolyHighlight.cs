using UnityEngine;
using System.Collections;

public class LowPolyHighlight : MonoBehaviour 
{
        public GameObject highlighted;

        private void ObjectHighlightOn()
        {

            highlighted.SetActive(true);
        }


        private void ObjectHighlightOff()
        {
            highlighted.SetActive(false);
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