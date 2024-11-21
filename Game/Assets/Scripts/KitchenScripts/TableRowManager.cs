using UnityEngine;

public class TableRowManager : MonoBehaviour
{

    public GameObject tablePrefab;
    public Transform rowContainer;

    public int tableCount = 5;

    // Start is called once before the first execution of Update after the MonoBehaviour is created
    void Start()
    {
        // mock population of tables for now. Will pull in the actual tables soon™
        for (int i = 0; i < tableCount; i++)
        {   
            GameObject table = Instantiate(tablePrefab, rowContainer);
        }
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
