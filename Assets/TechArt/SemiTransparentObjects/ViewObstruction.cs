using UnityEngine;
using System.Collections;

public class ViewObstruction : MonoBehaviour 
{
    private Material mat;

    void Awake()
    {
        mat = Resources.Load("semiTransparent") as Material;
    }
	// Update is called once per frame
	void Update () 
    {
        Vector3 fwd = transform.TransformDirection(Vector3.forward);
        RaycastHit hit;

        if (Physics.Raycast(transform.position, fwd, out hit, 100))
        {
            if(hit.collider.gameObject.GetComponent<ObjectObstructing>() != null)
            {
                hit.collider.gameObject.GetComponent<ObjectObstructing>().isObstructing = true;
                hit.collider.gameObject.GetComponent<Renderer>().material = mat;
            }
        }
	}
}
