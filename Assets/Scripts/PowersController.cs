using UnityEngine;
using System.Collections;

public class PowersController : MonoBehaviour
{
    [SerializeField]
    GameObject[] powers;

    int selectedPower = 1;
    int previousPower;

    [SerializeField]
    Transform emitter;

	// Update is called once per frame
	void Update ()
    {
        GetSelected();
   
        if(Input.GetKeyDown(KeyCode.Mouse0))
        {
            Instantiate(powers[selectedPower], emitter.position, emitter.rotation);
        }
        
    }

    void GetSelected()
    {
        previousPower = selectedPower;
        string keyPressed = Input.inputString;

        foreach(char c in keyPressed)
        {
            if (c >= '1' && c <= '7')
                selectedPower = int.Parse((string)keyPressed);
        }

    }

}
