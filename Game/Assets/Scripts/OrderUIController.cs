using UnityEngine;

public class OrderUIController : MonoBehaviour
{

    public Camera RestaurantCamera;
    public Camera OrderUICamera;

    public void OrderButtonClick() 
    {
        Debug.Log("Kitchen Button Clicked");

        if (RestaurantCamera.gameObject.activeSelf)
        {
            RestaurantCamera.gameObject.SetActive(false);
            OrderUICamera.gameObject.SetActive(true);
        }
        else
        {
            RestaurantCamera.gameObject.SetActive(true);
            OrderUICamera.gameObject.SetActive(false);
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
