using System.Collections.Generic;
using System.Text;
using UnityEngine;
using UnityEngine.Networking;

public class Data_Handler : MonoBehaviour
{
    private static Data_Handler instance;

    private static string url;
    private static string auth_token;

    private void Awake()
    {
        if (instance != null)
        {
            Debug.LogWarning("More than one Dialogue Manager in scene");
        }
        instance = this;

        API_Manager manager_instance = this.GetComponentInParent<API_Manager>();
        auth_token = manager_instance.auth_token;
        url = manager_instance.url;
    }

    public static Data_Handler GetInstance()
    {
        return instance;
    }

    private Data_Response DataRequest(string url, string json)
    {
        UnityWebRequest request = new UnityWebRequest(url, "POST");
        byte[] bodyRaw = Encoding.UTF8.GetBytes(json);
        request.uploadHandler = (UploadHandler)new UploadHandlerRaw(bodyRaw);
        request.downloadHandler = (DownloadHandler)new DownloadHandlerBuffer();
        request.SetRequestHeader("Content-Type", "application/json");

        if (request.result == UnityWebRequest.Result.Success)
        {
            Data_Response data_response = JsonUtility.FromJson<Data_Response>(request.downloadHandler.text);

            return data_response;
        }
        else
        {
            Debug.LogError("Error: " + request.error);

            return null;
        }
    }

    public string GetMenu()
    {
        Conversation_Request conversation_request = new Conversation_Request();
        conversation_request.auth_token = auth_token;

        // return DataRequest(url + "/start_conversation", JsonUtility.ToJson(conversation_request)).message;
        return "{\"Menu\" : \"response\"}";
    }
}
