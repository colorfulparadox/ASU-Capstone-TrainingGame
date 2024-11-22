using UnityEditor.VersionControl;
using UnityEngine;

public class OrderManager : MonoBehaviour
{

    public GameObject orderButton;
    public GameObject list;

    public void CreateButton(string title, float time, float cost)
    {
        GameObject order = Instantiate(orderButton);
        order.GetComponent<OrderButtonController>().setContent(title, cost, time);
        order.transform.SetParent(list.transform, false);
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
