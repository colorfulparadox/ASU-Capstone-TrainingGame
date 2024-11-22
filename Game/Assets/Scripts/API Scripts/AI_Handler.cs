using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;
using UnityEngine;
using UnityEngine.Networking;

public class AI_Handler : MonoBehaviour
{
    private static AI_Handler instance;

    private static string url;
    private static string auth_token;

    public List<string> conversations = new List<string>();
    private int conversations_num = 0;

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

    public static AI_Handler GetInstance()
    {
        return instance;
    }

    private Conversation_Response ConversationRequest(string url, string json)
    {
        UnityWebRequest request = new UnityWebRequest(url, "POST");
        byte[] bodyRaw = Encoding.UTF8.GetBytes(json);
        request.uploadHandler = (UploadHandler)new UploadHandlerRaw(bodyRaw);
        request.downloadHandler = (DownloadHandler)new DownloadHandlerBuffer();
        request.SetRequestHeader("Content-Type", "application/json");

        if (request.result == UnityWebRequest.Result.Success)
        {
            Conversation_Response conversation_response = JsonUtility.FromJson<Conversation_Response>(request.downloadHandler.text);

            return conversation_response;
        }
        else
        {
            Debug.LogError("Error: " + request.error);

            return null;
        }
    }
    
    // TODO: check that the conversation is properly created before adding it to the list
    public string StartConversation(string conversation_id, string message)
    {
        Conversation_Request conversation_request = new Conversation_Request();
        conversation_request.auth_token = auth_token;
        conversation_request.conversation_id = conversation_id;
        conversation_request.message = message;

        // return ConversationRequest(url + "/start_conversation", JsonUtility.ToJson(conversation_request)).message;
        conversations.Add(conversation_id);
        return "Start Response";
    }

    public string ContinueConversation(string conversation_id, string message)
    {
        Conversation_Request conversation_request = new Conversation_Request();
        conversation_request.auth_token = auth_token;
        conversation_request.conversation_id = conversation_id;
        conversation_request.message = message;

        // return ConversationRequest(url + "/continue_conversation", JsonUtility.ToJson(conversation_request)).message;
        return "Continue Response";
    }

    public void EndConversation(string conversation_id, string message)
    {
        Conversation_Request conversation_request = new Conversation_Request();
        conversation_request.auth_token = auth_token;
        conversation_request.conversation_id = conversation_id;

        if (ConversationRequest(url + "/delete_conversation", JsonUtility.ToJson(conversation_request)) == null)
        {
            Debug.LogError("Conversation does not exist or was not deleted correctly");
        } else
        {
            conversations.Remove(conversation_id);
        }
        Debug.Log("End Response");
    }

    private void OnApplicationQuit()
    {
        Conversation_Request conversation_request = new Conversation_Request();
        conversation_request.auth_token = auth_token;

        if (conversations.Count > 0)
        {
            Debug.LogWarning("Not all conversations were ended properly, this will try to be handled by a garbage collector but there is no guarantee of proper cleanup of everything");
        }

        //ConversationRequest(url + "/delete_all_conversations", JsonUtility.ToJson(conversation_request));

        
    }
}
