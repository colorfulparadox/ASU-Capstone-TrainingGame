using UnityEngine;
using TMPro;
public class DialogueScript : MonoBehaviour
{
    public TMP_Text dialogueText;         // Reference to the dialogue text
    public TMP_InputField playerInput;   // Reference to the input field
    public GameObject submitButton;      // Reference to the submit button

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
        aiHandler.StartConversation("conversation_id_1", response);
        dialogueText.text = aiHandler.conversations[0];
    }


    // Update is called once per frame
    void Update()
    {
        
    }
}
