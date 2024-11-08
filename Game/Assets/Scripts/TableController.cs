using UnityEngine;

public class TableController : MonoBehaviour
{

    public GameObject CustomerObj;
    CustomerController customer;

    Transform tableTransform;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        tableTransform = this.GetComponent<Transform>();
    }

    // Update is called once per frame
    void Update()
    {
        
    }


    public void AddCustomer(GameObject customer)
    {
        this.CustomerObj = customer;
        CustomerController cust = customer.GetComponent<CustomerController>();
        if (cust != null)
        {
            throw new System.Exception("Customer object does not have a customer controller!");
        }
        this.customer = cust;
    }
}
