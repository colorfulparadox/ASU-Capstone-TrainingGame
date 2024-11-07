using UnityEngine;
using UnityEngine.SceneManagement;

public class MainMenuController : MonoBehaviour
{
    public void PlayGame()
    {
        SceneManager.LoadScene("Scenes/GameScene");
    }

    public void Training()
    {
        SceneManager.LoadScene("Scenes/TrainingScene"); 
    }

    public void QuitGame()
    {
        Application.Quit();
    }

}
