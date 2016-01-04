using UnityEngine;
using System.Collections;

public class Teleporter : MonoBehaviour 
{
    public Transform destination;

    private void OnTriggerEnter(Collider col)
    {
        if(col.tag == "Player")
        {
            col.transform.position = destination.transform.position;
        }
    }
}
