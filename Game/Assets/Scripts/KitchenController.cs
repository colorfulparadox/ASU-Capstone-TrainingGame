using UnityEngine;

public class KitchenController : MonoBehaviour
{
    public Camera RestaurantCamera;
    public Camera KitchenCamera;

    public void KitchenButtonClick() 
    {
        Debug.Log("Kitchen Button Clicked");

        if (RestaurantCamera.gameObject.activeSelf)
        {
            RestaurantCamera.gameObject.SetActive(false);
            KitchenCamera.gameObject.SetActive(true);
        }
        else
        {
            RestaurantCamera.gameObject.SetActive(true);
            KitchenCamera.gameObject.SetActive(false);
        }
    }

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
