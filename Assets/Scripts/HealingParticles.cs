using UnityEngine;
using System.Collections;

public class HealingParticles : MonoBehaviour
{
    Transform target;
    float lifeTime = 5f;
	// Use this for initialization
	void Start ()
    {
        target = FindObjectOfType<CharacterMovement>().transform;
        this.transform.parent = target;
        Invoke("DestroyAfter",lifeTime);
	}

    void DestroyAfter()
    {
        Destroy(this.gameObject);
    }
}
