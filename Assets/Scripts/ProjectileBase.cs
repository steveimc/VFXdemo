using UnityEngine;
using System.Collections;

public class ProjectileBase : MonoBehaviour
{
    [SerializeField] float lifeTime;
    [SerializeField] float maxSpeed;
    [SerializeField] bool rotate;
    [SerializeField] bool hasCollision;
    [SerializeField] GameObject collisionObject;

	// Use this for initialization
	void Start ()
    {
        Invoke("DestroyAfter",lifeTime);
	}
	
	// Update is called once per frame
	void Update ()
    {
        this.transform.Translate(Vector3.forward * maxSpeed);

        if (rotate)
            this.transform.Rotate(0, 0, 1);
	}

    void DestroyAfter()
    {
        if (this.hasCollision == false)
            Instantiate(collisionObject, this.transform.position,this.transform.rotation);

        Destroy(this.gameObject);
    }

    void OnCollisionEnter(Collision col)
    {
        if (this.hasCollision)
        {
            Instantiate(collisionObject, this.transform.position, Quaternion.identity);
            Destroy(this.gameObject);
        }
            
    }
}
