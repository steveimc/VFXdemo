using UnityEngine;
using System.Collections;

public class CharacterMovement : MonoBehaviour
{
    float fMaxSpeed = 0.4f;
	// Use this for initialization
	void Start ()
    {
	
	}
	
	// Update is called once per frame
	void Update ()
    {
        float horizontal = Input.GetAxis("Horizontal");
        float vertical = Input.GetAxis("Vertical");

        this.transform.Translate(Mathf.Clamp(horizontal*fMaxSpeed,-fMaxSpeed, fMaxSpeed),0, Mathf.Clamp(vertical*fMaxSpeed, -fMaxSpeed, fMaxSpeed));
        Quaternion rotation = this.GetComponent<CameraController>().GetCharacterRotation();
        this.transform.rotation = rotation;
    }
}
