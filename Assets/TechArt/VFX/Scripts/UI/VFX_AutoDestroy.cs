using UnityEngine;
using System.Collections;

public class VFX_AutoDestroy : MonoBehaviour 
{
	// Update is called once per frame
	void Update () 
    {
        ParticleSystem ps = GetComponent<ParticleSystem>();

	    if(!ps.IsAlive(true))
        {
            Destroy(this.gameObject);
        }
	}
}
