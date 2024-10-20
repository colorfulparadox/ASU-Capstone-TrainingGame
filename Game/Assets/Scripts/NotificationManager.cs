using UnityEditor.VersionControl;
using UnityEngine;

public class NotifcationManager : MonoBehaviour
{
    public GameObject msgPrefab;
    public GameObject list;

    public void Start()
    {
        AddMessage("test", "asdasdasdasdadasd");
        AddMessage("test2", "bbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbbb");
        AddMessage("test3", "aaaaaaaaaaaaaaaaaaaaaad");
        AddMessage("tes4t", "aalllllllppppppppppppppppppppppppppppppp");
    }


    public void AddMessage(string title, string message)
    {
        GameObject newMessage = Instantiate(msgPrefab);
        newMessage.GetComponent<MessageController>().setContent(title, message);
        newMessage.transform.SetParent(list.transform, false);
    }
}
