using UnityEngine;

public class TableController : MonoBehaviour
{

    public GameObject CustomerObj;
    CustomerController customer;

    Transform tableTransform;

    int timer = 0;

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

        Transform custTransfrom = customer.GetComponent<Transform>();
        var tabPos = tableTransform.position;
        custTransfrom.position = tabPos + new Vector3 (0, 45f, 0);
    }


    public void ClearCustomer()
    {

    }

    public void QueryCustomer()
    {

    }

}
