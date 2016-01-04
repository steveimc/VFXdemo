using UnityEngine;
using System.Collections;

public class DestroyVanish : MonoBehaviour 
{

	// Use this for initialization
	void Start () 
    {
        Invoke("Kill",1.0f);
	}
	
	void Kill()
    {
        Destroy(this.gameObject);
    }
}
