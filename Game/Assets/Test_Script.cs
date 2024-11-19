using UnityEngine;

public class Test_Script : MonoBehaviour
{
    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    // Update is called once per frame
    void Update()
    {
        
    }

    public void Conversation_Start_Test()
    {
        Debug.LogWarning(AI_Handler.GetInstance().StartConversation("test", "test conversation"));
    }

    public void Conversation_End_Test()
    {
        AI_Handler.GetInstance().EndConversation("test", "test conversation");
    }

    public void Conversation_Test()
    {
        Debug.LogWarning(AI_Handler.GetInstance().conversations.Count);
    }
}
