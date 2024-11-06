using System;
using TMPro;
using TMPro.Examples;
using UnityEngine;

public class InputTrainingTest : MonoBehaviour
{

    public TextAnim textAnim;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        
    }

    public void TestButton() {
        Debug.Log("Button Pressed");
    
        // add lines
        textAnim.stringArray.Add("Test line of dialogue");
        textAnim.stringArray.Add("Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. ");
        textAnim.stringArray.Add("Project Persona");

        // start the animation
        textAnim.EndCheck();
        
        // In the inspector, make sure to add the reference for the Text TMP object that contains the TextAnim component
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
