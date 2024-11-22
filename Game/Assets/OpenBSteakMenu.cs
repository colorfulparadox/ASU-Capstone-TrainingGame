using UnityEngine;

public class OpenBSteakMenu : MonoBehaviour
{
    public GameObject popupImage;

    public void TogglePopup()
    {
        if (popupImage != null)
        {
            popupImage.SetActive(!popupImage.activeSelf);
        }
    }
}
