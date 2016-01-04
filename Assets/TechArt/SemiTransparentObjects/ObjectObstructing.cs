using UnityEngine;
using System.Collections;

public class ObjectObstructing : MonoBehaviour 
{
    private Material mat;
    internal bool isObstructing = false;

    private void Awake()
    {
        mat = GetComponent<Renderer>().material;
    }
	// Update is called once per frame
	private void LateUpdate () 
    {
	    if(!isObstructing)
        {
            GetComponent<Renderer>().material = mat;
        }

        isObstructing = false;
	}
}
