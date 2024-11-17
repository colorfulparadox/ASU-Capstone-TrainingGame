using System.Text;
using UnityEngine;
using UnityEngine.Networking;

public class User_Handler : MonoBehaviour
{
    private static User_Handler instance;

    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogWarning("More than one Dialogue Manager in scene");
        }
        instance = this;
    }

    public static User_Handler GetInstance()
    {
        return instance;
    }

    public string UserRequest(string url, string json)
    {
        UnityWebRequest request = new UnityWebRequest(url, "POST");
        byte[] bodyRaw = Encoding.UTF8.GetBytes(json);
        request.uploadHandler = (UploadHandler)new UploadHandlerRaw(bodyRaw);
        request.downloadHandler = (DownloadHandler)new DownloadHandlerBuffer();
        request.SetRequestHeader("Content-Type", "application/json");

        if (request.result == UnityWebRequest.Result.Success)
        {
            Conversation_Response conversation_response = JsonUtility.FromJson<Conversation_Response>(request.downloadHandler.text);

            return conversation_response.message;
        }
        else
        {
            Debug.LogError("Error: " + request.error);

            return "";
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
