using UnityEngine;
using System.Collections;

public class SelfDestroy : MonoBehaviour
{
    [SerializeField] float lifeTime;

	// Use this for initialization
	void Start ()
    {
        Invoke("DestroyAfter", lifeTime);
	}

    void DestroyAfter()
    {
        Destroy(this.gameObject);
    }

}
