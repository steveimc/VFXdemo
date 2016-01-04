using UnityEngine;
using System.Collections;

public class DestroyTiblingParts : MonoBehaviour 
{
    [SerializeField]
    Color finalColor;

    private Color startColor;
    private float lifeTime = 2.0f;
    private int value = 0;
    private bool canVanish = false;

    private void Start()
    {
        Invoke("Vanish", 60f);
        InvokeRepeating("AddColor", 60f, 0.1f);
    }

    private void Update()
    {
        if (canVanish)
        {
            VanishColor();
        }
    }

    private void Vanish()
    {
        canVanish = true;
        Invoke("DestroyBody", lifeTime);
    }

    private void DestroyBody()
    {
        Destroy(gameObject);
    }

    private void AddColor()
    {
        value++;
    }

    private void VanishColor()
    {
        Renderer[] rend = GetComponentsInChildren<Renderer>();

        for(int j = 0; j < rend.Length; j++)
        {
            Material[] mat = rend[j].materials;

            for (int i = 0; i < mat.Length; i++)
            {
                if (mat[i].shader == Shader.Find("TiB/Crystal Transparent"))
                {
                    startColor = mat[i].GetColor("_Color");
                    mat[i].SetColor("_Color", Color.Lerp(startColor, finalColor, value * 0.01f));
                }
            }
        }
    }
}
