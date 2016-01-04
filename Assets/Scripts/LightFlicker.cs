using UnityEngine;
using System.Collections;

[RequireComponent(typeof(Light))]
public class LightFlicker : MonoBehaviour 
{
    public float minIntensity = 2.0f;
    public float maxIntensity = 2.5f;
    public float flickerSpeed = 5f;

    private Light thisLight;

    private float startValue;
    private float endValue;
    private bool onLerp = false;
    private float lerpState = 0;

    void Awake()
    {
        thisLight = GetComponent<Light>();
    }

    void Start()
    {
        NextFlickeringValue();
    }

    void Update()
    {
        if (onLerp)
        {
            thisLight.intensity = Mathf.Lerp(thisLight.intensity, endValue, lerpState);
            if (lerpState < 1)
            {
                lerpState += Time.deltaTime * flickerSpeed;
            }
            else
            {
                onLerp = false;
            }
        }
        else
        {
            lerpState = 0;
            NextFlickeringValue();
        }
    }

    void NextFlickeringValue()
    {
        int random = Random.Range(0, 1);
        //int flickerSpeed = Random.Range(15, 20);

        if (random == 0)
        {
            endValue = (Random.Range(minIntensity, maxIntensity));
        }
        else
        {
            endValue = (Random.Range(minIntensity, maxIntensity));
        }
        onLerp = true;
    }
}

