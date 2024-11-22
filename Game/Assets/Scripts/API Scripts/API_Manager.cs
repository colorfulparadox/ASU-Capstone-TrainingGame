using System;
using System.Linq;
using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using static System.Runtime.CompilerServices.RuntimeHelpers;

public class API_Manager : MonoBehaviour
{
    [Header("URL")]
    public String url;

    [Header("Auth ID")]
    public string auth_token;

    [Header("Handlers")]
    public GameObject ai_handler;
    public GameObject user_handler;
    public GameObject data_handler;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        if (auth_token != "")
        {
            ai_handler.SetActive(true);
            user_handler.SetActive(true);
            data_handler.SetActive(true);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
