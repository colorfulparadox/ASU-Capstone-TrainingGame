using UnityEditor.VersionControl;
using UnityEngine;

public class OrderManager : MonoBehaviour
{

    public GameObject orderButton;

    public void CreateButton(string title, float time, float cost)
    {
        GameObject order = Instantiate(orderButton);
        order.GetComponent<OrderButtonController>().setContent(title, cost, time);
        order.transform.SetParent(this.transform, false);
    }


    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        CreateButton("Coke", 0.75f, 10f);
        CreateButton("Pizza", 2.75f, 100f);
        CreateButton("Hotdog", 1.75f, 120f);
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
