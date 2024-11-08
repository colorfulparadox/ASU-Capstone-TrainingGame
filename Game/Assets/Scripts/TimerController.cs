using UnityEngine;

public class TimerManager : MonoBehaviour
{
    private GameTimer[] timers;

    void Awake()
    {
        // alternatively, manually populate the list of GameTimer objects, we'll see.
        timers = FindObjectsByType<GameTimer>(FindObjectsSortMode.InstanceID);
    }

    public void StartTimer(int index)
    {
        if (index >= 0 && index < timers.Length)
        {
            timers[index].enabled = true;
        }
    }

    public void StopTimer(int index)
    {
        if (index >= 0 && index < timers.Length)
        {
            timers[index].enabled = false;
        }
    }

    public void ResetTimer(int index)
    {
        if (index >= 0 && index < timers.Length)
        {
            timers[index].enabled = false;
            timers[index].Start();         
        }
    }

    public void StartAllTimers()
    {
        foreach (GameTimer timer in timers)
        {
            timer.enabled = true;
        }
    }

    public void StopAllTimers()
    {
        foreach (GameTimer timer in timers)
        {
            timer.enabled = false;
        }
    }

    public void ResetAllTimers()
    {
        foreach (GameTimer timer in timers)
        {
            timer.enabled = false;
            timer.Start();
        }
    }
}