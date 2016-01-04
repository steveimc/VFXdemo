using UnityEngine;
using System.Collections;

public class CameraController : MonoBehaviour
{
    private Transform cameraContainer;
    private Camera playerCamera;

    public void Awake()
    {
        Transform playerContainer = this.transform.parent;
        Cursor.visible = false;

        cameraContainer = playerContainer.FindChild("Camera Container");
        playerCamera = cameraContainer.Find("Main Camera").GetComponent<Camera>();
    }

    private void Update()
    {
        if(playerCamera != null)
        {
            float lerpSpeed = 5f;
            cameraContainer.transform.rotation = Quaternion.Lerp(cameraContainer.transform.rotation, this.transform.rotation, Time.deltaTime * lerpSpeed);
            cameraContainer.transform.position = this.transform.position;
        }
    }

    public Camera GetPlayerCamera()
    {
        return playerCamera;
    }

    public Transform GetCameraContainer()
    {
        return cameraContainer;
    }

    public Quaternion GetCharacterRotation()
    {
        if (Input.GetAxis("Mouse X") == 0)
            return this.transform.rotation;
        
        float mouseSensitivity = 2f;
        float rotationX = Input.GetAxis("Mouse X") * mouseSensitivity;

        Quaternion prevRot = this.transform.rotation;

        this.transform.Rotate(0, rotationX, 0);

        Quaternion returnValue = this.transform.rotation;

        this.transform.rotation = prevRot;

        return returnValue;
    }
}
