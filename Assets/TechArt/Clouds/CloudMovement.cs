using UnityEngine;
using System.Collections;

public class CloudMovement : MonoBehaviour 
{
    
    public float speed;
    
    /*
    public float maxValue;

    private Transform cloud;
    private Vector3 startPos;
    private float count = 0;
  */

    void Start()
    {
        /*
        cloud = this.transform;
        startPos = this.transform.position;
         * */
    }

	// Update is called once per frame
	void Update () 
    {
        transform.Translate(0, 0, -speed/10,Space.World);
	}
     
}
