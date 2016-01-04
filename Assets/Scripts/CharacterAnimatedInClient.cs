using UnityEngine;
using System.Collections;

// This class handles the movement animations in the client side ///////////////////////////////////////////////////
public class CharacterAnimatedInClient : MonoBehaviour 
{
    // Private ---------------------------------------
    private Animator animator;
    private Vector3 lastPosition;
    private Vector3 animatorInput;
    private float distance;

    private const float MULTIPLIER = 10f;
    private const float ANIMATOR_SMOOTHING = 0.1f;

    private Mask tibMask;

    private void Start()
    {
        lastPosition = transform.position;
        animator = GetComponentInChildren<Animator>();
    }

    public void Init(GameObject pMask)
    {
        //tibMask = this.GetComponentInChildren<Mask>();
        tibMask = pMask.GetComponent<Mask>();
    }

    // Animate the character depending on it's movement and direction
    private void Update()
    {
        Vector3 heading = transform.position - lastPosition;

        lastPosition = transform.position;

        // Check the direction of the character and transform it from world space to local
        Vector3 direction = transform.InverseTransformDirection(heading);

        animatorInput = Vector3.Lerp(animatorInput, direction * MULTIPLIER, ANIMATOR_SMOOTHING);

        if(animator != null)
        {
            animator.SetFloat("VelX", animatorInput.x); // Set animator values
            animator.SetFloat("VelZ", animatorInput.z);
        }             
    }
}
