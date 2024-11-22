using UnityEngine;
using TMPro;
public class DialogueScript : MonoBehaviour
{
    public TMP_Text dialogueText; 
    public TMP_InputField playerInput;  
    public GameObject submitButton;      
    public GameObject leaveButton; 
    private string currentDialogue; 


    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        SetDialogue("Introduce yourself and ask what you can get started for everyone.");
        submitButton.SetActive(true);
    }

    public void SetDialogue(string text)
    {
        // Display new dialogue
        currentDialogue = text;
        dialogueText.text = currentDialogue;
    }

      public void OnSubmitResponse()
    {
        string playerResponse = playerInput.text;
        playerInput.text = "";
        ProcessResponse(playerResponse);
    }

    private void ProcessResponse(string response)
    {
        AI_Handler aiHandler = AI_Handler.GetInstance();
        string conversationId = "conversation_id_1";

        if (aiHandler.conversations.Contains(conversationId))
        {
            dialogueText.text = aiHandler.ContinueConversation(conversationId, response);
        } else if (response == "end") {
            aiHandler.EndConversation("conversation_id_1", response);
        }
        else
        {
            dialogueText.text = aiHandler.StartConversation(conversationId, response);
        }
    }


    // Update is called once per frame
    void Update()
    {
        
    }
}
