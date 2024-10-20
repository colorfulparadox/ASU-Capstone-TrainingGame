using TMPro;
using UnityEngine;
using UnityEngine.UI;

public class MessageController : MonoBehaviour
{
    public Button deleteButton;
    public GameObject message;
    public GameObject title;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        deleteButton.onClick.AddListener(deleteMessage);
    }


    public void setContent(string title, string content)
    {
        this.title.GetComponent<TextMeshProUGUI>().SetText(title);
        this.message.GetComponent<TextMeshProUGUI>().SetText(content);
    }

    void deleteMessage()
    {
        Destroy(gameObject); 
    }
}
