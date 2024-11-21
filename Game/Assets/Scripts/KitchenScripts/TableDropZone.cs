using UnityEngine;
using UnityEngine.EventSystems;

public class TableDropZone : MonoBehaviour, IDropHandler
{
    private bool isInDropZone = false;

    public void OnTriggerEnter2D(Collider2D other)
    {
        if (other.CompareTag("DraggableTable"))
        {
            Debug.Log("Table entered the drop zone: " + other.name);

            // Snapping the table only once when it enters the drop zone
            if (!isInDropZone)
            {
                other.transform.position = transform.position;
                isInDropZone = true;  // Flag to prevent continuous updates
            }
        }
    }

    public void OnTriggerExit2D(Collider2D other)
    {
        if (other.CompareTag("DraggableTable"))
        {
            Debug.Log("Table exited the drop zone: " + other.name);
            isInDropZone = false;  // Reset flag when the table leaves the drop zone
        }
    }
    
    public void OnDrop(PointerEventData eventData)
    {
        GameObject droppedObject = eventData.pointerDrag; // The object being dragged
        if (droppedObject != null)
        {
            // Reparent the dropped object to the drop zone
            droppedObject.transform.SetParent(transform);

            // Center the object in the drop zone
            RectTransform droppedRect = droppedObject.GetComponent<RectTransform>();
            droppedRect.anchoredPosition = Vector2.zero; // Align to center of drop zone
        }
    }
}