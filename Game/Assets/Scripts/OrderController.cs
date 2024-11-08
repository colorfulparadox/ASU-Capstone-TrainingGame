using UnityEngine;

public enum ORDERTYPE
{
    Food,
    Drink
}

public class OrderController : MonoBehaviour
{
    
    public int OrderID;
    public string OrderName;
    public ORDERTYPE OrderType;
    public float Cost;
    public float WaitTime;

    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
