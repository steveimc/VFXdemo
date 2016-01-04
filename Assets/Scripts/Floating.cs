using UnityEngine;
using System.Collections;

public class Floating : MonoBehaviour 
{
    float originalY;
    float floatY;
    public float amplitude = 1;
    public float speed = 0.1f;

    public bool isRandom;
    public float maxSpeed = 1.5f;
    public float minspeed = 2.5f;
    // Use this for initialization
    void Start()
    {
        // Save the y position prior to start floating (maybe in the Start function):

        floatY = transform.position.y;

        if (isRandom)
            speed = Random.Range(minspeed, maxSpeed);

    }

    // Update is called once per frame
    void Update()
    {
        Vector3 newPos = transform.position;
        // Put the floating movement in the Update function:
        newPos.y = floatY + amplitude * Mathf.Sin(speed * Time.time);
        this.transform.position = newPos;
    }
}
