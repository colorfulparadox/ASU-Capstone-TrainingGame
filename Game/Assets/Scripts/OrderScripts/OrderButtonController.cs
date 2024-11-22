using TMPro;
using UnityEngine;

public class OrderButtonController : MonoBehaviour
{
    public GameObject titleText;
    public GameObject costText;
    public GameObject timeText;

    public string name;
    public float price;
    public float timeToMake;


    public GameObject orderText;


    public void setContent(string title, float cost, float timeToMake)
    {
        name = title;
        price = cost;
        this.timeToMake = timeToMake;

        this.titleText.GetComponent<TextMeshProUGUI>().SetText(title);
        this.costText.GetComponent<TextMeshProUGUI>().SetText(string.Format($"Cost: {cost}"));
        this.timeText.GetComponent<TextMeshProUGUI>().SetText(string.Format($"Time: {timeToMake}"));
    }

    public void onClick()
    {
        GameObject order = Instantiate(orderText);
        order.GetComponent<TextMeshProUGUI>().SetText(name);
        order.transform.SetParent(orderList.transform, false);
    }
}
