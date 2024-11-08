using UnityEngine;
using TMPro;

public class GameTimer : MonoBehaviour
{
    public TextMeshProUGUI timerText; // Reference to the TextMeshPro component
    public bool countDown = true;     // Choose between counting down or up
    public float timeDuration = 60f;  // Set initial duration for countdown or start time for count up
    private float timeLeft;           // Internal timer

    public void Start()
    {
        timeLeft = countDown ? timeDuration : 0;
        UpdateTimerDisplay();
    }

    void Update()
    {
        if (countDown)
        {
            timeLeft -= Time.deltaTime;
            if (timeLeft <= 0)
            {
                timeLeft = 0;
                enabled = false;
            }
        }
        else
        {
            timeLeft += Time.deltaTime;
            if (timeLeft >= timeDuration)
            {
                timeLeft = timeDuration;
                enabled = false; 
            }
        }

        UpdateTimerDisplay();
    }

    private void UpdateTimerDisplay()
    {
        int minutes = Mathf.FloorToInt(timeLeft / 60F);
        int seconds = Mathf.FloorToInt(timeLeft % 60F);
        timerText.text = $"{minutes:00}:{seconds:00}";
    }
}